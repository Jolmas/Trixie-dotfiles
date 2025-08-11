#!/bin/sh

## Grimshot: a helper for screenshots within sway
## Requirements:
##  - `grim`: screenshot utility for wayland
##  - `slurp`: to select an area
##  - `swaymsg`: to read properties of current window
##  - `wl-copy`: clipboard utility
##  - `jq`: json utility to parse swaymsg output
##  - `notify-send`: to show notifications
## Those are needed to be installed, if unsure, run `grimshot check`
##
## See `man 1 grimshot` or `grimshot usage` for further details.

getTargetDirectory() {
  test -f "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs" && \
    . "${XDG_CONFIG_HOME:-$HOME/.config}/user-dirs.dirs"

  echo "${XDG_SCREENSHOTS_DIR:-${XDG_PICTURES_DIR:-$HOME}}"
}

NOTIFY=no
CURSOR=

while [ $# -gt 0 ]; do
  key="$1"

  case $key in
    -n|--notify)
      NOTIFY=yes
      shift # past argument
      ;;
    -c|--cursor)
      CURSOR=yes
      shift # past argument
      ;;
    *)    # unknown option
      break # done with parsing --flags
      ;;
  esac
done

ACTION=${1:-usage}
SUBJECT=${2:-screen}
FILE=${3:-$(getTargetDirectory)/Screenshot-$(date "+%H:%M:%S").png}

if [ "$ACTION" != "save" ] && [ "$ACTION" != "copy" ] && [ "$ACTION" != "check" ]; then
  echo "Usage:"
  echo "  grimshot [--notify] [--cursor] (copy|save) [active|screen|output|area|window] [FILE|-]"
  echo "  grimshot check"
  echo "  grimshot usage"
  echo ""
  echo "Commands:"
  echo "  copy: Copy screenshot data to clipboard."
  echo "  save: Save screenshot to regular file or '-' to send STDOUT."
  echo "  check: Verify dependencies utilities are installed."
  echo "  usage: Show this message."
  echo ""
  echo "Targets:"
  echo "  active: Active window."
  echo "  screen: All visibles outputs."
  echo "  output: Active Output."
  echo "  area: Select Area."
  echo "  window: Select Window."
  exit
fi

notify() {
  notify-send -t 3000 -a grimshot "$@"
}
notifyOk() {
  [ "$NOTIFY" = "no" ] && return

  TITLE=${2:-"Screenshot"}
  MESSAGE=${1:-"OK"}
  notify "$TITLE" "$MESSAGE"
}
notifyError() {
  if [ $NOTIFY = "yes" ]; then
    TITLE=${2:-"Screenshot"}
    MESSAGE=${1:-"Error taking screenshot with grim"}
    notify -u critical "$TITLE" "$MESSAGE"
  else
    echo "$1"
  fi
}

die() {
  MSG=${1:-Bye}
  notifyError "Error: $MSG"
  exit 2
}

check() {
  COMMAND=$1
  if command -v "$COMMAND" > /dev/null 2>&1; then
    RESULT="OK"
  else
    RESULT="NOT FOUND"
  fi
  echo "   $COMMAND: $RESULT"
}

takeScreenshot() {
  FILE=$1
  GEOM=$2
  OUTPUT=$3
  if [ -n "$OUTPUT" ]; then
    grim ${CURSOR:+-c} -o "$OUTPUT" "$FILE" || die "Error invoking grim"
  elif [ -z "$GEOM" ]; then
    grim ${CURSOR:+-c} "$FILE" || die "Error invoking grim"
  else
    grim ${CURSOR:+-c} -g "$GEOM" "$FILE" || die "Error invoking grim"
  fi
}

if [ "$ACTION" = "check" ] ; then
  echo "Checking required utilities are installed. if not, install it and make available in PATH..."
  check grim
  check slurp
  check swaymsg
  check wl-copy
  check jq
  check notify-send
  exit
elif [ "$SUBJECT" = "area" ] ; then
  GEOM=$(slurp -d)
  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
    exit 1
  fi
  WHAT="Area"
elif [ "$SUBJECT" = "active" ] ; then
  FOCUSED=$(swaymsg -t get_tree | jq -r 'recurse(.nodes[]?, .floating_nodes[]?) | select(.focused)')
  GEOM=$(echo "$FOCUSED" | jq -r '.rect | "\(.x),\(.y) \(.width)x\(.height)"')
  APP_ID=$(echo "$FOCUSED" | jq -r '.app_id')
  WHAT="$APP_ID window"
elif [ "$SUBJECT" = "screen" ] ; then
  GEOM=""
  WHAT="Screen"
elif [ "$SUBJECT" = "output" ] ; then
  GEOM=""
  OUTPUT=$(swaymsg -t get_outputs | jq -r '.[] | select(.focused)' | jq -r '.name')
  WHAT="$OUTPUT"
elif [ "$SUBJECT" = "window" ] ; then
  GEOM=$(swaymsg -t get_tree | jq -r '.. | select(.pid? and .visible?) | .rect | "\(.x),\(.y) \(.width)x\(.height)"' | slurp)
  # Check if user exited slurp without selecting the area
  if [ -z "$GEOM" ]; then
   exit 1
  fi
  WHAT="Window"
else
  die "Unknown objet taking screenshot from" "$SUBJECT"
fi

if [ "$ACTION" = "copy" ] ; then
  takeScreenshot - "$GEOM" "$OUTPUT" | wl-copy --type image/png || die "Clipboard Error"
  notifyOk "$WHAT copied to buffer"
else
  if takeScreenshot "$FILE" "$GEOM" "$OUTPUT"; then
    TITLE="Captura de $SUBJECT"
    MESSAGE=$(basename "$FILE")
    notifyOk "$MESSAGE" "$TITLE"
    echo "$FILE"
  else
    notifyError "Error taking screenshot with grim"
  fi
fi
