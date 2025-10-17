#Requires AutoHotkey v2.0
#SingleInstance Force

; ================================
; Script Launcher Menu
; Hotkey: Win + H
; Lists all .ps1 and .bat scripts
; from a chosen directory, and
; runs them when clicked.
; ================================

; --------- CONFIGURATION ---------
; Path to the scripts folder
global scriptsDir := EnvGet("USERPROFILE") . "\.config\scripts"

; Extensions to include in the menu
global scriptExtensions := [".ps1", ".bat"]

; Hotkey (Win + T)
#t::OpenScriptsMenu()
; --------------------------------

; Open the dynamic scripts menu
OpenScriptsMenu() {
    global scriptsDir, scriptExtensions
    
    ; Verify that the folder exists
    if !DirExist(scriptsDir) {
        MsgBox(
            "Error: The scripts directory does not exist:`n" . scriptsDir,
            "Script Menu Error",
            "IconStop"
        )
        return
    }
    
    ; Create menu object
    scriptMenu := Menu()
    count := 0
    
    ; Loop through allowed extensions
    for ext in scriptExtensions {
        Loop Files, scriptsDir . "\*" . ext, "F" {
            scriptMenu.Add(A_LoopFileName, RunScript)
            count++
        }
    }
    
    ; If no scripts found
    if (count = 0) {
        MsgBox(
            "No supported scripts found in:`n" . scriptsDir,
            "Script Menu",
            "IconInformation"
        )
        return
    }
    
    ; Show the menu in the center of the primary screen
    ShowMenuCentered(scriptMenu)
}

; Run the selected script
RunScript(ItemName, ItemPos, MyMenu) {
    global scriptsDir
    
    scriptPath := scriptsDir . "\" . ItemName
    
    try {
        Run(scriptPath)  ; Launch normally
    } catch as e {
        MsgBox(
            "Failed to run script:`n" . ItemName . "`nError: " . e.Message,
            "Run Error",
            "IconStop"
        )
    }
}

; Utility: Show menu centered on screen
ShowMenuCentered(menuObj) {
    ; Get primary monitor work area (excluding taskbar)
    MonitorGetWorkArea(1, &left, &top, &right, &bottom)
    centerX := (left + right) // 2
    centerY := (top + bottom) // 2
    
    ; Offset slightly so it looks centered
    menuObj.Show(centerX - 100, centerY - 50)
}


