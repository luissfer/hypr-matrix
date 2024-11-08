#!/bin/bash
cp waybar/config ~/.config/waybar/config
cp waybar/modules.jsonc ~/.config/waybar/modules.jsonc
cp waybar/style.css ~/.config/waybar/style.css

hyprctl reload