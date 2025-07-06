#!/bin/bash
cd /home/$(whoami)/BOTLB

# Aktifkan X11
./fix-x11.sh

# Masuk venv & jalanin bot
source venv/bin/activate
python botlb.py
