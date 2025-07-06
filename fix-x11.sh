#!/bin/bash

# Coba cek DISPLAY, default ke :0
DISPLAY_VAL=${DISPLAY:-:0}
export DISPLAY=$DISPLAY_VAL

echo "[*] Menggunakan DISPLAY=$DISPLAY_VAL"

# Pastikan .Xauthority ada
touch ~/.Xauthority

# Generate akses trusted (abaikan error kalau udah ada)
xauth generate "$DISPLAY_VAL" . trusted || true

# Cek isi Xauthority (debugging aja)
echo "[*] Isi xauth list:"
xauth list
