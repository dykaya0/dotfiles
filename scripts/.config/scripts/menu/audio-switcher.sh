#!/usr/bin/env bash

get_sink_by_keyword() {
    local keyword="$1"
    pactl list short sinks | awk -v k="$keyword" '$2 ~ k {print $2; exit}'
}

headphones() {
    SINK=$(get_sink_by_keyword "usb-SteelSeries")

    if [[ -n "$SINK" ]]; then
        pactl set-default-sink "$SINK"
        notify-send -h string:bgcolor:#a3be8c "Audio switched to headphones "
    else
        notify-send -h string:bgcolor:#bf616a "Headphones not found"
    fi
}

speakers() {
    SINK=$(get_sink_by_keyword "pci-0000_00_1f.3")

    if [[ -n "$SINK" ]]; then
        pactl set-default-sink "$SINK"
        notify-send -h string:bgcolor:#bf616a "Audio switched to speakers 󰴸"
    else
        notify-send -h string:bgcolor:#bf616a "Speakers not found"
    fi
}

switchAudio() {
    choice=$(printf "Headphones\nSpeakers" | rofi -dmenu -c -l 2 -i -p "Choose output:")
    case "$choice" in
        Headphones) headphones ;;
        Speakers)   speakers ;;
    esac
}

if [[ $# -gt 0 ]]; then
    "$1"
else
    switchAudio
fi

