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

