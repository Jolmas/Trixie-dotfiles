#!/bin/bash

# WOFI STYLES
THEMES="$HOME/.config/waybar/style"
WAYBAR="$HOME/.config/scripts/Waybar.sh"

# wofi window config (in %)
WIDTH=20
HEIGHT=50

## Wofi Command
wofi_command="wofi --show dmenu \
			--prompt Seleccione...
			--conf $CONFIG --style $STYLE --color $COLORS \
			--width=$WIDTH% --height=$HEIGHT% \
			--cache-file=/dev/null \
			--hide-scroll --no-actions \
			--matching=fuzzy"

menu(){
  printf "1. default\n"
  printf "2. dark-cat\n"
  printf "3. dark-tokyo\n"
  printf "4. byw\n"
  printf "5. rgb\n"
  printf "6. default_alter\n"
  printf "7. tahoe-light\n"
  printf "8. light\n"
  printf "9. dracula\n"
  printf "10. dark\n"
  printf "11. clear\n"
  printf "12. tahoe-dark\n"
  printf "13. nord\n"
  printf "14. evergreen\n"

}

restart() {
	pkill waybar
	$WAYBAR &
	exit 0
}

main() {
    choice=$(menu | ${wofi_command} | cut -d. -f1)
    case $choice in
        1)
            ln -sf $THEMES/style-simple.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-simple.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        2)
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        3)
	        ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        4)
	        ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        5)
	        ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        6)
	        ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        7)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        8)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-dracula.css"
			restart
            ;;
        9)
	        ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        10)
	        ln -sf $THEMES/style-dark.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        11)
	        ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        12)
	        ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        13)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        14)
	        ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        *)
            ;;
    esac
}

main
