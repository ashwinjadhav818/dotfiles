#!/bin/bash

# Directory where your scripts live
SCRIPT_DIR="$HOME/.config/scripts/hyprland"

# Define the menu options (Display Name|Script Filename)
declare -A menu
menu=(
    ["Animations"]="hypranim.sh"
    ["Wallpaper"]="wallpaper.sh" # Example for future use
    ["Keybinds"]="keybinds_hint.sh" # Example for future use
)

# Pipe the keys (Display Names) to rofi
choice=$(printf "%s\n" "${!menu[@]}" | rofi -dmenu -i -p "Hypr Settings:")

# If a choice was made, execute the corresponding script
if [ -n "$choice" ]; then
    bash "$SCRIPT_DIR/${menu[$choice]}"
fi
