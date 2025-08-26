#!/bin/bash

# Define la ruta del archivo de forma segura.
# Usar $HOME es una buena práctica para la portabilidad.
ARCHIVO_SALIDA="$HOME/.cache/wspace"
ACTIVE="$HOME/.config/scripts/WSpaces.sh"
# Verifica si se proporcionó un argumento.
if [ -z "$1" ]; then
    echo "Error: Debes proporcionar un argumento para guardar."
    echo "Uso: ./guardar.sh \"texto a guardar\""
    exit 1
fi

# El comando 'printf' es más fiable que 'echo' para manejar cadenas con caracteres especiales.
printf "%s\n" "$1" > "$ARCHIVO_SALIDA"

$ACTIVE
