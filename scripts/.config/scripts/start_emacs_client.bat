@echo off
setlocal

set MAX_RETRIES=60
set RETRY_COUNT=0

REM First, try to reuse an existing frame if server is running
emacsclient -n --eval "(select-frame-set-input-focus (selected-frame))" >nul 2>&1
if not errorlevel 1 (
    echo Emacs is already running - raised existing frame.
    exit /b 0
)

echo Emacs server not running. Starting daemon detached...
start "" conhost --headless sh -c "emacs --daemon"

:waitloop
emacsclient -n --eval nil >nul 2>&1
if errorlevel 1 (
    set /a RETRY_COUNT+=1
    if %RETRY_COUNT% GEQ %MAX_RETRIES% (
        echo ERROR: Emacs server did not start within %MAX_RETRIES% seconds.
        exit /b 1
    )
    echo "Waiting for Emacs server to start... (%RETRY_COUNT%/%MAX_RETRIES%)"
    timeout /t 1 >nul
    goto waitloop
)

REM Once server is up, open one client frame
emacsclient -c

endlocal

