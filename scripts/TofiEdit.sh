#!/bin/bash

labDir="$HOME/.config/labwc"
waybarDir="$HOME/.config/waybar"

menu(){
  printf "1. Configure Labwc\n"
  printf "2. Configure Waybar\n"
  printf "3. Configure Autostart\n"

}

tofi_command=$(menu | tofi --config ~/.config/tofi/config | cut -d. -f1)

main() {
    choice=${tofi_command}
    case $choice in
        1)
            foot -e micro "$labDir/rc.xml"
            ;;
        2)
            foot -e micro "$waybarDir/config-default"
            ;;
        3)
            foot -e micro "$labDir/autostart"
            ;;
        *)
            ;;
    esac
}

main
