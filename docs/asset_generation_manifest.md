# AUTOVERSE — VISUAL ASSET AUDIT & GENERATION MANIFEST (FINAL REVISION)

**Tanggal Audit & Revisi:** 15 November 2026  
**Project:** AUTOVERSE (Flutter / Dart)  
**Status Audit File Inbox:** **9/9 FILE TERVERIFIKASI FISIK DI `asset_inbox/gemini_generated/`**  
**Format Asli File Inbox:** **100% JPEG (`.jpg`)**  
**Status 9 Aset Eksisting:** `GENERATED — FILE RECEIVED — READY FOR INTEGRATION`  

---

## 1. Asset Audit Summary

| Metrik Audit | Nilai | Keterangan & Rincian |
|---|:---:|---|
| **Aset Gemini Terverifikasi di `asset_inbox/`** | **9** | Status: `GENERATED — FILE RECEIVED — READY FOR INTEGRATION` |
| **Format File Gambar di Inbox** | **JPEG (`.jpg`)** | Semua 9 file asli berformat JPEG, bukan WebP murni |
| **Total File Gambar Lama di Project (`assets/images/`)** | **7** | Aset warisan sprint awal (`.png`) |
| **Total Referensi Aset di Kode Dart (`lib/`)** | **47** | Tersebar di model, data seed, dan presentasi |
| **Celah Gambar Produk Marketplace Riil** | **8 / 8** | Seluruh produk di `marketplace_data.dart` saat ini memakai foto mobil utuh |
| **Ketidaksesuaian Kritis (Visual Mismatch)** | **2** | Honda Civic Type R FK8 (`dummy_data` & `vehicles_data`) memakai gambar Porsche GT3 |
| **Total Rencana Aset Tambahan Baru (New Gemini Generation)** | **11** | Konsisten: **P0: 5 aset**, **P1: 3 aset**, **P2: 3 aset** |
| • **Prioritas P0 (MVP Critical)** | **5** | 3 Postingan Vertikal FYP 9:16 + 2 Produk Marketplace tanpa aset |
| • **Prioritas P1 (Marketplace & Tuner Identity)** | **3** | 2 Produk Marketplace (Intake & Wide Body) + 1 Avatar Kreator FYP |
| • **Prioritas P2 (Enthusiast & Seller Enhancements)** | **3** | 2 Avatar Pengguna/Seller + 1 Paddock Atmosphere Post |

---

## 2. Laporan Verifikasi Fisik 9 Aset di `asset_inbox/gemini_generated/`

Pemeriksaan langsung terhadap seluruh file gambar hasil generasi Google Gemini pada folder `asset_inbox/gemini_generated/`:

| No | File Asli di Inbox | Target File Name | Deskripsi Visual & Subjek | Resolusi Riil | Format Riil | Evaluasi Teknis & Pemetaan | Status Aset |
|:---:|---|---|---|:---:|:---:|---|:---:|
| 1 | `media_1794722250342_68a560c4.jpg` | `vehicle_porsche_911_gt3_hero.jpg` | **Porsche 911 GT3 992.1**<br>Dark Graphite Metallic, swan-neck wing, PCCB yellow calipers, front 3/4 | 1024 × 572 | JPEG | **VALID.** Terintegrasi penuh ke `vehicles_data.dart`, hero showcase, dan profile garage. | `INTEGRATED AND REFERENCED` |
| 2 | `media_1794722244008_b3b1f586.jpg` | `vehicle_mazda_rx7_fd3s_hero.jpg` | **Mazda RX-7 FD3S**<br>Midnight Blue, pop-up lights, BBS wheels, workshop tuning garage, front 3/4 | 1024 × 572 | JPEG | **VALID.** Terintegrasi penuh ke `vehicles_data.dart`, garage build list, dan create media picker. | `INTEGRATED AND REFERENCED` |
| 3 | `media_1794722239152_5a8bed91.jpg` | `vehicle_honda_civic_type_r_fk8_hero.jpg` | **Honda Civic Type R FK8**<br>Championship White, red Brembo calipers, vortex generators, hood scoop | 1024 × 572 | JPEG | **VALID & TERVERIFIKASI.** 100% otentik FK8. Memperbaiki visual mismatch di `vehicles_data.dart` & `dummy_data.dart`. | `INTEGRATED AND REFERENCED` |
| 4 | `media_1794722235271_b85bbf9c.jpg` | `product_titanium_exhaust.jpg` | **Titanium Performance Exhaust**<br>Cat-back valved race exhaust, pie-cut welds, quad carbon fiber tips | 1024 × 765 | JPEG | **VALID.** Terintegrasi ke `prod_01` (Marketplace card, detail, chat, saved) & component modal. | `INTEGRATED AND REFERENCED` |
| 5 | `media_1794722231397_2ec94003.jpg` | `product_forged_wheel.jpg` | **Forged Alloy Wheel**<br>Satin titanium 10-spoke monobloc forged wheel with performance track tire | 1024 × 1024 | JPEG | **VALID.** Terintegrasi ke `prod_02` (Marketplace card, detail, chat, saved) & component modal. | `INTEGRATED AND REFERENCED` |
| 6 | `media_1794722227988_b18422f8.jpg` | `product_performance_coilover.jpg` | **Performance Coilover Suspension**<br>Sepasang coilover motorsport, per kuning linier, piggyback reservoir dial | 1024 × 1024 | JPEG | **VALID (KW CLUBSPORT COMPONENT).** Terintegrasi ke modal komponen suspensi Porsche showcase. | `INTEGRATED AND REFERENCED` |
| 7 | `media_1794722224208_c80f85cb.jpg` | `product_carbon_ceramic_brake.jpg` | **Carbon Ceramic Brake Kit**<br>Sepasang rotor carbon-ceramic cross-drilled + kaliper balap monobloc merah | 1024 × 1024 | JPEG | **VALID (BREMBO 410MM COMPONENT).** Terintegrasi ke modal komponen pengereman Porsche showcase. | `INTEGRATED AND REFERENCED` |
| 8 | `media_1794722215162_299957dd.jpg` | `product_turbocharger.jpg` | **Performance Turbocharger**<br>Billet compressor wheel, anti-surge housing, twin-scroll cast turbine T4 | 1024 × 1024 | JPEG | **TERSEDIA DI ASSET DIRECTORY.** Komponen turbocharger mandiri, disimpan untuk ekspansi listing masa depan. | `INTEGRATED BUT UNMAPPED` |
| 9 | `media_1794722208511_45d05b1d.jpg` | `product_carbon_fiber_wing.jpg` | **Carbon Fiber GT Rear Wing**<br>3D dry carbon aerodynamic wing blade, carbon endplates, black aluminium legs | 1024 × 1024 | JPEG | **TERSEDIA DI ASSET DIRECTORY.** Komponen sayap GT mandiri, disimpan untuk listing aero masa depan. | `INTEGRATED BUT UNMAPPED` |

---

## 3. Resolusi Teknis & Kebijakan Format Gambar (JPEG vs WebP)

> [!CAUTION]
> **Kebijakan Format Gambar:**  
> Seluruh sembilan file asli hasil generasi Gemini yang ada di `asset_inbox/gemini_generated/` adalah file berformat **JPEG asli** (`.jpg`), bukan WebP.  
> **DILARANG KERAS** sekadar mengubah ekstensi nama file (misal: mengganti nama dari `.jpg` menjadi `.webp` tanpa transcoding) karena Flutter Image Decoder pada engine Android/iOS akan mendeteksi ketidaksesuaian header biner (*magic bytes*) dan memicu runtime image decoding error.
> 
> **Pilihan Integrasi yang Sah:**
> 1. **Transcoding Sejati:** Melakukan konversi format sesungguhnya menggunakan tools encoding standar (seperti script Python Pillow, ImageMagick, atau cwebp) dari JPEG ke WebP saat integrasi.
> 2. **Retensi Ekstensi JPEG Asli:** Mempertahankan ekstensi `.jpg` asli saat dipindahkan ke `assets/images/` dan mendaftarkannya dengan ekstensi `.jpg` pada kode Dart dan `pubspec.yaml`.

---

## 4. Evaluasi Khusus Komponen Marketplace & Keputusan Implementasi

### A. Coilover: KW Clubsport vs HKS Hipermax S (`product_performance_coilover.webp`)
- **Temuan Visual:** Gambar `media_1794722227988_b18422f8.jpg` secara visual menampilkan karakteristik khas KW Suspensions (per kuning linier, lock ring ungu anodized, tabung stainless, dan tabung reservoir terpisah).
- **Target Kode Saat Ini:** `prod_03` di `marketplace_data.dart` berjudul *HKS Hipermax S Street Coilover Kit*.
- **Di Sisi Lain:** Pada `FeaturedVehicleShowcaseScreen` (Porsche 911 GT3), modifikasi suspensi yang tercatat justru adalah *KW Clubsport 3-Way Coilovers (Setelan Seimbang untuk Lintasan)*.
- **Keputusan:**  
  Aset ini diklasifikasikan sebagai **Aset Ilustratif Generik Suspensi Performa Tinggi** (*Generic Performance Coilover*). Aset ini sangat cocok mewakili kategori suspensi balap pada demo MVP. Jika di kemudian hari tim produk mewajibkan akurasi merek HKS yang presisi (bodi gunmetal, per hitam/gelap, aksen perak), aset tersebut dijadwalkan untuk regenerasi ulang terpisah.

### B. Rem: Big Brake Kit Utuh vs Kampas Rem (`product_carbon_ceramic_brake.webp`)
- **Temuan Visual:** Gambar `media_1794722224208_c80f85cb.jpg` menampilkan **kit sistem pengereman lengkap** (dua rotor carbon-ceramic berventilasi dengan topi tengah anodized dan bobbins mengambang, serta dua kaliper monobloc balap merah multi-piston).
- **Target Kode Saat Ini:** `prod_04` di `marketplace_data.dart` bernama *Brembo Racing Carbon-Ceramic Brake Pad Set* dengan harga Rp 8.750.000 dan deskripsi berfokus pada kampas rem (*pad set*).
- **Keputusan:**  
  Dalam antarmuka katalog marketplace visual, menampilkan rotor cakram karbon-keramik dan kaliper balap merah utuh memberikan daya tarik visual yang jauh lebih premium dan langsung dapat dikenali oleh penggemar otomotif dibandingkan hanya menampilkan bantalan kampas rem persegi kecil.
- **Rekomendasi Review Implementasi:**  
  1. *Opsi Rekomendasi (UI/Data alignment):* Memperbarui nama `prod_04` menjadi *Brembo Racing Carbon-Ceramic Brake System Upgrade* dengan penyesuaian harga proporsional pada sprint berikutnya.
  2. *Opsi Alternatif:* Jika tim produk bersikeras hanya ingin menampilkan kotak kampas rem murni, maka gambar kampas rem terpisah dapat digenerate ulang di masa depan.

### C. Jok Balap: OMP WRC Bucket Racing Seat sebagai Interior (`product_bucket_seat.webp`)
- **Target Kode Saat Ini:** `prod_07` saat ini terdaftar dengan `category: 'Exterior'` di `marketplace_data.dart`.
- **Keputusan:**  
  Secara teknis otomotif, jok balap serat karbon (*racing bucket seat*) adalah komponen **Interior**.
- **Status Implementasi:**  
  Ditandai sebagai **FLAGGED: INTERIOR — PENDING IMPLEMENTATION REVIEW**. Sesuai aturan non-intervensi kode pada task dokumentasi ini, kode Dart tidak diubah sekarang; penambahan kategori *Interior* pada tab katalog dan filter panel Marketplace dijadwalkan sebelum produk ini diintegrasikan secara final.

### D. Penahanan Komponen Unmapped (Turbocharger & Carbon GT Wing)
- **Asset 8 (`product_turbocharger.webp`):** Ditetapkan berstatus **`GENERATED — UNMAPPED (ON HOLD)`**. Tidak dipaksakan ke produk yang tidak relevan (seperti camshaft atau intake). Disimpan untuk listing upgrade turbo atau fitur showcase mesin Mazda RX-7.
- **Asset 9 (`product_carbon_fiber_wing.webp`):** Ditetapkan berstatus **`GENERATED — AERO COMPONENT (ON HOLD)`**. Ditegaskan **berbeda** dari `prod_05` (*RE-Amemiya Wide Body Aero Kit* yang merupakan body kit lengkap: bumper, overfender, canard, side skirt).

---

## 5. Audit & Solusi Media FYP (Full-Screen Vertical 9:16)

Penggunaan cropping ekstrem pada gambar landscape 16:9 (`1024 × 572`) untuk layar penuh FYP vertikal (9:16) **TIDAK DIREKOMENDASIKAN** karena akan memotong lebih dari 65% bidang gambar dan merusak komposisi visual mobil. Oleh karena itu, dialokasikan **3 aset vertikal 9:16 khusus** pada Tier P0:

| Post ID | Pembuat & Handle | Caption & Subjek | Asosiasi Kendaraan | Masalah Visual Eksisting | Aset Baru yang Direncanakan (9:16) | Prioritas |
|---|---|---|---|---|---|:---:|
| `post_01` | Aditya Pratama (`@aditya_gt3`) | Cold start & tunnel pull flat-6 titanium exhaust acoustics | `veh_porsche_gt3` (Porsche 911 GT3 992.1) | Format landscape ter-crop vertikal, resolusi menurun | `post_porsche_gt3_vertical.webp`<br>*(Porsche 911 GT3 tunnel / pit-lane vertical content)* | **P0** |
| `post_02` | Kenji Sato (`@rotary_kenji`) | Bridge port 13B-REW idling & twin sequential turbos spooling | `veh_mazda_rx7` (Mazda RX-7 FD3S) | Format landscape ter-crop vertikal | `post_rx7_rotary_vertical.webp`<br>*(Mazda RX-7 FD3S rotary workshop vertical content)* | **P0** |
| `post_03` | Dimas Rizky (`@type_r_jakarta`) | Testing KW Clubsport 3-way di Turn 3-4 Sentul Circuit | `veh_civic_fk8` (Honda Civic Type R FK8) | **CRITICAL MISMATCH:** Menampilkan mobil Porsche GT3 | `post_civic_fk8_vertical.webp`<br>*(Honda Civic Type R FK8 Sentul track-day vertical content)* | **P0** |

---

## 6. Audit Identitas Pengguna & Status Avatar Obrolan

| Nama Pengguna | Handle | Peran di Aplikasi | Aset Avatar Saat Ini | Masalah Visual | Solusi yang Direkomendasikan | Status / Prioritas |
|---|---|---|---|---|---|:---:|
| **Aditya Pratama** | `@aditya_gt3` | User Utama, Pemilik Garasi, Author `post_01` | `assets/images/avatar_aditya.png` | Tidak ada masalah (kualitas tinggi) | **Pertahankan** aset eksisting (`avatar_aditya.png`) | **RETAINED** |
| **Kenji Sato** | `@rotary_kenji` | Creator `post_02`, spesialis rotary tuner | `assets/images/avatar_aditya.png` | Duplikasi foto Aditya | `avatar_kenji.webp` (Tuner JDM spesialis rotary) | **P1** |
| **Dimas Rizky** | `@type_r_jakarta` | Creator `post_03`, pebalap track day Jakarta | `assets/images/avatar_aditya.png` | Duplikasi foto Aditya | `avatar_dimas.webp` (Penggemar hot-hatch Sentul) | **P2** |
| **Kevin Mahendra** | `@ak_parts_jkt` | Penjual `prod_01`, partisipan chat seller | `null` (Initial 'K') | Menggunakan inisial huruf standar | `avatar_kevin_seller.webp` (Profil merchant resmi) | **P2** |
| **Daniel Wijaya** | `@daniel_992` | Member Porsche Club, teman chat | `null` (Initial 'D') | Tidak ada masalah | **Inisial huruf dipertahankan** | **DEFERRED (Out of Scope)** |
| **Adrian Kusuma** | `@adrian_tuning` | Spesialis Dyno & ECU, Apex Garage | `null` (Initial 'A') | Tidak ada masalah | **Inisial huruf dipertahankan** | **DEFERRED (Out of Scope)** |
| **Rafael Putra** | `@rafael_fd3s` | Anggota Rotary Syndicate | `null` (Initial 'R') | Tidak ada masalah | **Inisial huruf dipertahankan** | **DEFERRED (Out of Scope)** |
| **Sentul Paddock** | `@sentul_official` | Komunitas track day & penyelenggara sirkuit | `null` | Aset atmosfer sirkuit Sentul | `post_track_day_paddock.webp` (Paddock pit-lane atmosphere) | **P2** |

---

## 7. Struktur Prioritas 11 Aset Baru (Priority Tiers)

Total aset tambahan yang direncanakan: **11 aset** (P0: 5, P1: 3, P2: 3).

### **TIER P0 — Sangat Kritis untuk MVP Demonstration (5 Aset):**
1. `post_porsche_gt3_vertical.webp` — Konten FYP vertikal 9:16 untuk `post_01` (Porsche 911 GT3).
2. `post_rx7_rotary_vertical.webp` — Konten FYP vertikal 9:16 untuk `post_02` (Mazda RX-7 FD3S).
3. `post_civic_fk8_vertical.webp` — Konten FYP vertikal 9:16 untuk `post_03` (Honda Civic Type R FK8).
4. `product_camshaft_set.webp` — Komponen mesin untuk `prod_06` (Toda Racing Camshaft Set K20C1).
5. `product_bucket_seat.webp` — Komponen interior untuk `prod_07` (OMP WRC Bucket Racing Seat).

### **TIER P1 — Kelengkapan Marketplace & Identitas Kreator (3 Aset):**
6. `product_cold_air_intake.webp` — Komponen mesin untuk `prod_08` (HKS GT2 Cold Air Induction Kit).
7. `product_wide_body_aero_kit.webp` — Komponen eksterior untuk `prod_05` (RE-Amemiya FD3S Full Wide Body Aero Kit).
8. `avatar_kenji.webp` — Avatar kreator Kenji Sato (`@rotary_kenji`, `post_02`).

### **TIER P2 — Penyempurnaan Visual & Komunitas (3 Aset):**
9. `avatar_dimas.webp` — Avatar kreator Dimas Rizky (`@type_r_jakarta`, `post_03`).
10. `avatar_kevin_seller.webp` — Avatar verified seller Kevin Mahendra (`@ak_parts_jkt`, `conv_kevin_autoparts`).
11. `post_track_day_paddock.webp` — Suasana pit-lane Sirkuit Sentul senja untuk galeri komunitas.

---

## 8. Siap Pakai: 11 Gemini Generation Prompts

Seluruh prompt dirancang secara ketat mengikuti visual direction **AutoVerse Dark Premium**:
- Void Black (`#0A0D10`), Carbon, Graphite, Steel, aksen Performance Lime halus.
- Fotografi editorial otomotif sinematik, pencahayaan dramatic studio/paddock, depth of field dangkal.
- Standalone photograph tunggal, tanpa bingkai, tanpa mockup smartphone, tanpa teks/logo melayang.

---

### PROMPT 1: Porsche 911 GT3 Tunnel & Pit Lane Reel (P0 — FYP Vertical)
```text
Cinematic vertical automotive photograph of a dark graphite metallic Porsche 911 GT3 (992.1) driving through an illuminated modern concrete tunnel at night. Dynamic low rear-three-quarter tracking angle capturing the massive swan-neck rear wing, glowing red LED continuous lightbar, and heat haze radiating from the dual center-exit titanium exhaust pipes. Motion-blurred tunnel lighting streaks reflecting across the sculpted wide fenders and wet asphalt road surface. Dark premium editorial atmosphere, rich void blacks, cool tungsten and neon highlights. Vertical 9:16 composition, shot on 35mm lens, photorealistic, 8k resolution. NO text, NO watermarks, NO mockups, NO UI elements, NO people visible.
```
- **Target File:** `post_porsche_gt3_vertical.webp`
- **Rasio:** 9:16 (1080 × 1920)
- **Penggunaan:** Home / FYP feed background untuk `post_01` (Aditya Pratama)

---

### PROMPT 2: Mazda RX-7 FD3S Rotary Workshop Reel (P0 — FYP Vertical)
```text
Atmospheric vertical automotive photograph of a midnight blue 1994 Mazda RX-7 FD3S parked inside a dimly lit Japanese underground speed shop at midnight. Eye-level front three-quarter view with pop-up headlights recessed and amber marker lights glowing softly. The hood is slightly propped open, revealing illuminated polished intake piping and twin turbochargers under dramatic overhead fluorescent strip lighting. Dark industrial garage background with rolling tool chests, spare racing slicks, and moody wet concrete floor reflections. Cinematic dark moody color grading, deep shadows in charcoal and void black, shallow depth of field. Vertical 9:16 aspect ratio, 8k resolution, photorealistic editorial photography. NO text, NO logos, NO anime, NO watermarks, NO UI elements.
```
- **Target File:** `post_rx7_rotary_vertical.webp`
- **Rasio:** 9:16 (1080 × 1920)
- **Penggunaan:** Home / FYP feed background untuk `post_02` (Kenji Sato)

---

### PROMPT 3: Honda Civic Type R FK8 Sentul Track Day (P0 — FYP Vertical)
```text
High-speed vertical trackside action photograph of a Championship White 2018 Honda Civic Type R (FK8) aggressively carving through a sweeping asphalt corner on a racetrack during late afternoon golden hour dusk. Front dynamic 3/4 action shot showing subtle body roll, sharp front-wheel turn-in, Brembo red brake calipers visible through dark multi-spoke motorsport wheels, and a low carbon front splitter scraping close to the red-and-white circuit kerb. Distant grandstands and tire barriers blurred in high-speed panning motion. Dark asphalt texture, dramatic low-angle sunlight glinting across the white pearl paintwork, cinematic filmic tone. Vertical 9:16 aspect ratio, photorealistic, 8k resolution. NO text, NO watermarks, NO mockups, NO UI elements.
```
- **Target File:** `post_civic_fk8_vertical.webp`
- **Rasio:** 9:16 (1080 × 1920)
- **Penggunaan:** Home / FYP feed background untuk `post_03` (Dimas Rizky — Memperbaiki mismatch Porsche)

---

### PROMPT 4: Toda Racing Billet Steel Camshaft Set (P0 — Marketplace)
```text
Professional commercial studio photograph of a pair of high-performance billet steel camshafts for a high-revving racing engine. The dual camshafts rest side-by-side on an industrial dark slate workbench with subtle reflections. Precision-ground steel lobes with razor-sharp machining textures, polished bearing journals, and laser-etched timing marks. Dramatic rim lighting from the side highlighting the metallic gleam and oil-slick finish. Moody, dark premium atmosphere, deep shadows in charcoal and void black, cinematic shallow depth of field. High-end automotive editorial photography, 8k resolution, photorealistic, 1:1 aspect ratio. NO text, NO watermarks, NO mockups, NO UI elements, NO hands.
```
- **Target File:** `product_camshaft_set.webp`
- **Rasio:** 1:1 (1024 × 1024)
- **Penggunaan:** `prod_06` (Toda Racing High-Power Camshaft Set K20C1)

---

### PROMPT 5: OMP WRC Composite Racing Bucket Seat (P0 — Marketplace)
```text
Studio product photograph of a single professional FIA-approved motorsport racing bucket seat with prominent side head protection bolsters. The seat is constructed with an exposed glossy carbon-kevlar weave shell on the back and premium matte black breathable anti-slip fabric upholstery with subtle red and lime contrast stitching on the cushions. Integrated five-point racing harness guide slots with glossy finish. Displayed angled 3/4 view on a dark graphite concrete floor inside a sleek dark tuning studio. Moody low-key cinematic lighting with crisp edge highlights defining the sculpted ergonomic contours. Premium automotive editorial quality, photorealistic, 8k resolution, 1:1 aspect ratio. NO car interior, NO humans, NO watermarks, NO text, NO logos.
```
- **Target File:** `product_bucket_seat.webp`
- **Rasio:** 1:1 (1024 × 1024)
- **Penggunaan:** `prod_07` (OMP WRC Bucket Racing Seat — Interior Component)

---

### PROMPT 6: HKS GT2 Cold Air Induction Intake Kit (P1 — Marketplace)
```text
Commercial product studio photograph of a complete dual cold-air intake induction kit for a twin-turbocharged sports car. The kit includes mandrel-bent polished mirror-finish aluminium induction pipes, black multi-ply silicone couplers, stainless T-bolt hose clamps, and two iconic polyurethane mushroom-style high-flow air filter pods with signature green honeycomb cages. Cleanly arranged on a dark matte carbon-fiber surface. Dramatic rim lighting glinting off the polished aluminium and honeycomb mesh. Dark moody studio backdrop, void black negative space, shallow depth of field. Automotive parts catalog commercial photography, crisp details, 8k resolution, photorealistic, 1:1 aspect ratio. NO text, NO branding badges, NO watermarks, NO hands, NO mockups.
```
- **Target File:** `product_cold_air_intake.webp`
- **Rasio:** 1:1 (1024 × 1024)
- **Penggunaan:** `prod_08` (HKS GT2 Super Power Flow Air Intake Kit)

---

### PROMPT 7: RE-Amemiya FD3S Full Wide Body Aero Kit (P1 — Marketplace)
```text
Clean commercial automotive studio shot of a complete aerodynamic widebody kit for a Japanese sports coupe. Unassembled components artfully displayed on a dark industrial epoxy floor: front aggressive aero bumper with integrated carbon canards, vented lightweight front over-fenders, sculpted side skirts, and rear diffuser fins. Raw unpainted dark grey composite finish with visible carbon fiber textures on the aerodynamic dive planes. Overhead diffused softbox lighting with crisp side kickers emphasizing the sharp aerodynamic lines and cooling ducts. Deep dark graphite background, ultra-clean commercial look, 8k resolution, photorealistic, 1:1 aspect ratio. NO full car, NO text, NO watermarks, NO clutter.
```
- **Target File:** `product_wide_body_aero_kit.webp`
- **Rasio:** 1:1 (1024 × 1024)
- **Penggunaan:** `prod_05` (RE-Amemiya Wide Body Aero Kit FD3S — Distinct from GT Wing)

---

### PROMPT 8: Kenji Sato Avatar — JDM Tuner (P1 — Avatar)
```text
Cinematic portrait photograph of a 30-year-old Japanese automotive mechanic and rotary engine tuner. He has styled dark messy hair, focused passionate expression, faint smudge of engine grease on one cheek. Wearing a dark charcoal minimalist work jacket over a black crewneck. Background is a dimly lit high-end Japanese speed shop at night, softly blurred neon amber and fluorescent tube lighting reflecting off tool cabinets and a rotary engine stand. Moody dark aesthetic, dramatic soft key light highlighting his face and eyes, cinematic film grain, shallow depth of field. Natural, authentic, non-AI-looking, 8k resolution, 1:1 aspect ratio. Centered square avatar framing. NO cartoon, NO anime, NO exaggerated features, NO text, NO watermarks.
```
- **Target File:** `avatar_kenji.webp`
- **Rasio:** 1:1 (512 × 512)
- **Penggunaan:** Avatar kreator Kenji Sato (`@rotary_kenji`, `post_02`)

---

### PROMPT 9: Dimas Rizky Avatar — Track Day Enthusiast Jakarta (P2 — Avatar)
```text
Cinematic lifestyle portrait of a 26-year-old Indonesian male automotive enthusiast and track day driver. Short neat modern fade haircut, confident friendly smile, athletic build. Wearing a dark graphite racing team polo shirt with subtle motorsport sleeve accents. Background is the pit lane garage of Sentul International Circuit at late afternoon dusk, with the warm golden hour light softly outlining his shoulder and a dark garage interior behind him. Premium editorial look, sharp eye focus, natural skin texture, moody dark cinematic grading, 1:1 aspect ratio centered avatar framing. Photorealistic, 8k resolution. NO cartoon, NO watermark, NO logo, NO oversaturation.
```
- **Target File:** `avatar_dimas.webp`
- **Rasio:** 1:1 (512 × 512)
- **Penggunaan:** Avatar kreator Dimas Rizky (`@type_r_jakarta`, `post_03`)

---

### PROMPT 10: Kevin Mahendra Avatar — Verified Merchant (P2 — Avatar)
```text
Professional corporate portrait of a 32-year-old Indonesian male motorsport business owner and aftermarket performance parts importer. Professional yet approachable expression, clean groomed hair, wearing a sleek black motorsport softshell jacket with subtle lime green zipper accents. Background is a modern dark-themed speed shop showroom with illuminated glass display cabinets showcasing titanium exhausts and forged wheels in soft bokeh. Balanced cinematic studio lighting, premium luxury aesthetic, authentic skin texture, sharp focus on eyes, 1:1 aspect ratio centered avatar composition. Photorealistic, 8k resolution. NO cartoon, NO watermarks, NO text.
```
- **Target File:** `avatar_kevin_seller.webp`
- **Rasio:** 1:1 (512 × 512)
- **Penggunaan:** Avatar verified seller Kevin Mahendra (`@ak_parts_jkt`, `conv_kevin_autoparts`)

---

### PROMPT 11: Sentul Circuit Pit Lane Atmosphere (P2 — Social Community)
```text
Dramatic cinematic vertical photograph taken from inside a dark pit lane garage looking out onto the asphalt racetrack during twilight dusk. A sleek dark sports car with glowing red LED taillights idles near the pit exit, with tire marks visible on the tarmac and distant circuit floodlights casting long reflections on the damp ground. Mechanics silhouettes working quietly near a tire rack with tire warmers glowing orange. Atmospheric haze, moody cinematic grading with deep void blacks and cool steel blues. 9:16 vertical aspect ratio, shot on 35mm anamorphic lens, authentic filmic grain, 8k resolution, photorealistic. NO text, NO watermarks, NO UI elements, NO mockups.
```
- **Target File:** `post_track_day_paddock.webp`
- **Rasio:** 9:16 (1080 × 1920)
- **Penggunaan:** Feed FYP background / media gallery variasi komunitas

---

## 9. Konvensi Penamaan Lengkap Aset (Asset Naming Convention)

```text
assets/images/
├── vehicles/
│   ├── vehicle_porsche_911_gt3_hero.webp        # Asset 1 (Received in Inbox)
│   ├── vehicle_mazda_rx7_fd3s_hero.webp         # Asset 2 (Received in Inbox)
│   └── vehicle_honda_civic_type_r_fk8_hero.webp  # Asset 3 (Received in Inbox - Verified FK8)
│
├── products/
│   ├── product_titanium_exhaust.webp            # Asset 4 (Received in Inbox - prod_01)
│   ├── product_forged_wheel.webp                # Asset 5 (Received in Inbox - prod_02)
│   ├── product_performance_coilover.webp        # Asset 6 (Received in Inbox - Generic Illustrative prod_03)
│   ├── product_carbon_ceramic_brake.webp        # Asset 7 (Received in Inbox - Complete Kit prod_04)
│   ├── product_turbocharger.webp                # Asset 8 (Received in Inbox - Unmapped / On Hold)
│   ├── product_carbon_fiber_wing.webp           # Asset 9 (Received in Inbox - Aero Wing / On Hold)
│   ├── product_camshaft_set.webp                # Planned New Generation P0 (prod_06)
│   ├── product_bucket_seat.webp                 # Planned New Generation P0 (prod_07 - Interior)
│   ├── product_cold_air_intake.webp             # Planned New Generation P1 (prod_08)
│   └── product_wide_body_aero_kit.webp          # Planned New Generation P1 (prod_05 - Body Kit)
│
├── posts/
│   ├── post_porsche_gt3_vertical.webp           # Planned New Generation P0 (post_01 FYP 9:16)
│   ├── post_rx7_rotary_vertical.webp            # Planned New Generation P0 (post_02 FYP 9:16)
│   ├── post_civic_fk8_vertical.webp             # Planned New Generation P0 (post_03 FYP 9:16)
│   └── post_track_day_paddock.webp              # Planned New Generation P2 (FYP Community)
│
└── avatars/
    ├── avatar_aditya.png                        # Existing Project Asset (Retained)
    ├── avatar_kenji.webp                        # Planned New Generation P1 (@rotary_kenji)
    ├── avatar_dimas.webp                        # Planned New Generation P2 (@type_r_jakarta)
    └── avatar_kevin_seller.webp                 # Planned New Generation P2 (@ak_parts_jkt)
```
