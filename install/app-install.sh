#!/usr/bin/env bash
# Fonction pour installer des packages avec yay, seulement s'ils ne sont pas déjà installés
if [ "$(cat /etc/os-release | grep '^ID=arch' | wc -l)" -eq "1" ]; then
    install() {
        local packages=$1
        for package in $packages; do
            if ! pacman -Q $package &> /dev/null; then
                echo "Installation de $package..."
                yay -S --noconfirm $package
            else
                echo "$package est déjà installé."
            fi
        done
    }
    install "thunar blas-openblas brave-bin vim jan-bin ollama lmstudio-appimage localai-git"
else
    echo "Ce script n'est pas destiné à votre système d'exploitation."
fi


## download via curl this  appimage 
## then install it making a ./local/share/application/AnythingLLM.desktop 
curl -L https://s3.us-west-1.amazonaws.com/public.useanything.com/latest/AnythingLLMDesktop.AppImage -o $HOME/.local/bin/AnythingLLMDesktop.AppImage
mkdir -p ~/.local/share/applications
cat > ~/.local/share/applications/AnythingLLM.desktop <<EOF
[Desktop Entry]
Type=Application
Name=Anything LLM
Exec=$HOME/.local/bin/AnythingLLMDesktop.AppImage
Icon=$HOME/.local/bin/AnythingLLMDesktop.AppImage
Terminal=false
Categories=Utility;Application;
EOF


if [ "$(cat /etc/os-release | grep '^ID=debian' | wc -l)" -eq "1" ] || [ "$(cat /etc/os-release | grep '^ID=ubuntu' | wc -l)" -eq "1" ]; then
    wget https://github.com/janhq/jan/releases/download/v0.4.9/jan-linux-amd64-0.4.9.deb
    sudo dpkg -i jan-linux-amd64-0.4.9.deb
fi
