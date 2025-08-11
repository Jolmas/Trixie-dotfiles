#!/bin/bash

CONFIG="$HOME/.config/waybar/config-default"
STYLE="$HOME/.config/waybar/style.css"

waybar --bar main-bar --config ${CONFIG} --style ${STYLE}
