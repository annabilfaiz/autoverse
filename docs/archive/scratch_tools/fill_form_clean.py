import subprocess, time, shutil

def tap(x, y, wait=0.8):
    subprocess.run(['adb', 'shell', 'input', 'tap', str(x), str(y)], check=True)
    time.sleep(wait)

def type_text(text, wait=0.8):
    escaped = text.replace(' ', '%s')
    subprocess.run(['adb', 'shell', 'input', 'text', escaped], check=True)
    time.sleep(wait)

def keyevent(code, wait=0.4):
    subprocess.run(['adb', 'shell', 'input', 'keyevent', str(code)], check=True)
    time.sleep(wait)

def screencap(filename):
    with open('scratch/' + filename, 'wb') as f:
        subprocess.run(['adb', 'exec-out', 'screencap', '-p'], stdout=f, check=True)
    shutil.copy2('scratch/' + filename, 'docs/assets/' + filename)
    shutil.copy2('scratch/' + filename, r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62/' + filename)
    print(f"Captured {filename}")

# 1. Close current form
print("Closing dirty form...")
tap(150, 180, 1.0)

# 2. Re-open List a Part
print("Re-opening List a Part...")
tap(1010, 240, 1.5)
screencap('emulator_marketplace_create_form.png')

# 3. Product Name (x = 300, y = 720)
print("Entering Product Name...")
tap(300, 720, 0.5)
type_text('Titanium%sTurbo%sDownpipe', 0.5)
keyevent(4, 0.5) # hide keyboard

# 4. Brand (x = 300, y = 960)
print("Entering Brand...")
tap(300, 960, 0.5)
type_text('HKS', 0.5)
keyevent(4, 0.5)

# 5. Price (x = 300, y = 1220)
print("Entering Price...")
tap(300, 1220, 0.5)
type_text('14500000', 0.5)
keyevent(4, 0.5)

# 6. Description (x = 300, y = 1580)
print("Entering Description...")
tap(300, 1580, 0.5)
type_text('Track-spec%stitanium%sdownpipe', 0.5)
keyevent(4, 0.5)

# 7. Compatible Vehicles (x = 300, y = 1990)
print("Entering Compatible Vehicles...")
tap(300, 1990, 0.5)
type_text('Mazda%sRX-7%sFD3S', 0.5)
keyevent(4, 0.5)

# 8. Tap Publish Listing (x = 540, y = 2320)
print("Publishing Listing...")
tap(540, 2320, 2.5)

# We should now be back on Marketplace Home with the new listing!
screencap('emulator_marketplace_new_listing.png')

# 9. Tap the new listing card at top (x = 540, y = 1000)
print("Opening Product Detail for new listing...")
tap(540, 1000, 1.5)
screencap('emulator_product_detail.png')

# 10. Tap Chat Seller CTA (x = 600, y = 2280)
print("Tapping Chat Seller...")
tap(600, 2280, 1.0)
screencap('emulator_marketplace_chat_seller.png')

print("All done!")
