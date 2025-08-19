#!/bin/bash

WALLPAPERS="$HOME/Imágenes/Wallpapers"
ALIST=( `ls -w1 $WALLPAPERS` )
RANGE=${#ALIST[@]}
let "number = 0"
let LASTNUM="`cat $WALLPAPERS/.last` + 1"
let "number = $LASTNUM % $RANGE"
echo $number > $WALLPAPERS/.last

if [ $number -gt $RANGE ];then
  number=1
fi

#labwc/wayland:
pkill swaybg
swaybg -i $WALLPAPERS/${ALIST[$number]} -m fill &
exit
