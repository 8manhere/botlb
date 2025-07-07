#!/bin/bash

echo "[*] Download dan set wallpaper..."
INSTALL_PATH="/home/$(whoami)/BOTLB"
wget -q -O "$INSTALL_PATH/wallpaper.jpg" https://raw.githubusercontent.com/8manhere/botlb/main/macOS-Catalina-Dark-Mode.jpg
echo "[✓] Wallpaper berhasil diunduh ke $INSTALL_PATH"

# Terapkan wallpaper ke semua workspace & monitor (XFCE pakai last-image)
for i in $(xfconf-query -c xfce4-desktop -l | grep last-image); do
    xfconf-query -c xfce4-desktop -p "$i" -s "$INSTALL_PATH/wallpaper.jpg"
done
xfdesktop --reload
echo "[✓] Wallpaper berhasil diterapkan ke desktop"
