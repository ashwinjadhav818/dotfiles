#!/bin/bash

# 1. Path to your wallpapers
WALL_DIR="$HOME/Pictures/Wallpapers"

# 2. Function to generate the list for Rofi
list_wallpapers() {
    if [ ! -d "$WALL_DIR" ]; then
        notify-send "Error" "Directory $WALL_DIR not found."
        return
    fi

    # Find images and format for Rofi: Name\0icon\x1fPath
    find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r wall; do
        echo -en "$(basename "$wall")\0icon\x1f$wall\n"
    done
}

# 3. Run Rofi (Grid view)
choice=$(list_wallpapers | rofi -dmenu -i -p "Wallpaper" \
    -show-icons \
    -theme-str 'window { height: 530px; } listview { spacing: 10px; layout: horizontal; } element { orientation: vertical; width: 800px; padding: 10px; } element-icon { size: 400px; } element-text { horizontal-align: 0.5; }')

# 4. Apply selection using awww
if [ -n "$choice" ]; then
    # Using awww as requested
    swww img "$WALL_DIR/$choice" --transition-type grow --transition-pos 0.85,0.85 --transition-fps 60
    notify-send "Wallpaper" "Applied $choice"
fi
