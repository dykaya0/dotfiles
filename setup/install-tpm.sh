#!/bin/bash

set -e

if ! pacman -Q tmux &>/dev/null; then
  echo "tmux is not installed."
  exit 1
fi

TPM_DIR="$HOME/.tmux/plugins/tpm"

# Check if TPM is already installed
if [ -d "$TPM_DIR" ]; then
  echo "TPM is already installed in $TPM_DIR"
else
  echo "Installing Tmux Plugin Manager (TPM)..."
  git clone https://github.com/tmux-plugins/tpm $TPM_DIR
fi

echo "TPM installed successfully!"
echo "Now opening tmux session and installing plugins..."

tmux new-session -d -s tpm_install_session

# The prefix is default (C-b) at the moment since dotfiles are not configured
tmux send-keys -t tpm_install_session C-b "I" C-m

tmux attach -t tpm_install_session

exit 0

