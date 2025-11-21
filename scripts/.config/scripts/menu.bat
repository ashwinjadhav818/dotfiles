@echo off
title Menu
setlocal enabledelayedexpansion

set "BASE=%USERPROFILE%\.config\scripts"

call :menu "%BASE%"
exit /b

:menu
@echo off
set "CUR=%~1"
cd /d "%CUR%" >nul 2>&1

set "LISTFILE=%TEMP%\menu_list.txt"
> "%LISTFILE%" type nul

:: Add Go Back except in base folder
if /i not "%CUR%"=="%BASE%" (
    echo [GO BACK]>> "%LISTFILE%"
)

:: Add folders
for /f "delims=" %%F in ('dir /b /ad 2^>nul') do (
    echo [DIR] %%F>> "%LISTFILE%"
)

:: Add scripts but hide menu.bat
for /f "delims=" %%F in ('dir /b 2^>nul ^| findstr /i "\.bat$ \.ps1$ \.ahk$"') do (
    if /i not "%%F"=="menu.bat" echo %%F>> "%LISTFILE%"
)

:: Show fzf
fzf --prompt "Select (%CUR%) > " < "%LISTFILE%" > "%TEMP%\choice.txt" 2>nul

set /p SEL= < "%TEMP%\choice.txt"
if not defined SEL exit /b


:: ----------------------------
:: GO BACK
:: ----------------------------
if /i "%SEL%"=="[GO BACK]" (
    call :up "%CUR%"
    exit /b
)


:: ----------------------------
:: ENTER DIRECTORY
:: ----------------------------
if "%SEL:~0,5%"=="[DIR]" (
    set "SUB=%SEL:~6%"
    call :menu "%CUR%\%SUB%"
    exit /b
)


:: ----------------------------
:: RUN FILE
:: ----------------------------
call :run "%CUR%\%SEL%"
exit /b



:up
@echo off
set "CURDIR=%~1"
for %%A in ("%CURDIR%") do set "PARENT=%%~dpA"
set "PARENT=%PARENT:~0,-1%"
call :menu "%PARENT%"
exit /b


:run
@echo off
set "FILE=%~1"

:: .bat
if /i "%FILE:~-4%"==".bat" (
    start "" "%FILE%" >nul 2>&1
    exit /b
)

:: .ahk
if /i "%FILE:~-4%"==".ahk" (
    start "" "%FILE%" >nul 2>&1
    exit /b
)

:: .ps1
if /i "%FILE:~-4%"==".ps1" (
    powershell -ExecutionPolicy Bypass -File "%FILE%" >nul 2>&1
    exit /b
)

exit /b

