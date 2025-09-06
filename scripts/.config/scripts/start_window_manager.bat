@echo off
REM Usage: [glazewm|komorebi|windows-workspaces]

echo Starting common background services...
echo.

REM Define the paths for the configuration files
set "ConfigPath=%USERPROFILE%\.config"

REM Start common background scripts
start "Keymaps" /b autohotkey "%ConfigPath%\scripts\keymaps.ahk"
start "Fixes" /b autohotkey "%ConfigPath%\scripts\fixes.ahk"
start "Emacs Deamon" conhost --headless sh -c "emacs --daemon" 
start "Kanata" conhost --headless %ConfigPath%\kanata\kanata_gui.exe -c "%ConfigPath%\kanata\kanata.kbd"

echo Background services started.
echo ---

REM --- Window Manager/Workspace Selection ---

REM Check for a command-line argument
IF /I "%1"=="glazewm" GOTO GLAZEWM
IF /I "%1"=="komorebi" GOTO KOMOREBI
IF /I "%1"=="windows-workspaces" GOTO WINDOWS_WORKSPACES
IF NOT "%1"=="" (
echo Unknown workspace type: '%1'.
echo Supported types are: glazewm, komorebi, windows-workspaces.
GOTO END
)

:WM_SELECTION
echo Please choose your preferred Workspace:
echo [1] Komorebi WM
echo [2] GlazeWM
echo [3] Windows Workspaces
set /p WM_CHOICE="Enter 1, 2, or 3: "

IF /I "%WM_CHOICE%"=="1" GOTO KOMOREBI
IF /I "%WM_CHOICE%"=="2" GOTO GLAZEWM
IF /I "%WM_CHOICE%"=="3" GOTO WINDOWS_WORKSPACES
echo Invalid choice. Please enter 1, 2, or 3.
echo.
GOTO WM_SELECTION

:GLAZEWM
echo Starting GlazeWM environment...
start "yasb" /b yasb
start "GlazeWM" /b glazewm start
GOTO END

:KOMOREBI
echo Starting Komorebi environment...
set "KOMOREBI_CONFIG_HOME=%ConfigPath%\komorebi"
start "yasb" /b yasb
start "Komorebi" /b komorebic start --ahk --masir
GOTO END

:WINDOWS_WORKSPACES
echo Starting Windows Workspaces desktop switcher...
start "Windows Workspaces" /b "%ConfigPath%\scripts\windows-workspaces\desktop_switcher.ahk"
GOTO END

:END
echo.
echo Setup completed.
