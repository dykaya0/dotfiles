#!/usr/bin/env bash

# Array of required commands
required_commands=(
    notify-send
    rofi
    waybar
    nvim
    vim
    git
    ghostty
    foot
    starship
    tmux
    wlogout
    btop
    mpv
    nsxiv
    matugen
    yt-dlp
    xrdb
    cliphist
    obs
    obs-cmd
    pactl
)

missing=()

for cmd in "${required_commands[@]}"; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        missing+=("$cmd")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    notify-send -u critical $'Missing command(s):\n'"$(printf '%s\n' "${missing[@]}")"
    exit 1
fi
