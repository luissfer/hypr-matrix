#!/bin/bash


# Variables
uptime=$(uptime -p | sed -e 's/up //g')
host="archlinux"

# Opciones
options=(
  "🔒 Lock"
  "💤 Suspend"
  "🔄 Reboot"
  "⏻  Shutdown"
)

# Función para mostrar el menú con wofi
main_menu() {
  printf '%s\n' "${options[@]}" | \
    wofi --dmenu --insensitive --prompt="$host" --define "lines=${#options[@]}+1"
}

# Función para mostrar confirmación con wofi
confirm() {
  echo -e "Yes\nNo" | \
    wofi --dmenu --insensitive --prompt="Are you sure?"
}

# Función para ejecutar el comando
execute() {
  [[ "$(confirm)" != "Yes" ]] && exit
  case "$1" in
    shutdown) systemctl poweroff ;;
    reboot) systemctl reboot ;;
    suspend) mpc -q pause; amixer set Master mute; systemctl suspend ;;
  esac
}

# Ejecutar el menú y responder según la opción
case "$(main_menu)" in
  "🔒 Shutdown") execute shutdown ;;
  "💤 Reboot") execute reboot ;;
  "🔄 Suspend") execute suspend ;;
  "⏻  Lock")
    if command -v betterlockscreen >/dev/null; then
      betterlockscreen -l
    elif command -v i3lock >/dev/null; then
      i3lock
    fi ;;
esac