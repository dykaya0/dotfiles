#!/usr/bin/env bash

# Directory of shell menu scripts
SCRIPT_DIR="$HOME/.config/scripts/menu/"

# Make sure the directory exists
if [ ! -d "$SCRIPT_DIR" ]; then
    notify-send "Script directory not found: $SCRIPT_DIR"
    exit 1
fi

# List .sh files (both symlinks and regular files), sorted
SCRIPTS=$(find $SCRIPT_DIR -maxdepth 1 \( -type f -o -type l \) -name "*.sh")

# Check if there are any scripts
if [ -z "$SCRIPTS" ]; then
    notify-send "No scripts found in $SCRIPT_DIR"
    exit 1
fi

# Strip directory path, keep only filenames
SCRIPT_NAMES=$(basename -a $SCRIPTS)

# Show in rofi
CHOSEN=$(printf "%s\n" $SCRIPT_NAMES | rofi -dmenu -i -p "Run script:")

# Run the chosen script if selected
if [ -n "$CHOSEN" ]; then
    # Ask for confirmation
    CONFIRM=$(echo -e "No\nYes" | rofi -dmenu -i -p "Are you sure you want to run $CHOSEN?")
    if [ "$CONFIRM" = "Yes" ]; then
        "$SCRIPT_DIR/$CHOSEN"
    else
        notify-send "Not Executing: $CHOSEN"
    fi
fi
