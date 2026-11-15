import urllib.request
from PIL import Image

url = "https://lh3.googleusercontent.com/aida/ALJJyrCAc3XBcHWjavzdwtAsdwnNMI5rgDv_Wz7e6BFrRpI2iYinfYn67nt_sgwWZJVmsX_ei_x4RsOdBxXB-_01TTUadGW5VECBBYNzUOa0eDUdX86w7moWi6PS9BAVe-qiJQSirx5oT_5E6Jf2BmxsZjoISPN7bJzYqLQucW25YetsDyQQ8AKDn11XPuhmlqc5LvX4lzoXOBpXGFR1N6hVgGKrWVLjomQVMvBhqu5Ln00844qM20IvjU5Srw"

req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
with urllib.request.urlopen(req, timeout=10) as resp, open('scratch/showcase_hero.png', 'wb') as f:
    f.write(resp.read())

im = Image.open('scratch/showcase_hero.png')
print("showcase_hero size:", im.size)
