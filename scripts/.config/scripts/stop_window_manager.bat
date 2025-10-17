@echo off
REM Window Manager Stop Script
REM This stops Kanata, Komorebi, GlazeWM and YASB
REM echo Stopping Window Manager Components...
echo.

REM Stop GlazeWM
echo Stopping GlazeWM...
REM Attempt to stop GlazeWM by killing its process
REM You might need to change 'GlazeWM.exe' to the actual process name if it's different
taskkill /f /im glazewm.exe 
if %errorlevel% equ 0 (
    echo GlazeWM stopped successfully
) else (
    echo Failed to stop GlazeWM or it wasn't running. Ensure 'GlazeWM.exe' is the correct process name.
)
echo.

echo All window manager components have been stopped!
REM echo Press any key to exit...
REM pause
