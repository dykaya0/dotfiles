#!/usr/bin/env bash

STATE_FILE="$HOME/.stopwatch_state"
START_TIME_FILE="$HOME/.stopwatch_start"
TOTAL_FILE="$HOME/.stopwatch_total"

pause() {
    if [ ! -f "$START_TIME_FILE" ]; then
        echo "Not running."
        exit 0
    fi
    start_time=$(cat "$START_TIME_FILE")
    now=$(date +%s)
    elapsed=$(( now - start_time ))

    total=$(cat "$TOTAL_FILE" 2>/dev/null || echo 0)
    total=$(( total + elapsed ))
    echo "$total" > "$TOTAL_FILE"

    rm -f "$START_TIME_FILE"
    echo "paused" > "$STATE_FILE"
}

resume() {
    if [ -f "$START_TIME_FILE" ]; then
        echo "Already running."
        exit 0
    fi
    echo "$(date +%s)" > "$START_TIME_FILE"
    echo "running" > "$STATE_FILE"
}

status() {
    total=$(cat "$TOTAL_FILE" 2>/dev/null || echo 0)
    if [ -f "$START_TIME_FILE" ]; then
        start_time=$(cat "$START_TIME_FILE")
        now=$(date +%s)
        total=$(( total + (now - start_time) ))
    fi
    mins=$(( total / 60 ))
    secs=$(( total % 60 ))
    printf " %02d min %02d sec\n" "$mins" "$secs"
}


case "$1" in
    pause) pause ;;
    resume) resume ;;
    status) status ;;
    reset) rm -f "$START_TIME_FILE" "$TOTAL_FILE" "$STATE_FILE" ;;
    *) echo "Usage: $0 {pause|resume|status|reset}" ;;
esac
