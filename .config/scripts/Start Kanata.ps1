# Define the paths for the executable and configuration file using the correct home directory variable
$KanataPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata_gui.exe"
$KanataConfigPath = "$env:USERPROFILE\.dotfiles\.config\kanata\kanata.kbd"

# Start the application directly with Start-Process
Start-Process -FilePath "conhost" -ArgumentList "--headless", $KanataPath, "-c", $KanataConfigPath
