#Requires AutoHotkey v2.0

Term := EnvGet("DEFAULT_TERM")

; Keybinds
#Enter::Run "alacritty" 

; Disable Useless Windows Keybinds
~LWin:: {
    LWinDown := true
    Send("{Blind}{vkE8}")
}
#D:: {
    Send("{Blind}{vkE8}")
}
#P:: {
    Send("{Blind}{vkE8}")
}

; Sound
Pause:: {
    Sleep(500) ; Wait for 0.5 second
    SendMessage(0x112, 0xF170, 2,, "Program Manager")
}
; Volume_Up:: {
;     currentVolume := SoundGetVolume()
;     SoundSetVolume(currentVolume + 1)  ; Increase volume by 1%
; }
; Volume_Down:: {
;     currentVolume := SoundGetVolume()
;     SoundSetVolume(currentVolume - 1)  ; Decrease volume by 1%
; }

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")

; Touchpad
+^#F22:: #a ; Detects three-finger tap (Ctrl+Shift+Win+F22)
