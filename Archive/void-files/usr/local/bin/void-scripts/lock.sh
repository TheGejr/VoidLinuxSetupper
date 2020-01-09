#!/bin/bash
# Not really secure, shouldn't be used

### Required packages: sudo xbps-install -S physlock tty-clock wmctrl xfce4-terminal

wmctrl -k on
xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 2
xfce4-terminal --fullscreen --hide-menubar --hide-scrollbar --color-bg=#000 --font='Monospace 35' -e 'tty-clock -cDC 7' &&

if ! pgrep -x "tty-clock" > /dev/null; then
  physlock -dsm
  xfconf-query -c xfce4-panel -p /panels/panel-1/autohide-behavior -s 0
  wmctrl -k off
fi

exit 0
