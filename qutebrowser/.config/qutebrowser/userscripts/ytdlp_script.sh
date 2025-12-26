#!/usr/bin/env bash

URL="$QUTE_URL"

notify-send "script is working"
# Exit if no URL is provided
[ -z "$URL" ] && exit 0

# Daily directory
DIR="$HOME/videos/youtube/$(date +%F)"
mkdir -p "$DIR"

# Download time (24h format)
TIME=$(date +"%H:%M")

# Filename template
TEMPLATE="$TIME - %(title)s.%(ext)s"

# Run yt-dlp
yt-dlp -o $DIR/$TEMPLATE "$URL"; notify-send "yt-dlp finished with exit code $?"
