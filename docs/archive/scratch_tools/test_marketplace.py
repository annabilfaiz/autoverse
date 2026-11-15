import subprocess, time, shutil

def tap(x, y, wait=1.0):
    subprocess.run(['adb', 'shell', 'input', 'tap', str(x), str(y)], check=True)
    time.sleep(wait)

def screencap(filename):
    with open('scratch/' + filename, 'wb') as f:
        subprocess.run(['adb', 'exec-out', 'screencap', '-p'], stdout=f, check=True)
    shutil.copy2('scratch/' + filename, 'docs/assets/' + filename)
    shutil.copy2('scratch/' + filename, r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62/' + filename)
    print(f"Captured {filename}")

# 1. Tap Marketplace tab (x = 324, y = 2320)
print("Switching to Marketplace tab...")
tap(324, 2320, 1.5)
screencap('emulator_marketplace_home.png')

