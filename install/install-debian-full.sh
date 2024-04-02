#!/usr/bin/env bash
## check if git is installed if not install it
if ! command -v git &> /dev/null
then
    echo "git n'est pas installé"
    sudo apt-get install -y git
fi


read -p "Do you want to install Debian-Hyprland? [Y/n] " -n 1 -r
echo
if [[ $REPLY =~ ^[Nn]$ ]]; then
    echo "Skipping Debian-Hyprland installation"
else
    cd ~/AI-Local-Machine/cache/
    git clone  https://github.com/JaKooLit/Debian-Hyprland.git
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc
    source ~/.zshrc
    nvm install 21
    npm i -g typescript
    sudo apt install -y foot foot-terminfo fish meson libgjs-dev libpulse-dev axel libtinyxml2-dev fish foot foot-terminfo libgtk-layer-shell-dev ydotoold libghc-gi-dbusmenugtk3-dev libgtksourceviewmm-3.0-dev libgtkmm-3.0-dev
    curl -sS https://starship.rs/install.sh | sh
    cd Debian-Hyprland
    source ./install.sh
    cd ../
fi


read -p "Voulez-vous lancer l'installation de dots-hyprland ? (O/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Oo]$ ]]
then
    cd ~/AI-Local-Machine/cache/
    git clone https://github.com/end-4/dots-hyprland.git
    cd dots-hyprland
    sudo apt install -y meson libgjs-dev libpulse-dev axel libtinyxml2-dev fish foot foot-terminfo libgtk-layer-shell-dev ydotoold libghc-gi-dbusmenugtk3-dev libgtksourceviewmm-3.0-dev libgtkmm-3.0-dev
    source ./non-Arch-installer.temp.sh
    cd ~/AI-Local-Machine/
    source install/hyprland-end-install.sh
else
    echo "L'installation a été annulée."
fi

read -p "Voulez-vous installer les applications AI ? (O/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Oo]$ ]]
then
    cd ~/AI-Local-Machine/
    source ./install/app-install.sh
