#!/bin/bash
set -e

echo "[*] Install Python & tools"
sudo apt update && sudo apt install -y \
  python3 python3-venv python3-pip curl \
  wmctrl xdotool scrot python3-tk python3-dev

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

echo "[*] Install library Python"
pip install --upgrade pip
pip install -r requirements.txt
python -m playwright install

chmod +x botlb.sh fix-x11.sh botlb.desktop
cp botlb.desktop ~/Desktop/
chmod +x ~/Desktop/botlb.desktop

echo "[✓] BOTLB siap dijalankan dari Desktop!"
