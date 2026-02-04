#!/bin/bash

DOTFILES_DIR="$HOME/dotfiles"

is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

if [ $? -eq 0 ]; then
  cd "$DOTFILES_DIR"
  stow -R --dotfiles -v */
else
  echo "Failed to stow the repo"
  exit 1
fi

