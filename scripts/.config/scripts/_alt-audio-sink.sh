#!/usr/bin/env bash

sink_exists() {
    pactl list short sinks | awk '{print $2}' | grep -qx "$1"
}

module_loaded() {
    pactl list short modules | grep -q "$1"
}

load_null_sink_if_missing() {
    local name="$1"

    if sink_exists "$name"; then
        echo "Sink $name already exists."
    else
        echo "Creating sink $name..."
        pactl load-module module-null-sink \
            sink_name="$name" \
            sink_properties=device.description="$name"
    fi
}

# Set default output device to headphone
$XDG_CONFIG_HOME/scripts/menu/audio-switcher.sh headphones
sleep 1

# Step 1 - Create null sinks only if missing
load_null_sink_if_missing "ChatSink"
load_null_sink_if_missing "MainSink"
load_null_sink_if_missing "ObsMonitor"

# Step 2 - Forward sinks to default output (only if loopback not already created)
if ! module_loaded "source=ChatSink.monitor"; then
    pactl load-module module-loopback \
        source=ChatSink.monitor \
        sink=@DEFAULT_SINK@
fi

if ! module_loaded "source=MainSink.monitor"; then
    pactl load-module module-loopback \
        source=MainSink.monitor \
        sink=@DEFAULT_SINK@
fi

# Step 3 - Virtual Microphone (only if not exists)
if ! pactl list short sources | awk '{print $2}' | grep -qx "VirtualMic"; then
    pactl load-module module-virtual-source \
        source_name=VirtualMic \
        master=ObsMonitor.monitor
fi

# Step 4 - Start OBS Studio only if not running
if ! pgrep -x obs >/dev/null; then
    obs &
fi

# Step 5 - Waybar refresh
$XDG_CONFIG_HOME/scripts/waybar_refresh.sh
