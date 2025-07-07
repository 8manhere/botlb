#!/bin/bash

echo "[*] Download & install WhiteSur-Dark GTK Theme..."
git clone https://github.com/vinceliuice/WhiteSur-gtk-theme.git --depth=1
cd WhiteSur-gtk-theme
./install.sh -t default -c dark
cd ..
rm -rf WhiteSur-gtk-theme

echo "[*] Download & install WhiteSur Icon Pack..."
git clone https://github.com/vinceliuice/WhiteSur-icon-theme.git --depth=1
cd WhiteSur-icon-theme
./install.sh
cd ..
rm -rf WhiteSur-icon-theme

echo "[*] Terapkan theme & icon di XFCE..."
xfconf-query -c xsettings -p /Net/ThemeName -s "WhiteSur-Dark"
xfconf-query -c xsettings -p /Net/IconThemeName -s "WhiteSur"

echo "[*] Download dan set wallpaper..."
mkdir -p ~/Pictures
wget -q -O ~/Pictures/wallpaper.jpg https://raw.githubusercontent.com/8manhere/botlb/main/macOS-Catalina-Dark-Mode.jpg

# Terapkan wallpaper ke semua monitor di XFCE
for i in $(xfconf-query -c xfce4-desktop -l | grep image-path); do
    xfconf-query -c xfce4-desktop -p "$i" -s "$HOME/Pictures/wallpaper.jpg"
done
