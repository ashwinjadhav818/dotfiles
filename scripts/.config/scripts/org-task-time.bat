@echo off
chcp 65001 >nul

for /f "usebackq delims=" %%i in (`emacsclient -e "(my/org-clock-task-and-time)"`) do (
    set out=%%i
)

REM remove leading and trailing quotes
set out=%out:"=%

echo %out%

