#!/usr/bin/env bash

SOURCE="Desktop Audio"

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
