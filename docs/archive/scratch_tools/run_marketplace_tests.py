import subprocess, time, shutil

def tap(x, y, wait=1.0):
    subprocess.run(['adb', 'shell', 'input', 'tap', str(x), str(y)], check=True)
    time.sleep(wait)

def type_text(text, wait=1.0):
    # Escape spaces for adb shell input text
    escaped = text.replace(' ', '%s')
    subprocess.run(['adb', 'shell', 'input', 'text', escaped], check=True)
    time.sleep(wait)

def keyevent(code, wait=1.0):
    subprocess.run(['adb', 'shell', 'input', 'keyevent', str(code)], check=True)
    time.sleep(wait)

def screencap(filename):
    with open('scratch/' + filename, 'wb') as f:
        subprocess.run(['adb', 'exec-out', 'screencap', '-p'], stdout=f, check=True)
    shutil.copy2('scratch/' + filename, 'docs/assets/' + filename)
    shutil.copy2('scratch/' + filename, r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62/' + filename)
    print(f"Captured {filename}")

# Test 1: Category filter -> tap Exhaust
# Looking at screenshot:
# Engine: x ~ 125, Exhaust: x ~ 290, Wheels: x ~ 460, Suspension: x ~ 630, Brakes: x ~ 800, Exterior: x ~ 970
# Y coordinate: the category boxes are centered around y = 240 dp (~600 px in 2424 height).
# Let's tap Exhaust around x = 290, y = 600
print("Testing Category filter: Exhaust...")
tap(290, 600, 1.5)
screencap('emulator_marketplace_category_exhaust.png')

# Reset category by tapping Exhaust again
tap(290, 600, 1.0)

# Test 2: Search -> tap search bar (x = 540, y = 390)
print("Testing Search for 'BBS'...")
tap(540, 390, 1.0)
type_text('BBS', 1.0)
# Hide keyboard
keyevent(4, 1.0)
screencap('emulator_marketplace_search.png')

# Test 3: Open Product Detail -> tap the BBS product card (x = 540, y = 750)
print("Opening Product Detail for BBS...")
tap(540, 750, 1.5)
screencap('emulator_product_detail.png')

# Test 4: Toggle Save in Product Detail -> top right bookmark icon (x = 990, y = 140)
print("Toggling Save on Product Detail...")
tap(990, 140, 1.0)

# Test 5: Tap Chat Seller CTA (x = 600, y = 2280)
print("Tapping Chat Seller CTA...")
tap(600, 2280, 1.5)
screencap('emulator_marketplace_chat_seller.png')

# Back to Marketplace Home
keyevent(4, 1.0)

# Clear search: tap 'x' on search bar (x = 970, y = 390)
tap(970, 390, 1.0)

# Test 6: Open Create Listing Screen -> tap '+' in header (x = 990, y = 240)
print("Opening Create Listing...")
tap(990, 240, 1.5)
screencap('emulator_marketplace_create_form.png')

# Fill in listing form:
# Tap Product Name (x = 400, y = 1000)
tap(400, 1000, 0.5)
type_text('Titanium%sTurbo%sDownpipe', 0.5)

# Tap Brand (x = 400, y = 1180)
tap(400, 1180, 0.5)
type_text('HKS', 0.5)

# Tap Price (x = 400, y = 1360)
tap(400, 1360, 0.5)
type_text('14500000', 0.5)

# Hide keyboard to scroll down
keyevent(4, 0.5)

# Scroll down
subprocess.run(['adb', 'shell', 'input', 'swipe', '540', '1600', '540', '700', '300'], check=True)
time.sleep(1.0)

# Tap Description
tap(400, 1050, 0.5)
type_text('High-flow%sdownpipe%swith%scell%scat', 0.5)
keyevent(4, 0.5)

# Tap Compatible Vehicles
tap(400, 1350, 0.5)
type_text('Mazda%sRX-7%sFD3S', 0.5)
keyevent(4, 0.5)

# Tap Publish Listing CTA (x = 540, y = 2320)
print("Publishing Listing...")
tap(540, 2320, 2.0)
screencap('emulator_marketplace_new_listing.png')

print("All automated tests completed!")
