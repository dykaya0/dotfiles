#!/usr/bin/env bash

FOLDER=$WALLPAPER_DIR

MODE="$1"   

CHOICE=$(nsxiv -otb "$FOLDER"/*)

# Exit if nothing was selected
[ -z "$CHOICE" ] && exit 0

set_wallpaper() {
    hyprctl hyprpaper wallpaper ", $CHOICE, cover"
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
        echo "Usage: $0 [--only-wallpaper]"
        exit 1
        ;;
esac

