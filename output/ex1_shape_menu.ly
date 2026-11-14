\version "2.24.3"
% automatically converted by musicxml2ly from /home/user/Music/output/ex1_shape_menu.musicxml
\pointAndClickOff

\header {
  title = "Exercise 1 - Four ways to enclose one note"
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
PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOne = 
\relative a' {
    \clef "treble" \numericTimeSignature\time 4/4 | % 1
    \tempo 4=100 r2 - "1. scale step above, half step below" r4 \stemUp
    a8 [ \stemUp fis8 ] | % 2
    g2 - "2. half step above, half step below" r4 \stemUp as8 [ \stemUp
    fis8 ] \break | % 3
    g2 - "3. half step below, scale step above" r4 \stemUp fis8 [
    \stemUp a8 ] | % 4
    g2 - "4. step above, whole step below, half step below" r8 a8
    \stemUp f8 [ \stemUp fis8 ] \break | % 5
    g1 }

PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOneChords = 
\chordmode {
    | % 1
    c2:maj7 s4 s8 s8 | % 2
    c2:maj7 s4 s8 s8 | % 3
    c2:maj7 s4 s8 s8 | % 4
    c2:maj7 s8 s8 s8 s8 | % 5
    c1:maj7 }


% The score definition
\score {
    <<
        
        \context ChordNames = "PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOneChords" { \PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOneChords}
        \new Staff
        <<
            \set Staff.instrumentName = "Trumpet in B♭"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOne" {  \PartPadcFourbFiveFiveebEightThreeThreeTwocZeroOneeZeroOneFiveZeroeZerobSevenFiveFiveSixdSixfFourVoiceOne }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 100 }
    }

