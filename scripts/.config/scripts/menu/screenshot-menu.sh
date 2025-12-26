#!/usr/bin/env bash

SelectRegion() {
sleep 0.2
hyprshot --freeze -m region
}

WholeMonitor() {
sleep 0.2
hyprshot --freeze -m output
}

WholeWindow() {
sleep 0.2
hyprshot --freeze -m window
}

ClipboardSelectRegion() {
sleep 0.2
hyprshot --clipboard-only --freeze -m region
}

ClipboardAndPreviewSelectRegion() {
sleep 0.2

TMP_FILENAME=$(date +%Y-%m-%dT%H-%M-%S)
TMP_DIR=$HOME/.local/tmp/screenshots
hyprshot --freeze -o "$TMP_DIR" -f "$TMP_FILENAME" -m region 
nsxiv --name "TMP_SS_PREVIEW" $TMP_DIR/$TMP_FILENAME
}

ClipboardExtractText() {

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

hyprshot -m region -f scr.png --silent -o $SCR_IMG
sleep 0.1
mogrify -modulate 100,0 -resize 400% "$SCR_IMG/scr.png" || die "failed to convert image"
tesseract "$SCR_IMG/scr.png" "$SCR_IMG/scr" &>/dev/null || die "failed to extract text"
wl-copy <"$SCR_IMG/scr.txt" || die "failed to copy text to clipboard"
dunstify "Text extracted from image" || die "failed to send notification"
exit
}

takeScreenshot() { 
    choice=$(printf "SelectRegion\\nWholeMonitor\\nWholeWindow\\nClipboardSelectRegion\\nClipboardAndPreviewSelectRegion\\nClipboardExtractText" \
        | rofi -dmenu -c -l 6 -i -p "Choose output: ")
    case "$choice" in 
    SelectRegion)    SelectRegion;;
    WholeMonitor)    WholeMonitor;;
    WholeWindow)    WholeWindow;;
    ClipboardSelectRegion)    ClipboardSelectRegion;;
    ClipboardAndPreviewSelectRegion)    ClipboardAndPreviewSelectRegion;;
    ClipboardExtractText)    ClipboardExtractText;;
    esac

}

if [[ $# -gt 0 ]]; then
    # Call the function named in the first argument
    "$1"
else
    takeScreenshot
fi
