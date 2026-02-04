#!/usr/bin/env bash

FOLDER="$HOME/pictures/wallpapers"
MONITOR="DP-2"

MODE="$1"   

CHOICE=$(nsxiv -otb "$FOLDER"/*)

# Exit if nothing was selected
[ -z "$CHOICE" ] && exit 0

set_wallpaper() {
    hyprctl hyprpaper wallpaper "$MONITOR, $CHOICE"
}

set_matugen() {
    matugen image "$CHOICE"
}

case "$MODE" in
    "")
        set_wallpaper
        set_matugen
        ;;
    --only-wallpaper)
        set_wallpaper
        ;;
    *)
        echo "Usage: $0 --only-wallpaper"
        exit 1
        ;;
esac

