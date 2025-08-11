#!/bin/bash

iDIR="$HOME/.config/dunst/icons"

# Get Volume
get_volume() {
	volume=$(pulsemixer --get-volume | cut -d ' ' -f1)
	echo "$volume"
}

# Get icons
get_icon() {
	current=$(get_volume)
	if [[ "$current" -eq "0" ]]; then
		echo "$iDIR/volume-mute.png"
	elif [[ ("$current" -le "30") ]]; then
		echo "$iDIR/volume-low.png"
	elif [[ ("$current" -le "60") ]]; then
		echo "$iDIR/volume-mid.png"
	elif [[ ("$current" -le "100") ]]; then
		echo "$iDIR/volume-high.png"
	fi
}

# Notify
notify_user() {
#	notify-send -h string:x-canonical-private-synchronous:sys-notify -u normal -i "$(get_icon)" "Volume : $(get_volume) %"
	notify-send -h int:value:$(get_volume) -h "string:x-dunst-stack-tag:volume_notif" -u low -i "$(get_icon)" "Volume : $(get_volume) %"

}

# Increase Volume
inc_volume() {
	pulsemixer --change-volume +1 
}

# Decrease Volume
dec_volume() {
	pulsemixer --change-volume -1 
}

# Toggle Mute
toggle_mute() {
	if [ "$(pulsemixer --get-mute)" == "false" ]; then
		pulsemixer -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/volume-mute.png" "Volume Switched OFF"
	elif [ "$(pulsemixer --get-mute)" == "true" ]; then
		pulsemixer -u && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_icon)" "Volume Switched ON"
	fi
}

# Toggle Mic
toggle_mic() {
	if [ "$(pulsemixer --get-mute)" == "false" ]; then
		pulsemixer -m && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone-mute.png" "Microphone Switched OFF"
	elif [ "$(pulsemixer --get-mute)" == "true" ]; then
		pulsemixer -u u && notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$iDIR/microphone.png" "Microphone Switched ON"
	fi
}
# Get icons
get_mic_icon() {
	current=$(pulsemixer --get-volume)
	if [[ "$current" -eq "0" ]]; then
		echo "$iDIR/microphone.png"
	elif [[ ("$current" -le "30") ]]; then
		echo "$iDIR/microphone.png"
	elif [[ ("$current" -le "60") ]]; then
		echo "$iDIR/microphone.png"
	elif [[ ("$current" -le "100") ]]; then
		echo "$iDIR/microphone.png"
	fi
}
# Notify
notify_mic_user() {
#	notify-send -h string:x-canonical-private-synchronous:sys-notify -u low -i "$(get_mic_icon)" "Mic-Level : $(pulsemixer --default-source --get-volume) %"
	notify-send -h int:value:$(pulsemixer --get-volume) -h "string:x-dunst-stack-tag:volume_notif" -u low -i "$(get_mic_icon)" "Mic-Level : $(pulsemixer --get-volume) %"
}

# Increase MIC Volume
inc_mic_volume() {
	pulsemixer --change-volume +1 
}

# Decrease MIC Volume
dec_mic_volume() {
	pulsemixer --change-volume -1 
}

# Execute accordingly
if [[ "$1" == "--get" ]]; then
	get_volume
elif [[ "$1" == "--inc" ]]; then
	inc_volume
elif [[ "$1" == "--dec" ]]; then
	dec_volume
elif [[ "$1" == "--toggle" ]]; then
	toggle_mute
elif [[ "$1" == "--toggle-mic" ]]; then
	toggle_mic
elif [[ "$1" == "--get-icon" ]]; then
	get_icon
elif [[ "$1" == "--get-mic-icon" ]]; then
	get_mic_icon
elif [[ "$1" == "--mic-inc" ]]; then
	inc_mic_volume
elif [[ "$1" == "--mic-dec" ]]; then
	dec_mic_volume
else
	get_volume
fi
