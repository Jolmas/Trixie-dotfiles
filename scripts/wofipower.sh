#!/usr/bin/env bash

## Author : Aditya Shakya (adi1090x)
## Github : @adi1090x
#  Mod Wofi: @jolmasch
## Wofi   : Power Menu
#

# Current Theme
dir="$HOME/.config/wofi/styles"
cfg="$HOME/.config/wofi/config"
theme='style-dark'

# CMDs
host=`hostname`

# Options
shutdown='Apagar'
reboot='Reiniciar'
lock='Bloquear'
suspend='Suspender'
logout='Salir'
yes='Si'
no='No'

# Wofi CMD
wofi_cmd() {
	wofi --dmenu \
		--prompt $host \
		--conf $cfg \
		--style ${dir}/${theme}.css \
    	--width=20 --height=30 \
		--cache-file=/dev/null
}

# Confirmation CMD
confirm_cmd() {
	wofi --dmenu \
		--prompt Confirmar \
		--conf $cfg \
		--style ${dir}/${theme}.css \
		--width=20 --height=25
}

# Ask for confirmation
confirm_exit() {
	echo -e "$yes\n$no" | confirm_cmd
}

# Pass variables to wofi dmenu
run_wofi() {
	echo -e "$logout\n$reboot\n$lock\n$suspend\n$shutdown" | wofi_cmd
}

# Execute Command
run_cmd() {
	selected="$(confirm_exit)"
	if [[ "$selected" == "$yes" ]]; then
		if [[ $1 == '--shutdown' ]]; then
			loginctl poweroff
		elif [[ $1 == '--reboot' ]]; then
			loginctl reboot
		elif [[ $1 == '--suspend' ]]; then
			mpc -q pause
			loginctl suspend
		elif [[ $1 == '--logout' ]]; then
			desktop=$(echo  $DESKTOP_SESSION)
			echo "Está en "$desktop
			case $desktop in
				labwc)
					labwc --exit
					;;
				*)
					labwc --exit
					;;
			esac
		fi
	else
		exit 0
	fi
}

# Actions
chosen="$(run_wofi)"
case ${chosen} in
    $shutdown)
		run_cmd --shutdown
        ;;
    $reboot)
		run_cmd --reboot
        ;;
    $lock)
		/home/luis/.config/scripts/LockScreen.sh
        ;;
    $suspend)
		run_cmd --suspend
        ;;
    $logout)
		run_cmd --logout
        ;;
esac
