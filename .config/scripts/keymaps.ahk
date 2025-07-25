#Requires AutoHotkey v2.0

; Keybinds
#Enter::Run "wezterm-gui"
!Space::#s

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")

; Touchpad
+^#F22:: #a ; Detects three-finger tap (Ctrl+Shift+Win+F22)
