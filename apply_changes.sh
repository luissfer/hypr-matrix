#!/bin/bash

# Colors for output messages
GREEN='\033[0;32m'
BLUE='\033[0;34m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Base directory for configuration files
CONFIG_DIR="$HOME/.config"

# Base directory for backups
BACKUP_BASE="$HOME/.config/hypr-matrix-backup/backup-$(date +%Y%m%d-%H%M%S)"

# Create backup directory
mkdir -p "$BACKUP_BASE"

# Function to copy configuration
copy_config() {
    local source=$1
    local dest=$2
    local backup_dir=$3

    # Create backup directory if it doesn't exist
    if [ ! -d "$backup_dir" ]; then
        mkdir -p "$backup_dir"
    fi

    # Backup existing configuration if it exists
    if [ -e "$dest" ]; then
        cp -r "$dest" "$backup_dir/"
    fi

    # Apply new configuration
    cp -r "$source" "$dest"
    echo -e "${GREEN}Configuration for $source applied to $dest${NC}"
}

# Configuration directories
declare -a dirs=(
    "hypr"
    "kitty"
    "waybar"
    "wofi"
)

echo -e "${BLUE}Starting Matrix configuration application...${NC}"

# Create config directory if it doesn't exist
mkdir -p "$CONFIG_DIR"

# Backup and apply each configuration
for dir in "${dirs[@]}"; do
    echo -e "\n${BLUE}Processing $dir configuration...${NC}"

    # Backup existing configuration
    mkdir -p "$BACKUP_BASE/$dir"

    # Apply new configuration
    if [ -d "$dir" ]; then
        # If source is a directory, copy its contents
        copy_config "$PWD/$dir/." "$CONFIG_DIR/$dir" "$BACKUP_BASE/$dir"
    elif [ -f "$dir" ]; then
        # If source is a file, copy the file
        copy_config "$PWD/$dir" "$CONFIG_DIR/$dir" "$BACKUP_BASE"
    else
        echo -e "${RED}Error: $dir not found${NC}"
        continue
    fi
done

# Restart Waybar to apply changes
killall waybar
waybar &

echo -e "\n${GREEN}Matrix configuration successfully applied!${NC}"
echo -e "${BLUE}Backups of your previous configuration are in $BACKUP_BASE${NC}"