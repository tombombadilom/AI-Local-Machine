#!/usr/bin/env bash
# Fonction pour installer des packages avec yay, seulement s'ils ne sont pas déjà installés
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

## download via curl this  appimage 
## then install it making a ./local/share/application/AnythingLLM.desktop 
curl -L https://s3.us-west-1.amazonaws.com/public.useanything.com/latest/AnythingLLMDesktop.AppImage -o AnythingLLMDesktop.AppImage
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


