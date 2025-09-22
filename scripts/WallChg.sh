#!/bin/bash

# WALLPAPERS PATH
DIR="$HOME/Pictures/Wallpapers"

# wofi window config (in %)
WIDTH=25
HEIGHT=40

# Find image files (jpg, jpeg, png) in the specified directory
PICS=($(find "${DIR}" -maxdepth 1 -type f -regex '.*\.\(jpg\|jpeg\|png\)$'))

# Generate a random index within the bounds of the PICS array
if [[ ${#PICS[@]} -gt 0 ]]; then
  RANDOM_INDEX=$((RANDOM % ${#PICS[@]}))
  RANDOM_PIC="${PICS[$RANDOM_INDEX]}"
  RANDOM_PIC_NAME="Random Wallpaper" # More descriptive name
else
  echo "No wallpaper images found in ${DIR}"
  exit 1
fi

# WOFI STYLES
CONFIG="$HOME/.config/wofi/WofiBig/config" # Assuming a more standard config name
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

## Wofi Command
wofi_command="wofi --show dmenu \
              --prompt 'Select wallpaper...' \
              --conf \"${CONFIG}\" --style \"${STYLE}\" --color \"${COLORS}\" \
              --width=\"${WIDTH}%\" --height=\"${HEIGHT}%\" \
              --cache-file=/dev/null \
              --hide-scroll --no-actions \
              --matching=fuzzy"

menu() {
  # Loop through the PICS array with index
  for i in "${!PICS[@]}"; do
    # Check if the filename contains ".gif"
    if [[ "${PICS[$i]}" != *".gif"* ]]; then
      # Print index and filename without extension
      printf "%s. %s\n" "$i" "$(basename "${PICS[$i]}" .${PICS[$i]##*.})"
    else
      # Print index and full filename for GIFs
      printf "%s. %s\n" "$i" "${PICS[$i]}"
    fi
  done
  # Print the random wallpaper option
  printf "%s\n" "$RANDOM_PIC_NAME"
}

main() {
  choice=$(menu | eval "${wofi_command}") # Use eval to expand variables in wofi_command

  # No choice case
  if [[ -z "$choice" ]]; then
    return
  fi

  # Random choice case
  if [[ "$choice" = "$RANDOM_PIC_NAME" ]]; then
    swaybg -i "${RANDOM_PIC}" -m fill &
    return
  fi

  # Extract the index from the chosen line
  pic_index=$(echo "$choice" | cut -d'.' -f1)

  # Check if the extracted index is a number and within the array bounds
  if [[ "$pic_index" =~ ^[0-9]+$ ]] && [[ "$pic_index" -ge 0 ]] && [[ "$pic_index" -lt "${#PICS[@]}" ]]; then
    # Kill existing wbg process if running
    if pidof swaybg >/dev/null; then
      pkill swaybg
    fi
    # Set the new wallpaper
    swaybg -i "${PICS[$pic_index]}" -m fill &
  else
    echo "Invalid selection."
  fi
}

# Check if wofi is already running
if pidof wofi >/dev/null; then
  pkill wofi
  exit 0
else
  main
fi

