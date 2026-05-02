#!/usr/bin/env bash

# First text selected
hyprctl dispatch sendshortcut ALT,1,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut CTRL,V,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut ,ENTER,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut ALT,2,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut CTRL,V,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut ,ENTER,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut ALT,3,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut CTRL,V,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2
hyprctl dispatch sendshortcut ,ENTER,class:^\(firefox\)$ || notify-send -t 2000 "Couldn't copy link"
sleep 0.2

