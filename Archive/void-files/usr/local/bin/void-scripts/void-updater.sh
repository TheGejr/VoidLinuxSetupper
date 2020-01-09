#!/bin/bash

### Required packages: sudo xbps-install -S lynx zenity

readonly AVUP=$(xbps-install -nuM | wc -l)
readonly XTRM=xfce4-terminal

if [ ! -d ~/.snooze/ ]; then
  mkdir ~/.snooze/
fi
date +%c > ~/.snooze/updater

if [ $AVUP -gt 0 ]; then
  zenity --title="Void Updates" --name="Void Updates" --question --width=280 --height=140 --ok-label="Yes" --cancel-label="No" \
  --window-icon="/usr/share/icons/Papirus/64x64/apps/distributor-logo-void.svg" --icon-name="system-software-update" \
  --text "$AVUP update(s) available.\nDo you want to proceed?"
    if [ $? = 0 ]; then
      $XTRM -x '/usr/local/bin/void-scripts/execute.sh'
    else
      exit 0
    fi
else
  exit 0
fi
