#!/bin/bash

XML_THEME_FILE="$HOME/.config/labwc/rc.xml" # Puedes cambiar esto por el nombre real de tu archivo XML
# --------------------

echo "Extrayendo el nombre del tema del archivo: $XML_THEME_FILE"

if [[ ! -f "$XML_THEME_FILE" ]]; then
    echo "Error: El archivo '$XML_THEME_FILE' no se encontró."
    exit 1
fi

TEMA_EXTRAIDO=$(grep -oP '<icon>\K[^<]+(?=</icon>)' "$XML_THEME_FILE")

if [[ -z "$TEMA_EXTRAIDO" ]]; then
    echo "Error: No se pudo extraer el nombre del tema del archivo '$XML_THEME_FILE'."
    exit 1
fi

echo "Nombre del tema: '$TEMA_EXTRAIDO'"
echo "Aplicando el tema '$TEMA_EXTRAIDO'..."

gsettings set org.gnome.desktop.interface icon-theme "$TEMA_EXTRAIDO"

if [[ $? -eq 0 ]]; then
    echo "¡Tema de Iconos '$TEMA_EXTRAIDO' aplicado con éxito! 🎉"
else
    echo "Error al aplicar el tema de iconos '$TEMA_EXTRAIDO'. Asegúrate de que el tema esté instalado en tu sistema. 😔"
fi
