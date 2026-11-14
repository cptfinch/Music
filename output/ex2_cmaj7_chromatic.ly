\version "2.24.3"
% automatically converted by musicxml2ly from /home/user/Music/output/ex2_cmaj7_chromatic.musicxml
\pointAndClickOff

\header {
  title = "Exercise 2 - Chromatic enclosures on Cmaj7 chord tones"
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
PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOne = 
\relative des' {
    \clef "treble" \numericTimeSignature\time 4/4 | % 1
    \tempo 4=100 r2 - "half step above, half step below" r4 \stemUp des8
    [ \stemUp b8 ] | % 2
    c2 r4 \stemUp f8 [ \stemUp dis8 ] | % 3
    e2 r4 \stemUp as8 [ \stemUp fis8 ] | % 4
    g2 r4 \stemDown c8 [ \stemDown ais8 ] \break | % 5
    b2 r4 \stemDown des8 [ \stemDown b8 ] | % 6
    c2 r4 \stemDown c8 [ \stemDown ais8 ] | % 7
    b2 r4 \stemUp as8 [ \stemUp fis8 ] | % 8
    g2 r4 \stemUp f8 [ \stemUp dis8 ] \break | % 9
    e2 r4 \stemUp des8 [ \stemUp b8 ] | \barNumberCheck #10
    c1 }

PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOneChords = 
\chordmode {
    | % 1
    c2:maj7 s4 s8 s8 | % 2
    c2:maj7 s4 s8 s8 | % 3
    c2:maj7 s4 s8 s8 | % 4
    c2:maj7 s4 s8 s8 | % 5
    c2:maj7 s4 s8 s8 | % 6
    c2:maj7 s4 s8 s8 | % 7
    c2:maj7 s4 s8 s8 | % 8
    c2:maj7 s4 s8 s8 | % 9
    c2:maj7 s4 s8 s8 | \barNumberCheck #10
    c1:maj7 }


% The score definition
\score {
    <<
        
        \context ChordNames = "PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOneChords" { \PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOneChords}
        \new Staff
        <<
            \set Staff.instrumentName = "Trumpet in B♭"
            
            \context Staff << 
                \mergeDifferentlyDottedOn\mergeDifferentlyHeadedOn
                \context Voice = "PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOne" {  \PartPFivebcaeTwoFourdEightNineeNineZerofNineNineEightfFourbSevendfTwoFiveccdOneTwobTwoVoiceOne }
                >>
            >>
        
        >>
    \layout {}
    % To create MIDI output, uncomment the following line:
    %  \midi {\tempo 4 = 100 }
    }

