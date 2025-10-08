# $HOME\.config\powershell\heavy.ps1
# -------------------------------------------------
# Loaded only when $env:FAST_START ? '1'
# -------------------------------------------------

# ---------- 1. Theme (cached) ----------
$themeSource = "$HOME\.config\powershell\Themes\aura.omp.json"
$themeCache  = "$env:LOCALAPPDATA\ohmyposh\cached_aura.ps1"

# Ensure cache folder exists (once)
$cacheDir = Split-Path $themeCache -Parent
if (-not (Test-Path $cacheDir)) {
    New-Item -ItemType Directory -Path $cacheDir -Force | Out-Null
}

# Use the pre-generated cache; regenerate only if source JSON changed
if (-not (Test-Path $themeCache) -or
    (Get-Item $themeCache).LastWriteTime -lt (Get-Item $themeSource).LastWriteTime) {
    oh-my-posh --init --shell pwsh --config $themeSource > $themeCache
}
. $themeCache   # dot-source cached script


# ---------- 2. zoxide lazy cd ----------
function cd {
    if (-not $script:ZoxideInitialized) {
        $zInit = & zoxide init powershell --cmd cd 2>$null
        if ($zInit) { Invoke-Expression ($zInit -join "`n") }
        $script:ZoxideInitialized = $true
    }
    Set-Location @args
}


# ---------- 3. PSReadLine (load immediately) ----------
Set-PSReadLineOption -PredictionSource History


# ---------- 4. (Optional) heavy modules ----------
# Uncomment only if you need them
# function Get-ChildItemWithIcons {
#     Import-Module Terminal-Icons -ErrorAction SilentlyContinue
#     Get-ChildItem @args
# }
# Set-Alias ls Get-ChildItemWithIcons
