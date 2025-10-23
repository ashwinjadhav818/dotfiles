$ConfigPath = "$env:USERPROFILE\.config"

Write-Host "[1] Komorebi"
Write-Host "[2] GlazeWM"
Write-Host "[3] Windows Workspaces"
$choice = Read-Host "Enter 1, 2, or 3"

$ConfigPath = "$env:USERPROFILE\.config"

switch ($choice) {
    "1" {
        Write-Host "Starting Komorebi environment..."
        $env:KOMOREBI_CONFIG_HOME = "$ConfigPath\komorebi"
        & komorebic.exe "start" "--ahk" "--masir" 
    }
    "2" {
        Write-Host "Starting GlazeWM environment..."
        Start-Process glazewm "start"
    }
    "3" {
        Write-Host "Starting Windows Workspaces desktop switcher..."
        Start-Process autohotkey "$ConfigPath\scripts\windows-workspaces\desktop_switcher.ahk"
    }
    default {
        Write-Host "Invalid choice."
    }
}

Write-Host "Setup completed."

