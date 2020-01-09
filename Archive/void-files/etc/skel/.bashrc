# .bashrc

## If not running interactively, don't do anything
[[ $- != *i* ]] && return

THEMESEL() {
  clear
  printf "Select a theme:\n  0) Cancel\n  1) Standard\n  2) Dark\n  3) Light\n\n"
  read -p "Option: " a
    if [ "$a" = "1" ]; then
      cat > ~/.gtkrc-2.0 << EOF
gtk-icon-theme-name = "Papirus"
gtk-theme-name = "Plata-Compact"
gtk-font-name = "Ubuntu 11"
gtk-cursor-theme-name = "Vanilla-DMZ"
EOF
      cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-icon-theme-name = Papirus
gtk-theme-name = Plata-Compact
gtk-font-name = Ubuntu 11
gtk-cursor-theme-name = Vanilla-DMZ
gtk-recent-files-enabled=0
EOF
      xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus
      xfconf-query -c xsettings -p /Net/ThemeName -s Plata-Compact
      xfconf-query -c xfwm4 -p /general/theme -s Plata-Compact
      xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Vanilla-DMZ
      sed -i 's/DMZ-AA/DMZ/g' ~/.Xresources
      cp ~/.xfce-wireframe-mouse-dark.png ~/.face
      #sed -i 's/grayscale-dark/grayscale-light/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/start-black/start-white/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/111111/f5f5f5/g' ~/.genmonup-icon.svg
    elif [ "$a" = "2" ]; then
      cat > ~/.gtkrc-2.0 << EOF
gtk-icon-theme-name = "Papirus-Dark"
gtk-theme-name = "Plata-Noir-Compact"
gtk-font-name = "Ubuntu 11"
gtk-cursor-theme-name = "Vanilla-DMZ"
EOF
      cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-icon-theme-name = Papirus-Dark
gtk-theme-name = Plata-Noir-Compact
gtk-font-name = Ubuntu 11
gtk-cursor-theme-name = Vanilla-DMZ
gtk-recent-files-enabled=0
EOF
      xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
      xfconf-query -c xsettings -p /Net/ThemeName -s Plata-Noir-Compact
      xfconf-query -c xfwm4 -p /general/theme -s Plata-Noir-Compact
      xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Vanilla-DMZ
      sed -i 's/DMZ-AA/DMZ/g' ~/.Xresources
      cp ~/.xfce-wireframe-mouse-light.png ~/.face
      #sed -i 's/grayscale-dark/grayscale-light/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/start-black/start-white/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/111111/f5f5f5/g' ~/.genmonup-icon.svg
    elif [ "$a" = "3" ]; then
      cat > ~/.gtkrc-2.0 << EOF
gtk-icon-theme-name = "Papirus-Light"
gtk-theme-name = "Plata-Lumine-Compact"
gtk-font-name = "Ubuntu 11"
gtk-cursor-theme-name = "Vanilla-DMZ-AA"
EOF
      cat > ~/.config/gtk-3.0/settings.ini << EOF
[Settings]
gtk-icon-theme-name = Papirus-Light
gtk-theme-name = Plata-Lumine-Compact
gtk-font-name = Ubuntu 11
gtk-cursor-theme-name = Vanilla-DMZ-AA
gtk-recent-files-enabled=0
EOF
      xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Light
      xfconf-query -c xsettings -p /Net/ThemeName -s Plata-Lumine-Compact
      xfconf-query -c xfwm4 -p /general/theme -s Plata-Lumine-Compact
      xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Vanilla-DMZ-AA
      sed -i 's/DMZ/DMZ-AA/g' ~/.Xresources
      cp ~/.xfce-wireframe-mouse-dark.png ~/.face
      #sed -i 's/grayscale-light/grayscale-dark/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/start-white/start-black/g' ~/.config/xfce4/panel/whiskermenu-1.rc
      sed -i 's/f5f5f5/111111/g' ~/.genmonup-icon.svg
    elif [ "$a" = "0" ]; then
      exit 0
    fi
  xfce4-panel -r
  printf "\nDone! You may have to login again to apply changes."
  sleep 2s
  clear
}

GAMEMODE() {
  clear
  printf "Select a mode:\n  0) Cancel\n  1) Normal CPU/GPU\n  2) Maximal CPU/GPU\n  3) Compositor only\n\n"
  read -p "Option: " a
    if [ "$a" = "1" ]; then
      sudo cpupower -c all frequency-set -g schedutil
      #echo 'balanced' | sudo tee /sys/class/drm/card0/device/power_dpm_state ### performance seems to be default
      echo 'auto' | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
      xfconf-query -c xfwm4 -p /general/use_compositing -s true
    elif [ "$a" = "2" ]; then
      sudo cpupower -c all frequency-set -g performance
      #echo 'performance' | sudo tee /sys/class/drm/card0/device/power_dpm_state ### performance seems to be default
      echo 'high' | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level
      xfconf-query -c xfwm4 -p /general/use_compositing -s false
    elif [ "$a" = "3" ]; then
      xfconf-query -c xfwm4 -p /general/use_compositing -T
    elif [ "$a" = "0" ]; then
      exit 0
    fi
  printf "\nDone! CPU/GPU changes will revert after reboot."
  sleep 2s
  clear
}

## Change themes to standard or dark or light
alias change-theme='THEMESEL'

## Change CPU/GPU perfs and toggle compositor
alias boost='GAMEMODE'

## Number of available package updates
alias vchup='xbps-install -nuM | wc -l'
## Update packages
alias vpu='sudo xbps-install -Su'
## Install package <package name>
alias vpi='sudo xbps-install -S'
## Remove package <package name>
alias vpr='sudo xbps-remove -R'
## Search package <package name>
alias vpq='xbps-query -Rs'
## Clean obsolete packages
alias vpc='sudo xbps-remove -Oo'

## Refresh Xfce updates icon
alias genmon-refresh='xfce4-panel --plugin-event=genmon-5:refresh:bool:true'

## Edit notes displayed in Conky
alias notes='nano ~/.conkytodo'

## Install/Update custom Void gtk and icon themes
alias void-gtk='/usr/local/bin/void-scripts/plata-custom-void.sh'
alias void-ico='/usr/local/bin/void-scripts/papirus-custom-void.sh'

## Run RKhunter and read log file
alias rk-run='sudo rkhunter -c --noappend-log'
alias rk-log='sudo cat /var/log/rkhunter.log | grep -i "warning"'

## Enhance some commands
alias ls='ls --color=auto --group-directories-first'
alias grep='grep --color=auto'

## Custom prompt
export PS1="\[\033[38;5;222m\][\u@\h]\[$(tput sgr0)\]\[\033[38;5;137m\]\\$\[$(tput sgr0)\]\[\033[38;5;15m\] \[$(tput sgr0)\]"
