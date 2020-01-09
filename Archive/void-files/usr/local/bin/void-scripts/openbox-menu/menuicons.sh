#!/bin/bash

readonly rcxml="$HOME/.config/openbox/rc.xml"

if grep -q "<showIcons>yes</showIcons>" "$rcxml"; then
  sed -i "s/<showIcons>yes<\/showIcons>/<showIcons>no<\/showIcons>/g" $rcxml
elif grep -q "<showIcons>no</showIcons>" "$rcxml"; then
  sed -i "s/<showIcons>no<\/showIcons>/<showIcons>yes<\/showIcons>/g" $rcxml
fi

openbox --reconfigure

exit 0