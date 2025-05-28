#!/bin/bash
killall waybar

if [[ $USER = "fernando" ]]
then
    waybar -c waybar/config & -style waybar/style.css
else
    waybar
fi