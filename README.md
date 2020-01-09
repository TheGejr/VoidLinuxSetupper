# VoidLinuxSetupper
## Automate the process of setting up Void Linux

---

__NOTICE__: THIS SCRIPT IS DESIGNED AND WILL MOST LIKELY ONLY WORK FOR XFCE VARIANT

### Usage
Ready the system and install required packages
```bash
$ sudo xbps-install -Syu
$ sudo xbps-install -S wget
```

Download the installation script
```bash
$ wget https://github.com/TheGejr/VoidLinuxSetupper/blob/master/void-installer.sh
OR
$ wget https://gejr.dk/static/void-installer.sh
```

Ready the installation script and run it.
```bash
$ sudo +x void-installer.sh
$ ./void-installer.sh
```
This will take some time.

---

This repo was made possible by Alex from alkusin.net
This repo use much of his work, but with an english translation and some improvements to some scripts and settings.
Check his site out for the original work https://alkusin.net/voidlinux/
