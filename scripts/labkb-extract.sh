#!/bin/bash

# Configuración de archivos (puedes pasarlos como argumentos)
INPUT_FILE=${1:-"rc.xml"}
OUTPUT_FILE=${2:-"labwc-kbinds.txt"}

# Check if xmlstarlet is installed
if ! command -v xmlstarlet &> /dev/null; then
    echo "Error: 'xmlstarlet' not found. Please install it first."
    exit 1
fi

# Check if file exist
if [ ! -f "$INPUT_FILE" ]; then
    echo "Error: File '$INPUT_FILE' not found"
    exit 1
fi

echo "Processing $INPUT_FILE..."

# Create/clean output file with header
cat << EOF > "$OUTPUT_FILE"
==================================================
   LABWC KEYBINDS (Extrated from $INPUT_FILE)
   Date: $(date '+%Y-%m-%d %H:%M:%S')
==================================================

EOF

# Ejecutar la extracción con xmlstarlet
xmlstarlet sel -T -t -m "//keybind" \
    -v "@key" -o " => " \
    -m "action" \
        -v "@name" \
        -i "@command" -o " [" -v "@command" -o "]" -b \
        -i "@to" -o " [Desktop " -v "@to" -o "]" -b \
        -o "; " \
    -b -n "$INPUT_FILE" >> "$OUTPUT_FILE"

if [ $? -eq 0 ]; then
    echo "¡Success! The keybinds are saved in: $OUTPUT_FILE"
    echo "Total extracted keybinds: $(grep -c "=>" "$OUTPUT_FILE")"
else
    echo "Error processing XML file."
fi
