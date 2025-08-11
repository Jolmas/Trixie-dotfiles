#!/bin/bash

# Obtener el número de espacio de trabajo actual
# LabWC no tiene una forma directa de obtener el número de escritorio desde un script externo
# Necesitarás una herramienta que pueda consultar el estado del compositor,
# o puedes pasar el número de escritorio como argumento desde rc.xml

# Opción 1: Pasar el número de escritorio como argumento desde rc.xml
DESKTOP_NUM=$1

# Define tus fondos de pantalla
WALLPAPER_DIR="$HOME/Imágenes/Wallpapers" # Cambia esto a tu directorio de fondos
WALLPAPER=""

case "$DESKTOP_NUM" in
    1) WALLPAPER="$WALLPAPER_DIR/macOS_Tahoe_DefaultDark.png" ;;
    2) WALLPAPER="$WALLPAPER_DIR/macOS_Tahoe_LightDefault.png" ;;
    3) WALLPAPER="$WALLPAPER_DIR/purpleeyes.png" ;;
    *) WALLPAPER="$WALLPAPER_DIR/win11-blue.jpg" ;; # Fondo de pantalla predeterminado
esac

# Mata cualquier instancia anterior de swaybg para evitar conflictos
pkill swaybg &>/dev/null
pkill wbg &>/dev/null

# Establece el nuevo fondo de pantalla
if [ -f "$WALLPAPER" ]; then
    wbg -s "$WALLPAPER" & # Usa -s stretch
else
    echo "Error: El archivo de fondo de pantalla '$WALLPAPER' no existe."
fi
