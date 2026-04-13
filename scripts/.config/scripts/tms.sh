#!/usr/bin/env bash

DIRS=(
    "$HOME/projects/personal"
    "$HOME/projects/work"
    "$HOME/projects/forked"
    "$HOME/projects/meta"
)

if [[ $# -eq 1 ]]; then
    selected=$(realpath "$1" 2>/dev/null) || exit 1
else
    selected=$(
        fd . "${DIRS[@]}" --type d --max-depth 1 \
            | sed "s|^$HOME/||" \
            | fzf --no-preview
        )

    [[ $selected ]] && selected="$HOME/$selected"
fi

[[ ! $selected ]] && exit 0

if [[ -x "$selected/.launch.sh" ]]; then
    source "$selected/.launch.sh"
fi

selected_name=$(basename "$selected" | sed 's/[^a-zA-Z0-9_-]/_/g')

if ! tmux has-session -t "$selected_name" &>/dev/null; then
    tmux new-session -ds "$selected_name" -c "$selected"
    tmux select-window -t "$selected_name:1"
    launch &>/dev/null
fi

if [[ -z $TMUX ]]; then
    tmux attach -t "$selected_name"
else
    tmux switch-client -t "$selected_name"
fi
