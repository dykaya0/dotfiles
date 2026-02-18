#!/usr/bin/env bash

# Xresources theming
if [ ! -f "$HOME/.Xresources" ]; then
    notify-send -u critical "~/.Xresources not found!"
    exit 1
fi

xrdb -merge $HOME/.Xresources
