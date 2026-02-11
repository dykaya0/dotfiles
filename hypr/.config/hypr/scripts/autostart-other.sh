#!/usr/bin/env bash

# Xresources theming
if ! command -v xrdb >/dev/null 2>&1 || [ ! -f "$HOME/.Xresources" ]; then
    notify-send -u critical "Command xrdb or file ~/.Xresources not found!"
    exit 1
fi

xrdb -merge $HOME/.Xresources
