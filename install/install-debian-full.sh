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
    git clone  https://github.com/JaKooLit/Debian-Hyprland.git
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
    source ~/.bashrc
    source ~/.zshrc
    nvm install 21
    npm i -g typescript
    sudo apt install -y foot foot-terminfo fish libpulse-dev libgjs-dev axel libtinyxml2 libgtkmm-3.0-dev libgtksourceviewmm-3.0-dev
    curl -sS https://starship.rs/install.sh | sh
    cd Debian-Hyprland
fi


read -p "Voulez-vous lancer l'installation de dots-hyprland ? (O/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Oo]$ ]]
then
    git clone https://github.com/end-4/dots-hyprland.git
    cd dots-hyprland
    sudo apt install -y libgjs-dev libpulse-dev axel libtinyxml2-dev fish foot foot-terminfo
    bash
    source ./non-Arch-installer.temp.sh
    bash
    declare -A config_git=(
        ["$HOME/.config/ags"]="https://github.com/tombombadilom/ags"
        ["$HOME/.config/hypr"]="https://github.com/tombombadilom/hypr"
    )

    # Boucler sur chaque répertoire et son URL
    for conf in "${!config_git[@]}"; do
        url="${config_git[$conf]}"
        echo "Vérification du répertoire: $conf"
        # Vérifier si le répertoire existe
        if [ -d "$conf" ]; then
            echo "Le répertoire existe."
            # Vérifier si le répertoire .git existe à l'intérieur
            if [ -d "$conf/.git" ]; then
                echo "Le répertoire .git existe. Exécution de git pull..."
                # Se déplacer dans le répertoire et exécuter git pull
                (cd "$conf" && git pull)
            else
                echo "Le répertoire .git n'existe pas. Clonage du dépôt $url..."
                # Cloner le dépôt Git dans le répertoire spécifié
                mv "$conf" "$conf.old"
                git clone "$url" "$conf"
            fi
        else
            echo "Le répertoire $conf n'existe pas. Création et clonage du dépôt $url..."
            # Cloner le dépôt Git dans le répertoire spécifié
            git clone "$url" "$conf"
        fi
    done

    cp ../config/config.fish ~/.config/fish/.
    cp ../config/foot.ini ~/./config/foot/.
    cp ../config/user_options.js ~/.
else
    echo "L'installation a été annulée."
fi

read -p "Voulez-vous installer les applications AI ? (O/N) " -n 1 -r
echo    # (optional) move to a new line
if [[ $REPLY =~ ^[Oo]$ ]]
then
    source ./app-install.sh
