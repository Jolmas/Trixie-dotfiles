#!/bin/bash

TMP_DIR="/tmp"
ARCHIVO_0="$TMP_DIR/wspace_$(whoami)"
ARCHIVO_1="$TMP_DIR/wspace1_$(whoami)"
ARCHIVO_2="$TMP_DIR/wspace2_$(whoami)"
ARCHIVO_3="$TMP_DIR/wspace3_$(whoami)"
ARCHIVO_4="$TMP_DIR/wspace4_$(whoami)"

contenido0=$(printf "%s" "$(<$ARCHIVO_0)" 2>/dev/null)

if [ "$contenido0" = "1" ]; then
	printf "%s" "" > "$ARCHIVO_1"
    printf "%s" "" > "$ARCHIVO_2"
    printf "%s" "" > "$ARCHIVO_3"
    printf "%s" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "2" ]; then
    printf "%s" "" > "$ARCHIVO_1"
    printf "%s" "" > "$ARCHIVO_2"
    printf "%s" "" > "$ARCHIVO_3"
    printf "%s" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "3" ]; then
    printf "%s" "" > "$ARCHIVO_1"
    printf "%s" "" > "$ARCHIVO_2"
    printf "%s" "" > "$ARCHIVO_3"
    printf "%s" "" > "$ARCHIVO_4"
elif [ "$contenido0" = "4" ]; then
    printf "%s" "" > "$ARCHIVO_1"
    printf "%s" "" > "$ARCHIVO_2"
    printf "%s" "" > "$ARCHIVO_3"
    printf "%s" "" > "$ARCHIVO_4"
fi
