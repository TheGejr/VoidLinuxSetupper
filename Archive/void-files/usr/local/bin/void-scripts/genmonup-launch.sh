#!/bin/bash

### Check manual interventions before updating
#printf "Known manual interventions:\n\n"
#if [ $(lynx -dump -nolist https://voidlinux.org/news/archive.html | grep -i "intervention" | wc -l) -eq 0 ]; then
#  printf "None" && sleep 1s
#else
#  lynx -dump -nolist https://voidlinux.org/news/archive.html | grep -i "intervention"
#  printf "\n"
#  read -p "Visit news page for more details? [Y/n] " a
#    if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
#      lynx https://voidlinux.org/news/archive.html
#    fi
#fi
#
#clear

sudo xbps-install -Su
xfce4-panel --plugin-event=genmon-5:refresh:bool:true

clear

### Delete obsolete packages and clean cache
printf "Cleaning cache and obsolete packages...\n\n"
sudo xbps-remove -Oo

clear

### Check and purge old kernels
printf "Kernels marked for deletion:\n\n"
if [ $(vkpurge list | wc -l) -eq 0 ]; then
  printf "None" && sleep 1s
else
  vkpurge list
  printf "\n"
  read -p "Purge? [Y/n] " a
    if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
      sudo vkpurge rm all
    else
      printf "Cancelled" && sleep 1s
    fi
fi

clear

### End script
printf "System updated!\n"
read -p "Press ENTER to close. "
exit 0

### End script alt
#notify-send --icon=system-software-update "Update completed."
#exit 0
