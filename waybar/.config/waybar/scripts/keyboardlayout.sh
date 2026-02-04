#!/usr/bin/env bash

layout=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "corsair-corsair-k60-rgb-pro-low-profile-mechanical-gaming-keyboard") | .active_keymap')

# Map key layout to CSS class
case "$layout" in
    "English (UK)")
        class="english"
        ;;
    "Turkish")
        class="turkish"
        ;;
    "German")
        class="german"
        ;;
    *)
        class="unknown"
        ;;
esac

# Construct JSON for Waybar (must be one line)
echo "{\"text\":\"$layout\",\"tooltip\":\"$layout\",\"class\":\"$class\"}" \
    | jq --unbuffered --compact-output
