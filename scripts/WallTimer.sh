#!/bin/bash

DIR=$HOME/Imágenes/Wallpapers
PICS=($(ls ${DIR}))
RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

# Función para cambiar el wallpaper
change_wallpaper() {
  pkill swaybg 2>/dev/null # Silencia el error si wbg no está corriendo
  swaybg -i ${DIR}/${RANDOMPICS} -m fill &
}

while true; do
	DIR=$HOME/Imágenes/Wallpapers
	PICS=($(ls ${DIR}))
	RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}
	change_wallpaper
  	sleep 900 # Cambia el wallpaper cada X segundos.
done
