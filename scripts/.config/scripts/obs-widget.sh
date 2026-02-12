#!/usr/bin/env bash

SOURCE="Desktop Audio"

isReady() {
    if ! command -v obs-cmd >/dev/null 2>&1; then
        notify-send "obs-cmd is not installed"
        exit 1
    fi
}

getStatus() {
    STATUS_OUTPUT=$(obs-cmd audio status "$SOURCE" 2>/dev/null)
    CONNECTION_OUTPUT=$(obs-cmd info 2>&1)

    if grep -Eqi "error|connection refused" <<<"$CONNECTION_OUTPUT"; then
        echo "failed"
        exit 1
    fi

    if echo "$STATUS_OUTPUT" | grep -qi "unmuted"; then
        echo '{"text":"","class":"unmuted","tooltip":"OBS Desktop Audio: Unmuted"}'
    else
        echo '{"text":"","class":"muted","tooltip":"OBS Desktop Audio: Muted"}'
    fi
}

toggleStatus() {
    obs-cmd audio toggle "$SOURCE" >/dev/null 2>&1
}

if [[ $# -gt 0 ]]; then
    "$1"
else
    getStatus
fi

