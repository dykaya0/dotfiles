#!/usr/bin/env bash

# Set default output to headphone
pactl set-default-sink "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo"
notify-send -h string:bgcolor:#a3be8c "Audio switched to headphones!"

sleep 1

# Start teams in the background
teams-for-linux &

sleep 2

# Create virtual mic
pactl load-module module-null-sink sink_name=Source
pactl load-module module-virtual-source source_name=VirtualMic master=Source.monitor

sleep 1

# Start OBS in the background
obs &
