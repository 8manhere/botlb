#!/bin/bash
set -e

# cek update jika ada
sudo apt update

# Cek dan install firefox-esr jika belum ada
if ! command -v firefox-esr &> /dev/null; then
    echo "[*] firefox-esr belum terpasang, memasang..."
    sudo apt install -y firefox-esr
else
    echo "[✓] firefox-esr sudah terpasang, skip instalasi"
fi

echo "[*] Install Python & tools"
sudo apt install -y python3
sudo apt install -y python3-venv
sudo apt install -y python3-pip
sudo apt install -y curl
sudo apt install -y wmctrl
sudo apt install -y xdotool
sudo apt install -y scrot
sudo apt install -y python3-tk
sudo apt install -y python3-dev

TARGET_DIR="/home/$(whoami)/BOTLB"
mkdir -p "$TARGET_DIR"
cd "$TARGET_DIR"

echo "[*] Buat virtualenv"
python3 -m venv venv
source venv/bin/activate

echo "[*] Download file dari GitHub"
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/requirements.txt
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/botlb.py
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/botlb.sh
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/fix-x11.sh
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/botlb.desktop

echo "set lokasi install"
INSTALL_PATH="/home/$(whoami)/BOTLB"

# Replace placeholder path di botlb.sh dan botlb.desktop
sed -i "s|__INSTALL_PATH__|$INSTALL_PATH|g" botlb.sh
sed -i "s|__INSTALL_PATH__|$INSTALL_PATH|g" botlb.desktop

echo "[*] Install library Python"
pip install --upgrade pip
pip install -r requirements.txt
python -m playwright install

chmod +x botlb.sh fix-x11.sh botlb.desktop
cp botlb.desktop ~/Desktop/
chmod +x ~/Desktop/botlb.desktop

echo "[✓] BOTLB siap dijalankan dari Desktop!"

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
