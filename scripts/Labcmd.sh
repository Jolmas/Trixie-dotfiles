#!/bin/bash

# Define la ruta al archivo de configuración de LabWC
RC_XML="$HOME/.config/labwc/rc.xml"

# Define la ruta a los archivos de configuración de Rofi
ROFICFG="$HOME/.config/rofi/themes/win11-list-light.rasi"
THEME_FILE="$HOME/.config/rofi/keybinds.rasi"

# Verifica si xmlstarlet está instalado
if ! command -v xmlstarlet &> /dev/null; then
    echo "Error: xmlstarlet no está instalado. Por favor, instálalo con tu gestor de paquetes."
    exit 1
fi

# Extrae los atajos y sus comandos del archivo XML
# La salida es una lista con el formato: <tecla> | <comando>
KEYBINDS_RAW=$(xmlstarlet sel -t -m "//keybind[action/@name='Execute']" -v "@key" -o " = " -v "action/@command" -n "$RC_XML")

# Muestra la lista en Rofi
# La opción '-dmenu' crea un menú interactivo.
# La opción '-i' hace que la búsqueda sea insensible a mayúsculas y minúsculas.
# La opción '-p' establece el texto del "prompt"
selected=$(echo "$KEYBINDS_RAW" | rofi -dmenu -i -p "LabWC Keybinds" -config "$ROFICFG" -theme "$THEME_FILE")

# Si se selecciona algo, extrae y ejecuta el comando
if [[ -n "$selected" ]]; then
    # Extrae el comando de la segunda columna usando 'awk'
    # Esto es crucial para manejar comandos con espacios o argumentos
    cmd=$(echo "$selected" | awk -F'=' '{print $2}' | xargs)
    
    # Ejecuta el comando en segundo plano
    if [[ -n "$cmd" ]]; then
        nohup $cmd &>/dev/null &
    fi
fi
