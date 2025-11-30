<#
.SYNOPSIS
A script to manage and switch between different "rice" (theme) configurations using a THEME/APP directory structure.

.DESCRIPTION
This script is hardcoded to assume the dotfiles repository is located at %USERPROFILE%\.dotfiles\. 
It handles file copying, backup, and reloading for YASB, Komorebi, and GlazeWM.
#>

# --- Configuration (HARDCODED TO %USERPROFILE%\.DOTFILES) ---

# Determine the user's home directory
$HomeDir = $env:USERPROFILE

# HARDCODED: Define the Dotfiles Root directory using the user's home path.
$BaseDir = Join-Path $HomeDir ".dotfiles"

# Define the paths relative to the Dotfiles Root ($BaseDir)
$RiceStorageDir = Join-Path $BaseDir "rices"
$BackupDir = Join-Path $BaseDir "backups"

# Define the managed applications, their active configuration directories, and the files they use.
# Source files are assumed to be located at $RiceStorageDir\THEME_NAME\APP_NAME\
$ConfigSets = @{
    "yasb" = @{
        "ActiveDir" = Join-Path $HomeDir ".config\yasb"; 
        "Files" = @("config.yaml", "styles.css")
    };
    "komorebi" = @{
        "ActiveDir" = Join-Path $HomeDir ".config\komorebi"; 
        "Files" = @("komorebi.json")
    };
    "glazewm" = @{
        "ActiveDir" = Join-Path $HomeDir ".config\glazewm"; 
        "Files" = @("config.yaml")
    }
}

# --- Function Definitions ---

function Ensure-Directories {
    Write-Host "`nEnsuring necessary directories exist..." -ForegroundColor DarkYellow
    if (-not (Test-Path $RiceStorageDir -PathType Container)) {
        Write-Host "Creating rice storage directory: $RiceStorageDir" -ForegroundColor Yellow
        New-Item -Path $RiceStorageDir -ItemType Directory | Out-Null
    }
    if (-not (Test-Path $BackupDir -PathType Container)) {
        Write-Host "Creating backup directory: $BackupDir" -ForegroundColor Yellow
        New-Item -Path $BackupDir -ItemType Directory | Out-Null
    }
}

function Get-AvailableRices {
    # Get all immediate subdirectories under the 'rices' folder. These are the Theme Names.
    Get-ChildItem -Path $RiceStorageDir -Directory | Select-Object -ExpandProperty Name
}

function Backup-CurrentConfig {
    Write-Host "`n-- Starting Backup --" -ForegroundColor Cyan
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $BackupName = "backup_$Timestamp"
    $TargetBackupPath = Join-Path $BackupDir $BackupName

    Write-Host "Creating backup directory: $BackupName"

    try {
        New-Item -Path $TargetBackupPath -ItemType Directory -Force | Out-Null
        
        $ConfigSets.GetEnumerator() | ForEach-Object {
            $AppName = $_.Name
            $ActiveDir = $_.Value.ActiveDir
            $Files = $_.Value.Files
            $AppBackupDir = Join-Path $TargetBackupPath $AppName

            if (-not (Test-Path $AppBackupDir)) { New-Item -Path $AppBackupDir -ItemType Directory | Out-Null }
            
            foreach ($File in $Files) {
                $SourcePath = Join-Path $ActiveDir $File
                if (Test-Path $SourcePath -PathType Leaf) {
                    Copy-Item -Path $SourcePath -Destination $AppBackupDir -Force
                }
            }
        }
        
        Write-Host "✅ Backup successful! Saved to $BackupName" -ForegroundColor Green
    }
    catch {
        Write-Host "❌ Backup failed: $($_.Exception.Message)" -ForegroundColor Red
    }
}

function Reload-WindowManagers {
    Write-Host "`n-- Reloading Applications --" -ForegroundColor Cyan

    # Reload GlazeWM (Using the common 'glaze.exe' name and assuming a valid reload command)
    Write-Host "Attempting to reload GlazeWM..."
    try {
        Start-Process -FilePath "glazewm.exe" -ArgumentList "command wm-reload-config" -Wait -NoNewWindow 
        Write-Host "✅ GlazeWM reload initiated." -ForegroundColor Green
    } catch {
        Write-Warning "Could not run 'glaze.exe reload'. GlazeWM may need manual restart."
    }

    # Reload Komorebi 
    Write-Host "Attempting to reload Komorebi..."
    try {
        Start-Process -FilePath "komorebic.exe" -ArgumentList "reload-config" -Wait -NoNewWindow
        Write-Host "✅ Komorebi configuration reloaded." -ForegroundColor Green
    } catch {
        Write-Warning "Could not run 'komorebic.exe reload-config'. Komorebi may need manual restart."
    }
}

function Apply-Rice {
    $RiceNames = Get-AvailableRices

    if (-not $RiceNames) {
        Write-Host "❌ No theme folders found in '$RiceStorageDir'. Exiting." -ForegroundColor Red
        return
    }

    Write-Host "`n-- Available Rice Themes --" -ForegroundColor Cyan
    for ($i = 0; $i -lt $RiceNames.Count; $i++) {
        Write-Host "$($i + 1). $($RiceNames[$i])"
    }
    
    $Choice = Read-Host "Enter the number or name of the Rice to apply (or 'b' to backup first):"
    
    if ($Choice -ceq 'b') {
        Backup-CurrentConfig
        $Choice = Read-Host "Now enter the number or name of the Rice to apply:"
    }
    
    [int]$Index = 0 
    $RiceName = $null

    if ([int]::TryParse($Choice, [ref]$Index)) {
        $Index-- 
        if ($Index -ge 0 -and $Index -lt $RiceNames.Count) {
            $RiceName = $RiceNames[$Index]
        }
    } elseif ($Choice -notin $RiceNames) {
        $RiceName = $Choice
    }

    if ([string]::IsNullOrWhiteSpace($RiceName) -or $RiceName -notin $RiceNames) {
        Write-Host "❌ Invalid selection or theme folder '$RiceName' not found." -ForegroundColor Red
        return
    }

    $ThemeSourceDir = Join-Path $RiceStorageDir $RiceName
    Write-Host "`nApplying Theme: '$RiceName'..." -ForegroundColor Yellow

    try {
        $ConfigSets.GetEnumerator() | ForEach-Object {
            $AppName = $_.Name
            $ConfigSet = $_.Value
            
            # Source path construction: $BaseDir\rices\THEME_NAME\APP_NAME
            $SourcePath = Join-Path $ThemeSourceDir $AppName
            
            if (-not (Test-Path $SourcePath -PathType Container)) {
                Write-Warning "Theme folder not found for $AppName in $RiceName. Skipping $AppName."
                return 
            }
            
            Write-Host "  Copying $AppName files..."
            foreach ($File in $ConfigSet.Files) {
                $SourceFile = Join-Path $SourcePath $File
                $DestFile = Join-Path $ConfigSet.ActiveDir $File
                
                if (Test-Path $SourceFile -PathType Leaf) {
                    if (-not (Test-Path $ConfigSet.ActiveDir -PathType Container)) {
                        New-Item -Path $ConfigSet.ActiveDir -ItemType Directory -Force | Out-Null
                    }
                    Copy-Item -Path $SourceFile -Destination $DestFile -Force
                } else {
                    Write-Warning "    File $File not found in $AppName source folder. Skipping copy."
                }
            }
        }
        
        Write-Host "`n✅ Theme '$RiceName' applied successfully to all configured apps!" -ForegroundColor Green
        Reload-WindowManagers
    }
    catch {
        Write-Host "❌ Failed to apply theme: $($_.Exception.Message)" -ForegroundColor Red
    }
}


# --- Main Menu Logic ---
Ensure-Directories

while ($true) {
    Write-Host "`n#####################################" -ForegroundColor DarkYellow
    Write-Host "#     🍚 Integrated Rice Manager 🍚   #" -ForegroundColor DarkYellow
    Write-Host "#####################################`n" -ForegroundColor DarkYellow
    
    Write-Host "1. Apply/Switch Rice"
    Write-Host "2. Backup Current Configuration"
    Write-Host "3. List Available Rices"
    Write-Host "4. Exit"
    Write-Host ""
    
    $MenuChoice = Read-Host "Enter your choice (1-4):"

    switch ($MenuChoice) {
        "1" { Apply-Rice }
        "2" { Backup-CurrentConfig }
        "3" { 
            Write-Host "`n-- Available Rice Themes --" -ForegroundColor Cyan
            $RiceNames = Get-AvailableRices
            if ($RiceNames) {
                $RiceNames
            } else {
                Write-Host "No theme folders found." -ForegroundColor Yellow
            }
            Read-Host "Press Enter to continue..." | Out-Null 
        }
        "4" { 
            Write-Host "`nExiting Rice Manager. Goodbye! 👋" -ForegroundColor Green
            exit 
        }
        default { 
            Write-Host "❌ Invalid choice. Please try again." -ForegroundColor Red 
        }
    }
}
