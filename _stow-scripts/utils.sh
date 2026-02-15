#!/bin/bash

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

# Function to check if a package is installed
is_installed() {
  pacman -Qi "$1" &> /dev/null
}

# Function to check if a package is installed
is_group_installed() {
  pacman -Qg "$1" &> /dev/null
}

install_aur_helper() {
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
        echo "AUR helper(paru) is already installed"
    fi
}

# Function to install packages if not already installed
install_packages() {
  local packages=("$@")
  local to_install=()

  for pkg in "${packages[@]}"; do
    if ! is_installed "$pkg" && ! is_group_installed "$pkg"; then
      to_install+=("$pkg")
    fi
  done

  if [ ${#to_install[@]} -ne 0 ]; then
    echo "Installing: ${to_install[*]}"
    paru -S --noconfirm "${to_install[@]}"
  fi
} 
