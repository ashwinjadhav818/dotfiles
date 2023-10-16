# Oh My Posh Themes
# oh-my-posh --init --shell pwsh --config ~\.config\powershell\Themes\aura.omp.json | Invoke-Expression
Invoke-Expression (&starship init powershell)
$ENV:STARSHIP_CONFIG = "$HOME\.config\starship.toml"

# Modules
Import-Module -Name Terminal-Icons

# Alias
Set-Alias np C:\Windows\notepad.exe
Set-Alias ll ls
Set-Alias g git
Set-Alias vi nvim
Set-Alias vim nvim
Set-Alias cmake make

# PSReadLine
Set-PSReadLineOption -EditMode Vi
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
# Set-PsReadLineOption -PredictionViewStyle ListView

# FZF
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
