@echo off
REM Window Manager Stop Script
REM This stops Kanata, Komorebi, GlazeWM and YASB
REM echo Stopping Window Manager Components...
echo.

REM Stop Komorebi
echo Stopping Komorebi...
komorebic stop
if %errorlevel% equ 0 (
    echo Komorebi stopped successfully
) else (
    echo Failed to stop Komorebi or it wasn't running
)
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

REM Stop YASB
echo Stopping YASB...
yasbc stop
if %errorlevel% equ 0 (
    echo YASB stopped successfully
) else (
    echo Failed to stop YASB or it wasn't running
)
echo.

REM Stop Komorebi Switcher
echo Stopping Komorebi Switcher...
taskkill /f /im komorebi-switcher.exe
if %errorlevel% equ 0 (
    echo Komorebi Switcher stopped successfully
) else (
    echo Failed to stop Komorebi Switcher or it wasn't running
)
echo.

REM Stop Kanata
echo Stopping Kanata...
taskkill /f /im kanata_gui.exe
if %errorlevel% equ 0 (
    echo Kanata stopped successfully
) else (
    echo Failed to stop Kanata or it wasn't running
)
echo.

echo All window manager components have been stopped!
REM echo Press any key to exit...
REM pause
