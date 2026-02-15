#!/usr/bin/env bash

STOW_SCRIPTS_DIR="$HOME/dotfiles/_stow-scripts"
cd $STOW_SCRIPTS_DIR || {
    echo "Error: Cannot cd into STOW_SCRIPTS_DIR"
    exit 1
}

if [ ! -f "utils.sh" ]; then
    echo "Error: utils.sh not found!"
    return 1
fi

if [ ! -f "helpers.sh" ]; then
    echo "Error: helpers.sh not found!"
    return 1
fi

source utils.sh
source helpers.sh

clear
print_logo

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

install-packages

dotfiles-setup

change-shell

echo "Setup complete! You may want to reboot your system."
