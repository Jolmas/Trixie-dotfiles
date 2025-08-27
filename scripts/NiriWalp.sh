#!/bin/bash

# Configuration
WALLPAPER_DIR="$HOME/Imágenes/Wallpapers"
CACHE_FILE="$HOME/.cache/wlpaper-index.txt"
WOFI_CONFIG="$HOME/.config/wofi/config-main"
AZOTEBG="$HOME/.azotebg"
AZOTEMP="$HOME/.cache/temp_file"

# Ensure dependencies are installed
command -v convert >/dev/null || { notify-send "ImageMagick 'convert' is not installed."; exit 1; }
command -v swaybg >/dev/null || { notify-send "swaybg is not installed."; exit 1; }
command -v wofi >/dev/null || { notify-send "wofi is not installed."; exit 1; }

# Function to show folder selection
select_folder() {
    local folders=("All Wallpapers")
    while IFS= read -r -d $'\0' folder; do
        folders+=("$(basename "$folder")")
    done < <(find "$WALLPAPER_DIR" -mindepth 1 -maxdepth 1 -type d -print0 | sort -z)

    printf "%s\n" "${folders[@]}" | wofi \
        --dmenu \
        -p "󰉏 Carpeta de Fondos" \
        --conf "$WOFI_CONFIG"
}

# Function to show wallpaper selection from a folder
select_wallpaper() {
    local folder="$1"
    local wallpaper_paths=()
    local search_path="$WALLPAPER_DIR"

    if [[ "$folder" != "All Wallpapers" ]]; then
        search_path="$WALLPAPER_DIR/$folder"
    fi

    # Build the list of wallpaper paths
    mapfile -d '' -t wallpaper_paths < <(find "$search_path" -type f \( -iname "*.jpg" -o -iname "*.png" -o -iname "*.webp" -o -iname "*.gif" \) -print0 | sort -z)

    # Check if any wallpapers were found
    if [ ${#wallpaper_paths[@]} -eq 0 ]; then
        notify-send "No se encontraron wallpapers en: $search_path"
        exit 1
    fi

    local wofi_lines=()
    for path in "${wallpaper_paths[@]}"; do
        wofi_lines+=("$(basename "$path")")
    done

    # Let wofi handle the selection and get the result
    local selected_basename=$(printf "%s\n" "${wofi_lines[@]}" | wofi \
        --dmenu \
        -p "󰉏 Wallpaper ($folder)" \
        --conf "$WOFI_CONFIG")

    # If nothing was selected, exit
    [[ -z "$selected_basename" ]] && exit 0

    # Find the full path of the selected wallpaper
    for path in "${wallpaper_paths[@]}"; do
        if [[ "$(basename "$path")" == "$selected_basename" ]]; then
            echo "$path"
            return 0
        fi
    done

    # Fallback if the file is not found
    echo "Error: No se encontró la ruta para '$selected_basename'" >&2
    exit 1
}

# Main execution
SELECTED_FOLDER=$(select_folder)
[[ -z "$SELECTED_FOLDER" ]] && exit 0

SELECTED_WALLPAPER=$(select_wallpaper "$SELECTED_FOLDER")
[[ -z "$SELECTED_WALLPAPER" ]] && exit 0

# Apply the wallpaper
if [[ -f "$SELECTED_WALLPAPER" ]]; then
    echo "$SELECTED_WALLPAPER" > "$CACHE_FILE"

    # Kill existing swaybg processes
    pkill swaybg
    swaybg -o 'VGA-1' -i "$SELECTED_WALLPAPER" -m fill &
    sleep 0.5
    head -n 2 "$AZOTEBG" > "$AZOTEMP"
    cp "$AZOTEMP" "$AZOTEBG"
    echo "swaybg -o 'VGA-1' -i \"$SELECTED_WALLPAPER\" -m fill &" >> "$AZOTEBG"

    # Lightweight notification
    notify-send -t 3000 "Wallpaper Aplicado" "󰉏 $(basename "$SELECTED_WALLPAPER")"

fi
