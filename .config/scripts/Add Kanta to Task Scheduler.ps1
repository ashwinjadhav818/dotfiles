$KanataPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata_gui.exe"
$KanataConfigPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata.kbd"

$Action = New-ScheduledTaskAction -Execute "conhost" -Argument "--headless `"$KanataPath`" -c `"$KanataConfigPath`""
$Trigger = New-ScheduledTaskTrigger -AtLogOn
$Principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest
$Settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries

$Task = New-ScheduledTask -Action $Action -Principal $Principal -Trigger $Trigger -Settings $Settings
Register-ScheduledTask -TaskName "Run Kanata with Admin" -InputObject $Task
