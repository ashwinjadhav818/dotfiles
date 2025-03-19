#Requires AutoHotkey v2.0

; Launch Media
Launch_Media::^!+S ; Launches Spotify
Launch_App2::^!+p ; Launches Notion

; Keybinds
#Enter::Run "wt"
~LWin:: {
    LWinDown := true
    Send("{Blind}{vkE8}")
}
#D:: {
    Send("{Blind}{vkE8}")
}

; Sound
Pause:: {
    Sleep(500) ; Wait for 0.5 second
    SendMessage(0x112, 0xF170, 2,, "Program Manager")
}
Volume_Up:: {
    currentVolume := SoundGetVolume()
    SoundSetVolume(currentVolume + 1)  ; Increase volume by 1%
}
Volume_Down:: {
    currentVolume := SoundGetVolume()
    SoundSetVolume(currentVolume - 1)  ; Decrease volume by 1%
}

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")
