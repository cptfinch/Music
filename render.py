"""Render exercises to PDF, MusicXML, MIDI, MP3 play-along and a page-turn video.

    python3 render.py                 # everything
    python3 render.py ex4_251_twelve_keys --no-video

Pipeline:  music21 score -> MusicXML -> musicxml2ly -> LilyPond (PDF / PNG pages)
           music21 score -> concert-pitch MIDI (+ piano/bass backing, count-in)
                         -> FluidSynth -> MP3
           PNG pages + MP3 -> ffmpeg -> MP4 (page flips when the music reaches it)
"""

import argparse
import copy
import re
import subprocess
from pathlib import Path

from music21 import (harmony, instrument, layout, note, chord, stream, tempo)

import enclosures

OUT = Path(__file__).parent / "output"
SOUNDFONT = "/usr/share/sounds/sf2/FluidR3_GM.sf2"
SYSTEMS_PER_PAGE = 2          # video: two lines of music per screen
COUNT_IN_BARS = 1


def run(cmd, **kw):
    subprocess.run(cmd, check=True, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL, **kw)


# --- notation ----------------------------------------------------------------

PAPER = {
    "pdf": r"""
\paper {
  #(set-paper-size "a4")
  left-margin = 22\mm
  ragged-last = ##t
  tagline = ##f
}
#(set-global-staff-size 20)
""",
    "video": r"""
#(set! paper-alist (cons '("video" . (cons (* 320 mm) (* 180 mm))) paper-alist))
\paper {
  #(set-paper-size "video")
  systems-per-page = %d
  print-page-number = ##f
  tagline = ##f
  top-margin = 8\mm
  bottom-margin = 8\mm
  left-margin = 14\mm
  right-margin = 14\mm
  system-system-spacing.basic-distance = 26
}
#(set-global-staff-size 26)
""" % SYSTEMS_PER_PAGE,
}

# only allow the line breaks we asked for (bars_per_line), so we know page contents
NO_AUTO_BREAKS = r"""
\layout {
  \context { \Score
    \override NonMusicalPaperColumn.line-break-permission = ##f
  }
}
"""


def write_lilypond(xml_path, ly_path, mode, score):
    run(["musicxml2ly", str(xml_path), "-o", str(ly_path)])
    src = ly_path.read_text()
    header = '\\header {\n  title = "%s"\n  composer = "%s"\n}' % (
        score.metadata.title, score.metadata.composer)
    src = re.sub(r"\\header \{.*?\n    \}", lambda _: header, src, count=1, flags=re.S)
    src = re.sub(r"\\paper \{.*?\}", lambda _: PAPER[mode] + NO_AUTO_BREAKS, src, count=1, flags=re.S)
    src = re.sub(r"#\(set-global-staff-size [\d.]+\)\n", "", src, count=1)
    ly_path.write_text(src)


def engrave(score, name):
    xml = OUT / f"{name}.musicxml"
    score.write("musicxml", fp=xml)

    ly = OUT / f"{name}.ly"
    write_lilypond(xml, ly, "pdf", score)
    run(["lilypond", "-o", str(OUT / name), str(ly)])

    vdir = OUT / "video_frames" / name
    vdir.mkdir(parents=True, exist_ok=True)
    for old in vdir.glob("*.png"):
        old.unlink()
    vly = vdir / f"{name}.ly"
    write_lilypond(xml, vly, "video", score)
    # 320 mm wide at 152 dpi ~= 1920 px
    run(["lilypond", "--png", "-dresolution=152", "-o", str(vdir / name), str(vly)])
    return sorted(vdir.glob("*.png"), key=lambda p: int(re.findall(r"(\d+)\.png$", p.name)[0])
                  if re.search(r"page\d+\.png$", p.name) else 0)


# --- audio -------------------------------------------------------------------

def make_instrument(program, name):
    inst = instrument.Instrument()
    inst.midiProgram = program
    inst.partName = name
    return inst


def playback_score(score):
    """Concert-pitch score: trumpet melody, piano comping, bass, woodblock count-in."""
    bpm, chords_per_bar = score.bpm, score.chords_per_bar
    melody_src = score.parts[0].getElementsByClass(stream.Measure)

    melody = stream.Part(); melody.insert(0, make_instrument(56, "Trumpet"))
    piano = stream.Part(); piano.insert(0, make_instrument(0, "Piano"))
    bass = stream.Part(); bass.insert(0, make_instrument(32, "Bass"))
    click = stream.Part(); click.insert(0, make_instrument(115, "Woodblock"))

    for part in (melody, piano, bass, click):
        part.insert(0, tempo.MetronomeMark(number=bpm))
        for _ in range(COUNT_IN_BARS):
            m = stream.Measure()
            if part is click:
                for beat in range(4):
                    n = note.Note("E6" if beat == 0 else "C6", quarterLength=1)
                    n.volume.velocity = 90
                    m.append(n)
            else:
                m.append(note.Rest(quarterLength=4))
            part.append(m)

    for i, src in enumerate(melody_src):
        m = stream.Measure()
        for el in src.notesAndRests:
            if not isinstance(el, harmony.ChordSymbol):  # symbols are for the page, not the trumpet
                m.append(copy.deepcopy(el))
        melody.append(m)

        fig = chords_per_bar[i]
        pm, bm, cm = stream.Measure(), stream.Measure(), stream.Measure()
        cm.append(note.Rest(quarterLength=4))
        if fig:
            cs = harmony.ChordSymbol(fig)
            root = cs.root()
            voicing = [p.transpose(0) for p in cs.pitches]
            # close voicing around middle C
            for p in voicing:
                while p.ps < 55: p.octave += 1
                while p.ps > 67: p.octave -= 1
            for _ in range(2):
                # fresh pitch copies: shared Pitch objects would get transposed twice
                c = chord.Chord([copy.deepcopy(p) for p in sorted(voicing, key=lambda p: p.ps)],
                                quarterLength=2)
                c.volume.velocity = 50
                pm.append(c)
                b = note.Note(root.name + "2", quarterLength=2)
                b.volume.velocity = 75
                bm.append(b)
        else:
            pm.append(note.Rest(quarterLength=4))
            bm.append(note.Rest(quarterLength=4))
        piano.append(pm); bass.append(bm); click.append(cm)

    full = stream.Score([melody, piano, bass, click])
    # B-flat trumpet sounds a major 2nd below written pitch
    return full.transpose("M-2")


def make_audio(score, name):
    midi = OUT / f"{name}.mid"
    playback_score(score).write("midi", fp=midi)
    wav = OUT / f"{name}.wav"
    run(["fluidsynth", "-ni", "-g", "0.8", "-F", str(wav), "-r", "44100", SOUNDFONT, str(midi)])
    mp3 = OUT / f"{name}.mp3"
    run(["ffmpeg", "-y", "-i", str(wav), "-q:a", "3", str(mp3)])
    wav.unlink()
    return mp3


# --- video -------------------------------------------------------------------

def make_video(score, pages, mp3, name, bars_per_line):
    """Each page is shown exactly while its bars are playing."""
    n_bars = len(score.parts[0].getElementsByClass(stream.Measure))
    sec_per_bar = 4 * 60 / score.bpm
    bars_per_page = bars_per_line * SYSTEMS_PER_PAGE

    lines = []
    for i, png in enumerate(pages):
        bars = min(bars_per_page, n_bars - i * bars_per_page)
        dur = bars * sec_per_bar
        if i == 0:
            dur += COUNT_IN_BARS * sec_per_bar
        if i == len(pages) - 1:
            dur += 3  # let the last note ring
        lines += [f"file '{png.resolve()}'", f"duration {dur:.3f}"]
    lines.append(f"file '{pages[-1].resolve()}'")  # ffmpeg concat quirk
    listing = OUT / "video_frames" / name / "pages.txt"
    listing.write_text("\n".join(lines) + "\n")

    mp4 = OUT / f"{name}.mp4"
    vf = ("scale=1920:1080:force_original_aspect_ratio=decrease,"
          "pad=1920:1080:(ow-iw)/2:(oh-ih)/2:white,format=yuv420p")
    run(["ffmpeg", "-y", "-f", "concat", "-safe", "0", "-i", str(listing), "-i", str(mp3),
         "-vf", vf, "-r", "30", "-c:v", "libx264", "-tune", "stillimage",
         "-c:a", "aac", "-b:a", "192k", "-shortest", str(mp4)])
    return mp4


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("names", nargs="*", help="exercise names (default: all)")
    ap.add_argument("--no-video", action="store_true")
    args = ap.parse_args()

    OUT.mkdir(exist_ok=True)
    exercises = enclosures.all_exercises()
    for name in args.names or exercises:
        score = exercises[name]
        bars_per_line = next(
            (m.number - 1 for m in score.parts[0].getElementsByClass(stream.Measure)
             if m.getElementsByClass(layout.SystemLayout)), 99)
        print(f"{name}: engraving...", flush=True)
        pages = engrave(score, name)
        print(f"{name}: audio...", flush=True)
        mp3 = make_audio(score, name)
        if not args.no_video:
            print(f"{name}: video ({len(pages)} pages)...", flush=True)
            make_video(score, pages, mp3, name, bars_per_line)
    print(f"done -> {OUT}")


if __name__ == "__main__":
    main()
