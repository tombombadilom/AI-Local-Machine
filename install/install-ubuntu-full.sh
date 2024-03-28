#!/usr/bin/env bash
## check if git is installed if not install it
if ! command -v git &> /dev/null
then
    echo "git n'est pas installé"
    sudo apt-get install -y git
fi

git https://github.com/JaKooLit/Debian-Hyprland.git
cd Debian-Hyprland

source install.sh