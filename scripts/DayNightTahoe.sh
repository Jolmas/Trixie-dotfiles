#!/usr/bin/env bash

# Directorios
WALLPAPERS="$HOME/Pictures/Wallpapers"

# Estilos de Waybar y scripts
THEMES="$HOME/.config/waybar/style"
WAYBAR_SCRIPT="$HOME/.config/scripts/Waybar.sh"

# Archivo de estado para el modo día/noche.
STATUS_FILE="/tmp/daynight_$(whoami)"
STATUS=$(<"$STATUS_FILE")

day() {
	echo "Activando modo día..."
    
    # Enlaza los estilos de Waybar para el modo día
    ln -sf "$THEMES/style-tahoe.css" "$HOME/.config/waybar/style.css"
    ln -sf "$THEMES/style-tahoe.css" "$HOME/.config/waybar/style-default.css"
    
    # Cambia el tema de Labwc al tema claro
    CURRENT_THEME=$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>" | awk -F"[><]" '{print $3}')
    sed -i "s/$CURRENT_THEME/Lab-Liquid-Glass/g" ~/.config/labwc/rc.xml

    # Establece el tema de Iconos y GTK claro
	gsettings set org.gnome.desktop.interface gtk-theme MacTahoe-Light
	gsettings set org.gnome.desktop.interface icon-theme MacTahoe-light
	                
    # Establece el fondo de pantalla
    pkill swaybg
    swaybg -i "$WALLPAPERS/macOS_Tahoe_LightDefault.png" -m fill &
    
    # Actualiza el archivo de configuración de azote
    local AZOTEBG="$HOME/.azotebg"
	local AZOTEMP="$HOME/.cache/temp_file"
    sleep 0.5
    head -n 2 "$AZOTEBG" > "$AZOTEMP"
    cp "$AZOTEMP" "$AZOTEBG"
    echo "swaybg -o 'VGA-1' -i \"$WALLPAPERS/macOS_Tahoe_LightDefault.png\" -m fill &" >> "$AZOTEBG"
    
    # Escribe el nuevo estado (día) en el archivo de estado
    printf "%s" "0" > "$STATUS_FILE"
    
    restart_services
}

night() {
	echo "Activando modo noche..."
    
    # Enlaza los estilos de Waybar para el modo noche
    ln -sf "$THEMES/style-tahoe-dark.css" "$HOME/.config/waybar/style.css"
    ln -sf "$THEMES/style-tahoe-dark.css" "$HOME/.config/waybar/style-default.css"
    
    # Cambia el tema de Labwc al tema oscuro
    CURRENT_THEME=$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>" | awk -F"[><]" '{print $3}')
    sed -i "s/$CURRENT_THEME/Lab-Liquid-Dark/g" ~/.config/labwc/rc.xml
    
    # Establece el tema Iconos y GTK oscuro
	gsettings set org.gnome.desktop.interface gtk-theme MacTahoe-Dark
	gsettings set org.gnome.desktop.interface icon-theme MacTahoe-dark

    # Establece el fondo de pantalla
    pkill swaybg
    swaybg -i "$WALLPAPERS/macOS_Tahoe_DefaultDark.png" -m fill &
    
    # Actualiza el archivo de configuración de azote
    local AZOTEBG="$HOME/.azotebg"
    local AZOTEMP="$HOME/.cache/temp_file"
    sleep 0.5
    head -n 2 "$AZOTEBG" > "$AZOTEMP"
    cp "$AZOTEMP" "$AZOTEBG"
    echo "swaybg -o 'VGA-1' -i \"$WALLPAPERS/macOS_Tahoe_DefaultDark.png\" -m fill &" >> "$AZOTEBG"
    
    # Escribe el nuevo estado (noche) en el archivo de estado
    printf "%s" "1" > "$STATUS_FILE"
    
    restart_services
}

restart_services() {
    echo "Reiniciando servicios..."
    pkill waybar
    "$WAYBAR_SCRIPT" &
    labwc -r &
    exit 0
}

activate() {
    # El archivo de estado se crea la primera vez.
    if [ ! -f "$STATUS_FILE" ]; then
        echo "1" > "$STATUS_FILE" # Si no existe, asume que es noche para iniciar en día.
    fi
    
    # Ahora lee el valor del archivo de estado y compara el contenido
    local STATUS_CONTENT=$(<"$STATUS_FILE")

    if [ "$STATUS_CONTENT" == "1" ]; then
        day
    elif [ "$STATUS_CONTENT" == "0" ]; then
        night
    fi
}

# La llamada a la función 'activate' debe estar al final del script para que se ejecute.
activate
