#!/bin/bash
set -e

# Lokasi instalasi
INSTALL_PATH="/home/$(whoami)/BOTLB"

echo "[*] Pindah ke folder BOTLB"
cd "$INSTALL_PATH"

echo "[*] Buat virtualenv di $INSTALL_PATH/venv"
python3 -m venv venv
source venv/bin/activate

echo "[*] Download requirements.txt dari GitHub"
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/requirements.txt

echo "[*] Upgrade pip dan install dependensi"
pip install --upgrade pip
pip install -r requirements.txt

echo "[*] Install Playwright (browser automation)"
python -m playwright install

echo "[✓] BOTLB siap dijalankan dari Desktop!"
