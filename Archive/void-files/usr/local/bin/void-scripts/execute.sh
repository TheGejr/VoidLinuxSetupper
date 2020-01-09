#!/bin/bash

printf "Known manual interventions:\n\n"
if [ $(lynx -dump -nolist https://voidlinux.org/news/archive.html | grep -i "intervention" | wc -l) -eq 0 ]; then
  printf "None" && sleep 1s
else
  lynx -dump -nolist https://voidlinux.org/news/archive.html | grep -i "intervention"
  printf "\n"
  read -p "Visit news page for more details? [Y/n] " a
    if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
      lynx https://voidlinux.org/news/archive.html
    fi
fi
clear
sudo xbps-install -Su | sudo tee /var/log/xbps-update.log
date | sudo tee -a /var/log/xbps-update.log
printf "System updated!\n"
printf "Log file available at \'/var/log/xbps-update.log\'.\n\n"
read -p "Press ENTER to close. "
