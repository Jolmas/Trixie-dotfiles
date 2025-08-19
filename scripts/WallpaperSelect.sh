#!/bin/bash

# WALLPAPERS PATH
DIR=$HOME/Imágenes/Wallpapers

# wofi window config (in %)
WIDTH=55
HEIGHT=65

PICS=($(ls ${DIR} | grep -e ".jpg$" -e ".jpeg$" -e ".png$"))

RANDOM_PIC=${PICS[ $RANDOM % ${#PICS[@]} ]}
RANDOM_PIC_NAME="${#PICS[@]}. random"

# WOFI STYLES
CONFIG="$HOME/.config/wofi/WofiBig/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

## Wofi Command
wofi_command="wofi --show dmenu \
			--prompt seleccione...
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WIDTH% --height=$HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

menu(){
    # Here we are looping in the PICS array that is composed of all images in the $DIR
    # folder 
    for i in ${!PICS[@]}; do
        # keeping the .gif to make sue you know it is animated
        if [[ -z $(echo ${PICS[$i]} | grep .gif$) ]]; then
            printf "$i. $(echo ${PICS[$i]} | cut -d. -f1)\n" # n°. <name_of_file_without_identifier>
        else
            printf "$i. ${PICS[$i]}\n"
        fi
    done

    printf "$RANDOM_PIC_NAME"
}

main() {
    choice=$(menu | ${wofi_command})

    # no choice case
    if [[ -z $choice ]]; then return; fi

    # random choice case
    if [ "$choice" = "$RANDOM_PIC_NAME" ]; then
        swaybg -i ${DIR}/${RANDOM_PIC} -m fill &
        return
    fi
    
    pic_index=$(echo $choice | cut -d. -f1)
	if [[ $(pidof swaybg) ]]; then
	  pkill swaybg
	fi

    swaybg -i ${DIR}/${PICS[$pic_index]} -m fill &
}

# Check if wofi is already running
if pidof wofi >/dev/null; then
    pkill wofi
    exit 0
else
    main
fi
