@echo off
chcp 65001 >nul
setlocal enabledelayedexpansion

set "out="

rem --- read raw emacsclient output ---
for /f "usebackq delims=" %%i in (`emacsclient -e "(my/org-clock-task-and-time)" 2^>^&1`) do (
    set "out=%%i"
)

rem --- strip ALL quotes ---
set "out=!out:"=!"

rem --- trim whitespace ---
for /f "tokens=* delims= " %%a in ("!out!") do set "out=%%a"

rem --- treat '=', '', or whitespace-only as empty ---
if "!out!"=="=" set "out="
if "!out!"=="" (
    endlocal
    exit /b 0
)

echo !out!
endlocal

