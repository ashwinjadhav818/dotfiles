; Disable Useless Windows Keybinds

; Disable Ctrl+S in browsers
if WinActive("ahk_exe helium.exe") {
    ^s::return ; Disable Ctrl + S only in Helium Browser
}

; Sound
Pause:: {
    Sleep(500) ; Wait for 0.5 second
    SendMessage(0x112, 0xF170, 2,, "Program Manager")
}
;Volume_Up:: {
;    currentVolume := SoundGetVolume()
;    SoundSetVolume(currentVolume + 1)  ; Increase volume by 1%
;}
;Volume_Down:: {
;    currentVolume := SoundGetVolume()
;    SoundSetVolume(currentVolume - 1)  ; Decrease volume by 1%
;}

