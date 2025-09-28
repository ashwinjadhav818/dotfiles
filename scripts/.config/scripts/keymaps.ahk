
#Requires AutoHotkey v2.0

; Get the value of the DEFAULT_TERM environment variable
DEFAULT_TERM := EnvGet("DEFAULT_TERM")

; Keybinds
#Enter::Run DEFAULT_TERM
;#s::!Space
!Space::#s
#w::Run "conhost --headless start_emacs_client.bat"
#b::Run "C:\tools\cromite\chrome.exe"

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")

; Touchpad
+^#F22:: #a ; Detects three-finger tap (Ctrl+Shift+Win+F22)

; Toggle Windows Taskbar visibility with Ctrl+Alt+T
hidden := false

^!t:: {
    global hidden

    if hidden {
        SetTimer(HideTaskbar, 0)  ; stop timer
        if WinExist("ahk_class Shell_TrayWnd")
            WinShow("ahk_class Shell_TrayWnd")
        if WinExist("ahk_class Shell_SecondaryTrayWnd")
            WinShow("ahk_class Shell_SecondaryTrayWnd")
        hidden := false
    } else {
        SetTimer(HideTaskbar, 500) ; check every 500ms
        hidden := true
    }
}

HideTaskbar() {
    if WinExist("ahk_class Shell_TrayWnd")
        WinHide("ahk_class Shell_TrayWnd")
    if WinExist("ahk_class Shell_SecondaryTrayWnd")
        WinHide("ahk_class Shell_SecondaryTrayWnd")
}


