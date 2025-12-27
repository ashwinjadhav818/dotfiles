#!/bin/bash
WALL_DIR="$HOME/Pictures/Wallpapers"

list_wallpapers() {
    find "$WALL_DIR" -maxdepth 1 -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) | while read -r wall; do
        echo -en "$(basename "$wall")\0icon\x1f$wall\n"
    done
}

choice=$(list_wallpapers | rofi -dmenu -i -p "Wallpaper" \
    -show-icons \
    -theme-str 'window { height: 530px; } listview { spacing: 10px; layout: horizontal; } element { orientation: vertical; width: 800px; padding: 10px; } element-icon { size: 400px; } element-text { horizontal-align: 0.5; }')

if [ -n "$choice" ]; then
    # Matugen sets the wallpaper AND generates colors for both files now
    matugen image "$WALL_DIR/$choice" -m dark
    
    notify-send "System Theme" "Applied $choice"
fi
