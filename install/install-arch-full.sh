#!/usr/bin/env bash
## install git
if command -v git &> /dev/null
then
    echo "git est installé"
else
    echo "git n'est pas installé"
    sudo pacman -S --needed base-devel git
fi
## yay 
if command -v yay &> /dev/null
then
    echo "yay est installé"
else
  echo "yay n'est pas installé"
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si
  ## init yay 
  cd 
  yay -Syyu
fi

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
## Start install 
install "coreutils cliphist cmake curl onefetch fuzzel rsync wget ripgrep gojq npm meson typescript gjs dart-sass axel"

# Make deps of MicroTeX
install "tinyxml2 gtkmm3 gtksourceviewmm cairomm"

### Python
# Add `python-setuptools-scm` and `python-wheel` explicitly to fix #197
install "python-build python-materialyoucolor-git python-pillow python-pywal python-setuptools-scm python-wheel"


### Basic graphic env
install "hyprcursor hyprland-git xorg-xrandr xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-hyprland-git"

### Player and Audio
install "rustup pavucontrol wireplumber libdbusmenu-gtk3 plasma-browser-integration playerctl swww"

### GTK
install "webp-pixbuf-loader gtk-layer-shell gtk3 gtksourceview3 gobject-introspection upower yad ydotool"

### Gnome
install "polkit-gnome gnome-keyring gnome-control-center blueberry networkmanager brightnessctl wlsunset gnome-bluetooth-3.0"

### Widgets
install "python-pywayland python-psutil hypridle-git hyprlock-git wlogout wl-clipboard hyprpicker-git anyrun-git"

### Fonts and Themes
install "adw-gtk3-git nw-look-bin qt6ct qt6-wayland gradience-git fontconfig ttf-readex-pro ttf-jetbrains-mono-nerd ttf-material-symbols-variable-git ttf-space-mono-nerd fish foot starship"

### Screenshot and Recoder
install "swappy wf-recorder grim tesseract tesseract-data-eng slurp"

echo "install complete"

### install dots-hyprland
echo "starting dots-hyprland install"
cd
# Chemin vers le répertoire où vérifier l'existence de dots-hyprland
dots_dir="$HOME/dots-hyprland"

# URL du dépôt Git à cloner
url_depot="https://github.com/end-4/dots-hyprland"

# Vérification de l'existence du répertoire
if [ -d "$dots_dir" ]; then
    echo "Le répertoire $dots_dir existe déjà."
    cd $dots_dir
    git pull 
else
    echo "Le répertoire $dots_dir n'existe pas. Clonage du dépôt..."
    git clone $url_depot $dots_dir
    cd $dots_dir
fi
./install.sh

## complete installation

# Définition des chemins et des URLs des dépôts Git
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
source ./app-install.sh
echo "config installation complete you better restart your computer !"