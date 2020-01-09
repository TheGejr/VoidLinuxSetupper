#!/bin/bash

echo "Installing Papirus from source..."

  sudo xbps-remove -Ry papirus-icon-theme papirus-folders
  wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-icon-theme/master/install.sh | sh
  wget -qO- https://raw.githubusercontent.com/PapirusDevelopmentTeam/papirus-folders/master/install.sh | sh

sleep 2s

echo "Changing colors..."

  papirus-folders -C teal

clear
echo "Papirus-Custom: done!"
