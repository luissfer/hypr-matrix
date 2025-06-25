#!/bin/bash

options=(
    "on"
    "connect device"
    "add device"
    "remove device"
    "off"
)

main_menu() {
    printf '%s\n' "${options[@]}" | \
    wofi  --width 200 \
        --height 220 \
        --dmenu \
        --insensitive \
        --style ~/.config/wofi/themes/matrix.css \
        --hide-scroll \
        --cache-file /dev/null \
        --prompt="Bluetooth" 
}

case "$(main_menu)" in
  "on") bluetoothctl power on ;;
  "connect device") bluetoothctl devices ;;
  "add device") bluetoothctl scan on ;;
  "remove device") echo add ;;
  "off") bluetoothctl power off ;;
esac