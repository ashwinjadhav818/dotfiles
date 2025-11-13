@echo off
echo.

REM ---- Stop Kanata and Kmonad ----
echo Stopping Kanata and Kmonad...

REM Use `taskkill` directly; `sudo` is not a Windows command.
taskkill /F /IM kmonad.exe >nul 2>&1
taskkill /F /IM kanata_gui.exe >nul 2>&1

echo All keyboard remappers have been stopped!

