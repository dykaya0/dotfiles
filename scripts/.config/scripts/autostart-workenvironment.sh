#!/usr/bin/env bash

# Workspace 1: Dev Browser
hyprctl dispatch workspace 1
hyprctl dispatch exec "qutebrowser"
sleep 0.5

# Workspace 2: Browser
hyprctl dispatch workspace 2
hyprctl dispatch exec "ghostty"
sleep 0.5

# Workspace 2: Browser
hyprctl dispatch workspace 3
hyprctl dispatch exec "brave"
sleep 1

# Workspace 3: Music
hyprctl dispatch workspace 4
hyprctl dispatch exec "ghostty -e zsh -lc 'cd ~/notes; exec zsh'"
sleep 0.5
hyprctl dispatch exec "ghostty -e tomato"
sleep 0.5

# Workspace 4: Music
hyprctl dispatch workspace 5
hyprctl dispatch exec "firefox https://www.youtube.com"
