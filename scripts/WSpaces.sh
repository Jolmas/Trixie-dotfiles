#!/bin/bash

TMP_DIR="/tmp"
ARCHIVO_0="$TMP_DIR/wspace"
ARCHIVO_1="$TMP_DIR/wspace1"
ARCHIVO_2="$TMP_DIR/wspace2"
ARCHIVO_3="$TMP_DIR/wspace3"
ARCHIVO_4="$TMP_DIR/wspace4"

contenido0=$(cat "$ARCHIVO_0" 2>/dev/null)

if [ "$contenido0" = "1" ]; then
	printf "%s\n" "" > "$ARCHIVO_1"
    printf "%s\n" "" > "$ARCHIVO_2"
    printf "%s\n" "" > "$ARCHIVO_3"
    printf "%s\n" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "2" ]; then
    printf "%s\n" "" > "$ARCHIVO_1"
    printf "%s\n" "" > "$ARCHIVO_2"
    printf "%s\n" "" > "$ARCHIVO_3"
    printf "%s\n" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "3" ]; then
    printf "%s\n" "" > "$ARCHIVO_1"
    printf "%s\n" "" > "$ARCHIVO_2"
    printf "%s\n" "" > "$ARCHIVO_3"
    printf "%s\n" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "4" ]; then
    printf "%s\n" "" > "$ARCHIVO_1"
    printf "%s\n" "" > "$ARCHIVO_2"
    printf "%s\n" "" > "$ARCHIVO_3"
    printf "%s\n" "" > "$ARCHIVO_4"
fi
