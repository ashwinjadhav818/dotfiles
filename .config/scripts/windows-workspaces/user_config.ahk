; ====================
; === INSTRUCTIONS ===
; ====================
; 1. Any lines starting with ; are ignored
; 2. After changing this config file run script file "desktop_switcher.ahk"
; 3. Every line is in the format HOTKEY::ACTION

; === SYMBOLS ===
; !     <- Alt
; <^>!  <- AltGr
; +     <- Shift
; ^     <- Ctrl
; #     <- Win
; For more, visit https://autohotkey.com/docs/Hotkeys.htm

; === EXAMPLES ===
; !1::switchDesktopByNumber(1)             <- <Alt> + <1> will switch to the first desktop
; ===========================
; === END OF INSTRUCTIONS ===
; ===========================

; Set up 10 workspaces on startup
setupWorkspace(10)

; === INSTRUCTIONS ===
; Below is the alternate key configuration. Delete symbol ; in the beginning of the line to enable.
; Note, that  !1  means "Alt + 1",  !^1  means "Alt + Ctrl + 1" and !+1  means "Alt + Shift + 1"
; Note, that  <^>! stands for AltGr key which some keyboards might have instead of a Right Alt key"
; === END OF INSTRUCTIONS ===
; !1::switchDesktopByNumber(1)
; !2::switchDesktopByNumber(2)
; !3::switchDesktopByNumber(3)
; !4::switchDesktopByNumber(4)
; !5::switchDesktopByNumber(5)
; !6::switchDesktopByNumber(6)
; !7::switchDesktopByNumber(7)
; !8::switchDesktopByNumber(8)
; !9::switchDesktopByNumber(9)
; !0::switchDesktopByNumber(10)
;
; !Numpad1::switchDesktopByNumber(1)
; !Numpad2::switchDesktopByNumber(2)
; !Numpad3::switchDesktopByNumber(3)
; !Numpad4::switchDesktopByNumber(4)
; !Numpad5::switchDesktopByNumber(5)
; !Numpad6::switchDesktopByNumber(6)
; !Numpad7::switchDesktopByNumber(7)
; !Numpad8::switchDesktopByNumber(8)
; !Numpad9::switchDesktopByNumber(9)
; !Numpad0::switchDesktopByNumber(10)
;
; !l::switchDesktopToRight()
; !h::switchDesktopToLeft()
; !p::switchDesktopToLastOpened()
;
; !+1::MoveCurrentWindowToDesktop(1)
; !+2::MoveCurrentWindowToDesktop(2)
; !+3::MoveCurrentWindowToDesktop(3)
; !+4::MoveCurrentWindowToDesktop(4)
; !+5::MoveCurrentWindowToDesktop(5)
; !+6::MoveCurrentWindowToDesktop(6)
; !+7::MoveCurrentWindowToDesktop(7)
; !+8::MoveCurrentWindowToDesktop(8)
; !+9::MoveCurrentWindowToDesktop(9)
; !+0::MoveCurrentWindowToDesktop(10)
;
; !+Numpad1::MoveCurrentWindowToDesktop(1)
; !+Numpad2::MoveCurrentWindowToDesktop(2)
; !+Numpad3::MoveCurrentWindowToDesktop(3)
; !+Numpad4::MoveCurrentWindowToDesktop(4)
; !+Numpad5::MoveCurrentWindowToDesktop(5)
; !+Numpad6::MoveCurrentWindowToDesktop(6)
; !+Numpad7::MoveCurrentWindowToDesktop(7)
; !+Numpad8::MoveCurrentWindowToDesktop(8)
; !+Numpad9::MoveCurrentWindowToDesktop(9)
; !+Numpad0::MoveCurrentWindowToDesktop(10)
;
; !+l::MoveCurrentWindowToRightDesktop()
; !+h::MoveCurrentWindowToLeftDesktop()
;
; ; !^c::createVirtualDesktop()
; ; !^d::deleteVirtualDesktop()
; !q::!F4
; !d::Send ^{Esc}
; !f::minMaxActiveWindow()
; !+m::swapAll()
;
; ; For keyboards with AltGr key
; <^>!1::switchDesktopByNumber(1)
; <^>!2::switchDesktopByNumber(2)
; <^>!3::switchDesktopByNumber(3)
; <^>!4::switchDesktopByNumber(4)
; <^>!5::switchDesktopByNumber(5)
; <^>!6::switchDesktopByNumber(6)
; <^>!7::switchDesktopByNumber(7)
; <^>!8::switchDesktopByNumber(8)
; <^>!9::switchDesktopByNumber(9)
; <^>!0::switchDesktopByNumber(10)
;
; <^>!Numpad1::switchDesktopByNumber(1)
; <^>!Numpad2::switchDesktopByNumber(2)
; <^>!Numpad3::switchDesktopByNumber(3)
; <^>!Numpad4::switchDesktopByNumber(4)
; <^>!Numpad5::switchDesktopByNumber(5)
; <^>!Numpad6::switchDesktopByNumber(6)
; <^>!Numpad7::switchDesktopByNumber(7)
; <^>!Numpad8::switchDesktopByNumber(8)
; <^>!Numpad9::switchDesktopByNumber(9)
; <^>!Numpad0::switchDesktopByNumber(10)
;
; <^>!l::switchDesktopToRight()
; <^>!h::switchDesktopToLeft()
; <^>!p::switchDesktopToLastOpened()
;
; <^>!+1::MoveCurrentWindowToDesktop(1)
; <^>!+2::MoveCurrentWindowToDesktop(2)
; <^>!+3::MoveCurrentWindowToDesktop(3)
; <^>!+4::MoveCurrentWindowToDesktop(4)
; <^>!+5::MoveCurrentWindowToDesktop(5)
; <^>!+6::MoveCurrentWindowToDesktop(6)
; <^>!+7::MoveCurrentWindowToDesktop(7)
; <^>!+8::MoveCurrentWindowToDesktop(8)
; <^>!+9::MoveCurrentWindowToDesktop(9)
; <^>!+0::MoveCurrentWindowToDesktop(10)
;
; <^>!+Numpad1::MoveCurrentWindowToDesktop(1)
; <^>!+Numpad2::MoveCurrentWindowToDesktop(2)
; <^>!+Numpad3::MoveCurrentWindowToDesktop(3)
; <^>!+Numpad4::MoveCurrentWindowToDesktop(4)
; <^>!+Numpad5::MoveCurrentWindowToDesktop(5)
; <^>!+Numpad6::MoveCurrentWindowToDesktop(6)
; <^>!+Numpad7::MoveCurrentWindowToDesktop(7)
; <^>!+Numpad8::MoveCurrentWindowToDesktop(8)
; <^>!+Numpad9::MoveCurrentWindowToDesktop(9)
; <^>!+Numpad0::MoveCurrentWindowToDesktop(10)
;
; <^>!+l::MoveCurrentWindowToRightDesktop()
; <^>!+h::MoveCurrentWindowToLeftDesktop()
;
; ; <^>!^c::createVirtualDesktop()
; ; <^>!^d::deleteVirtualDesktop()
; <^>!q::Send !{F4}
; <^>!d::Send ^{Esc}
; <^>!f::minMaxActiveWindow()
; <^>!+m::swapAll()

; === INSTRUCTIONS ===
; Below is the alternate key configuration. Delete symbol ; in the beginning of the line to enable.
; Note, that  #1  means "Super + 1",  #^1  means "Super + Ctrl + 1" and #+1  means "Super + Shift + 1"
; === END OF INSTRUCTIONS ===

#1::switchDesktopByNumber(1)
#2::switchDesktopByNumber(2)
#3::switchDesktopByNumber(3)
#4::switchDesktopByNumber(4)
#5::switchDesktopByNumber(5)
#6::switchDesktopByNumber(6)
#7::switchDesktopByNumber(7)
#8::switchDesktopByNumber(8)
#9::switchDesktopByNumber(9)
#0::switchDesktopByNumber(10)

#Numpad1::switchDesktopByNumber(1)
#Numpad2::switchDesktopByNumber(2)
#Numpad3::switchDesktopByNumber(3)
#Numpad4::switchDesktopByNumber(4)
#Numpad5::switchDesktopByNumber(5)
#Numpad6::switchDesktopByNumber(6)
#Numpad7::switchDesktopByNumber(7)
#Numpad8::switchDesktopByNumber(8)
#Numpad9::switchDesktopByNumber(9)
#Numpad0::switchDesktopByNumber(10)

#l::switchDesktopToRight()
#h::switchDesktopToLeft()
#p::switchDesktopToLastOpened()

#+1::MoveCurrentWindowToDesktop(1)
#+2::MoveCurrentWindowToDesktop(2)
#+3::MoveCurrentWindowToDesktop(3)
#+4::MoveCurrentWindowToDesktop(4)
#+5::MoveCurrentWindowToDesktop(5)
#+6::MoveCurrentWindowToDesktop(6)
#+7::MoveCurrentWindowToDesktop(7)
#+8::MoveCurrentWindowToDesktop(8)
#+9::MoveCurrentWindowToDesktop(9)
#+0::MoveCurrentWindowToDesktop(10)

#+Numpad1::MoveCurrentWindowToDesktop(1)
#+Numpad2::MoveCurrentWindowToDesktop(2)
#+Numpad3::MoveCurrentWindowToDesktop(3)
#+Numpad4::MoveCurrentWindowToDesktop(4)
#+Numpad5::MoveCurrentWindowToDesktop(5)
#+Numpad6::MoveCurrentWindowToDesktop(6)
#+Numpad7::MoveCurrentWindowToDesktop(7)
#+Numpad8::MoveCurrentWindowToDesktop(8)
#+Numpad9::MoveCurrentWindowToDesktop(9)
#+Numpad0::MoveCurrentWindowToDesktop(10)

#+l::MoveCurrentWindowToRightDesktop()
#+h::MoveCurrentWindowToLeftDesktop()

#^c::createVirtualDesktop()
#^d::deleteVirtualDesktop()
#q::!F4
#d::Send ^{Esc}
#y::minMaxActiveWindow()
#+m::swapAll()
