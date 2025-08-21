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
  printf "1. Purple\n"
  printf "2. Catppuccin\n"
  printf "3. Tokyo-Night\n"
  printf "4. Arc-Light\n"
  printf "5. Drak-Thin\n"
  printf "6. Dark-Thin\n"
  printf "7. W10\n"
  printf "8. Mac-Light\n"
  printf "9. Dracula\n"
  printf "10. Nord-Dark\n"
  printf "11. Breeze-Dark\n"
  printf "12. Breeze-Darker\n"
  printf "13. Arc-Dark\n"
  printf "14. Evergreen\n"
  printf "15. Catppuccin-Latte\n"
  printf "16. Catppuccin-Macchiato\n"
  printf "17. Mac-Dark\n"
  printf "18. Nord\n"
  printf "19. Edna\n"
  printf "20. Breeze\n"
  printf "21. Crocus\n"
  printf "22. Brisa-Translucid\n"
  printf "23. Star\n"
  printf "24. Vintage\n"
  printf "25. Chimera-Night\n"
  printf "26. Liquid-Glass\n"
  printf "27. Liquid-Dark\n"
  printf "28. Win-7\n"
  printf "29. Chimera-Light\n"
  printf "30. Aqua-7\n"
  printf "31. Aqua-Pills\n"
  printf "32. Aqua-Dots\n"
  printf "33. Aqua-Dark\n"
  printf "34. Aquadrop\n"
  printf "35. Aqua-Gradient\n"
  printf "36. MacOS-Leopard\n"
  printf "37. MacOS-Lion\n"
  printf "38. Bluelook\n"
  printf "39. Oxygen\n"
  printf "40. OxigenGlass\n"

}

restart() {
	pkill waybar
	$WAYBAR &
	labwc -r &
	exit 0
}

main() {
    choice=$(menu | ${wofi_command} | cut -d. -f1)
    case $choice in
        1)
            ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Purple/g" ~/.config/labwc/rc.xml
			restart
            ;;
        2)
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Catppuccin/g" ~/.config/labwc/rc.xml
			restart
            ;;
        3)
	        ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-tokyo.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-TokyoNight/g" ~/.config/labwc/rc.xml
			restart
            ;;
        4)
	        ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Arc-Light/g" ~/.config/labwc/rc.xml
			restart
            ;;
        5)
	        ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-rgb.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Drak-thin/g" ~/.config/labwc/rc.xml
			restart
            ;;
        6)
	        ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-default_alter.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Light/g" ~/.config/labwc/rc.xml
			restart
            ;;
        7)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-w10/g" ~/.config/labwc/rc.xml
			restart
            ;;
        8)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Mac-Light/g" ~/.config/labwc/rc.xml
			restart
            ;;
        9)
	        ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dracula.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Dracula/g" ~/.config/labwc/rc.xml
			restart
            ;;
        10)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Nord-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        11)
	        ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Brisa/g" ~/.config/labwc/rc.xml
			restart
            ;;
        12)
	        ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Breeze-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        13)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Arc-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        14)
	        ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-evergreen.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Evergreen/g" ~/.config/labwc/rc.xml
			restart
            ;;
        15)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Catppuccin-Latte/g" ~/.config/labwc/rc.xml
			restart
            ;;
        16)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Catppuccin-Macchiato/g" ~/.config/labwc/rc.xml
			restart
            ;;
        17)
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style.css"
			ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Mac-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        18)
	        ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-nord.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Nord/g" ~/.config/labwc/rc.xml
			restart
            ;;
        19)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Edna/g" ~/.config/labwc/rc.xml
			restart
            ;;
        20)
	        ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-light.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Breeze-Light/g" ~/.config/labwc/rc.xml
			restart
            ;;
        21)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Crocus/g" ~/.config/labwc/rc.xml
			restart
            ;;
        22)
	        ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-cat.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Brisa-Translucid/g" ~/.config/labwc/rc.xml
			restart
            ;;
        23)
	        ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-byw.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Star/g" ~/.config/labwc/rc.xml
			restart
            ;;
        24)
	        ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-clear.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Vintage/g" ~/.config/labwc/rc.xml
			restart
            ;;
        25)
	        ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Chimera-Night/g" ~/.config/labwc/rc.xml
			restart
            ;;
        26)
	        ln -sf $THEMES/style-tahoe.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-tahoe.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Liquid-Glass/g" ~/.config/labwc/rc.xml
			restart
            ;;
        27)
	        ln -sf $THEMES/style-tahoe-dark.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-tahoe-dark.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Liquid-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        28)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-W7/g" ~/.config/labwc/rc.xml
			restart
            ;;
        29)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Chimera-Light/g" ~/.config/labwc/rc.xml
			restart
            ;;
        30)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aqua7/g" ~/.config/labwc/rc.xml
			restart
            ;;
        31)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aqua-Pills/g" ~/.config/labwc/rc.xml
			restart
            ;;
        32)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aqua-Dots/g" ~/.config/labwc/rc.xml
			restart
            ;;
        33)
	        ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-dark-breeze.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aqua-Dark/g" ~/.config/labwc/rc.xml
			restart
            ;;
        34)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aquadrop/g" ~/.config/labwc/rc.xml
			restart
            ;;
        35)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Aqua-Gradient/g" ~/.config/labwc/rc.xml
			restart
            ;;
        36)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-MacOS-Leopard/g" ~/.config/labwc/rc.xml
			restart
            ;;
        37)
	        ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-sequoia.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-MacOS-Lion/g" ~/.config/labwc/rc.xml
			restart
            ;;
        38)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Bluelook/g" ~/.config/labwc/rc.xml
			restart
            ;;
        39)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Oxygen/g" ~/.config/labwc/rc.xml
			restart
            ;;
        40)
	        ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style.css"
    	    ln -sf $THEMES/style-mauve.css "$HOME/.config/waybar/style-default.css"
			sed -i "s/$(grep "<theme>" ~/.config/labwc/rc.xml -A 5 | grep "<name>"| awk -F"[><]" '{print $3}')/Lab-Oxygen-Glass/g" ~/.config/labwc/rc.xml
			restart
            ;;
        *)
            ;;
    esac
}

main
