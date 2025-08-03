#!/bin/bash
DOTFILES_DIR="dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

if [ $? -eq 0 ]; then
  cd "$DOTFILES_DIR"
  stow --adopt .
else
  echo "Failed to stow the repo"
  exit 1
fi

