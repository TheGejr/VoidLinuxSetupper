#!/bin/bash
# Automate the process of setting up Void Linux

bypass() {
  sudo -v
  while true;
  do
    sudo -n true
    sleep 45
    kill -0 "$$" || exit
  done 2>/dev/null &
}

echo "Starting Void Linux post-install script..."
sleep 3s
	bypass

clear
echo "Updating system and adding repositories..."
sleep 3s
	sudo xbps-install -Syu
	sudo xbps-install -Sy void-repo-multilib void-repo-multilib-nonfree void-repo-nonfree

clear
echo "Installing packages..."
sleep 3s
	# XFCE4 packages
	sudo xbps-install -Sy xfce4 xfce-polkit xfce4-battery-plugin xfce4-clipman-plugin xfce4-genmon-plugin xfce4-notes-plugin xfce4-pulseaudio-plugin xfce4-weather-plugin xfce4-whiskermenu-plugin xfce4-screenshooter xfce4-settings xinit xorg xtools xdg-utils xdotool adwaita-icon-theme
  
	# UI & Functionality
	sudo xbps-install -Sy alsa-plugins alsa-plugins-32bit alsa-plugins-ffmpeg alsa-plugins-pulseaudio alsa-utils conky cpupower dbus-elogind elogind exo ffmpeg garcon gmic-gimp gnome-themes-extra greybird-themes gst-libav gst-plugins-bad1 gst-plugins-base1 gst-plugins-good1 gst-plugins-ugly1 gtk-update-icon-cache gtk3-nocsd gvfs gvfs-mtp lame libGL-32bit libavcodec libavcodec-32bit libavformat-32bit libavresample-32bit libavutil-32bit libpulseaudio-32bit libtxc_dxtn-32bit menulibre mugshot ntfs-3g ntp numlockx optipng parole pavucontrol physlock procps-ng pulseaudio rkhunter scrot simple-scan snooze tty-clock udisks2 ufw unrar unzip upower wmctrl x264 xarchiver xcalib xcursor-vanilla-dmz xcursor-vanilla-dmz-aa xdg-user-dirs-gtk xf86-input-wacom xz zenity
	
	# Fonts
	sudo xbps-install -Sy font-hack-ttf fontconfig fontconfig-32bit freetype google-fonts-ttf noto-fonts-cjk noto-fonts-emoji noto-fonts-ttf 
  
	# Programs & Misc.
	sudo xbps-install -Sy fish-shell audacity zip whois torsocks spigot bash-completion cpufrequtils gzip hardinfo epdfview filezilla firefox galculator-gtk3 gimp git pidgin htop hunspell libreoffice-calc libreoffice-writer libreoffice-gnome libreoffice nano vim neovim neofetch pfetch thunar-archive-plugin thunar-volman thunderbird transmission-gtk 
	
	# General graphics drivers
	sudo xbps-install -Sy vkd3d vkd3d-32bit vulkan-loader vulkan-loader-32bit 

	# AMD drivers
	#sudo xbps-install -Sy linux-firmware-amd xf86-video-amdgpu mesa-ati-dri mesa-ati-dri-32bit mesa-vulkan-radeon	mesa-vulkan-radeon-32bit
	
	# Intel drivers
	sudo xbps-install -Sy linux-firmware-intel xf86-video-intel mesa-intel-dri mesa-intel-dri-32bit mesa-vulkan-intel mesa-vulkan-intel-32bit
	
	# Nvidia drivers
	#sudo xbps-install -Sy linux-firmware-nvidia xf86-video-nouveau mesa-nouveau-dri mesa-nouveau-dri-32bit
	
	# Openbox
	#sudo xbps-install -Sy openbox obconf obmenu nitrogen tint2 gsimplecal volumeicon compton
	
	# LightDM and screensavers
	#sudo xbps-install -Sy light-locker lightdm lightdm-gtk-greeter-settings lightdm-gtk3-greeter xfce4-screensaver
	
	# Optional XFCE4 packages
	#sudo xbps-install -Sy xfce4-panel-appmenu appmenu-gtk-module appmenu-gtk3-module plank
	
	# Powermanagement
	#sudo xbps-install -Sy pm-utils
	
	# Linux Headers
	sudo xbps-install -Sy linux-headers linux-lts-headers
  
	# Build essentials
	sudo xbps-install -Sy linux-tools gcc ctags make cmake rsync git lynx
	
	#sudo xbps-install -Sy cups cups-filters cups-pk-helper gutenprint system-config-printer
	#sudo xbps-install -Sy octoxbps
	#sudo xbps-install -Sy xiccd
	#sudo xbps-install -Sy dhcpcd-gtk
	#sudo xbps-install -Sy wpa_gui
	#sudo xbps-install -Sy gufw
	#sudo xbps-install -Sy gsmartcontrol
	#sudo xbps-install -Sy catfish
	#sudo xbps-install -Sy vokoscreen pitivi
	#sudo xbps-install -Sy gstreamer-vaapi
	#sudo xbps-install -Sy sc-controller
	
	# Virtualization
	sudo xbps-install -Sy qemu
	sudo xbps-install -Sy virtualbox-ose virtualbox-dkms virtualbox-ose-guest virtualbox-ose-guest-dkms
	
	#sudo xbps-install -Sy socklog-void
	#sudo xbps-install -Sy dconf-editor
	#sudo xbps-install -Sy android-file-transfer-linux
	#sudo xbps-install -Sy amdvlk amdvlk-32bit
	
	# Java
	sudo xbps-install -Sy openjdk-jre
	
	# DNSSEC
	sudo xbps-install -Sy dnscrypt-proxy

clear
echo "Importing files from server..."
sleep 3s
 	cd /tmp/
	wget https://gejr.dk/static/void-files.tar.xz
	tar Jxvf void-files.tar.xz
  sudo chown -r $USER void-files/
	chmod +x void-files/usr/local/share/applications/*
	chmod +x void-files/usr/local/bin/void-scripts/*
	chmod +x void-files/usr/local/bin/void-scripts/openbox-menu/*
	chmod +x void-files/usr/local/bin/void-scripts/extra-themes/*

  \cp -r void-files/etc/skel/. ~/
  \cp -r void-files/user/config/. ~/.config
	sudo \cp -r void-files/etc/. /etc
	sudo \cp -r void-files/usr/. /usr
	rm -rf void-files/
	mkdir ~/.void-backup/
	mv void-files.tar.xz ~/.void-backup/
  sudo chown -R $USER /usr/local/bin/void-scripts
	sudo chmod 755 /etc/sv/void-updater/run

clear
echo "Installing new theme..."
sleep 3s
	sudo /usr/local/bin/void-scripts/plata-custom-void.sh
	sudo /usr/local/bin/void-scripts/papirus-custom-void.sh
	sudo ln -sfnr /usr/share/icons/Papirus/64x64/apps/hardinfo.svg /usr/share/hardinfo/pixmaps/logo.png

clear
echo "Configuring system..."
sleep 3s

	sudo sed -i "s/--noclear/--noclear\ --skip-login\ --login-options=$USER/g" /etc/sv/agetty-tty1/conf

	#sudo ln -s /etc/sv/void-updater /var/service/

	sudo rm -f /var/service/agetty-tty{3,4,5,6}
	sudo ln -s /etc/sv/ntpd /var/service/
	sudo ln -s /etc/sv/dbus /var/service/
	sudo ln -s /etc/sv/elogind /var/service/
	sudo ln -s /etc/sv/polkitd /var/service/
	sudo ln -s /etc/sv/ufw /var/service/
	#sudo ln -s /etc/sv/cupsd /var/service/
	#sudo ln -s /etc/sv/uuidd /var/service/
	#sudo ln -s /etc/sv/alsa /var/service/
	#sudo ln -s /etc/sv/libvirtd /var/service/
	#sudo ln -s /etc/sv/virtlogd /var/service/
	#sudo ln -s /etc/sv/virtlockd /var/service/
	#sudo ln -s /etc/sv/socklog-unix /var/service/
	#sudo ln -s /etc/sv/nanoklogd /var/service/
	sudo ln -s /etc/sv/dnscrypt-proxy /var/service/

	sudo resolvconf -u

	sudo ufw default deny
	#sudo ufw allow from 192.168.0.0/24
	sudo ufw logging off
	sudo ufw enable

	#sudo ln -sf /usr/share/zoneinfo/Europe/London /etc/localtime
	#sudo hwclock --systohc

	sudo mkdir /etc/sysctl.d/
	echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swappiness.conf

	sudo ln -s /usr/share/fontconfig/conf.avail/10-hinting-slight.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/10-sub-pixel-rgb.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/11-lcdfilter-default.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/50-user.conf /etc/fonts/conf.d/
	sudo ln -s /usr/share/fontconfig/conf.avail/70-no-bitmaps.conf /etc/fonts/conf.d/

  sudo chsh -s /usr/bin/fish $USER

clear
echo "Adding user to some groups..."
sleep 3s
	sudo usermod -aG input $USER
	sudo usermod -aG audio $USER
	sudo usermod -aG video $USER
	#sudo usermod -aG libvirt $USER
	#sudo usermod -aG kvm $USER
	#sudo usermod -aG socklog $USER

clear
echo "Importing dotfiles from server..."
sleep 3s
 	cd /tmp/
	wget https://gejr.dk/static/dotfiles.tar.xz
	tar Jxvf dotfiles.tar.xz
	chmod +x dotfiles/bin/*
  sudo chown -R $USER dotfiles/
	
	sudo \cp -r dotfiles/bin/. /bin/
  rm -rf dotfiles/bin
  
	\cp -r dotfiles/home/. ~/
  rm -rf dotfiles/home

  \cp -r dotfiles/* ~/.config
	rm -rf dotfiles/
	mv dotfiles.tar.xz ~/.void-backup/

clear
printf "If LightDM was installed, run \"sudo ln -s /etc/sv/lightdm /var/service/\" after reboot.\n"
read -p "Done! Press ENTER to reboot."
	sudo shutdown -r now
