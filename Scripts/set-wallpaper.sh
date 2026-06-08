#!/usr/bin/env bash

# Define your wallpaper directory
WALL_DIR="$HOME/Pictures/Wallpapers"

# Define the two virtual shortcut files
LINK_DP1="$WALL_DIR/current_dp1.png"
LINK_HDMI1="$WALL_DIR/current_hdmi1.png"

# Check if an argument was provided (Drag and drop or CLI)
if [ -n "$1" ] && [ -f "$1" ]; then
    NEW_WALL=$(realpath "$1")
else
    # 1. Get ONLY the plain filenames for Rofi using find + xargs basename
    SELECTED=$(find "$WALL_DIR" -maxdepth 1 -type f ! -name "current_*" -exec basename {} \; | rofi -dmenu -i -p "Select Wallpaper:")
    
    # Exit cleanly if you press ESC
    if [ -z "$SELECTED" ]; then
        exit 0
    fi
    
    # 2. Re-attach the directory path back to the plain filename cleanly
    NEW_WALL="$WALL_DIR/$SELECTED"
fi

# 1. Update the virtual pointers so they survive next system boot
ln -sf "$NEW_WALL" "$LINK_DP1"
ln -sf "$NEW_WALL" "$LINK_HDMI1"

# 2. Preload the new image into memory cache
hyprctl hyprpaper preload "$NEW_WALL"

# 3. Apply it to the displays immediately while the old one is still cached
hyprctl hyprpaper wallpaper DP-1,"$NEW_WALL"
hyprctl hyprpaper wallpaper HDMI-A-1,"$NEW_WALL"


echo "Wallpapers permanently updated to: $NEW_WALL"
