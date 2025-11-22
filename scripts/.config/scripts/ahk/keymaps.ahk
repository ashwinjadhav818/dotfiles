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
#d::Run "C:/Users/Ashwin/.config/scripts/menu.bat"
#f::Run "explorer.exe"

; Always on Top
#+p:: WinSetAlwaysOnTop(-1, "A")

; Colemak-DH hint
hintVisible := false
global guiHint

^!h::{
    global hintVisible, guiHint

    if hintVisible {
        try guiHint.Destroy()
        hintVisible := false
        return
    }

    guiHint := Gui("+AlwaysOnTop -Caption +ToolWindow")
    guiHint.BackColor := "EEFFFF"
    guiHint.SetFont("s12", "Consolas")

    text :=
    (
"Q  W  F  P  G     J  L  U  Y  ;
A  R  S  T  D     H  N  E  I  O
Z  X  C  V  B     K  M  ,  .  /

(Colemak)"
    )

    guiHint.Add("Text",, text)
    guiHint.Show("AutoSize Center")
    hintVisible := true
}
