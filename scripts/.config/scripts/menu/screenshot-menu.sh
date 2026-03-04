#!/usr/bin/env bash

Region() {
    hyprshot --freeze -m region
}

Monitor() {
    hyprshot --freeze -m output
}

Window() {
    hyprshot --freeze -m window
}

Region_clipboard() {
    hyprshot --clipboard-only --freeze -m region
}

Region_preview() {
    TMP_FILENAME=$(date +%Y-%m-%dT%H-%M-%S)
    TMP_DIR=$XDG_CACHE_HOME/screenshots
    mkdir -p $TMP_DIR
    hyprshot --freeze -o "$TMP_DIR" -f "$TMP_FILENAME" -m region 
    nsxiv --name "TMP_SS_PREVIEW" $TMP_DIR/$TMP_FILENAME
}

Region_extracttext() {
    die() {
        notify-send "$1"
        exit 1
    }
cleanup() {
    [[ -n $1 ]] && rm -r "$1"
}

SCR_IMG=$(mktemp -d) || die "failed to create tmpdir"

# shellcheck disable=SC2064
trap "cleanup '$SCR_IMG'" EXIT

hyprshot --freeze -m region -f scr.png --silent -o $SCR_IMG
sleep 0.1
mogrify -modulate 100,0 -resize 400% "$SCR_IMG/scr.png" || die "failed to convert image"
tesseract "$SCR_IMG/scr.png" "$SCR_IMG/scr" &>/dev/null || die "failed to extract text"
wl-copy <"$SCR_IMG/scr.txt" || die "failed to copy text to clipboard"
dunstify "Text extracted from image" || die "failed to send notification"
exit
}

takeScreenshot() { 
    choice=$(printf "Region\\nMonitor\\nWindow\\nRegion_clipboard\\nRegion_preview\\nRegion_extracttext" \
        | rofi -dmenu -c -l 6 -i -p "Choose output: ")
    case "$choice" in 
        Region)    Region;;
        Monitor)    Monitor;;
        Window)    Window;;
        Region_clipboard)    Region_clipboard;;
        Region_preview)    Region_preview;;
        Region_extracttext)    Region_extracttext;;
    esac

}

if [[ $# -gt 0 ]]; then
    # Call the function named in the first argument
    "$1"
else
    takeScreenshot
fi
