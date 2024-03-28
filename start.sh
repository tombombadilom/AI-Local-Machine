#!/usr/bin/env bash

read -p "Do you want to install only the AI applications or the whole Hyprland Display with the AI chat in it? (apps/full) " answer
if [[ "${answer}" == "apps" ]]; then
  source ./install/install-apps.sh
elif [[ "${answer}" == "full" ]]; then
  source ./install/install-full.sh
else
  echo "Please answer with 'apps' or 'full'"
fi
