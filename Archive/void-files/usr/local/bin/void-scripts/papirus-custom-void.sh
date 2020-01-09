#!/bin/bash

echo "Installing Papirus from source..."

  sudo xbps-remove -Ry papirus-icon-theme papirus-folders
  wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh

sleep 2s

echo "Changing colors..."

  sudo find /usr/share/icons/Papirus/*/places -type f -name "*.svg" -exec sed -i "s/5294e2/478061/gI" {} \;
  sudo find /usr/share/icons/Papirus/*/places -type f -name "*.svg" -exec sed -i "s/4877b1/2F5440/gI" {} \;
  sudo find /usr/share/icons/Papirus/*/places -type f -name "*.svg" -exec sed -i "s/1d344f/1D1D1D/gI" {} \;

clear
echo "Papirus-Custom-Void: done!"
