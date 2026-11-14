# Music

Trumpet exercises generated with Python ([music21](https://web.mit.edu/music21/)),
engraved with [LilyPond](https://lilypond.org), with a play-along and a
YouTube-style page-turn video.

## Enclosure exercises (after Hal Galper, *Forward Motion*)

The line is built backwards from a **target** chord tone on beat 1, which is
approached from above and below by the notes just before it.

| File | What it is |
|---|---|
| `ex1_shape_menu` | One target (G over Cmaj7) approached four different ways |
| `ex2_cmaj7_chromatic` | Half step above + half step below, Cmaj7 chord tones up and down |
| `ex3_scale_three_note` | 3-note enclosure (step above, whole step below, half step below) through the C major scale |
| `ex4_251_twelve_keys` | ii-V-I in all 12 keys (cycle of 4ths), enclosing the 3rd of every chord |

Each one is in `output/` as:

- `.pdf` sheet music, **written pitch for B♭ trumpet** (chord symbols are transposed too)
- `.mp3` play-along at **concert pitch** (trumpet + piano + bass, one bar woodblock count-in)
- `.mp4` 1080p video, two lines of music per screen, page turns when the music gets there
- `.musicxml` to open and edit in MuseScore / Sibelius / Dorico, and `.mid`

## Running it

```bash
sudo apt-get install lilypond fluidsynth fluid-soundfont-gm ffmpeg
pip install music21
python3 render.py                       # all exercises
python3 render.py ex4_251_twelve_keys   # just one
python3 render.py --no-video
```

- `enclosures.py`: the music. Enclosure shapes are defined in `SHAPES`, and new
  exercises go in `all_exercises()`.
- `render.py`: MusicXML → LilyPond → PDF/PNG, MIDI → FluidSynth → MP3, PNG + MP3 → ffmpeg → MP4.
