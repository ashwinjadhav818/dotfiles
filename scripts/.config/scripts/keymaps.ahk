#Requires AutoHotkey v2.0

; Get the value of the DEFAULT_TERM environment variable
DEFAULT_TERM := EnvGet("DEFAULT_TERM")
DEFAULT_BROWSER := EnvGet("DEFAULT_BROWSER")

; Keybinds
#Enter::Run DEFAULT_TERM
#s::!Space
; !Space::#s
#w::Run "conhost --headless start_emacs_client.bat"
#b::Run DEFAULT_BROWSER 

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")
