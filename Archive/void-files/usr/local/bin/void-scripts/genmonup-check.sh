#!/bin/bash

readonly NUPD=$(xbps-install -nuM | wc -l)
readonly LUPD=$(xbps-install -nuM | awk '{print $1}')
readonly TEXT1="Update(s) available :"
readonly TEXT2="Click on the icon to apply."
readonly TRMNL="xfce4-terminal --icon='system-software-update' --title='XBPS - update'"

PANEL="<click>$TRMNL -x '/usr/local/bin/void-scripts/genmonup-launch.sh'</click>"
PANEL+="<img>$HOME/.genmonup-icon.svg</img>"
PANEL+="<txt><span size='9000' weight='bold' rise='17000'>$NUPD</span></txt>"

TOOLTIP="<tool>"
TOOLTIP+="<span size='11000' weight='bold'>$NUPD $TEXT1</span>\n"
TOOLTIP+="<span size='9000'>$LUPD</span>\n\n"
TOOLTIP+="<span size='9000' weight='bold'>$TEXT2</span>"
TOOLTIP+="</tool>"

if [ $NUPD -gt 0 ]; then
  echo -e "${PANEL}"
  echo -e "${TOOLTIP}"  
else
  echo ""
fi
