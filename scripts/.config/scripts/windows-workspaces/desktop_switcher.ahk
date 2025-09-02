#Requires AutoHotkey v1.1.33+
#SingleInstance Force ; The script will Reload if launched while already running
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases
#KeyHistory 0 ; Ensures user privacy when debugging is not needed
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory
SendMode Input ; Recommended for new scripts due to its superior speed and reliability

; Globals
DesktopCount := 2 ; Windows starts with 2 desktops at boot
CurrentDesktop := 1 ; Desktop count is 1-indexed (Microsoft numbers them this way)
LastOpenedDesktop := 1

; DLL
hVirtualDesktopAccessor := DllCall("LoadLibrary", "Str", A_ScriptDir . "\VirtualDesktopAccessor.dll", "Ptr")
global IsWindowOnDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "IsWindowOnDesktopNumber", "Ptr")
global MoveWindowToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "MoveWindowToDesktopNumber", "Ptr")
global GoToDesktopNumberProc := DllCall("GetProcAddress", Ptr, hVirtualDesktopAccessor, AStr, "GoToDesktopNumber", "Ptr")

; Main
SetKeyDelay, 75
mapDesktopsFromRegistry()
OutputDebug, [loading] desktops: %DesktopCount% current: %CurrentDesktop%

#Include %A_ScriptDir%\user_config.ahk
return

;
; This function examines the registry to build an accurate list of the current virtual desktops and which one we're currently on.
; List of desktops appears to be in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops
; On Windows 11 the current desktop UUID appears to be in the same location
; On previous versions in HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\1\VirtualDesktops
;
mapDesktopsFromRegistry()
{
    global CurrentDesktop, DesktopCount

    ; Get the current desktop UUID. Length should be 32 always, but there's no guarantee this couldn't change in a later Windows release so we check.
    IdLength := 32
    SessionId := getSessionId()
    if (SessionId) {
        RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, CurrentVirtualDesktop
        if ErrorLevel {
            RegRead, CurrentDesktopId, HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\SessionInfo\%SessionId%\VirtualDesktops, CurrentVirtualDesktop
        }

        if (CurrentDesktopId) {
            IdLength := StrLen(CurrentDesktopId)
        }
    }

    ; Get a list of the UUIDs for all virtual desktops on the system
    RegRead, DesktopList, HKEY_CURRENT_USER, SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VirtualDesktops, VirtualDesktopIDs
    if (DesktopList) {
        DesktopListLength := StrLen(DesktopList)
        ; Figure out how many virtual desktops there are
        DesktopCount := floor(DesktopListLength / IdLength)
    }
    else {
        DesktopCount := 1
    }

    ; Parse the REG_DATA string that stores the array of UUID's for virtual desktops in the registry.
    i := 0
    while (CurrentDesktopId and i < DesktopCount) {
        StartPos := (i * IdLength) + 1
        DesktopIter := SubStr(DesktopList, StartPos, IdLength)
        OutputDebug, The iterator is pointing at %DesktopIter% and count is %i%.

        ; Break out if we find a match in the list. If we didn't find anything, keep the
        ; old guess and pray we're still correct :-D.
        if (DesktopIter = CurrentDesktopId) {
            CurrentDesktop := i + 1
            OutputDebug, Current desktop number is %CurrentDesktop% with an ID of %DesktopIter%.
            break
        }
        i++
    }
}

;
; Create total of workspaceCount number of desktops
; This takes the existing desktops into account
;
setupWorkspace(workspaceCount)
{
    global DesktopCount
    desktopCountToCreate := workspaceCount - DesktopCount
    if (desktopCountToCreate < 1) {
        return
    }
    OutputDebug, Creating %workspaceCount% workspaces
    while (desktopCountToCreate > 0) {
        createVirtualDesktop()
        desktopCountToCreate--
    }
    ; 300 is the minimum value that seems to consistently works on a modern pc when going from 1 to 10 virtual desktops
    ; but 500 has been set to make sure it always switches to the first v-desktop.
    Sleep, 500
    OutputDebug, Switching back to first workspace
    switchDesktopByNumber(1)
}

;
; This functions finds out ID of current session.
;
getSessionId()
{
    ProcessId := DllCall("GetCurrentProcessId", "UInt")
    if ErrorLevel {
        OutputDebug, Error getting current process id: %ErrorLevel%
        return
    }
    OutputDebug, Current Process Id: %ProcessId%

    DllCall("ProcessIdToSessionId", "UInt", ProcessId, "UInt*", SessionId)
    if ErrorLevel {
        OutputDebug, Error getting session id: %ErrorLevel%
        return
    }
    OutputDebug, Current Session Id: %SessionId%
    return SessionId
}

_switchDesktopToTarget(targetDesktop)
{
    ; Globals variables should have been updated via updateGlobalVariables() prior to entering this function
    global CurrentDesktop, DesktopCount, LastOpenedDesktop

    ; Don't attempt to switch to an invalid desktop
    if (targetDesktop > DesktopCount || targetDesktop < 1 || targetDesktop == CurrentDesktop) {
        OutputDebug, [invalid] target: %targetDesktop% current: %CurrentDesktop%
        return
    }

    LastOpenedDesktop := CurrentDesktop

    ; Fixes the issue of active windows in intermediate desktops capturing the switch shortcut and therefore delaying or stopping the switching sequence. This also fixes the flashing window button after switching in the taskbar. More info: https://github.com/pmb6tz/windows-desktop-switcher/pull/19
    WinActivate, ahk_class Shell_TrayWnd

    DllCall(GoToDesktopNumberProc, Int, targetDesktop-1)

    ; Makes the WinActivate fix less intrusive
    Sleep, 50
    focusTheForemostWindow(targetDesktop)
}

updateGlobalVariables()
{
    ; Re-generate the list of desktops and where we fit in that. We do this because
    ; the user may have switched desktops via some other means than the script.
    mapDesktopsFromRegistry()
}

switchDesktopByNumber(targetDesktop)
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(targetDesktop)
}

switchDesktopToLastOpened()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    updateGlobalVariables()
    _switchDesktopToTarget(LastOpenedDesktop)
}

switchDesktopToRight()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1)
}

switchDesktopToLeft()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    _switchDesktopToTarget(CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1)
}

focusTheForemostWindow(targetDesktop) {
    foremostWindowId := getForemostWindowIdOnDesktop(targetDesktop)
    if isWindowNonMinimized(foremostWindowId) {
        WinActivate, ahk_id %foremostWindowId%
    }
}

isWindowNonMinimized(windowId) {
    WinGet MMX, MinMax, ahk_id %windowId%
    return MMX != -1
}

isWindowMaximized(windowId) {
    WinGet MMX, MinMax, ahk_id %windowId%
    return MMX == 1
}

getForemostWindowIdOnDesktop(n)
{
    n := n - 1 ; Desktops start at 0, while in script it's 1

    ; winIDList contains a list of windows IDs ordered from the top to the bottom for each desktop.
    WinGet winIDList, list
    Loop % winIDList {
        windowID := % winIDList%A_Index%
        windowIsOnDesktop := DllCall(IsWindowOnDesktopNumberProc, UInt, windowID, UInt, n)
        ; Select the first (and foremost) window which is in the specified desktop.
        if (windowIsOnDesktop == 1) {
            return windowID
        }
    }
}

MoveCurrentWindowToDesktop(desktopNumber) {
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, desktopNumber - 1)
    ; switchDesktopByNumber(desktopNumber)
}

MoveCurrentWindowToRightDesktop()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, (CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1) - 1)
    _switchDesktopToTarget(CurrentDesktop == DesktopCount ? 1 : CurrentDesktop + 1)
}

MoveCurrentWindowToLeftDesktop()
{
    global CurrentDesktop, DesktopCount
    updateGlobalVariables()
    WinGet, activeHwnd, ID, A
    DllCall(MoveWindowToDesktopNumberProc, UInt, activeHwnd, UInt, (CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1) - 1)
    _switchDesktopToTarget(CurrentDesktop == 1 ? DesktopCount : CurrentDesktop - 1)
}

;
; This function creates a new virtual desktop and switches to it
;
createVirtualDesktop()
{
    global CurrentDesktop, DesktopCount
    Send, #^d
    DesktopCount++
    CurrentDesktop := DesktopCount
    OutputDebug, [create] desktops: %DesktopCount% current: %CurrentDesktop%
}

;
; This function deletes the current virtual desktop
;
deleteVirtualDesktop()
{
    global CurrentDesktop, DesktopCount, LastOpenedDesktop
    Send, #^{F4}
    if (LastOpenedDesktop >= CurrentDesktop) {
        LastOpenedDesktop--
    }
    DesktopCount--
    CurrentDesktop--
    OutputDebug, [delete] desktops: %DesktopCount% current: %CurrentDesktop%
}

minMaxActiveWindow() {
    WinGet, ID, ID, A
    if (isWindowMaximized(ID)) {
        Send #{Down}
    } else if (isWindowNonMinimized(ID)) {
        Send #{Up}
    }
}

;
; swapAll and swapMon have been taken from the below answer
; https://superuser.com/questions/1632298/switch-windows-to-other-screen-and-window-from-other-screen-to-main-screen
;
SetWinDelay, 0 ; This switching should be instant
swapAll()
{
    DetectHiddenWindows, Off ; I think this is default, but just for safety's sake...
    WinGet, WinArray, List ; , , , Sharp
    ; Enable the above commented out portion if you are running SharpE

    i := WinArray
    Loop, %i% {
        WinID := WinArray%A_Index%
        WinGetClass, ThisClass, ahk_id %WinID%
        if (ThisClass = "Shell_SecondaryTrayWnd") ; do not swap the secondary monitor taskbar
            continue
        WinGetTitle, CurWin, ahk_id %WinID%
        If (CurWin = ) ; For some reason, CurWin <> didn't seem to work.
            {}
            else
            {
                WinGet, IsMin, MinMax, ahk_id %WinID% ; The window will re-locate even if it's minimized
                If (IsMin = -1) {
                    WinRestore, ahk_id %WinID%
                    swapMon(WinID)
                    WinMinimize, ahk_id %WinID%
                } else {
                    swapMon(WinID)
                }
            }
    }
    return
}

swapMon(WinID) ; Swaps window with and ID of WinID onto the other monitor
{
    SysGet, Mon1, Monitor, 1
    Mon1Width := Mon1Right - Mon1Left
    Mon1Height := Mon1Bottom - Mon1Top

    SysGet, Mon2, Monitor, 2
    Mon2Width := Mon2Right - Mon2Left
    Mon2Height := Mon2Bottom - Mon2Top

    WinGetPos, WinX, WinY, WinWidth, WinHeight, ahk_id %WinID%
    WinCenter := WinX + (WinWidth / 2)
    if (WinCenter >= Mon1Left and WinCenter <= Mon1Right) {

        NewX := (WinX - Mon1Left) / Mon1Width
        NewX := Mon2Left + (Mon2Width * NewX)

        NewWidth := WinWidth / Mon1Width
        NewWidth := Mon2Width * NewWidth

        NewY := (WinY - Mon1Top) / Mon1Height
        NewY := Mon2Top + (Mon2Height * NewY)

        NewHeight := WinHeight / Mon1Height
        NewHeight := Mon2Height * NewHeight

    } else {
        NewX := (WinX - Mon2Left) / Mon2Width
        NewX := Mon1Left + (Mon1Width * NewX)

        NewWidth := WinWidth / Mon2Width
        NewWidth := Mon1Width * NewWidth

        NewY := (WinY - Mon2Top) / Mon2Height
        NewY := Mon1Top + (Mon1Height * NewY)

        NewHeight := WinHeight / Mon2Height
        NewHeight := Mon1Height * NewHeight
    }

    WinMove, ahk_id %WinID%, , %NewX%, %NewY%, %NewWidth%, %NewHeight%
    return
}

;
; Change the monitor resolution and refresh rate.
; credit: https://www.reddit.com/r/ultrawidemasterrace/comments/ogkiho/autohotkey_script_for_quickly_changing/
;
ChangeResolution(cD, sW, sH, rR) {
    VarSetCapacity(dM,156,0), NumPut(156,2,&dM,36)
    DllCall("EnumDisplaySettingsA", UInt,0, UInt,-1, UInt,&dM),
    NumPut(0x5c0000,dM,40)
    NumPut(cD,dM,104), NumPut(sW,dM,108), NumPut(sH,dM,112), NumPut(rR,dM,120)
    DllCall("ChangeDisplaySettingsA", UInt,&dM, UInt,0)
    return
}