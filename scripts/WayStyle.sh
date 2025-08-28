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
  printf "1. byw\n"
  printf "2. clear\n"
  printf "3. dark-breeze\n"
  printf "4. dark-cat\n"
  printf "5. dark-tokyo\n"
  printf "6. dark\n"
  printf "7. default_alter\n"
  printf "8. dracula\n"
  printf "9. evergreen\n"
  printf "10. light\n"
  printf "11. mauve-light\n"
  printf "12. mauve\n"
  printf "13. moccha\n"
  printf "14. nord\n"
  printf "15. rgb\n"
  printf "16. sequoia\n"
  printf "17. simple\n"
  printf "18. tahoe-dark\n"
  printf "19. tahoe\n"

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
            ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        2)
			ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        3)
	        ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        4)
	        ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        5)
	        ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        6)
	        ln -sf $THEMES/style-dark.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        7)
	        ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        8)
	        ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style-dracula.css"
			restart
            ;;
        9)
	        ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        10)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        11)
	        ln -sf $THEMES/style-mauve-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve-light.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        12)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        13)
	        ln -sf $THEMES/style-moccha.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-moccha.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        14)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        15)
	        ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        16)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        17)
	        ln -sf $THEMES/style-simple.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-simple.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        18)
	        ln -sf $THEMES/style-tahoe-dark.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-tahoe-dark.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        19)
	        ln -sf $THEMES/style-tahoe.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-tahoe.css "$HOME/.config/waybar/style-default.css"
			restart
            ;;
        *)
            ;;
    esac
}

main
