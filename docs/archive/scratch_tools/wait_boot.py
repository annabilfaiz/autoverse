import subprocess, time

print("Waiting for emulator to boot...")
for i in range(120):
    try:
        res = subprocess.run(["adb", "shell", "getprop", "sys.boot_completed"], capture_output=True, text=True, timeout=5)
        out = res.stdout.strip()
        if out == "1":
            print(f"Emulator booted successfully in ~{i*2} seconds!")
            break
    except Exception:
        pass
    time.sleep(2)
else:
    print("Emulator boot timeout!")
