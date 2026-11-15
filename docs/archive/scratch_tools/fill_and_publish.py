import subprocess, time, shutil

def tap(x, y, wait=1.0):
    subprocess.run(['adb', 'shell', 'input', 'tap', str(x), str(y)], check=True)
    time.sleep(wait)

def type_text(text, wait=0.8):
    escaped = text.replace(' ', '%s')
    subprocess.run(['adb', 'shell', 'input', 'text', escaped], check=True)
    time.sleep(wait)

def keyevent(code, wait=0.5):
    subprocess.run(['adb', 'shell', 'input', 'keyevent', str(code)], check=True)
    time.sleep(wait)

def screencap(filename):
    with open('scratch/' + filename, 'wb') as f:
        subprocess.run(['adb', 'exec-out', 'screencap', '-p'], stdout=f, check=True)
    shutil.copy2('scratch/' + filename, 'docs/assets/' + filename)
    shutil.copy2('scratch/' + filename, r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62/' + filename)
    print(f"Captured {filename}")

# We are currently on the List a Part form screen!
# 1. Fill Brand (x = 300, y = 390)
tap(300, 390, 0.5)
type_text('HKS', 0.5)

# 2. Fill Price (x = 300, y = 510)
tap(300, 510, 0.5)
type_text('14500000', 0.5)

# 3. Fill Description (x = 300, y = 650)
tap(300, 650, 0.5)
type_text('Track-spec%stitanium%sdownpipe', 0.5)

# 4. Fill Compatible Vehicles (x = 300, y = 810)
tap(300, 810, 0.5)
type_text('Mazda%sRX-7%sFD3S', 0.5)

# Hide keyboard
keyevent(4, 0.5)

# 5. Tap Publish Listing (x = 540, y = 2320)
print("Tapping Publish Listing...")
tap(540, 2320, 2.0)

# We should be back on Marketplace Home!
screencap('emulator_marketplace_new_listing.png')

# 6. Now tap the newly published product card at top of list (x = 540, y = 1050)
print("Opening Product Detail for the new listing...")
tap(540, 1050, 1.5)
screencap('emulator_product_detail.png')

# 7. Tap Save bookmark on detail screen (x = 990, y = 140)
print("Toggling Save on Product Detail...")
tap(990, 140, 0.8)

# 8. Tap Chat Seller (x = 600, y = 2280)
print("Tapping Chat Seller CTA...")
tap(600, 2280, 1.0)
screencap('emulator_marketplace_chat_seller.png')

print("Script completed!")
