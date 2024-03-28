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
