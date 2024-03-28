#!/usr/bin/env bash
## check if git is installed if not install it
if ! command -v git &> /dev/null
then
    echo "git n'est pas installé"
    sudo apt-get install -y git
fi

git https://github.com/JaKooLit/Debian-Hyprland.git
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
source ~/.bashrc
source ~/.zshrc
nvm install 21
npm i -g typescript
sudo apt install -y libpulse-dev libgjs-dev axel libtinyxml2 libgtk-mm-3.0-dev libgtksourceviewmm-3.0-dev
cd Debian-Hyprland

source install.sh
git clone https://github.com/end-4/dots-hyprland.git
cd dots-hyprland
source non-Arch-installer.temp.sh