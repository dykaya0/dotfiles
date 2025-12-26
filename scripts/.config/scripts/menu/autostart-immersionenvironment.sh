#!/usr/bin/env bash

for wid in $(hyprctl clients -j | jq -r '.[] | select(.workspace.id != 4) | .address'); do
    hyprctl dispatch closewindow address:"$wid"
done

# Workspace 1: Browser
hyprctl dispatch workspace 1
hyprctl dispatch exec "vivaldi"
sleep 0.5

# Workspace 5: anki
hyprctl dispatch workspace 5
hyprctl dispatch exec "anki"
