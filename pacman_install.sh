#!/bin/bash

# Colors for output messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Required packages for the Matrix theme
packages=(
    "hyprland"      # Window manager
    "hyprpaper"     # Wallpaper manager
    "hyprlock"      # Screen locker
    "waybar"        # Status bar
    "wofi"          # Application launcher
    "kitty"         # Terminal emulator
    "nemo"          # File manager
    "brightnessctl" # Brightness control
    "pamixer"       # Audio control
    "grim"          # Screenshot utility
    "slurp"         # Area selection
    "wl-clipboard"  # Clipboard manager
    "network-manager-applet" # Network management
    "bluez"         # Bluetooth support
    "bluez-utils"   # Bluetooth utilities
    "playerctl"     # Media control
    "swayidle"      # Idle management
)

echo -e "${BLUE}Installing required packages...${NC}"

# Install packages
sudo pacman -S --noconfirm --needed "${packages[@]}"

# Check installation status
if [ $? -eq 0 ]; then
    echo -e "${GREEN}All packages installed successfully!${NC}"
    echo -e "${BLUE}You can now run ./apply_changes.sh to apply the configuration${NC}"
else
    echo -e "${RED}Error: Some packages failed to install${NC}"
    exit 1
fi