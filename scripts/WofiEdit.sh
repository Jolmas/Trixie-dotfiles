#!/bin/bash

# WOFI STYLES
CONFIG="$HOME/.config/wofi/config-main"
STYLE="$HOME/.config/wofi/styles/style-light.css"
COLORS="$HOME/.config/wofi/colors"
SCRIPTS="$HOME/.config/scripts"
# Wofi window config (in %)
WOFI_WIDTH=25
WOFI_HEIGHT=22

labDir="$HOME/.config/labwc"
waybarDir="$HOME/.config/waybar"


wofi_command="wofi --dmenu \
			--prompt seleccione... \
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

menu(){
	printf "1. Configure_Labwc\n"
	printf "2. Configure_Waybar\n"
	printf "3. Configure_Autostart\n"
	printf "4. Temas_Waybar\n"
} 

main() {
    choice=$(menu | ${wofi_command} | cut -d. -f1)
    case $choice in
    1) 
        foot micro "$labDir/rc.xml"
        exit 0
        ;;
    2)
        foot micro "$waybarDir/config-default"
        exit 0
        ;;
    3)
        foot micro "$labDir/autostart"
        exit 0
        ;;
    4)
        $SCRIPTS/WayStyle.sh
        exit 0
        ;;
    *)
	esac
}
main

