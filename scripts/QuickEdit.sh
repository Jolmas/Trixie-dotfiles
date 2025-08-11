#!/bin/bash

# WOFI STYLES
CONFIG="$HOME/.config/wofi/WofiBig/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

wayDir="$HOME/.config/waybar"
labDir="$HOME/.config/labwc"
# wofi window config (in %)
WIDTH=10
HEIGHT=20

## Wofi Command
wofi_command="wofi --show dmenu \
			--prompt Editar...
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WIDTH% --height=$HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

menu(){
  printf "1. Waybar Config\n"
  printf "2. Labwc Config\n"
  printf "3. Labwc Menu\n"
}

main() {
    choice=$(menu | ${wofi_command} | cut -d. -f1)
    case $choice in
        1)
            foot -e micro "$wayDir/config-default"
            ;;
        2)
            foot -e micro "$labDir/rc.xml"
            ;;
        3)
            foot -e micro "$labDir/menu.xml"
            ;;
        *)
            ;;
    esac
}

main
