@echo off
REM Window Manager Stop Script
REM This stops Kanata, Komorebi, and YASB
echo Stopping Window Manager Components...
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

REM Stop YASB
echo Stopping YASB...
yasbc stop
if %errorlevel% equ 0 (
    echo YASB stopped successfully
) else (
    echo Failed to stop YASB or it wasn't running
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
