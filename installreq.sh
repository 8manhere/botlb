#!/bin/bash
set -e

echo "[*] Buat virtualenv"
python3 -m venv venv
source venv/bin/activate

echo "[*] Download file dari GitHub"
curl -O https://raw.githubusercontent.com/8manhere/botlb/main/requirements.txt
echo "set lokasi install"
INSTALL_PATH="/home/$(whoami)/BOTLB"

echo "[*] Install library Python"
pip install --upgrade pip
pip install -r requirements.txt
python -m playwright install

echo "[✓] BOTLB siap dijalankan dari Desktop!"
