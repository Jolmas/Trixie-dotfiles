#!/bin/bash

CONFIG="$HOME/.config/wofi/config"
STYLE="$HOME/.config/wofi/style.css"
COLORS="$HOME/.config/wofi/colors"

wofi --show drun --prompt 'Buscar...' --conf ${CONFIG} --style ${STYLE} --color ${COLORS}
