@echo off
REM Kanata Launcher Batch File
REM This can be double-clicked to run
echo Starting Window Manager Selection...
echo.

REM Define the paths for the executable and configuration file
set "ConfigPath=%USERPROFILE%\.dotfiles"

REM Start keymaps script
start "Keymaps" autohotkey "%ConfigPath%\.config\scripts\keymaps.ahk"

REM Start fixes script
start "Fixes" autohotkey "%ConfigPath%\.config\scripts\fixes.ahk"

REM Start kanata in background
start "Kanata" conhost --headless %ConfigPath%\.config\kanata\kanata_gui.exe -c "%ConfigPath%\.config\kanata\kanata.kbd"

REM Start yasb
start "YASB"/b yasbc start

REM Start kanata in background
start "Emacs Deamon" conhost --headless sh -c "emacs --daemon"

echo Scripts: started scripts
echo Kanata: %ConfigPath%\.config\kanata\kanata_gui.exe
echo YASB: yasbc
echo Emacs: daemon

REM Set komorebi config environment variable
set "KOMOREBI_CONFIG_HOME=%USERPROFILE%\.dotfiles\.config\komorebi"

REM Prompt user to select a window manager
:WM_SELECTION
echo Please choose your preferred Window Manager:
echo [1] Komorebi WM
echo [2] GlazeWM
set /p WM_CHOICE="Enter 1 or 2: "

IF /I "%WM_CHOICE%"=="1" GOTO KOMOREBI
IF /I "%WM_CHOICE%"=="2" GOTO GLAZEWM
echo Invalid choice. Please enter 1 or 2.
echo.
GOTO WM_SELECTION

:KOMOREBI
echo Starting Komorebi WM...

REM Start komorebi
start "Komorebi" /b komorebic start --ahk --masir

echo All Komorebi components started!
GOTO END

:GLAZEWM
echo Starting GlazeWM...
REM Start GlazeWM
start "GlazeWM" /b glazewm start 

echo All GlazeWM components started!
GOTO END

:END
echo.
echo Press any key to exit...
pause
