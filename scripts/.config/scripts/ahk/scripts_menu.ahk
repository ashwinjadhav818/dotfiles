#Requires AutoHotkey v2.0
#SingleInstance Force

; ================================
; Script Launcher Menu
; Hotkey: Win + D
; Lists all .ps1 and .bat scripts from a chosen directory
; and runs them in their default application asynchronously.
; ================================

; --------- CONFIGURATION ---------
global scriptsDir := EnvGet("USERPROFILE") . "\.config\scripts"
global scriptExtensions := [".ps1", ".bat", ".ahk"] 
#d::OpenScriptsMenu()
; --------------------------------

OpenScriptsMenu() {
    global scriptsDir, scriptExtensions

    if !DirExist(scriptsDir) {
        MsgBox("Error: Scripts folder not found:`n" . scriptsDir, "Script Menu Error", "IconStop")
        return
    }

    scriptMenu := Menu()
    count := 0

    for ext in scriptExtensions {
        Loop Files, scriptsDir . "\*" . ext, "F" {
            scriptMenu.Add(A_LoopFileName, RunScript)
            count++
        }
    }

    if (count = 0) {
        MsgBox("No supported scripts found in:`n" . scriptsDir, "Script Menu", "IconInformation")
        return
    }

    ShowMenuCentered(scriptMenu)
}

RunScript(ItemName, ItemPos, MyMenu) {
    global scriptsDir

    scriptPath := scriptsDir . "\" . ItemName

    if !FileExist(scriptPath) {
        MsgBox("Script not found:`n" . scriptPath, "Run Error", "IconStop")
        return
    }

    try {
        Run(scriptPath)  ; Launch normally
    } catch {
        MsgBox("Failed to run script:`n" . ItemName, "Run Error", "IconStop")
    }
}

ShowMenuCentered(menuObj) {
    ; Get primary monitor work area (excluding taskbar)
    MonitorGetWorkArea(1, &left, &top, &right, &bottom)
    centerX := (left + right) // 2
    centerY := (top + bottom) // 2

    ; Offset slightly to make it look centered
    menuObj.Show(centerX - 100, centerY - 50)
}
