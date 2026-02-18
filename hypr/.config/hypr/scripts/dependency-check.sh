#!/usr/bin/env bash

source $HOME/dotfiles/_stow-scripts/packages.conf

missing=()

for cmd in "${SYSTEM_UTILS[@]}"; do
    if ! pacman -Qi "$cmd" &>/dev/null; then
        missing+=("$cmd")
    fi
done

if [ ${#missing[@]} -ne 0 ]; then
    notify-send -u critical $'Missing command(s):\n'"$(printf '%s\n' "${missing[@]}")"
    exit 1
fi
