#!/bin/bash

# Directory containing your scripts
SCRIPT_DIR="$HOME/.config/scripts/dmenu"

# List scripts, pick one with dmenu
chosen=$(ls "$SCRIPT_DIR"/*.sh | xargs -n 1 basename | rofi -dmenu -i -p "Run script:")

# If user picked something, run it
if [ -n "$chosen" ]; then
    "$SCRIPT_DIR/$chosen"
fi
