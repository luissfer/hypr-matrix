#!/bin/bash

# Matrix theme colors
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Menu options
options=(
    "Lock"
    "Logout"
    "Suspend"
    "Hibernate"
    "Reboot"
    "Shutdown"
)

# Create menu items with Matrix-style formatting
menu=""
for option in "${options[@]}"; do
    menu+="$option\n"
done

# Show menu with wofi
chosen=$(echo -e "$menu" | wofi \
    --dmenu \
    --cache-file=/dev/null \
    --prompt="System Control" \
    --width=300 \
    --height=400 \
    --style="$HOME/.config/wofi/themes/matrix.css" \
    --hide-scroll \
    --allow-markup \
    --define=matching=fuzzy)

# Function to execute command
execute_command() {
    local cmd=$1
    local msg=$2
    echo -e "${GREEN}$msg${NC}"
    eval "$cmd"
}

# Execute menu and respond according to option
case "$chosen" in
    "Lock")
        execute_command "hyprlock" "Locking screen..."
        ;;
    "Logout")
        execute_command "hyprctl dispatch exit" "Logging out..."
        ;;
    "Suspend")
        execute_command "systemctl suspend" "Suspending system..."
        ;;
    "Hibernate")
        execute_command "systemctl hibernate" "Hibernating system..."
        ;;
    "Reboot")
        execute_command "systemctl reboot" "Rebooting system..."
        ;;
    "Shutdown")
        execute_command "systemctl poweroff" "Shutting down system..."
        ;;
esac