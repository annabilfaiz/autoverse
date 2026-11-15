import json, base64
from PIL import Image

with open(r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62\.system_generated\steps\1448\output.txt', 'r', encoding='utf-8') as f:
    data = json.loads(f.read())

raw = data.get('image', '')
if isinstance(raw, dict):
    raw = raw.get('dataString', '')

if raw:
    img_bytes = base64.b64decode(raw)
    with open('scratch/pure_car_portrait.jpg', 'wb') as out:
        out.write(img_bytes)
    im = Image.open('scratch/pure_car_portrait.jpg')
    print("Saved scratch/pure_car_portrait.jpg, size:", im.size, "format:", im.format)
else:
    print("No image data found!")
