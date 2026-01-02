#!/usr/bin/env bash

# Set default output device to headphone
# pactl set-default-sink "alsa_output.usb-SteelSeries_Arctis_Nova_Pro_Wireless-00.analog-stereo"
$XDG_CONFIG_HOME/scripts/menu/audio-switcher-v2.sh headphones
sleep 1

# Step 1 - Create the null sinks
pactl load-module module-null-sink sink_name=ChatSink sink_properties=device.description=ChatSink
pactl load-module module-null-sink sink_name=MainSink sink_properties=device.description=MainSink
pactl load-module module-null-sink sink_name=ObsMonitor sink_properties=device.description=ObsMonitor

# Step 2 - Forward both sinks to default output device
pactl load-module module-loopback source=ChatSink.monitor sink=@DEFAULT_SINK@
pactl load-module module-loopback source=MainSink.monitor sink=@DEFAULT_SINK@

# Step 3 - Virtual Microphone
pactl load-module module-virtual-source source_name=VirtualMic master=ObsMonitor.monitor

# Step 4 - Start OBS Studio
obs &
