; Disable Useless Windows Keybinds

; --- Disable Start menu when Win pressed alone, keep Win+ combos ---

; Pressing LWin/RWin alone won't open Start
~LWin::
~RWin::
{
    ; wait briefly to see if another key joins (combo)
    KeyWait("LWin", "T0.300")
    KeyWait("RWin", "T0.300")

    if (GetKeyState("LWin", "P") || GetKeyState("RWin", "P"))
        return  ; a combo started, don't block

    ; Win was pressed alone  block Start
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

; Hide Taskbar
^+f:: {  ; alt+shift+f toggles taskbar visibility
    if WinExist("ahk_class Shell_TrayWnd") {
        if WinGetStyle("ahk_class Shell_TrayWnd") & 0x10000000
            WinHide("ahk_class Shell_TrayWnd")
        else
            WinShow("ahk_class Shell_TrayWnd")
    }
}
; --- Hide Taskbar once and when Explorer restarts ---
HideTaskbar()

OnMessage(0x0001, OnShellRestart) ; WM_CREATE (used when explorer restarts)
OnMessage(0x0018, OnShellRestart) ; WM_SHOWWINDOW (safety net)

HideTaskbar() {
    if WinExist("ahk_class Shell_TrayWnd")
        WinHide("ahk_class Shell_TrayWnd")
    if WinExist("ahk_class Shell_SecondaryTrayWnd")
        WinHide("ahk_class Shell_SecondaryTrayWnd")
}

OnShellRestart(*) {
    SetTimer(Rehide, -500)  ; wait 0.5 s, then rehide once
}

Rehide() {
    HideTaskbar()
}
