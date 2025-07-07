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
