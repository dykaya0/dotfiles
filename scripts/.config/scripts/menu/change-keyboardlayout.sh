#!/usr/bin/env bash

KEYBOARDNAME=corsair-corsair-k60-rgb-pro-low-profile-mechanical-gaming-keyboard
hyprctl switchxkblayout "$KEYBOARDNAME" next
layout=$(hyprctl devices -j | jq -r ".keyboards[] | select(.name == \"$KEYBOARDNAME\") | .active_keymap")

case "$layout" in
    "English (UK)")
        class="english"
        notify-send -h string:bgcolor:#4444ff "Keyboard Layout: $layout"
        ;;
    "Turkish")
        class="turkish"
        notify-send -h string:bgcolor:#ff4444 "Keyboard Layout: $layout"
        ;;
    *)
        exit 1
        ;;
esac
