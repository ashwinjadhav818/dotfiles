@echo off
:: Start common background services

echo Starting common background services...
set "ConfigPath=%USERPROFILE%\.config"

:: Launch AHK scripts
start "" autohotkey "%ConfigPath%\scripts\keymaps.ahk"
start "" autohotkey "%ConfigPath%\scripts\scripts_menu.ahk"

:: Start yasbc
start "" conhost --headless yasbc start

:: Start Emacs daemon headless
start "" conhost --headless sh -c "emacs --daemon"

echo Background services started.
echo ---

