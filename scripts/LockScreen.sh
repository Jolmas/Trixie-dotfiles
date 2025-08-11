#!/bin/bash

CONFIG="$HOME/.config/swaylock/config"
IMG=/tmp/shot_blur.png
SUP="$HOME/.config/swaylock/lock1.png"
LCK=/tmp/lock-img.png

grim /tmp/shot.png &&
magick /tmp/shot.png -blur 0x8 /tmp/shot_blur.png &&
composite -gravity center ${SUP} ${IMG} /tmp/lock-img.png &&
sleep 0.5s; swaylock --config ${CONFIG} --image ${LCK} &

