#!/bin/bash

# Print the logo
print_logo() {
    cat << "EOF"
      _       _                      ___  
  __| |_   _| | ____ _ _   _  __ _ / _ \ 
 / _` | | | | |/ / _` | | | |/ _` | | | |
| (_| | |_| |   < (_| | |_| | (_| | |_| |
 \__,_|\__, |_|\_\__,_|\__, |\__,_|\___/ 
       |___/           |___/             
     _       _    __ _ _                 
  __| | ___ | |_ / _(_) | ___  ___       
 / _` |/ _ \| __| |_| | |/ _ \/ __|      
| (_| | (_) | |_|  _| | |  __/\__ \      
 \__,_|\___/ \__|_| |_|_|\___||___/      

                                                  Tailored 
                                               for Arch Linux 

EOF
}

# Clear screen and show logo
clear
print_logo

# Exit on any error
set -e

# Source utility functions
source utils.sh

# Source the package list
if [ ! -f "packages.conf" ]; then
    echo "Error: packages.conf not found!"
    exit 1
fi

source packages.conf

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install yay AUR helper if not present
if ! command -v paru &> /dev/null; then
    echo "Installing paru AUR helper..."
    sudo pacman -S --needed git base-devel --noconfirm
    if [[ ! -d "paru" ]]; then
        echo "Cloning paru repository..."
    else
        echo "paru directory already exists, removing it..."
        rm -rf paru
    fi

    git clone https://aur.archlinux.org/paru.git

    cd paru
    echo "building paru"
    makepkg -si --noconfirm
    cd ..
    rm -rf paru
else
    echo "paru is already installed"
fi

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

echo "Installing media packages..."
install_packages "${MEDIA[@]}"

echo "Installing fonts..."
install_packages "${FONTS[@]}"

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

  echo "Packages Synced."
