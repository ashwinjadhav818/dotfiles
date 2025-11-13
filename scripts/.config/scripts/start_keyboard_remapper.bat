@echo off

set "ConfigPath=%USERPROFILE%\.config"

echo [1] Kanata 
echo [2] Kmonad 
set /p choice=Enter 1, or 2: 

:: Kanata 
if "%choice%"=="1" (
    echo Starting Kanata...
    start "" conhost --headless "%ConfigPath%\kanata\kanata_gui.exe" -c "%ConfigPath%\kanata\kanata.kbd"
    goto end
)

:: Kmonad 
if "%choice%"=="2" (
    echo Starting Kmonad...
    start "" conhost --headless "%ConfigPath%\kmonad\kmonad.exe" "%ConfigPath%\kmonad\kmonad.kbd"
    goto end
)

:: Default
echo Invalid choice.

:end
echo Setup completed.

