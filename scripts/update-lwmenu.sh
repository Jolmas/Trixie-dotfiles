#!/bin/bash

# Variables para mejorar la legibilidad y mantenibilidad
MENU_CONFIG="$HOME/.config/labwc/menu.xml"
UPDATE_MENU_SCRIPT="$HOME/.config/scripts/update-menu.sh"
NOTIFICATION_MESSAGE="Menú LabWC Actualizado"

# Verificar si el script de actualización existe y es ejecutable
if [ ! -x "$UPDATE_MENU_SCRIPT" ]; then
  echo "Error: El script de actualización '$UPDATE_MENU_SCRIPT' no existe o no es ejecutable." >&2
  exit 1
fi

# Ejecutar el script de actualización y verificar el código de salida
if "$UPDATE_MENU_SCRIPT" > "$MENU_CONFIG"; then
  echo "Menú actualizado correctamente en '$MENU_CONFIG'."
else
  echo "Error: Falló la actualización del menú." >&2
  exit 1
fi

# Esperar un breve momento para asegurar que el archivo se haya escrito
sleep 0.5

# Recargar la configuración de labwc y verificar el código de salida
if labwc -r; then
  echo "LabWC recargado."
else
  echo "Advertencia: No se pudo recargar la configuración de LabWC." >&2
fi

# Esperar otro breve momento antes de la notificación
sleep 0.5

# Enviar notificación si notify-send está disponible
if command -v notify-send &> /dev/null; then
  notify-send "$NOTIFICATION_MESSAGE"
else
  echo "Advertencia: 'notify-send' no encontrado. No se mostrará la notificación." >&2
fi

exit 0
