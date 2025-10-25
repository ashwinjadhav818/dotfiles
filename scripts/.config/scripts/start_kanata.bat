@echo off
:: Start Kanata GUI

echo Starting Kanata...
set "ConfigPath=%USERPROFILE%\.config"

:: Launch Kanata headless via conhost
start "" conhost --headless "%ConfigPath%\kanata\kanata_gui.exe" -c "%ConfigPath%\kanata\kanata.kbd"

echo Kanata GUI started.
echo ---

