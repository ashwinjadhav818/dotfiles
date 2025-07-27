#Requires AutoHotkey v2.0

; Get the value of the DEFAULT_TERM environment variable
DEFAULT_TERM := EnvGet("DEFAULT_TERM")

; Keybinds
#Enter::Run DEFAULT_TERM
!Space::#s

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")

; Touchpad
+^#F22:: #a ; Detects three-finger tap (Ctrl+Shift+Win+F22)
