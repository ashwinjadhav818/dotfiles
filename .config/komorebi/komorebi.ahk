#SingleInstance Force

; Load library
#Include komorebic.lib.ahk
; Load configuration
#Include komorebi.generated.ahk

; Focus windows
#w::Focus("up")
#a::Focus("left")
#s::Focus("down")
#d::Focus("right")
#+[::CycleFocus("previous")
#+]::CycleFocus("next")

; Move windows
#+w::Move("up")
#+a::Move("left")
#+s::Move("down")
#+d::Move("right")
#+Enter::Promote()
    
; Stack windows
#!w::Stack("up")
#!a::Stack("left")
#!s::Stack("down")
#!d::Stack("right")
#;::Unstack()
#[::CycleStack("previous")
#]::CycleStack("next")

; Resize
#=::ResizeAxis("horizontal", "increase")
#-::ResizeAxis("horizontal", "decrease")
#+=::ResizeAxis("vertical", "increase")
#+-::ResizeAxis("vertical", "decrease")

; Manipulate windows
#q::Close()
#f::ToggleFloat()
#+f::ToggleMonocle()
^!f::ToggleFloat()
^!+f::ToggleMonocle()

; Window manager options
#+r::Retile()
#^p::TogglePause()

; Layouts
!x::FlipLayout("horizontal")
!y::FlipLayout("vertical")

; Workspaces
#1::FocusWorkspace(0)
#2::FocusWorkspace(1)
#3::FocusWorkspace(2)
#4::FocusWorkspace(3)
#5::FocusWorkspace(4)
#6::FocusWorkspace(5)
#7::FocusWorkspace(6)
#8::FocusWorkspace(7)
#9::FocusWorkspace(8)

#^Left::CycleWorkspace("previous")
#^Right::CycleWorkspace("next")
^!+a::CycleWorkspace("previous")
^!+d::CycleWorkspace("next")

; Move windows across workspaces
#+1::MoveToWorkspace(0)
#+2::MoveToWorkspace(1)
#+3::MoveToWorkspace(2)
#+4::MoveToWorkspace(3)
#+5::MoveToWorkspace(4)
#+6::MoveToWorkspace(5)
#+7::MoveToWorkspace(6)
#+8::MoveToWorkspace(7)
#+9::MoveToWorkspace(8)
