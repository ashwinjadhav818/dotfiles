# $PROFILE.CurrentUserAllHosts  (fast core)
Set-Alias np C:\Windows\notepad.exe
Set-Alias ls 'eza'
function eza-list {eza -la}
Set-Alias ll eza-list
Set-Alias g git
Set-Alias vi nvim
Set-Alias vim vi
Set-Alias cmake make
Set-Alias lg lazygit
Set-Alias bash sh
$Env:KOMOREBI_CONFIG_HOME = 'C:\Users\Ashwin\.config\komorebi'

# Fast-start flag - skip heavy stuff
if ($env:FAST_START -ne '1') {
    . $HOME\.config\powershell\heavy.ps1   # <-- all heavy stuff
}

