\version "2.24.3"
% automatically converted by musicxml2ly from /home/user/Music/output/ex3_scale_three_note.musicxml
\pointAndClickOff

\header {
  title = "Exercise 3 - Three-note enclosures through the C major scale"
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
PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOne = 
\relative d' {
    \clef "treble" \numericTimeSignature\time 4/4 | % 1
    \tempo 4=100 r2 - "step above, whole step below, half step below" r8
    d8 \stemUp bes8 [ \stemUp b8 ] | % 2
    c2 r8 e8 \stemUp c8 [ \stemUp cis8 ] | % 3
    d2 r8 f8 \stemUp d8 [ \stemUp dis8 ] | % 4
    e2 r8 g8 \stemUp es8 [ \stemUp e8 ] \break | % 5
    f2 r8 a8 \stemUp f8 [ \stemUp fis8 ] | % 6
    g2 r8 b8 \stemUp g8 [ \stemUp gis8 ] | % 7
    a2 r8 c8 \stemUp a8 [ \stemUp ais8 ] | % 8
    b2 r8 d8 \stemDown bes8 [ \stemDown b8 ] \break | % 9
    c2 r8 c8 \stemUp a8 [ \stemUp ais8 ] | \barNumberCheck #10
    b2 r8 b8 \stemUp g8 [ \stemUp gis8 ] | % 11
    a2 r8 a8 \stemUp f8 [ \stemUp fis8 ] | % 12
    g2 r8 g8 \stemUp es8 [ \stemUp e8 ] \break | % 13
    f2 r8 f8 \stemUp d8 [ \stemUp dis8 ] | % 14
    e2 r8 e8 \stemUp c8 [ \stemUp cis8 ] | % 15
    d2 r8 d8 \stemUp bes8 [ \stemUp b8 ] | % 16
    c1 }

PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOneChords = 
\chordmode {
    | % 1
    c2:maj7 s8 s8 s8 s8 | % 2
    c2:maj7 s8 s8 s8 s8 | % 3
    c2:maj7 s8 s8 s8 s8 | % 4
    c2:maj7 s8 s8 s8 s8 | % 5
    c2:maj7 s8 s8 s8 s8 | % 6
    c2:maj7 s8 s8 s8 s8 | % 7
    c2:maj7 s8 s8 s8 s8 | % 8
    c2:maj7 s8 s8 s8 s8 | % 9
    c2:maj7 s8 s8 s8 s8 | \barNumberCheck #10
    c2:maj7 s8 s8 s8 s8 | % 11
    c2:maj7 s8 s8 s8 s8 | % 12
    c2:maj7 s8 s8 s8 s8 | % 13
    c2:maj7 s8 s8 s8 s8 | % 14
    c2:maj7 s8 s8 s8 s8 | % 15
    c2:maj7 s8 s8 s8 s8 | % 16
    c1:maj7 }


% The score definition
\score {
    <<
        
        \context ChordNames = "PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOneChords" { \PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOneChords}
        \new Staff
        <<
            \set Staff.instrumentName = "Trumpet in B♭"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOne" {  \PartPNineEightaFourcEightSevenOnecFourEightTwoSixFiveeThreeZeroNineSevenbbThreeSixFiveEightSevenFiveaZerocOneThreeVoiceOne }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 100 }
    }

