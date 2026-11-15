from PIL import Image, ImageFilter

def create_feed_canvas(src_path, dest_path, target_w=780, target_h=1768):
    src = Image.open(src_path).convert('RGB')
    src_w, src_h = src.size

    # Target canvas
    canvas = Image.new('RGB', (target_w, target_h), (10, 13, 16)) # #0A0D10 Void Black

    # Scale to cover width or center nicely
    # If source is wider or taller, scale so that car is prominent in center/lower-mid
    scale = max(target_w / src_w, target_h / src_h)
    new_w = int(src_w * scale)
    new_h = int(src_h * scale)
    resized = src.resize((new_w, new_h), Image.Resampling.LANCZOS)

    # Crop to target_w, target_h centered
    left = (new_w - target_w) // 2
    top = (new_h - target_h) // 2
    cropped = resized.crop((left, top, left + target_w, top + target_h))

    cropped.save(dest_path, format='PNG', quality=95)
    print(f"Created {dest_path}: {target_w}x{target_h}")

# 1. Post 1: Agate Grey Porsche at coastal dusk (pure portrait photo)
create_feed_canvas('scratch/pure_car_portrait.jpg', 'assets/images/feed_porsche_dusk.png')

# 2. Post 2: GT3 Wide at dusk
create_feed_canvas('scratch/pure_gt3_wide.jpg', 'assets/images/feed_rx7_track.png')

# 3. Post 3: Modern sports car pavilion
create_feed_canvas('scratch/pure_car_pavilion.jpg', 'assets/images/feed_porsche_gt3.png')
