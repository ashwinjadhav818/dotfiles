@echo off
:: Menu BAT equivalent of your PowerShell script

set "ConfigPath=%USERPROFILE%\.config"

echo [1] Komorebi
echo [2] GlazeWM
echo [3] Windows Workspaces
set /p choice=Enter 1, 2, or 3: 

:: Komorebi
if "%choice%"=="1" (
    echo Starting Komorebi environment...
    set "KOMOREBI_CONFIG_HOME=%ConfigPath%\komorebi"
    komorebic.exe start --ahk --masir
    goto end
)

:: GlazeWM
if "%choice%"=="2" (
    echo Starting GlazeWM environment...
    start "" glazewm start
    goto end
)

:: Windows Workspaces
if "%choice%"=="3" (
    echo Starting Windows Workspaces desktop switcher...
    start "" autohotkey "%ConfigPath%\scripts\windows-workspaces\desktop_switcher.ahk"
    goto end
)

:: Default
echo Invalid choice.

:end
echo Setup completed.
pause

