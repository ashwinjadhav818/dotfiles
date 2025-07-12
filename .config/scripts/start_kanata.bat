@echo off
REM Kanata Launcher Batch File
REM This can be double-clicked to run

echo Starting Kanata...
echo.

REM Define the paths for the executable and configuration file
set "KanataPath=%USERPROFILE%\.dotfiles\.config\kanata\kanata_gui.exe"
set "KanataConfigPath=%USERPROFILE%\.dotfiles\.config\kanata\kanata.kbd"

REM Check if the executable exists
if not exist "%KanataPath%" (
    echo ERROR: Kanata executable not found at:
    echo %KanataPath%
    echo.
    pause
    exit /b 1
)

REM Check if the config file exists
if not exist "%KanataConfigPath%" (
    echo ERROR: Kanata config file not found at:
    echo %KanataConfigPath%
    echo.
    pause
    exit /b 1
)

REM Start the application silently
start "" conhost --headless "%KanataPath%" -c "%KanataConfigPath%"
