\version "2.24.3"
% automatically converted by musicxml2ly from /home/user/Music/output/ex4_251_twelve_keys.musicxml
\pointAndClickOff

\header {
  title = "Exercise 4 - ii-V-I guide-tone enclosures, 12 keys"
  composer = "after Hal Galper, Forward Motion"
}


\paper {
  #(set-paper-size "a4")
  left-margin = 22\mm
  ragged-last = ##t
  tagline = ##f
}
#(set-global-staff-size 20)

\layout {
  \context { \Score
    \override NonMusicalPaperColumn.line-break-permission = ##f
  }
}

\layout {
    \context { \Score
        autoBeaming = ##f
        }
    }
PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOne = 
\relative g' {
    \clef "treble" \numericTimeSignature\time 4/4 | % 1
    \tempo 4=120 r2 - "scale step above, half step below" r4 \stemUp g8
    [ \stemUp e8 ] | % 2
    \key c \major f2 - "Key of C" r4 \stemDown c'8 [ \stemDown ais8 ] | % 3
    b2 r4 \stemDown f'8 [ \stemDown dis8 ] | % 4
    e2 r2 \break | % 5
    r2 r4 \stemDown c8 [ \stemDown a8 ] | % 6
    \key f \major bes2 - "Key of F" r4 \stemUp f8 [ \stemUp dis8 ] | % 7
    e2 r4 \stemUp bes'8 [ \stemUp gis8 ] | % 8
    a2 r2 \break | % 9
    r2 r4 \stemUp f8 [ \stemUp d8 ] | \barNumberCheck #10
    \key bes \major es2 - "Key of Bb" r4 \stemUp bes'8 [ \stemUp gis8 ]
    | % 11
    a2 r4 \stemDown es'8 [ \stemDown cis8 ] | % 12
    d2 r2 \break | % 13
    r2 r4 \stemUp bes8 [ \stemUp g8 ] | % 14
    \key es \major as2 - "Key of Eb" r4 \stemUp es8 [ \stemUp cis8 ] | % 15
    d2 r4 \stemUp as'8 [ \stemUp fis8 ] | % 16
    g2 r2 \break | % 17
    r2 r4 \stemUp es8 [ \stemUp c8 ] | % 18
    \key as \major des2 - "Key of Ab" r4 \stemUp as'8 [ \stemUp fis8 ] | % 19
    g2 r4 \stemDown des'8 [ \stemDown b8 ] | \barNumberCheck #20
    c2 r2 \break | % 21
    r2 r4 \stemUp as8 [ \stemUp f8 ] | % 22
    \key des \major ges2 - "Key of Db" r4 \stemUp des8 [ \stemUp b8 ] | % 23
    c2 r4 \stemUp ges'8 [ \stemUp e8 ] | % 24
    f2 r2 \break | % 25
    r2 r4 \stemDown des'8 [ \stemDown bes8 ] | % 26
    \key ges \major ces2 - "Key of Gb" r4 \stemUp ges8 [ \stemUp e8 ] | % 27
    f2 r4 \stemDown ces'8 [ \stemDown a8 ] | % 28
    bes2 r2 \break | % 29
    r2 r4 \stemUp fis8 [ \stemUp dis8 ] | \barNumberCheck #30
    \key b \major e2 - "Key of B" r4 \stemUp b'8 [ \stemUp a8 ] | % 31
    ais2 r4 \stemDown e'8 [ \stemDown d8 ] | % 32
    dis2 r2 \break | % 33
    r2 r4 \stemUp b8 [ \stemUp gis8 ] | % 34
    \key e \major a2 - "Key of E" r4 \stemUp e8 [ \stemUp d8 ] | % 35
    dis2 r4 \stemUp a'8 [ \stemUp g8 ] | % 36
    gis2 r2 \break | % 37
    r2 r4 \stemUp e8 [ \stemUp cis8 ] | % 38
    \key a \major d2 - "Key of A" r4 \stemUp a'8 [ \stemUp g8 ] | % 39
    gis2 r4 \stemDown d'8 [ \stemDown c8 ] | \barNumberCheck #40
    cis2 r2 \break | % 41
    r2 r4 \stemUp a8 [ \stemUp fis8 ] | % 42
    \key d \major g2 - "Key of D" r4 \stemUp d8 [ \stemUp c8 ] | % 43
    cis2 r4 \stemUp g'8 [ \stemUp f8 ] | % 44
    fis2 r2 \break | % 45
    r2 r4 \stemUp d8 [ \stemUp b8 ] | % 46
    \key g \major c2 - "Key of G" r4 \stemUp g'8 [ \stemUp f8 ] | % 47
    fis2 r4 \stemDown c'8 [ \stemDown ais8 ] | % 48
    b1 }

PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOneChords = 
\chordmode {
    | % 1
    s2 s4 s8 s8 | % 2
    d2:m7 s4 s8 s8 | % 3
    g2:7 s4 s8 s8 | % 4
    c2:maj7 s2 | % 5
    c2:maj7 s4 s8 s8 | % 6
    g2:m7 s4 s8 s8 | % 7
    c2:7 s4 s8 s8 | % 8
    f2:maj7 s2 | % 9
    f2:maj7 s4 s8 s8 | \barNumberCheck #10
    c2:m7 s4 s8 s8 | % 11
    f2:7 s4 s8 s8 | % 12
    bes2:maj7 s2 | % 13
    bes2:maj7 s4 s8 s8 | % 14
    f2:m7 s4 s8 s8 | % 15
    bes2:7 s4 s8 s8 | % 16
    es2:maj7 s2 | % 17
    es2:maj7 s4 s8 s8 | % 18
    bes2:m7 s4 s8 s8 | % 19
    es2:7 s4 s8 s8 | \barNumberCheck #20
    as2:maj7 s2 | % 21
    as2:maj7 s4 s8 s8 | % 22
    es2:m7 s4 s8 s8 | % 23
    as2:7 s4 s8 s8 | % 24
    des2:maj7 s2 | % 25
    des2:maj7 s4 s8 s8 | % 26
    as2:m7 s4 s8 s8 | % 27
    des2:7 s4 s8 s8 | % 28
    ges2:maj7 s2 | % 29
    ges2:maj7 s4 s8 s8 | \barNumberCheck #30
    cis2:m7 s4 s8 s8 | % 31
    fis2:7 s4 s8 s8 | % 32
    b2:maj7 s2 | % 33
    b2:maj7 s4 s8 s8 | % 34
    fis2:m7 s4 s8 s8 | % 35
    b2:7 s4 s8 s8 | % 36
    e2:maj7 s2 | % 37
    e2:maj7 s4 s8 s8 | % 38
    b2:m7 s4 s8 s8 | % 39
    e2:7 s4 s8 s8 | \barNumberCheck #40
    a2:maj7 s2 | % 41
    a2:maj7 s4 s8 s8 | % 42
    e2:m7 s4 s8 s8 | % 43
    a2:7 s4 s8 s8 | % 44
    d2:maj7 s2 | % 45
    d2:maj7 s4 s8 s8 | % 46
    a2:m7 s4 s8 s8 | % 47
    d2:7 s4 s8 s8 | % 48
    g1:maj7 }


% The score definition
\score {
    <<
        
        \context ChordNames = "PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOneChords" { \PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOneChords}
        \new Staff
        <<
            \set Staff.instrumentName = "Trumpet in B♭"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOne" {  \PartPccSixaSixdcEightefTwoThreeThreeFiveThreeFivebFiveOnebTwocfbSevencfZeroeSixaThreeVoiceOne }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 120 }
    }

