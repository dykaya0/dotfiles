#!/usr/bin/env bash

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

color_echo() {
    local color_name="$1"
    shift
    local text="$*"

    declare -A colors=(
        [black]=30
        [red]=31
        [green]=32
        [yellow]=33
        [blue]=34
        [magenta]=35
        [cyan]=36
        [white]=37
    )

    local color_code="${colors[$color_name]}"
    echo -e "\e[${color_code}m${text}\e[0m"
}

print_defaults() {
    if [[ -z "$XDG_CONFIG_HOME" ]]; then
        color_echo red "\$XDG_CONFIG_HOME is null or empty"
    fi

    color_echo blue "Defaults: "

    color_echo magenta "$XDG_CONFIG_HOME/hypr/configs/variables.conf =>"
    echo -e "\t.\n\t.\n\t."
    sed -n '10,20p' $XDG_CONFIG_HOME/hypr/configs/variables.conf
    echo -e "\t.\n\t.\n\t."

    color_echo magenta "$HOME/.zprofile =>"
    echo -e "\t.\n\t.\n\t."
    cat $HOME/.zprofile
    echo -e "\t.\n\t.\n\t."
}

reload-config() {
    color_echo green "Reloading config..."
    hyprctl reload &>/dev/null
}

is_installed() {
  pacman -Qi "$1" &> /dev/null
}

is_group_installed() {
  pacman -Qg "$1" &> /dev/null
}

install_aur_helper() {
    if ! command -v paru &> /dev/null; then
        color_echo cyan "Installing paru AUR helper..."
        sudo pacman -S --needed git base-devel --noconfirm
        if [[ ! -d "paru" ]]; then
            color_echo blue "Cloning paru repository..."
        else
            color_echo red "paru directory already exists, removing it..."
            rm -rf paru
        fi

        git clone https://aur.archlinux.org/paru.git

        cd paru
        color_echo yellow "building paru"
        makepkg -si --noconfirm
        cd ..
        rm -rf paru
    else
        color_echo green "AUR helper(paru) is already installed"
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
    color_echo cyan "Installing: ${to_install[*]}"
    paru -S --noconfirm "${to_install[@]}"
  fi
} 
