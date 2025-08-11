#!/bin/bash

CONFIG="$HOME/.config/wofi/WofiBig/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

if [[ ! $(pidof wofi) ]]; then
	wofi --show drun --prompt 'Buscar...' --conf ${CONFIG} --style ${STYLE} --color ${COLORS}
else
	pkill wofi
fi
