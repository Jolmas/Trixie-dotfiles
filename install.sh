#!/bin/bash

echo "Installing..."

# -------------------------
# Directories
# -------------------------
src="./"
dest="$HOME/.config"

install() {
    local src=$1
    local dest=$2
    echo "Installing $src..."
    cp -r "$src/dunst" "$dest"
    cp -r "$src/labwc" "$dest"
    cp -r "$src/scripts" "$dest"
    cp -r "$src/swaylock" "$dest"
    cp -r "$src/tofi" "$dest"
    cp -r "$src/waybar" "$dest"
    cp -r "$src/wlogout" "$dest"
    cp -r "$src/wofi" "$dest"
}

install "$src" "$dest"

echo ""
echo "Installation complete!"
echo ""
