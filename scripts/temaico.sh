#!/bin/bash

THEME_FILE="$HOME/.gtkrc-2.0"

echo "Extrayendo el nombre del tema del archivo: $THEME_FILE"

if [[ ! -f "$THEME_FILE" ]]; then
    echo "Error: El archivo '$THEME_FILE' no se encontró."
    exit 1
fi

TEMA_EXTRAIDO=$(awk -F'"' '/gtk-icon-theme-name/ {print $2}' "$THEME_FILE")

if [[ -z "$TEMA_EXTRAIDO" ]]; then
    echo "Error: No se pudo extraer el nombre del tema del archivo '$THEME_FILE'."
    exit 1
fi

echo "Nombre del tema: '$TEMA_EXTRAIDO'"
echo "Aplicando el tema '$TEMA_EXTRAIDO'..."

gsettings set org.gnome.desktop.interface icon-theme "$TEMA_EXTRAIDO"

#sed -i '' "s/$(grep "<icon>" ~/.config/labwc/rc.xml | grep "<icon>"| awk -F"[><]" '{print $3}')/$TEMA_EXTRAIDO/g" ~/.config/labwc/rc.xml

if [[ $? -eq 0 ]]; then
    echo "¡Tema de Iconos '$TEMA_EXTRAIDO' aplicado con éxito! 🎉"
else
    echo "Error al aplicar el tema de iconos '$TEMA_EXTRAIDO'. Asegúrate de que el tema esté instalado en tu sistema. 😔"
fi
