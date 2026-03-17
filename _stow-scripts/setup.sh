#!/usr/bin/env bash

STOW_SCRIPTS_DIR="$HOME/dotfiles/_stow-scripts"
cd $STOW_SCRIPTS_DIR || {
    color_echo red "Error: Cannot cd into \$STOW_SCRIPTS_DIR"
    exit 1
}

if [ ! -f "utils.sh" ]; then
    color_echo red "Error: utils.sh not found!"
    exit 1
fi

if [ ! -f "helpers.sh" ]; then
    color_echo red "Error: helpers.sh not found!"
    exit 1
fi

source utils.sh
source helpers.sh

clear
print_logo

install-packages

dotfiles-setup

print_defaults

reload-config

color_echo green "Setup complete!"
