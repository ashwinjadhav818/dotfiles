; Disable Useless Windows Keybinds

; --- Disable Start menu when Win pressed alone, keep Win+ combos ---
~LWin::
~RWin:: {
    ; When Win is pressed down, immediately send a dummy key
    ; to pre-empt Windows from queuing the Start menu
    Send("{Blind}{vkE8}")
}

~LWin Up::
~RWin Up:: {
    ; Block Start menu on release too, in case Windows queued it late
    Send("{Blind}{vkE8}")
    return
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
; --- Hide Taskbar ---
SetTimer(HideTaskbar, 5000)

HideTaskbar() {
    tray := WinExist("ahk_class Shell_TrayWnd")
    if (tray) {
        style := WinGetStyle("ahk_id " tray)
        if (style & 0x10000000) ; WS_VISIBLE flag
            WinHide("ahk_id " tray)
    }

    secTray := WinExist("ahk_class Shell_SecondaryTrayWnd")
    if (secTray) {
        style := WinGetStyle("ahk_id " secTray)
        if (style & 0x10000000)
            WinHide("ahk_id " secTray)
    }
}

