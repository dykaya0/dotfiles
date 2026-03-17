#!/usr/bin/env bash

BASE_DIR="$WALLPAPER_DIR"
BRIGHT_DIR="$BASE_DIR/bright"
DARK_DIR="$BASE_DIR/dark"

MODE="$1"

set_theme() {
    TARGET_DIR="$1"
    TARGET=$(find "$TARGET_DIR" -type f | shuf -n 1)

    [ -z "$TARGET" ] && exit 1

    hyprctl hyprpaper wallpaper ", $TARGET, cover"
    matugen --source-color-index 0 image "$TARGET"
}

select_theme() {
    CHOICE=$(nsxiv -otb "$BASE_DIR"/*)
    [ -z "$CHOICE" ] && exit 0

    hyprctl hyprpaper wallpaper ", $CHOICE, cover"
    matugen --source-color-index 0 image "$CHOICE" 
}

case "$MODE" in
    "")
        select_theme
        ;;
    --mode)
        shift # Remove the --mode flag
        case "$1" in
            dark)
                set_theme "$DARK_DIR"
                ;;
            bright)
                set_theme "$BRIGHT_DIR"
                ;;
            *)
                echo "Usage: $0 [--mode dark | --mode bright]"
                exit 1
                ;;
        esac
        ;;
    --random)
        set_theme "$BASE_DIR/"
        ;;
    *)
        echo "Usage: $0 [--mode dark | --mode bright | --random]"
        exit 1
        ;;
esac
