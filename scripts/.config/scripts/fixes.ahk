; Disable Useless Windows Keybinds

; --- Disable Start menu when Win pressed alone, keep Win+ combos ---
~LWin::
~RWin:: {
    ; When Win is pressed down, immediately send a dummy key
    ; to pre-empt Windows from queuing the Start menu
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
;Volume_Up:: {
;    currentVolume := SoundGetVolume()
;    SoundSetVolume(currentVolume + 1)  ; Increase volume by 1%
;}
;Volume_Down:: {
;    currentVolume := SoundGetVolume()
;    SoundSetVolume(currentVolume - 1)  ; Decrease volume by 1%
;}

