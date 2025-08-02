#!/bin/bash

set -e

if ! pacman -Q zsh &>/dev/null; then
  echo "zsh is not installed."
  exit 1
fi

# Change shell to zsh
chsh -s $(which zsh)
# Install OhMyZsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

