# Script to restart Emacs daemon

# Forcefully terminate any existing Emacs processes
taskkill /f /im emacs.exe 2>$null

# Start Emacs in daemon mode using conhost
Start-Process conhost -ArgumentList "--headless", "sh", "-c", "emacs --daemon" -NoNewWindow
