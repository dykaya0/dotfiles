#!/bin/bash

ORIGINAL_DIR=$(pwd)
REPO_NAME="dotfiles"


is_stow_installed() {
  pacman -Qi "stow" &> /dev/null
}

if ! is_stow_installed; then
  echo "Install stow first"
  exit 1
fi

cd ~

if [ $? -eq 0 ]; then
  cd "$REPO_NAME"
  stow .
else
  echo "Failed to stow the repo"
  exit 1
fi

