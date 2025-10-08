Write-Host "Starting common background services..."
$ConfigPath = "$env:USERPROFILE\.config"

Start-Process autohotkey "$ConfigPath\scripts\keymaps.ahk"
Start-Process autohotkey "$ConfigPath\scripts\scripts_menu.ahk"
Start-Process yasbc "start"
Start-Process conhost -ArgumentList "--headless", "sh", "-c", "emacs --daemon"

Write-Host "Background services started."
Write-Host "---"

