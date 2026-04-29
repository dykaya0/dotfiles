#!/usr/bin/env bash

# First text selected
hyprctl dispatch sendshortcut CTRL,C,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
wl-paste --primary | tee -a uni.md && notify-send -t 2000 "Copied"

sleep 0.2

#Link
hyprctl dispatch sendshortcut CTRL,L,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't open link field"
hyprctl dispatch sendshortcut CTRL,C,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
wl-paste --primary | tee -a uni.md
printf '\n' | tee -a uni.md && notify-send -t 2000 "Copied"
