#!/usr/bin/env bash

add_tag_to_window() {
    hyprctl dispatch tagwindow +tmux 
}

remove_tag_from_window() {
    hyprctl dispatch tagwindow -- -tmux
}
