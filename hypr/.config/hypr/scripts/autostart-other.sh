#!/usr/bin/env bash

# Xresources theming
if [ ! -f "$HOME/.Xresources" ]; then
    notify-send -u critical "~/.Xresources not found!"
    exit 1
fi

xrdb -merge $HOME/.Xresources

# Script autostart
if [ ! -x "$XDG_CONFIG_HOME/waybar/scripts/package-updates.sh" ]; then
    notify-send -u critical "Waybar package update script missing or not executable!"
    exit 1
fi

$XDG_CONFIG_HOME/waybar/scripts/package-updates.sh recheck &
