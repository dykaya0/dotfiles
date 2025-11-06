#!/usr/bin/env bash

# Paths
STOPWATCH="$HOME/.config/scripts/stopwatch.sh"

# Check if stopwatch script exists
if [ ! -x "$STOPWATCH" ]; then
    notify-send "Stopwatch script not found or not executable"
    exit 1
fi

# Define menu options
options=" pause\n▶ resume\n󰑙 reset\n status"

# Launch rofi/dmenu and get selection
chosen=$(echo -e "$options" | rofi -dmenu -p "Stopwatch")

case "$chosen" in
    " pause")
        $STOPWATCH pause
        notify-send -h string:bgcolor:#bf616a "Stopwatch paused ⏸️"
        ;;
    "▶ resume")
        $STOPWATCH resume
        notify-send -h string:bgcolor:#a3be8c "Stopwatch resumed ▶️"
        ;;
    "󰑙 reset")
        $STOPWATCH reset
        notify-send -h string:bgcolor:#d08770 "Stopwatch reset 🔁"
        ;;
    " status")
        status=$($STOPWATCH status)
        notify-send -h string:bgcolor:#5e81ac "$status"
        ;;
esac
