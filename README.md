VoidLinuxSetupper
=================

Automate the process of setting up Void Linux.

__NOTICE__: THIS SCRIPT IS DESIGNED FOR THE MINIMAL ISO `void-live-x86_64-XXXXXXXX.iso` BUT IT WILL WORK FOR ANY OTHER VERSION.


Table of contents
=================

<!--ts-->
  * [VoidLinuxSetupper](#voidlinuxsetupper)
  * [Table of contents](#table-of-contents)
  * [Usage](#usage)
    * [Step 1](#step-1-install-voidlinux)
    * [Step 2](#step-2-install-required-packages)
    * [Step 3](#step-3-download-the-installation-script)
    * [Step 4](#step-4-ready-the-installation-script-and-run-it)
  * [What is it doing](#what-is-it-doing)
  * [Packages](#packages)
  * [Miscellaneous information](#miscellaneous-information)
    * [Firewall](#firewall)
<!--te-->


Usage
=====

#### STEP 1: Install VoidLinux
Download the correct ISO file from `voidlinux.org`, the ISO file this script was intended to work for should look like this `void-live-x86_64-YYYYMMDD.iso`, but if you download one that comes with a DE that should also work.

**NOTICE** The script *does not* work on MUSL versions. Glibc is required. 

After you have completed the installation of Void, continue to Step 2.


#### STEP 2: Install required packages
```sh
$ sudo xbps-install -Syu
$ sudo xbps-install -S wget
```


#### STEP 3: Download the installation script
The installation script acquired by cloning the repo, but it's much easier to wget the file from github or (for easier typing) my website.
```sh
$ wget https://raw.githubusercontent.com/TheGejr/VoidLinuxSetupper/master/void-installer.sh
OR
$ wget https://gejr.dk/static/void-installer.sh
```


#### STEP 3.2 (OPTIONAL): Edit to your preference 
The packages the script installs is neatly split up into different sections, therefore it is easy to read and edit.

The script does not install a Display Manager, so you will login in a `TTY`, however `LightDM` packages is ready it just need to be uncommented.

The script installs many of the packages I use therefore it can be a good idea to either look at [this section](#packages) to see the packages it installs or read/edit the code of the script.

A place that is good to edit is the graphics section. By default the script installs Intel graphics drivers, however there is commented code that installs AMD or Nvidia; all you have to do is uncomment and comment the unwanted packages.
There is also a section for Virtualization, by default it installs drivers as if you are running void on a host *not* in a VM.


#### STEP 4: Ready the installation script and run it.
The script is now ready, give the script the proper rights and execute it.
```sh
$ sudo +x void-installer.sh
$ ./void-installer.sh
```

This will take some time, so go make a cup of coffee and come back in a bit.

---

What is it doing
================
> ### So what is actually happening in this script.

Let me try to explain.

The first thing that happens is it makes sure you are running the script with sudo rights. It then updates the system, and installs the repos `multilib`, `multilib-nonfree`, `nonfree`. It then installs many packages, some is required and some is just my personal preference to install.
After all packages have been installed. It proceeds to download a tarball called `void-files.tar.xz` from my website, the content of the tarball can be seen in this repo in the folder `Archive/void-files`. This is downloaded and extracted. Some permission is set, and then the content is moved to the correct folders which is `~/`, `~/.config/`, `/etc/` and `/usr/`. As the last thing in this section, the script cleans up and fixes some permission issues.
The script now executes two other scripts. These script is what take the most time of the whole process. The scripts installs `Plata themes` and `Papirus icons` and customizes it by replacing the default colors with Void colors.

The script now removes `tty{3,4,5,6}` as services, and adds a whole bunch of other services. It also sets up a firewall with some basic rules (see [firewall rules](#firewall)). The script also sets the default shell to be `fish` because I like fish.
The last thing that the script does is install my own dotfiles. It downloads them from my own website and copies them to the correct places.

---

Packages
========
Here is a list of all the packages the script by default will install. This can of course be modified by editing the script as explained in [STEP 3.2](#step-3-download-the-installation-script).
```
void-repo-multilib
void-repo-multilib-nonfree
void-repo-nonfree
xfce4
xfce-polkit
xfce4-battery-plugin
xfce4-clipman-plugin
xfce4-genmon-plugin
xfce4-notes-plugin
xfce4-pulseaudio-plugin
xfce4-weather-plugin
xfce4-whiskermenu-plugin
xfce4-screenshooter
xfce4-settings
xinit
xorg
xtools
xdg-utils
xdotool
adwaita-icon-theme
alsa-plugins
alsa-plugins-32bit
alsa-plugins-ffmpeg
alsa-plugins-pulseaudio
alsa-utils
conky
cpupower
dbus-elogind
elogind
exo
ffmpeg
garcon
gmic-gimp
gnome-themes-extra
greybird-themes
gst-libav
gst-plugins-bad1
gst-plugins-base1
gst-plugins-good1
gst-plugins-ugly1
gtk-update-icon-cache
gtk3-nocsd
gvfs
gvfs-mtp
lame
libGL-32bit
libavcodec
libavcodec-32bit
libavformat-32bit
libavresample-32bit
libavutil-32bit
libpulseaudio-32bit
libtxc_dxtn-32bit
menulibre
mugshot
ntfs-3g
ntp
numlockx
optipng
parole
pavucontrol
physlock
procps-ng
pulseaudio
rkhunter
scrot
simple-scan
snooze
tty-clock
udisks2
ufw
unrar
unzip
upower
wmctrl
x264
xarchiver
xcalib
xcursor-vanilla-dmz
xcursor-vanilla-dmz-aa
xdg-user-dirs-gtk
xf86-input-wacom
xz
zenity
font-hack-ttf
fontconfig
fontconfig-32bit
freetype
google-fonts-ttf
noto-fonts-cjk
noto-fonts-emoji
noto-fonts-ttf
fish-shell
audacity
zip
whois
torsocks
spigot
bash-completion
cpufrequtils
gzip
hardinfo
epdfview
filezilla
firefox
galculator-gtk3
gimp
git
pidgin
htop
hunspell
libreoffice-calc
libreoffice-writer
libreoffice-gnome
libreoffice
nano
vim
neovim
neofetch
pfetch
thunar-archive-plugin
thunar-volman
thunderbird
transmission-gtk
vkd3d
vkd3d-32bit
vulkan-loader
vulkan-loader-32bit
linux-firmware-intel
xf86-video-intel
mesa-intel-dri
mesa-intel-dri-32bit
mesa-vulkan-intel
mesa-vulkan-intel-32bit
linux-headers
linux-lts-headers
linux-tools
gcc
ctags
make
cmake
rsync
git
lynx
virtualbox-ose
virtualbox-ose-dkms
openjdk-jre
dnscrypt-proxy
```

Here is a list of all the packages that will not be installed by default, but is commented out so it easily can be installed.
```
linux-firmware-amd
xf86-video-amdgpu
mesa-ati-dri
mesa-ati-dri-32bit
mesa-vulkan-radeon
mesa-vulkan-radeon-32bit
linux-firmware-nvidia
xf86-video-nouveau
mesa-nouveau-dri
mesa-nouveau-dri-32bit
openbox
obconf
obmenu
nitrogen
tint2
gsimplecal
volumeicon
compton
light-locker
lightdm
lightdm-gtk-greeter-settings
lightdm-gtk3-greeter
xfce4-screensaver
xfce4-panel-appmenu
appmenu-gtk-module
appmenu-gtk3-module
plank
pm-utils
cups
cups-filters
cups-pk-helper
gutenprint
system-config-printer
octoxbps
xiccd
dhcpcd-gtk
wpa_gui
gufw
gsmartcontrol
catfish
vokoscreen
pitivi
gstreamer-vaapi
sc-controller
virtualbox-ose-guest
virtualbox-ose-guest-dkms
socklog-void
dconf-editor
android-file-transfer-linux
amdvlk
amdvlk-32bit
```

---

Miscellaneous information
=========================
Here is some extra information located that didn't really fit anywhere.

Firewall
--------
The script sets up a firewall using `UFW`, the rules it sets is:
```sh
sudo ufw default deny
#sudo ufw allow from 192.168.0.0/24
sudo ufw logging off
sudo ufw enable
```


Thanks
======
This repo was made possible by Alex from alkusin.net
This repo use much of his work, but with an English translation and some improvements to some scripts and settings.
Check his site out for the original work https://alkusin.net/voidlinux/
