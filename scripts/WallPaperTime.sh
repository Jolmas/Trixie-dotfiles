#!/bin/bash

WALLPAPERS="/home/luis/Imágenes/Wallpapers"

while true; do
  ALIST=( `ls -w1 "$WALLPAPERS"` )
  RANGE=${#ALIST[@]}

  # Initialize .last if it doesn't exist or is empty
  if [ ! -f "$WALLPAPERS/.last" ] || [ -z "$(cat "$WALLPAPERS/.last" 2>/dev/null)" ]; then
    echo "0" > "$WALLPAPERS/.last"
    number=0
  else
    LASTNUM=$(cat "$WALLPAPERS/.last")
    let "number = ($LASTNUM + 1) % $RANGE"
  fi

  echo "$number" > "$WALLPAPERS/.last"

  pkill swaybg
  swaybg -i "$WALLPAPERS/${ALIST[$number]}" -m fill &

  # Esperar un tiempo antes de cambiar el fondo de pantalla nuevamente
  sleep 900 # Cambiar cada 5 minutos (ajusta este valor según sea necesario)
done
