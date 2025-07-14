@echo off
REM Kanata Launcher Batch File
REM This can be double-clicked to run
echo Starting Window Manager...
echo.

REM Define the paths for the executable and configuration file
set "ConfigPath=%USERPROFILE%\.dotfiles"

REM Set komorebi config environment variable
set "KOMOREBI_CONFIG_HOME=%USERPROFILE%\.dotfiles\.config\komorebi"

REM Start kanata in background
start "Kanata" conhost --headless %ConfigPath%\.config\kanata\kanata_gui.exe -c "%ConfigPath%\.config\kanata\kanata.kbd"

REM Start komorebi
start "Komorebi" /b komorebic start --ahk --masir

REM Start yasb
start "YASB"/b yasbc start

echo All components started!
echo Kanata: %ConfigPath%\.config\kanata\kanata_gui.exe
echo Komorebi: komorebic with config at %KOMOREBI_CONFIG_HOME%
echo YASB: yasbc
REM echo.
REM echo Press any key to exit...
REM pause
