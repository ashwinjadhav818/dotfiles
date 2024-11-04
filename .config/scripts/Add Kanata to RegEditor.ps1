$StartupPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"

$ProgramName="Kanata"
$KanataPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata_gui.exe"
$KanataConfigPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata.kbd"

$StartupCommand="conhost --headless $KanataPath -c $KanataConfigPath"

Set-ItemProperty -LiteralPath "$StartupPath" -Name "$ProgramName" -Value "$StartupCommand"
