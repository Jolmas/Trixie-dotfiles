#!/bin/bash

# Check which waybar theme is set
THEMES=(~/.config/waybar/style)
WAYBAR="$HOME/.config/scripts/Waybar.sh"

# Opciones del menú     
opciones=("byw" "clear" "dark-breeze" "dark-cat" "dark-tokyo" "dark" "default_alter" "dracula" "evergreen" "light" "mauve-light" "mauve" "moccha" "nord" "rgb" "sequoia" "simple")

# Función para ejecutar un comando mpc
ejecutar_comando() {
     ln -sf $THEMES/style-$1.css "$HOME/.config/waybar/style.css"
     ln -sf $THEMES/style-$1.css "$HOME/.config/waybar/style-default.css"
}

restart() {
	pkill waybar
	$WAYBAR &
	exit 0
}

# Mostrar el menú y ejecutar la opción seleccionada
opcion_seleccionada=$(gum choose --header="Waybar" "${opciones[@]}")

case $opcion_seleccionada in
    "byw")
        ejecutar_comando byw
        restart
        ;;
    "clear")
        ejecutar_comando clear
        restart
        ;;
    "dark-breeze")
        ejecutar_comando dark-breeze
        restart
        ;;
    "dark-cat")
        ejecutar_comando dark-cat
        restart
        ;;
    # ... otros casos
    "dark-tokyo")
        ejecutar_comando dark-tokyo
        restart
        ;;
    "dark")
        ejecutar_comando dark
        restart
        ;;
    "default_alter")
        ejecutar_comando default_alter
        restart
        ;;
    "dracula")
        ejecutar_comando dracula
        restart
        ;;
    "evergreen")
        ejecutar_comando evergreen
        restart
        ;;
    "light")
        ejecutar_comando light
        restart
        ;;
    "mauve-light")
        ejecutar_comando mauve-light
        restart
        ;;
    "mauve")
        ejecutar_comando mauve
        restart
        ;;
    "moccha")
        ejecutar_comando moccha
        restart
        ;;
    "nord")
        ejecutar_comando nord
        restart
        ;;
    "rgb")
        ejecutar_comando rgb
        restart
        ;;
    "sequoia")
        ejecutar_comando sequoia
        restart
        ;;
    "simple")
        ejecutar_comando simple
        restart
        ;;
esac
