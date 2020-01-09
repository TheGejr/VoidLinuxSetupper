#!/bin/bash

### Required packages: sudo xbps-install -S cpufrequtils cpupower git lynx

readonly CHKUPD=$(xbps-install -nuM | wc -l)

spell1() {
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
}

spell2() {
  printf "Kernels marked for deletion:\n"
  if [ $(vkpurge list | wc -l) -eq 0 ]; then
    printf "None" && sleep 1s
  else
    vkpurge list
    printf "\n"
    read -p "Purge? [Y/n] " a
      if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
        sudo vkpurge rm all
      else
        clear
        printf "Cancelled" && sleep 1s
      fi
  fi
}

spell3() {
  sudo xbps-remove -Oo
}

spell4() {
  rm -rfv ~/.thumbnails/
  rm -rfv ~/.cache/thumbnails/
}

spell5() {
  rm -rfv ~/.cache/
}

spell6() {
  if [ $(xbps-query -l | grep "^uu" | wc -l) -eq 0 ]; then
    printf "None" && sleep 1s
  else
    xbps-query -l | grep "^uu"
    printf "\n"
    read -p "Reconfigure? [Y/n] " a
      if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
        sudo xbps-reconfigure -a
        printf "\nDone" && sleep 1s
      else
        clear
        printf "Cancelled" && sleep 1s
      fi
  fi
}

spell7() {
  sudo xbps-pkgdb -a
  printf "\n"
  read -p "Press ENTER to close "
}

spell8() {
  printf "All source packages will be downloaded in 'github-void' hidden folder.\n"
  printf "\n"
  read -p "Continue? [y/n] " a
    if [ "$a" = "Y" ] || [ "$a" = "y" ]; then
      if [ ! -d $HOME/.github-void/void-packages/ ]; then
        printf "\nLocal repository 'void-packages' doesn't exist.\nInitializing... (git clone)\n\n"
        mkdir $HOME/.github-void/
        cd $HOME/.github-void/
        git clone git://github.com/void-linux/void-packages.git
        cd $HOME
      else
        printf "\nLocal repository 'void-packages' already exists.\nUpdating... (git pull)\n\n"
        cd $HOME/.github-void/void-packages/
        git pull
        cd $HOME
      fi
      clear
      printf "\nAvailable restricted packages:\n(https://docs.voidlinux.org/xbps/repositories/restricted.html)\n\n"
      grep -rl '^restricted=' $HOME/.github-void/void-packages/srcpkgs/ | cut -d '/' -f 7 | sort -n
      printf "\n"
      read -p "Press ENTER to close "
    else
      clear
      printf "Cancelled" && sleep 1s
    fi
}

spell9() {
  printf "\n  \e[1mG A M I N G   M O D E\e[0m\n  |\n  |------------ ON -> 1\n  |----------- OFF -> 2\n  |---------- INFO -> 3\n  |--------- ABORT -> 0\n  |\n  |\n"
  read -p "  |__________ Option: " a
    if [ "$a" = "1" ]; then
      clear
      #printf "\n\nStop Conky...\n"
        #killall conky
      #printf "\n\nStop Redshift...\n"
        #killall redshift && killall redshift-gtk
      printf "\n\nStop updates service...\n"
        sudo sv stop void-updater ## Only if you have my void-updater service
      printf "\n\nDisable compositor...\n"
        xfconf-query -c xfwm4 -p /general/use_compositing -s false ## Xfwm only, adapt to other compositors or comment this line
      printf "\n\nBoost CPU perfs...\n"
        sudo cpupower -c all frequency-set -g performance ## Should work with any AMD or Intel CPUs
      printf "\n\nBoost GPU perfs...\n"
        echo 'performance' | sudo tee /sys/class/drm/card0/device/power_dpm_state ## Recent AMD GPUs only (RX and Vega series)
        echo 'high' | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level ## Recent AMD GPUs only (RX and Vega series)
      #printf "Set swap threshold to optimized 90%...\n"
        #sudo sysctl vm.swappiness=10 && sudo swapoff -a && sudo swapon -a ## Swappiness should always be set on "10" with "sudo mkdir /etc/sysctl.d/ && echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf"
      printf "\n\nDone!"
      printf "\nPS: CPU and GPU settings will revert to default after reboot." && sleep 2s ## Swappiness too
    elif [ "$a" = "2" ]; then
      clear
      #printf "\n\nLaunch Conky...\n"
        #conky -q
      #printf "\n\nLaunch Redshift...\n"
        #redshift-gtk
      printf "\n\nStart updates service...\n"
        sudo sv start void-updater ## Only if you have my void-updater service
      printf "\n\nEnable compositor...\n"
        xfconf-query -c xfwm4 -p /general/use_compositing -s true ## Xfwm only, adapt to other compositors or comment this line
      printf "\n\nReset CPU perfs...\n"
        sudo cpupower -c all frequency-set -g ondemand ## Should work with any AMD or Intel CPUs; Recent Intel CPUs should use "powersave" instead of "ondemand"
      printf "\n\nReset GPU perfs...\n"
        echo 'balanced' | sudo tee /sys/class/drm/card0/device/power_dpm_state ## Recent AMD GPUs only (RX and Vega series)
        echo 'auto' | sudo tee /sys/class/drm/card0/device/power_dpm_force_performance_level ## Recent AMD GPUs only (RX and Vega series)
      #printf "Set swap threshold to default 40%...\n"
        #sudo sysctl vm.swappiness=60 && sudo swapoff -a && sudo swapon -a ## Swappiness should always be set on "10" with "sudo mkdir /etc/sysctl.d/ && echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf"
      printf "\n\nDone!" && sleep 1s
    elif [ "$a" = "3" ]; then
      clear
      printf "This function disables compositor then enables CPU and GPU max frequencies;\nIt will only work with: Xfwm + AMD or Intel CPUs + recent AMD GPUs;\nLook at the script' source code (spell9) for more details.\n\n"
      read -p "Press ENTER to close "
    else
      clear
      printf "Cancelled" && sleep 1s
    fi
}

spell0() {
  exit 0
}

clear
while [ 1 ];do
clear
cat << "EOF"
               _     _ __    __ _                  _ 
   /\   /\___ (_) __| / / /\ \ (_)______ _ _ __ __| |
   \ \ / / _ \| |/ _` \ \/  \/ / |_  / _` | '__/ _` |
    \ V / (_) | | (_| |\  /\  /| |/ / (_| | | | (_| |
     \_/ \___/|_|\__,_| \/  \/ |_/___\__,_|_|  \__,_|
EOF
printf "\n
          \e[1m\e[35m1\e[0m \e[2m=>\e[0m \e[1mRun system update\e[0m ($CHKUPD available)
          \e[1m\e[35m2\e[0m \e[2m=>\e[0m \e[1mClean old kernels\e[0m
          \e[1m\e[35m3\e[0m \e[2m=>\e[0m \e[1mClean obsolete packages\e[0m
          \e[1m\e[35m4\e[0m \e[2m=>\e[0m \e[1mClean thumbnails cache\e[0m
          \e[1m\e[35m5\e[0m \e[2m=>\e[0m \e[1mClean global user cache\e[0m
          \e[1m\e[35m6\e[0m \e[2m=>\e[0m \e[1mCheck misconfigured packages\e[0m
          \e[1m\e[35m7\e[0m \e[2m=>\e[0m \e[1mCheck installed packages errors\e[0m
          \e[1m\e[35m8\e[0m \e[2m=>\e[0m \e[1mList restricted source packages\e[0m
          \e[1m\e[35m9\e[0m \e[2m=>\e[0m \e[1mToggle gaming mode\e[0m
          \e[1m\e[35m0\e[0m \e[2m=>\e[0m \e[1mQuit\e[0m
       \e[2m_ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _ _\e[0m
\n"
	printf "  \e[1m\e[35mOPTION:\e[0m "
	read _cast
	case $_cast in
		1)
			clear
			spell1
			sleep 1s
		;;
		2)
			clear
			spell2
			sleep 1s
		;;
		3)
			clear
			spell3
			sleep 1s
		;;
		4)
			clear
			spell4
			sleep 1s
		;;
		5)
			clear
			spell5
			sleep 1s
		;;
		6)
			clear
			spell6
			sleep 1s
		;;
		7)
			clear
			spell7
			sleep 1s
		;;
		8)
			clear
			spell8
			sleep 1s
		;;
		9)
			clear
			spell9
			sleep 1s
		;;
		0)
			clear
			spell0
			break
		;;
	esac
done
