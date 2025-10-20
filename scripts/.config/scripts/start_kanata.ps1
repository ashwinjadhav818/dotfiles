Write-Host "Starting Kanata.."
$ConfigPath = "$env:USERPROFILE\.config"

sudo conhost --headless "$ConfigPath\kanata\kanata_gui.exe" -c "$ConfigPath\kanata\kanata.kbd"

Write-Host "Kanata GUI started."
Write-Host "---"
