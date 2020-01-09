#!/bin/bash

echo "Cleaning older versions..."

  sudo xbps-remove -Ry plata-theme
  sudo rm -rf /usr/share/themes/{Plata,Plata-Compact,Plata-Lumine,Plata-Lumine-Compact,Plata-Noir,Plata-Noir-Compact}

echo "Installing requirements..."

  sudo xbps-install -Sy autoconf automake ImageMagick inkscape optipng gdk-pixbuf-devel glib-devel libxml2 sassc parallel pkg-config wget xz

echo "Downloading upstream..."

  cd /tmp
  wget -O - https://gitlab.com/tista500/plata-theme/-/archive/master/plata-theme-master.tar.gz | tar xz
  cd plata-theme-master

echo "Customizing upstream..."

  for thirdrc in src/gtk/gtk-2.0/3rd-party*; do
  cat << "EOF" >> "$thirdrc"

### Xfce panel tasklist

style "xfce-tasklist-style"
{
  XfceTasklist::max-button-length = 300
  XfceTasklist::ellipsize-mode = PANGO_ELLIPSIZE_END
  XfceTasklist::minimized-icon-lucency = 50
}
class "XfceTasklist" style "xfce-tasklist-style"
EOF
  done

  #sed -i "s/Roboto/Ubuntu, Roboto/g" src/shell/sass/cinnamon/_common.scss
  #sed -i "s/Roboto/Ubuntu, Roboto/g" src/shell/sass/gnome-shell/_common.scss
  #sed -i 's/symbolic/regular/g' src/shell/sass/gnome-shell/_common.scss
  ./autogen.sh --prefix=/usr --enable-parallel --enable-plank --disable-gnome --disable-cinnamon --disable-mate --disable-flashback --with-selection_color=#FFEB3B --with-accent_color=#FFF176 --with-suggestion_color=#FFFF00 --with-destruction_color=#FFEB3B

echo "Generating themes..."

  make

echo "Installing themes..."

  sudo make install

  sudo cp /usr/share/themes/Plata-Noir/gtksourceview/plata-dark.xml /usr/share/gtksourceview-3.0/styles/
  sudo cp /usr/share/themes/Plata-Lumine/gtksourceview/plata-light.xml /usr/share/gtksourceview-3.0/styles/

    ### horizontal mirror to maximize-toggled buttons for leftside use (xfwm & openbox)
  sudo mogrify -flop /usr/share/themes/{Plata,Plata-Compact,Plata-Lumine,Plata-Lumine-Compact,Plata-Noir,Plata-Noir-Compact}/xfwm4/maximize-toggled-active.png
  sudo mogrify -flop /usr/share/themes/{Plata,Plata-Compact,Plata-Lumine,Plata-Lumine-Compact,Plata-Noir,Plata-Noir-Compact}/xfwm4/maximize-toggled-inactive.png
  sudo mogrify -flop /usr/share/themes/{Plata,Plata-Compact,Plata-Lumine,Plata-Lumine-Compact,Plata-Noir,Plata-Noir-Compact}/xfwm4/maximize-toggled-prelight.png
  sudo mogrify -flop /usr/share/themes/{Plata,Plata-Compact,Plata-Lumine,Plata-Lumine-Compact,Plata-Noir,Plata-Noir-Compact}/xfwm4/maximize-toggled-pressed.png
  sudo wget -qO /usr/share/themes/Plata/openbox-3/max_toggled.xbm https://alkusin.net/voidlinux/extras/themes/openbox/leftside_max_toggled.xbm
  sudo wget -qO /usr/share/themes/Plata-Lumine/openbox-3/max_toggled.xbm https://alkusin.net/voidlinux/extras/themes/openbox/leftside_max_toggled.xbm
  sudo wget -qO /usr/share/themes/Plata-Noir/openbox-3/max_toggled.xbm https://alkusin.net/voidlinux/extras/themes/openbox/leftside_max_toggled.xbm

echo "Cleaning downloaded files..."

  cd ..
  rm -rf plata-theme-master

clear
echo "Plata-Custom-Classic: done!"
