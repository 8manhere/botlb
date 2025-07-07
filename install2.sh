#!/bin/bash

echo "[*] Download dan set wallpaper..."
INSTALL_PATH="/home/$(whoami)/BOTLB"
mkdir -p "$INSTALL_PATH"
wget -q -O "$INSTALL_PATH/wallpaper.jpg" https://raw.githubusercontent.com/8manhere/botlb/main/macOS-Catalina-Dark-Mode.jpg

# Cek apakah file berhasil diunduh
if [[ -f "$INSTALL_PATH/wallpaper.jpg" ]]; then
    echo "[✓] Wallpaper berhasil diunduh ke $INSTALL_PATH"
    
    # Terapkan wallpaper ke semua monitor/workspace
    for i in $(xfconf-query -c xfce4-desktop -l | grep last-image); do
        xfconf-query -c xfce4-desktop -p "$i" -s "$INSTALL_PATH/wallpaper.jpg"
    done
    xfdesktop --reload
    echo "[✓] Wallpaper berhasil diterapkan ke desktop"
else
    echo "[✗] Wallpaper gagal diunduh! Cek koneksi atau link."
fi
