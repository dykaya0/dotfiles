#!/usr/bin/env bash

source utils.sh

change-shell() {
    if ! command -v zsh &>/dev/null; then
        color_echo red "zsh is not installed."
        exit 1
    fi

    local current_shell
    current_shell="$(getent passwd "$(id -u)" | cut -d: -f7)"

    local zsh_path
    zsh_path="$(command -v zsh)"

    if [[ "$current_shell" == "$zsh_path" ]]; then
        color_echo magenta "Shell is already set to zsh."
    fi

    color_echo magenta "Changing shell to zsh..."
    chsh -s "$zsh_path" || {
        color_echo red "Failed to change shell."
        exit 1
    }

    echo "Shell changed to zsh. Log out and back in to apply."
}

dotfiles-setup() {
    DOTFILES_DIR="$HOME/dotfiles"

if ! is_installed stow; then
    color_echo red "Install stow first"
    exit 1
fi

cd "$DOTFILES_DIR" || {
    color_echo red "Dotfiles directory not found"
    exit 1
}

color_echo magenta "Preview of stow changes:"
if ! stow -nvR --dotfiles [a-z]*/; then
    color_echo red "Stow preview failed."
    exit 1
fi

read -rp "Do you want to proceed stow(will recreate existing symlinks)? [y/N]: " run_stow

if [[ "$run_stow" =~ ^[Yy]$ ]]; then
    color_echo yellow "Stow in progress..."
    stow -vR --dotfiles [a-z]*/ || {
        color_echo red "Stow failed."
        exit 1
    }
    color_echo green "Dotfiles symlinked succesfully."
else
    color_echo red "Stow canceled."
fi

}

install-packages() {
if [ ! -f "packages.conf" ]; then
    color_echo red "Error: packages.conf not found!"
    exit 1
fi

source packages.conf

# Update the system first
color_echo yellow "Updating system..."
sudo pacman -Syu --noconfirm

install_aur_helper

# Sync packages 
color_echo yellow "Installing system utilities..."
install_packages "${SYSTEM_UTILS[@]}"

color_echo yellow "Installing Desktop utils..."
install_packages "${DESKTOP[@]}"

# Ask confirmation before installing fonts
read -rp "Do you want to install development tools? [y/N]: " install_devtools
if [[ "$install_devtools" =~ ^[Yy]$ ]]; then
    color_echo yellow "Installing development tools..."
    install_packages "${DEV_TOOLS[@]}"
else
    color_echo red "Skipping development tools installation."
fi

# Ask confirmation before installing extra packages
read -rp "Do you want to install extra packages? [y/N]: " install_extras
if [[ "$install_extras" =~ ^[Yy]$ ]]; then
    color_echo yellow "Installing extra packages..."
    install_extras "${EXTRA[@]}"
else
    color_echo red "Skipping extra packages installation."
fi

color_echo yellow "Installing fonts..."
install_packages "${FONTS[@]}"

fc-cache -v &>/dev/null

# Enable services
color_echo blue "Configuring system services..."
for service in "${SERVICES[@]}"; do
    if ! systemctl is-enabled "$service" &> /dev/null; then
        color_echo green "Enabling $service..."
        sudo systemctl enable "$service"
    else
        color_echo red "$service is already enabled"
    fi
done

color_echo blue "Configuring user services..."
for service in "${USER_SERVICES[@]}"; do
    if ! systemctl --user is-enabled "$service" &> /dev/null; then
        color_echo green "Enabling user service: $service"
        systemctl --user enable "$service"
    else
        color_echo red "User service $service is already enabled"
    fi
done

color_echo green "Packages installed, services configured."

}
