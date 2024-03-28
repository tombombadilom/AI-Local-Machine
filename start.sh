#!/usr/bin/env bash
## check the os of the machine (arch linux, debian , ubuntu )
if [ -f /etc/arch-release ]; then
  OS="arch"
elif [ -f /etc/debian_version ]; then
  OS="debian"
  DEBIAN_VERSION=$(cat /etc/debian_version | cut -d '.' -f1 | cut -d '/' -f1)
  if [ "$DEBIAN_VERSION" -lt "13" ] || [ "$DEBIAN_VERSION" -ge "14" ]; then
    echo "Debian version not supported, please use Debian 10 (Buster) or higher"
    exit 1
  else
    DEBIAN_RELEASE="trixie"
  fi
elif [ -f /etc/os-release ]; then
  . /etc/os-release
  if [ "$ID" == "ubuntu" ]; then
    OS="ubuntu"
    UBUNTU_VERSION=$(echo $VERSION_ID | cut -d '.' -f1)
    if [ "$UBUNTU_VERSION" -lt "20" ]; then
      echo "Ubuntu version not supported, please use Ubuntu 20.04 (Focal) or higher"
      exit 1
    else
      UBUNTU_RELEASE="focal"
    fi
  fi
fi

read -p "Do you want to install only the AI applications or the whole Hyprland Display with the AI chat in it? (apps/full) " answer
if [[ "${answer}" == "apps" ]]; then
  source ./install/install-apps.sh
elif [[ "${answer}" == "full" ]]; then
  if [ "$OS" == "debian" ] && [ "$DEBIAN_VERSION" -eq "10" ]; then
    source ./install/install-debian-full.sh
  elif [ "$OS" == "ubuntu" ] && [ "$UBUNTU_VERSION" -eq "20" ]; then
    source ./install/install-ubuntu-full.sh
  else
    source ./install/install-full.sh
  fi

else
  echo "Please answer with 'apps' or 'full'"
fi

