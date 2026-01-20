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

# Update the system first
echo "Updating system..."
sudo pacman -Syu --noconfirm

bash install-packages.sh

bash install-tpm.sh

bash dotfiles-setup.sh

bash change-shell.sh

echo "Setup complete! You may want to reboot your system."
