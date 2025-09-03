#!/bin/bash

# Define la ruta del archivo de forma segura.
# Usar $HOME es una buena práctica para la portabilidad.
ARCHIVO_SALIDA="/tmp/wspace_$(whoami)"
ACTIVE="$HOME/.config/scripts/WSpaces.sh"
# Verifica si se proporcionó un argumento.
if [ -z "$1" ]; then
    echo "Error: No input found."
    exit 1
fi

# El comando 'printf' es más fiable que 'echo' para manejar cadenas con caracteres especiales.
printf "%s" "$1" > "$ARCHIVO_SALIDA"
notify-send "Workspace" "$1" -i desktop -t 2000
$ACTIVE
