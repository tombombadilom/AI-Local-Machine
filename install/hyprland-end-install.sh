#!/usr/bin/env bash
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

    cp config/config.fish ~/.config/fish/.
    cp config/foot.ini ~/./config/foot/.
    cp config/user_options.js ~/.