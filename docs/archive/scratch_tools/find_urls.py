import json, re

path = r'C:\Users\Faiz\.gemini\antigravity\brain\524a13a4-50f5-47a6-aeaa-1aebf04e3b62\.system_generated\steps\1422\output.txt'
with open(path, 'r', encoding='utf-8') as f:
    html = json.loads(f.read()).get('html', '')

urls = re.findall(r'https://[^\s"\'<>]+', html)
for u in set(urls):
    if any(ext in u.lower() for ext in ['googleusercontent', '.png', '.jpg', '.jpeg']):
        print(u)
