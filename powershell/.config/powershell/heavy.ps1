# $HOME\.config\powershell\heavy.ps1
# -------------------------------------------------
# Loaded only when $env:FAST_START ? '1'
# -------------------------------------------------

# ---------- 1. Theme (cached) ----------
$themeSource = "$HOME\.config\powershell\Themes\aura.omp.json"

# oh-my-posh 
oh-my-posh init pwsh --config $themeSource | Invoke-Expression

# ---------- 2. zoxide lazy cd ----------
if (-not $script:ZoxideInitialized) {
    $zInit = & zoxide init powershell --cmd cd 2>$null
    if ($zInit) { Invoke-Expression ($zInit -join "`n") }
    $script:ZoxideInitialized = $true
}
Set-Location @args


# ---------- 3. PSReadLine (load immediately) ----------
Set-PSReadLineOption -PredictionSource History


# ---------- 4. (Optional) heavy modules ----------
# Uncomment only if you need them
# function Get-ChildItemWithIcons {
#     Import-Module Terminal-Icons -ErrorAction SilentlyContinue
#     Get-ChildItem @args
# }
# Set-Alias ls Get-ChildItemWithIcons
