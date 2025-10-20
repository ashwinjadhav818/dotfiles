Write-Host "Starting kmonad.."
$ConfigPath = "$env:USERPROFILE\.config"

sudo conhost --headless "$ConfigPath\kmonad\kmonad.exe" "$ConfigPath\kmonad\kmonad.kbd"

Write-Host "Kmonad started."
Write-Host "---"
