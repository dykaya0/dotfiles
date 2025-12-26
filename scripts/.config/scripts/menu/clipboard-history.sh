#!/usr/bin/env bash

cliphist list | rofi -dmenu -theme-str 'window { location: south; anchor: south; width: 100%; }' -theme-str 'listview { lines: 6; }'| cliphist decode | wl-copy
