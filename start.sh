#!/usr/bin/env bash
## check the os of the machine (arch linux, debian , ubuntu )
if [ -f /etc/arch-release ]; then
  OS="arch"
  sudo pacman -S --noconfirm valgrind
elif [ -f /etc/debian_version ]; then
  OS="debian"
  DEBIAN_VERSION=$(echo "$(cat /etc/debian_version | cut -d '/' -f1)" | cut -d '-' -f1)
  if [ "$DEBIAN_VERSION" == "trixie" ]; then
    DEBIAN_VERSION="13"
  fi
  if ! [[ "$DEBIAN_VERSION" =~ ^[0-9]+$ ]]; then
    echo "Unknown Debian version, please install Valgrind manually"
    exit 1
  fi
  if [ "$DEBIAN_VERSION" -lt "10" ] || [ "$DEBIAN_VERSION" -ge "15" ]; then
    echo "Debian version not supported, please use Debian 10 (Buster) or higher"
    exit 1
  else
    DEBIAN_RELEASE="$DEBIAN_VERSION"
  fi
  sudo apt-get install valgrind -y
  # Check for common bugs
  bash -n ./install/install-debian-full.sh
  valgrind --leak-check=full ./install/install-debian-full.sh
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  OS="$ID"
  if [ "$ID" == "ubuntu" ]; then
    UBUNTU_VERSION=$(echo "$(echo $VERSION_ID | cut -d '.' -f1)" | cut -d '/' -f1)
    if ! [[ "$UBUNTU_VERSION" =~ ^[0-9]+$ ]]; then
      echo "Unknown Ubuntu version, please install Valgrind manually"
      exit 1
    fi
    if [ "$UBUNTU_VERSION" -lt "20" ]; then
      echo "Ubuntu version not supported, please use Ubuntu 20.04 (Focal) or higher"
      exit 1
    else
      UBUNTU_RELEASE="$UBUNTU_VERSION"
    fi
    sudo apt-get install valgrind -y
    # Check for common bugs
    bash -n ./install/install-ubuntu-full.sh
    valgrind --leak-check=full ./install/install-ubuntu-full.sh
  else
    echo "Unsupported Linux distribution, please install Valgrind manually"
    exit 1
  fi
else
  echo "Unknown Linux distribution, please install Valgrind manually"
  exit 1
fi

read -p "Do you want to install only the AI applications or the whole Hyprland Display with the AI chat in it? (apps/full) " answer
if [[ "${answer}" == "apps" ]]; then
  bash -n ./install/install-apps.sh
  valgrind --leak-check=full ./install/install-apps.sh
elif [[ "${answer}" == "full" ]]; then
  if [ "$OS" == "debian" ] && [ "$DEBIAN_VERSION" -eq "10" ]; then
    echo "debian install"
    bash -n ./install/install-debian-full.sh
    valgrind --leak-check=full ./install/install-debian-full.sh
  elif [ "$OS" == "debian" ] && [ "$DEBIAN_VERSION" -eq "13" ]; then
    echo "debian install"
    bash -n ./install/install-debian-trixie-full.sh
    valgrind --leak-check=full ./install/install-debian-trixie-full.sh
  elif [ "$OS" == "ubuntu" ] && [ "$UBUNTU_VERSION" -eq "20" ]; then
    echo "ubuntu install"
    bash -n ./install/install-ubuntu-full.sh
    valgrind --leak-check=full ./install/install-ubuntu-full.sh
  else
    echo "Arch Linux install"
    bash -n ./install/install-arch-full.sh
    valgrind --leak-check=full ./install/install-arch-full.sh

