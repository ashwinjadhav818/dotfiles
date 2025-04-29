# Define the paths for the executable and configuration file using the correct home directory variable
$KomorebiConfig = "$env:USERPROFILE\.dotfiles\.config\komorebi\komorebi.json"
$AhkPath = "$env:USERPROFILE\.dotfiles\.config\komorebi\komorebi.ahk"

# Start the application directly with Start-Process
Start-Process komorebi -ArgumentList "-c $KomorebiConfig" -WindowStyle hidden 
Start-Process masir -WindowStyle hidden 
Start-Process autohotkey -ArgumentList "$AhkPath" -WindowStyle hidden 
Start-Process yasbc -ArgumentList "start" -WindowStyle hidden 
