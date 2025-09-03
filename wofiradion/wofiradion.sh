#!/bin/bash
#        ╭───╮╭───╮╭───╮╭───╮╭───╮╭───╮
#  WOFI │ R ││ A ││ D ││ I ││ O ││ N │
#        ╰───╯╰───╯╰───╯╰───╯╰───╯╰───╯
# A bash script written by Christos Angelopoulos, October 2023, under GPL v2
# Modified for Wofi by Gemini and Jolmasch, August 2025

EDITOR="$(grep 'Preferred_editor' "$HOME/.config/radion/radion.conf" | cut -d " " -f2)"

function play_station
{
    echo "ESTACIÓN: $1"
    echo "URL      : $2"
    pkill mpv
    mpv "$2" &
    sleep 5
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
    OPTIONS+="--- Acciones ---\nTodas las Estaciones\nEditar Estaciones\nApagar Radio\nPreferencias\nBuscar Estaciones\nSalir"

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
            ;;
        *)
            if grep -q "~${SELECTION// /-}"~ "$HOME/.config/radion/stations.txt"; then
                LINE=$(grep "~${SELECTION// /-}"~ "$HOME/.config/radion/stations.txt")
                STATION=$(echo "$LINE" | awk '{print $2}' | sed 's/~//g;s/-/ /g')
                STATION_URL=$(echo "$LINE" | awk '{print $1}')
                play_station "$STATION" "$STATION_URL"
            elif grep -q "#$SELECTION" "$HOME/.config/radion/stations.txt"; then
                select_station_from_file <(grep "#$SELECTION" "$HOME/.config/radion/stations.txt") "$SELECTION"
            fi
            ;;
    esac
}

function random_station
{
    local FILE_PATH="$1"
    local rand_max_lim=$(grep -v -E '^$|^//' "$FILE_PATH" | wc -l)
    local rand_station_index=$((1 + RANDOM % rand_max_lim))
    local LINE=$(grep -v -E '^$|^//' "$FILE_PATH" | head -"$rand_station_index" | tail -1)
    local STATION=$(echo "$LINE" | awk '{print $2}' | sed 's/-/ /g;s/~//g')
    local STATION_URL=$(echo "$LINE" | awk '{print $1}')
    play_station "$STATION" "$STATION_URL"
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
            ;;
        "Atrás")
            return
            ;;
        "Salir")
            exit 0
            ;;
        *)
            if [ -n "$SELECTION" ]; then
                local LINE=$(grep "~${SELECTION// /-}"~ "$HOME/.config/radion/stations.txt")
                local STATION_URL=$(echo "$LINE" | awk '{print $1}')
                play_station "$SELECTION" "$STATION_URL"
            fi
            ;;
    esac
}

# --- Main Logic ---

while true; do
    select_tag
done
