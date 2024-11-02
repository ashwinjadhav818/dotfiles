$StartupPath="HKCU:\Software\Microsoft\Windows\CurrentVersion\Run"
$ProgramName="Kanata"
$KanataPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata.exe"
$KanataConfigPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata.kbd"
$StartupCommand="C:\Windows\system32\conhost.exe --headless $KanataPath --cfg $KanataConfigPath"

Set-ItemProperty -LiteralPath "$StartupPath" -Name "$ProgramName" -Value "$StartupCommand"
