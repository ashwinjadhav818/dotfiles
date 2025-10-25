@echo off
:: Start KMonad

echo Starting kmonad...
set "ConfigPath=%USERPROFILE%\.config"

:: Launch KMonad headless via conhost
start "" conhost --headless "%ConfigPath%\kmonad\kmonad.exe" "%ConfigPath%\kmonad\kmonad.kbd"

echo Kmonad started.
echo ---
