@echo off
:: Restart Emacs daemon

echo Restarting Emacs daemon...

:: Forcefully terminate any existing Emacs processes
taskkill /F /IM emacs.exe >nul 2>&1

:: Start Emacs in daemon mode using conhost
start "" conhost --headless sh -c "emacs --daemon"

echo Emacs daemon restarted.

