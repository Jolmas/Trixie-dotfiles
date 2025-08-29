#!/bin/bash
#       ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
#  WOFI │ R ││ A ││ D ││ I ││ O ││ N │
#       ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
# A bash script written by Christos Angelopoulos, October 2023, under GPL v2
# Modified for Wofi by Gemini and Jolmasch, August 2025

EDITOR="$(grep 'Preferred_editor' "$HOME/.config/radion/radion.conf" | cut -d " " -f2)"
 
function random_station
{
    rand_max_lim=$(grep -v -E '^$|^//' "$1" | wc -l)
    rand_station_index=$((1 + RANDOM % rand_max_lim))
    STATION=$(grep -v -E '^$|^//' "$1" | head -"$rand_station_index" | tail -1 | awk '{print $2}' | sed 's/-/ /g;s/~//g')
    STATION_URL="$(grep "~${STATION// /-}"~ "$1" | awk '{print $1}')"
}

function play_station
{
    echo "ESTACIÓN: $STATION"
    echo "URL     : $STATION_URL"
    pkill mpv
    mpv "$STATION_URL"
    sleep 10
    pkill wofi
}

function select_tag
{
    TAGS=$(sed 's/ /\n/g' "$HOME/.config/radion/stations.txt" | grep '#' | grep -v '#Favoritas' | sort | uniq | sed 's/#//g')
    FAVS=$(grep '#Favoritas' "$HOME/.config/radion/stations.txt" | grep -v -E '^$|^//' | awk {'print $2'} | sed 's/~//g;s/-/ /g')

    OPTIONS="Estación Aleatoria\n"
    if [ -n "$FAVS" ]; then
        OPTIONS+="--- Favoritas ---\n$FAVS\n"
    fi
    if [ -n "$TAGS" ]; then
        OPTIONS+="--- Etiquetas ---\n$TAGS\n"
    fi
    OPTIONS+="--- Acciones ---\nTodas las Estaciones\nEditar Estaciones\nEstación Aleatoria\nApagar Radio\nPreferencias\nBuscar Estaciones\nSalir"

    SELECTION=$(echo -e "$OPTIONS" | wofi --show dmenu -p "Wofi Radion:")

    case "$SELECTION" in
        "Todas las Estaciones")
            select_station_from_file "$HOME/.config/radion/stations.txt" "Todas las Estaciones"
            ;;
        "Editar Estaciones")
            foot $EDITOR "$HOME/.config/radion/stations.txt"
            ;;
        "Estación Aleatoria")
            random_station "$HOME/.config/radion/stations.txt"
            play_station
            ;;
        "Apagar Radio")
        	pkill mpv
        	;;
        "Preferencias")
            foot $EDITOR "$HOME/.config/radion/radion.conf"
            ;;
        "Buscar Estaciones")
            URL_OPENER="xdg-open"
            if [[ "$OSTYPE" == "darwin"* ]]; then URL_OPENER="open"; fi
            $URL_OPENER "https://www.radio-browser.info/tags"
            echo "Presiona Enter para continuar con radion."
            read -r
            ;;
        "Salir")
        	exit 0
            ;;
        "---"*)
            # Ignorar líneas separadoras
            ;;
        *)
            # Verificar si la selección es una estación favorita
            if grep -q "~${SELECTION// /-}"~ "$HOME/.config/radion/stations.txt"; then
                STATION="$SELECTION"
                STATION_URL="$(grep "~${STATION// /-}"~ "$HOME/.config/radion/stations.txt" | awk '{print $1}')"
                play_station
            # Verificar si la selección es una etiqueta
            elif grep -q "#$SELECTION" "$HOME/.config/radion/stations.txt"; then
                select_station_from_file <(grep "#$SELECTION" "$HOME/.config/radion/stations.txt") "$SELECTION"
            fi
            ;;
    esac
}

function select_station_from_file
{
    local FILE_PATH="$1"
    local PROMPT_TEXT="$2"
    local STATIONS=$(grep -v -E '^$|^//' "$FILE_PATH" | awk '{print $2}' | sed 's/~//g;s/-/ /g')
    
    local SELECTION=$(echo -e "Estación Aleatoria\nAtrás\nSalir\n$STATIONS" | wofi --show dmenu -p "$PROMPT_TEXT:")

    case "$SELECTION" in
        "Estación Aleatoria")
        	random_station "$FILE_PATH"
            play_station
            ;;
        "Atrás")
            # Volver al menú principal
            ;;
        "Salir")
            exit 0
            ;;
        *)
            if [ -n "$SELECTION" ]; then
                STATION="$SELECTION"
                STATION_URL="$(grep "~${STATION// /-}"~"$FILE_PATH" | awk '{print $1}')"
                play_station
            fi
            ;;
    esac
}

# --- Main Logic ---

while true; do
    select_tag
done
