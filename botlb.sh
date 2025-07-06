#!/bin/bash

# lokasi file
cd __INSTALL_PATH__

# Aktifkan X11
./fix-x11.sh

# Masuk venv & jalanin bot
source venv/bin/activate
python botlb.py
