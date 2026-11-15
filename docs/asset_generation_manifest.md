# AUTOVERSE — GEMINI ASSET GENERATION MANIFEST
**Document Version:** 1.0.0  
**Phase:** Post-MVP Architecture Refinement & Asset Planning  
**Target Visual Theme:** Dark Premium Automotive Aesthetic  
**Execution Rule:** This document defines the asset blueprint only. Image generation is deferred to a subsequent asset generation cycle.

---

## 1. Executive Overview & Visual Direction

AutoVerse delivers an enthusiast-grade automotive social and marketplace mobile application. To replace temporary placeholders with authentic, photorealistic, and consistent visuals, this manifest specifies each visual asset required across all modules.

### Design System Compliance
- **Background Context:** Moody, high-contrast dark environments (#0A0D10 Void Black, #11171D Carbon).
- **Accent Harmonies:** Highlighting via Performance Lime (#C7F36B) accents, warm dusk flares, or circuit sodium vapors.
- **Lighting Philosophy:** Directional rim lighting, moody automotive studio lighting, asphalt reflections, and wet track sheen. No plastic or toy-like rendering.
- **Camera Optics:** Simulated 35mm / 50mm / 85mm prime lenses (Sony A7R V / Hasselblad X2D 100C look), shallow depth of field (\(f/1.4 - f/2.8\)), cinematic dynamic range.

---

## 2. Global Asset Catalog & Prompts

### Category A: Home / FYP Full-Bleed Video & Reel Frames
*Orientation: Portrait (9:16) | Resolution: 1080 × 1920 px | File Format: PNG*

| Asset ID | Target File Name | Subject Vehicle | Environment & Atmosphere | Camera Angle & Composition |
|---|---|---|---|---|
| `FYP-001` | `feed_porsche_gt3_dusk.png` | Porsche 911 GT3 (992), Shark Blue | Winding coastal mountain pass at blue hour dusk; soft twilight mist, taillights illuminated | Low tracking shot behind left quarter, asphalt texture in foreground |
| `FYP-002` | `feed_rx7_track_night.png` | Mazda RX-7 FD3S, Competition Yellow | Sentul International Circuit pit straight under floodlights; glowing brake discs, exhaust backfire pop | Front 3/4 action pan, motion blur in background wheels and barriers |
| `FYP-003` | `feed_civic_fl5_track.png` | Honda Civic Type R (FL5), Championship White | Apex cornering on wet rumble strips; spray off Michelin Pilot Sport Cup 2 tires | Front 3/4 dynamic cornering, low angle capturing aggressive front splitter |
| `FYP-004` | `feed_supra_twilight.png` | Toyota GR Supra (A90), Matte Storm Grey | Urban industrial highway underpass at night; moody neon sodium and cyan rim lights | Side profile rolling shot, speed blur, reflections on aerodynamic flanks |

#### Prompt Template — Home FYP
```text
Photorealistic cinematic 9:16 mobile wallpaper photography, {Vehicle Make & Model}, {Color & Finish}, {Environment & Weather}, dramatic dusk rim lighting, subtle carbon fiber reflections, moody atmospheric fog, shot on Sony A7R V with 50mm f/1.4 lens, 8k resolution, authentic automotive enthusiast media, Dark Premium aesthetic --no cartoon, 3d render plastic, watermark, logo distortion, low quality
```

---

### Category B: Featured Vehicle Showcase Hero Assets
*Orientation: Landscape (16:9) | Resolution: 1920 × 1080 px | File Format: PNG*

These assets serve as the interactive canvas for component callout hotspots (`Akrapovič Exhaust`, `BBS FI-R Wheels`, `KW V4 Suspension`, `Brembo Brakes`).

| Asset ID | Target File Name | Vehicle Specification | Canvas Layout Requirement |
|---|---|---|---|
| `SHW-001` | `showcase_porsche_gt3.png` | 2023 Porsche 911 GT3 (992) Clubsport in Shark Blue with Satin Black aerodynamic wing | Clear front 3/4 angle (45°), ample margins for interactive callout hotspots at wheel hubs, front bumper, rear wing, and side skirt |
| `SHW-002` | `showcase_rx7_fd3s.png` | 1997 Mazda RX-7 (FD3S) Series 7 in Sunburst Yellow with RE-Amemiya carbon diffuser | Studio 3/4 angle, rim light accentuating twin-rotor rotary engine bay and lightweight Rays TE37 wheels |
| `SHW-003` | `showcase_civic_fl5.png` | 2023 Honda Civic Type R (FL5) in Championship White with red Brembo calipers | Front 3/4 stance showing wide aero arches, vented hood, and functional triple center exhaust |

#### Prompt Template — Vehicle Showcase Hero
```text
High-end automotive studio beauty shot, 16:9 aspect ratio, 2023 Porsche 911 GT3 992 Clubsport in Shark Blue, studio stage with dark carbon slate floor (#11171D), overhead softbox diffusion, precise rim lighting highlighting wheel arches and aerodynamic carbon rear wing, pristine reflections, ultra-sharp detail on brakes and carbon ceramic calipers, Hasselblad medium format look, hyper-realistic, 8k --no oversaturation, fake flares, artifacts, cropped wheels
```

---

### Category C: Marketplace Performance Parts
*Orientation: Square (1:1) | Resolution: 1080 × 1080 px | File Format: PNG*

Marketplace listings require clean, tactile, premium component photography against dark neutral backdrops (#11171D Carbon / #192129 Graphite).

| Asset ID | Target File Name | Component Name | Material & Texture Details |
|---|---|---|---|
| `MKT-001` | `part_akrapovic_exhaust.png` | Akrapovič Evolution Line Titanium Exhaust | Blue heat-treated titanium weld seams, carbon fiber exhaust tips, brushed titanium pipes |
| `MKT-002` | `part_bbs_fir_wheels.png` | BBS FI-R Forged Monobloc 20" Wheel | Satin Black finish, skeletonized cut-outs on forged spokes, BBS gold center cap |
| `MKT-003` | `part_kw_v4_coilovers.png` | KW Variant 4 3-Way Adjustable Coilovers | Inox-line stainless steel shock bodies, signature yellow springs, purple anodized aluminum collars |
| `MKT-004` | `part_brembo_gtr_brakes.png` | Brembo GT-R Billet 6-Piston Monobloc Caliper | Nickel-plated billet aluminum finish with red Brembo racing emblem, slotted two-piece floating rotor |
| `MKT-005` | `part_eventuri_intake.png` | Eventuri Carbon Fiber Cold Air Intake System | Gloss pre-preg 2x2 carbon weave, patent-pending reverse cone filter housing, black silicone couplings |
| `MKT-006` | `part_vorsteiner_aero_wing.png` | Vorsteiner VRS Carbon Aero Wing & Diffuser | Exposed autoclave dry carbon fiber weave, CNC aluminum uprights, aerodynamic endplates |

#### Prompt Template — Marketplace Component
```text
Macro commercial product photography, 1:1 square ratio, {Component Name and Brand}, precision engineered {Material & Finish Details}, resting on dark graphite textured studio surface (#192129), subtle lime green edge reflection (#C7F36B), clean directional soft light, crisp metal brushing and carbon fiber weave texture, Leica SL2 90mm macro lens, ultra-clean automotive catalogue standard --no background clutter, fake badges, blur, low resolution
```

---

### Category D: User Profile & Community Avatars
*Orientation: Circular / Square (1:1) | Resolution: 512 × 512 px | File Format: PNG*

Realistic automotive enthusiast portraits, professional race attire, or workshop headshots.

| Asset ID | Target File Name | Persona & Username | Description & Visual Tone |
|---|---|---|---|
| `AVT-001` | `avatar_aditya.png` | Aditya Pratama (@aditya_gt3) | Experienced Indonesian track driver and car builder; wearing Sparco racing suit unzipped, paddock background |
| `AVT-002` | `avatar_kevin.png` | Kevin Mahendra (@ak_parts_jkt) | Automotive parts importer and specialist seller; modern dark enthusiast apparel, warehouse backdrop |
| `AVT-003` | `avatar_daniel.png` | Daniel Wijaya (@danny_motorsport) | Chief race engineer & motorsport tuner; clean workshop uniform, holding digital torque wrench |
| `AVT-004` | `avatar_adrian.png` | Adrian Kusuma (@adrian_rotary) | Classic JDM rotary builder; casual tuner garage setting with engine schematics |
| `AVT-005` | `avatar_rafael.png` | Rafael Putra (@rafael_camber) | Track stance & fitment specialist; clean industrial studio portrait |

#### Prompt Template — User Avatars
```text
Photorealistic portrait headshot, 1:1 ratio, 30-year-old Southeast Asian automotive builder, confident friendly expression, wearing minimalist charcoal technical jacket, soft warm rim light from workshop lamps in blurred background, Canon EOS R5 with 85mm f/1.4 lens, natural skin texture, professional social profile standard --no anime, AI face artifacts, plastic skin, distorted eyes
```

---

## 3. Image Optimization & Delivery Pipeline

When generating and integrating these assets into the AutoVerse Flutter application:

1. **Resolution Scale:**
   - Raw output: 1080 × 1920 (Feed), 1920 × 1080 (Showcase), 1080 × 1080 (Parts).
   - Downscaled optimized assets: `@1x`, `@2x`, and `@3x` variants in `assets/images/`.
2. **Compression:**
   - Run WebP / PNG quantization (Oxipng or TinyPNG) targeting `< 400 KB` per reel frame and `< 250 KB` per part image.
3. **Asset Registration:**
   - Register directory pattern `assets/images/` in `pubspec.yaml` (already configured).
4. **Fallback Handling:**
   - Maintain `Image.asset(..., errorBuilder: (ctx, err, stk) => ...)` on all image widgets to guarantee zero black screens or crashing if an asset is missing or fails to decode.
