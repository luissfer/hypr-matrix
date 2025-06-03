#!/bin/bash

# Variables
uptime=$(uptime -p | sed -e 's/up //g')
host="archlinux"

# Opciones
options=(
  "🔒 Lock"
  "💤 Suspend"
  "🔄 Reboot"
  "⏻ Shutdown"
)

# Función para mostrar el menú con wofi
main_menu() {
  printf '%s\n' "${options[@]}" | \
    wofi --width 200 \
        --height 200 \
        --dmenu \
        --insensitive \
        --style ~/.config/wofi/themes/matrix.css \
        --hide-scroll \
        --cache-file /dev/null \
        --prompt="$host" 
}

# Función para mostrar confirmación con wofi
confirm() {
  echo -e "Yes\nNo" | \
    wofi --width 200 \
        --height 150 \
        --dmenu \
        --insensitive \
        --style ~/.config/wofi/themes/matrix.css \
        --hide-search=true \
        --hide-scroll \
        --cache-file /dev/null \
        --dmenu --insensitive --prompt="Are you sure?"
}

# Función para ejecutar el comando
execute() {
  [[ "$(confirm)" != "Yes" ]] && exit
  case "$1" in
    shutdown) systemctl poweroff ;;
    reboot) systemctl reboot ;;
    suspend) systemctl suspend ;;
    lock) hyprlock ;;
  esac
}

# Ejecutar el menú y responder según la opción
case "$(main_menu)" in
  "⏻ Shutdown") execute shutdown ;;
  "💤 Suspend") execute suspend ;;
  "🔄 Reboot") execute reboot ;;
  "🔒 Lock") execute lock ;;
esac