#!/bin/bash
wifi="$(nmcli r wifi | awk 'FNR = 2 {print $1}')"
if [ "$wifi" == "enabled" ]; then
    rfkill block all &
    notify-send -t 5000 'Airplane Mode: Inactive'
else
    rfkill unblock all &
    notify-send -t 5000 'Airplane Mode: Active'
fi
