#!/usr/bin/env bash

headphones () { \
    pactl set-default-sink "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo"
    notify-send -h string:bgcolor:#a3be8c "Audio switched to headphones!"
}

speakers () { \
    pactl set-default-sink "alsa_output.pci-0000_00_1f.3.analog-stereo"
    notify-send -h string:bgcolor:#bf616a "Audio switched to speakers!"
}

switchAudio () { \
    choice=$(printf "Headphones\\nSpeakers" | rofi -dmenu -c -l 2 -i -p "Choose output: ")
    case "$choice" in 
        Headphones) headphones;;
        Speakers) speakers;;
    esac

}

switchAudio
