$ConfigPath = "$env:USERPROFILE\.config"

Write-Host "Select workspace:"
Write-Host "[1] GlazeWM"
Write-Host "[2] Windows Workspaces"
$choice = Read-Host "Enter 1, 2, or 3"

$ConfigPath = "$env:USERPROFILE\.config"

switch ($choice) {
    "1" {
        Write-Host "Starting GlazeWM environment..."
        glazewm start
    }
    "2" {
        Write-Host "Starting Windows Workspaces desktop switcher..."
        autohotkey "$ConfigPath\scripts\windows-workspaces\desktop_switcher.ahk"
    }
    default {
        Write-Host "Invalid choice."
    }
}

Write-Host "Setup completed."

