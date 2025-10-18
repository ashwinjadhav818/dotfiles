Write-Host "Starting common background services..."
$ConfigPath = "$env:USERPROFILE\.config"

autohotkey "$ConfigPath\scripts\keymaps.ahk"
autohotkey "$ConfigPath\scripts\scripts_menu.ahk"
autohotkey "$ConfigPath\scripts\fixes.ahk"
yasbc "start"
conhost --headless sh -c "emacs --daemon"

Write-Host "Background services started."
Write-Host "---"

