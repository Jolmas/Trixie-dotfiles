#!/bin/bash

echo "Installing configuration files..."

# -------------------------
# Directories
# -------------------------
src="./"
dest="$HOME/.config"

# --- List of directories to install ---
config_dirs=(
    "radion"
)

# --- Installation function ---
install() {
    local source_dir=$1
    local destination_dir=$2
    
    # Check if source directory exists
    if [ ! -d "$source_dir" ]; then
        echo "Error: Source directory '$source_dir' not found. Exiting."
        exit 1
    fi

    # Create destination directory if it doesn't exist
    if [ ! -d "$destination_dir" ]; then
        echo "Creating destination directory: $destination_dir"
        mkdir -p "$destination_dir"
    fi
    
    for dir in "${config_dirs[@]}"; do
        if [ -d "$source_dir/$dir" ]; then
            echo "Installing $dir..."
            cp -r "$source_dir/$dir" "$destination_dir"
        else
            echo "Warning: Directory '$dir' not found in source. Skipping."
        fi
    done
}

# --- Run installation ---
install "$src" "$dest"
chmod +x wofiradion.sh
cp  wofiradion.sh ~/.local/bin
cp  wofiradion.desktop ~/.local/share/applications

echo ""
echo "Installation complete! 🎉"
echo ""

