#!/usr/bin/env bash

source utils.sh

change-shell() {
    if ! command -v zsh &>/dev/null; then
        echo "zsh is not installed."
        return 1
    fi

    local current_shell
    current_shell="$(getent passwd "$USER" | cut -d: -f7)"

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$current_shell" == "$zsh_path" ]]; then
        echo "Shell is already set to zsh."
        return 0
    fi

    echo "Changing shell to zsh..."
    chsh -s "$zsh_path" || {
        echo "Failed to change shell."
        return 1
    }

    echo "Shell changed to zsh. Log out and back in to apply."
}

dotfiles-setup() {
    DOTFILES_DIR="$HOME/dotfiles"

if ! is_installed stow; then
    echo "Install stow first"
    return 1
fi

cd "$DOTFILES_DIR" || {
    echo "Dotfiles directory not found"
    return 1
}

echo "Preview of stow changes:"
if ! stow -vnR --dotfiles [a-z]*/; then
    echo "Stow preview failed."
    return 1
fi

read -rp "Do you want to proceed stow(will recreate existing symlinks)? [y/N]: " run_stow

if [[ "$run_stow" =~ ^[Yy]$ ]]; then
    echo "Stow in progress..."
    stow -vR --dotfiles [a-z]*/ || {
        echo "Stow failed."
        return 1
    }
    echo "Dotfiles installed succesfully."
else
    echo "Stow canceled."
    return 0
fi

}

install-packages() {
if [ ! -f "packages.conf" ]; then
    echo "Error: packages.conf not found!"
    return 1
fi

source packages.conf

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

install_aur_helper

# Sync packages 
echo "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

echo "Installing Desktop utils..."
install_packages "${DESKTOP[@]}"

# Ask confirmation before installing fonts
read -rp "Do you want to install development tools? [y/N]: " install_devtools
if [[ "$install_devtools" =~ ^[Yy]$ ]]; then
    echo "Installing development tools..."
    install_packages "${DEV_TOOLS[@]}"
else
    echo "Skipping development tools installation."
fi

echo "Installing fonts..."
install_packages "${FONTS[@]}"

fc-cache -v &>/dev/null

# Enable services
echo "Configuring services..."
for service in "${SERVICES[@]}"; do
    if ! systemctl is-enabled "$service" &> /dev/null; then
        echo "Enabling $service..."
        sudo systemctl enable "$service"
    else
        echo "$service is already enabled"
    fi
done

echo "Configuring user services..."
for service in "${USER_SERVICES[@]}"; do
    if ! systemctl --user is-enabled "$service" &> /dev/null; then
        echo "Enabling user service: $service"
        systemctl --user enable "$service"
    else
        echo "User service $service is already enabled"
    fi
done

echo "Packages installed, services configured."

}
