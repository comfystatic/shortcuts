#SingleInstance Force
#Persistent
#NoEnv

SendMode Input
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

Run, "%A_ScriptDir%\duck.ahk"
Run, "%A_ScriptDir%\syllabic.ahk"

#\::Reload

#`::Suspend

+BackSpace::Send, {Delete}
^+BackSpace::Send, ^{Delete}

>!Up::Send, {PgUp}
>!Down::Send, {PgDn}

>!+Up::Send, {Home}
>!+Down::Send, {End}

F3::Send #{Tab}

F7::Media_Prev
F8::Media_Play_Pause
F9::Media_Next
F10::Volume_Mute
F11::SoundSet -5
F12::SoundSet +5