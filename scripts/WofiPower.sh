#!/usr/bin/env bash

# WOFI STYLES
CONFIG="$HOME/.config/wofi/configs/config-default"
STYLE="$HOME/.config/wofi/styles/style-dark.css"
COLORS="$HOME/.config/wofi/colors"

# Wofi window config (in %)
WOFI_WIDTH=25
WOFI_HEIGHT=22

wofi_command="wofi --dmenu \
			--prompt seleccione... \
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WOFI_WIDTH% --height=$WOFI_HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"
			
entries=$(echo -e "Apagar\nReiniciar\nSuspender\nBloquear\nSalir" | $wofi_command -i --dmenu)

case $entries in 
    Apagar)
    loginctl shutdown
        exit 0
        ;;
    Reiniciar)
    loginctl reboot
        exit 0
        ;;
    Suspender)
    loginctl suspend
        exit 0
        ;;
    Bloquear)
        $HOME/.config/scripts/LockScreen.sh
        ;;
    Salir)
        labwc --exit
        exit 0
        ;;
esac
