"""Enclosure exercises in the spirit of Hal Galper's *Forward Motion*.

Core idea: the line is built backwards from a TARGET note (a chord tone) that
lands on a strong beat (beat 1). The notes just before it "enclose" it, one
above and one below, so the line moves forward into the target.

Every bar has the same shape:
    target (half note on beat 1) ... enclosure notes on beats 3-4 -> next target

All pitches are WRITTEN pitch for B-flat trumpet. render.py transposes the
audio down a major 2nd, so the play-along sounds at concert pitch.
"""

from music21 import (clef, metadata, expressions, harmony, instrument, key, layout,
                     meter, note, pitch, scale, stream, tempo)

# Comfortable written range for the targets (approach notes may go a step outside)
LOW, HIGH = pitch.Pitch("C4"), pitch.Pitch("G5")


# --- enclosure shapes --------------------------------------------------------
# Each shape takes (target, major scale) and returns the approach notes in order.

def chrom_above(p, sc): return p.transpose("m2")
def chrom_below(p, sc): return p.transpose("m-2")
def diat_above(p, sc): return sc.nextPitch(p, direction=scale.Direction.ASCENDING)
def diat_below(p, sc): return sc.nextPitch(p, direction=scale.Direction.DESCENDING)
def whole_below(p, sc): return p.transpose("M-2")


SHAPES = {
    # name: (label printed above the music, list of approach-note functions)
    "diatonic_above_chromatic_below": ("scale step above, half step below",
                                        [diat_above, chrom_below]),
    "chromatic_both": ("half step above, half step below",
                       [chrom_above, chrom_below]),
    "chromatic_below_diatonic_above": ("half step below, scale step above",
                                       [chrom_below, diat_above]),
    "three_note": ("step above, whole step below, half step below",
                   [diat_above, whole_below, chrom_below]),
}


def readable(p):
    """Respell awkward approach notes (G## -> A, B# -> C, E# -> F) for sight-reading."""
    if p.accidental and (abs(p.accidental.alter) > 1 or p.name in ("B#", "E#")):
        p = p.simplifyEnharmonic(mostCommon=True)
    return p


def enclosure(target, shape, sc):
    return [readable(fn(target, sc)) for fn in SHAPES[shape][1]]


# --- bar builders ------------------------------------------------------------

def approach_bar_tail(approach):
    """Beats 3-4: rest, then the approach notes as eighths ending on '4&'."""
    n = len(approach)
    out = [note.Rest(quarterLength=2 - 0.5 * n)]
    out += [note.Note(p, quarterLength=0.5) for p in approach]
    return out


def make_bar(target=None, approach=None, final=False):
    """One 4/4 bar: optional target half note, then optional enclosure."""
    m = stream.Measure()
    if target is None:
        m.append(note.Rest(quarterLength=2))
    elif final or not approach:
        m.append(note.Note(target, quarterLength=4 if final else 2))
    else:
        m.append(note.Note(target, quarterLength=2))
    if not final:
        if approach:
            for el in approach_bar_tail(approach):
                m.append(el)
        else:
            m.append(note.Rest(quarterLength=2))
    return m


def new_part(title):
    part = stream.Part()
    trumpet = instrument.Instrument()
    trumpet.partName = "Trumpet in B♭"
    trumpet.midiProgram = 56  # GM trumpet; no transposition: we write written pitch
    part.insert(0, trumpet)
    return part


def finish(part, title, bpm, bars_per_line, chords_per_bar):
    """Number bars, add clef/time/tempo, forced line breaks and chord symbols."""
    measures = list(part.getElementsByClass(stream.Measure))
    first = measures[0]
    first.insert(0, clef.TrebleClef())
    first.insert(0, meter.TimeSignature("4/4"))
    first.insert(0, tempo.MetronomeMark(number=bpm))
    for i, m in enumerate(measures):
        m.number = i + 1
        if i and i % bars_per_line == 0:
            m.insert(0, layout.SystemLayout(isNew=True))
        figure = chords_per_bar[i]
        if figure:
            m.insert(0, harmony.ChordSymbol(figure))
    score = stream.Score()
    score.insert(0, part)
    score.metadata = metadata.Metadata(title=title, composer="after Hal Galper, Forward Motion")
    score.bpm = bpm
    score.chords_per_bar = chords_per_bar
    return score


def fit_octave(p, prev):
    """Put pitch-class p in the octave closest to prev, kept inside LOW..HIGH."""
    best = None
    for octv in range(3, 7):
        cand = pitch.Pitch(p.name + str(octv))
        if not (LOW.ps <= cand.ps <= HIGH.ps):
            continue
        if best is None or abs(cand.ps - prev.ps) < abs(best.ps - prev.ps):
            best = cand
    return best


# --- exercises ---------------------------------------------------------------

def targets_exercise(title, targets, shape, chord_fig, sc, bpm, bars_per_line=4):
    """Enclose each target in turn. Bar 1 is a pickup into the first target."""
    part = new_part(title)
    part.append(make_bar(None, enclosure(targets[0], shape, sc)))
    for i, t in enumerate(targets):
        if i == len(targets) - 1:
            part.append(make_bar(t, final=True))
        else:
            part.append(make_bar(t, enclosure(targets[i + 1], shape, sc)))
    measures = part.getElementsByClass(stream.Measure)
    measures[0].insert(0, expressions.TextExpression(SHAPES[shape][0]))
    return finish(part, title, bpm, bars_per_line, [chord_fig] * len(measures))


def shape_menu(bpm=100):
    """Same target (G over Cmaj7) approached with each enclosure shape."""
    sc = scale.MajorScale("C")
    target = pitch.Pitch("G4")
    part = new_part("menu")
    names = list(SHAPES)
    part.append(make_bar(None, enclosure(target, names[0], sc)))
    for i, name in enumerate(names):
        nxt = names[i + 1] if i + 1 < len(names) else None
        part.append(make_bar(target, enclosure(target, nxt, sc) if nxt else None,
                             final=nxt is None))
    measures = part.getElementsByClass(stream.Measure)
    for i, name in enumerate(names):
        measures[i].insert(0, expressions.TextExpression(f"{i + 1}. {SHAPES[name][0]}"))
    return finish(part, "Exercise 1 - Four ways to enclose one note",
                  bpm, 2, ["Cmaj7"] * len(measures))


CYCLE_OF_FOURTHS = ["C", "F", "B-", "E-", "A-", "D-", "G-", "B", "E", "A", "D", "G"]


def chord_name(p, quality):
    return p.name + quality  # music21 spells flats with "-"


def two_five_one_all_keys(shape="diatonic_above_chromatic_below", bpm=120):
    """ii-V-I in 12 keys, enclosing the 3rd of every chord (the guide tones).

    Per key, 4 bars:  ii (target its 3rd) | V (its 3rd) | I (its 3rd) | I (rest,
    then enclose the 3rd of the next key's ii).
    """
    part = new_part("251")
    chords = []
    prev = pitch.Pitch("F4")
    keys = [pitch.Pitch(k) for k in CYCLE_OF_FOURTHS]

    def guide_tones(tonic, prev):
        ii, v = tonic.transpose("M2"), tonic.transpose("P5")
        names = [ii.transpose("m3"), v.transpose("M3"), tonic.transpose("M3")]
        out = []
        for n in names:
            prev = fit_octave(n, prev)
            out.append(prev)
        return out, [chord_name(ii, "m7"), chord_name(v, "7"), chord_name(tonic, "maj7")]

    plan = []
    for tonic in keys:
        tones, figs = guide_tones(tonic, prev)
        plan.append((tonic, tones, figs))
        prev = tones[-1]

    # pickup bar into the first key
    first_tonic, first_tones, first_figs = plan[0]
    sc0 = scale.MajorScale(first_tonic)
    part.append(make_bar(None, enclosure(first_tones[0], shape, sc0)))
    chords.append(None)

    for k, (tonic, tones, figs) in enumerate(plan):
        sc = scale.MajorScale(tonic)
        bars = [make_bar(tones[0], enclosure(tones[1], shape, sc)),
                make_bar(tones[1], enclosure(tones[2], shape, sc))]
        if k + 1 < len(plan):
            nxt_tonic, nxt_tones, _ = plan[k + 1]
            bars.append(make_bar(tones[2]))
            bars.append(make_bar(None, enclosure(nxt_tones[0], shape,
                                                 scale.MajorScale(nxt_tonic))))
        else:
            bars.append(make_bar(tones[2], final=True))
        ks = key.Key(tonic.name)
        bars[0].insert(0, ks.asKey() if hasattr(ks, "asKey") else ks)
        bars[0].insert(0, expressions.TextExpression("Key of " + tonic.name.replace("-", "b")))
        for b in bars:
            part.append(b)
        chords += figs + ([figs[2]] if len(bars) == 4 else [])

    part.getElementsByClass(stream.Measure)[0].insert(
        0, expressions.TextExpression(SHAPES[shape][0]))
    return finish(part, "Exercise 4 - ii-V-I guide-tone enclosures, 12 keys",
                  bpm, 4, chords)


def all_exercises():
    c = scale.MajorScale("C")
    arp = [pitch.Pitch(p) for p in ["C4", "E4", "G4", "B4", "C5", "B4", "G4", "E4", "C4"]]
    scale_up_down = [pitch.Pitch(p) for p in
                     ["C4", "D4", "E4", "F4", "G4", "A4", "B4", "C5",
                      "B4", "A4", "G4", "F4", "E4", "D4", "C4"]]
    return {
        "ex1_shape_menu": shape_menu(),
        "ex2_cmaj7_chromatic": targets_exercise(
            "Exercise 2 - Chromatic enclosures on Cmaj7 chord tones",
            arp, "chromatic_both", "Cmaj7", c, bpm=100),
        "ex3_scale_three_note": targets_exercise(
            "Exercise 3 - Three-note enclosures through the C major scale",
            scale_up_down, "three_note", "Cmaj7", c, bpm=100),
        "ex4_251_twelve_keys": two_five_one_all_keys(),
    }
