# AUTOVERSE — Platform Sosial & Marketplace Otomotif

**AUTOVERSE** adalah aplikasi mobile berbasis Flutter/Dart yang dirancang khusus bagi komunitas penggemar otomotif (*automotive enthusiasts*). Aplikasi ini menggabungkan pengalaman *social feed* berbasis video vertikal (FYP), integrasi garasi kendaraan modifikasi (*Vehicle Showcase*), eksplorasi suku cadang & komponen (*Marketplace*), serta komunikasi langsung antara calon pembeli dan penjual (*In-App Messaging*).

Aplikasi ini dikembangkan dengan pendekatan arsitektur modular (*feature-driven*), desain bertema *Dark Premium*, dan antarmuka ramah pengguna dalam Bahasa Indonesia untuk keperluan demonstrasi akademik.

---

## 1. Tujuan Aplikasi (*Purpose*)

1. **Wadah Sosial Otomotif:** Memungkinkan pengguna berbagi video build, sound check mesin, dan dokumentasi modifikasi kendaraan secara vertikal 9:16.
2. **Katalog Garasi Terintegrasi:** Menghubungkan setiap postingan modifikasi dengan kendaraan spesifik milik pengguna lengkap dengan spesifikasi teknis dan hotspot interaktif.
3. **Pusat Komponen & Part:** Memfasilitasi jual-beli suku cadang performa tinggi dengan fitur penyesuaian kecocokan kendaraan (*vehicle compatibility*).
4. **Interaksi Kontekstual:** Menyediakan ruang pesan antar-pengguna yang secara otomatis menyertakan kartu referensi produk saat menanyakan barang marketplace.

---

## 2. Teknologi yang Digunakan (*Tech Stack*)

- **Framework:** [Flutter](https://flutter.dev/) (Channel stable, Dart 3.x)
- **Target Platform:** Android (Direkomendasikan API 34+ / Pixel_10a, kompatibel Android 8.0+)
- **State Management:** In-memory reactive state controllers (`ChangeNotifier` / `Listenable`)
- **Video Player:** `video_player: ^2.14.1` dengan integrasi *App Lifecycle* dan jeda audio antar-tab
- **Asset Processing:** H.264 vertical MP4 video playback & photorealistic automotive imagery
- **Testing Framework:** Flutter Test (Unit, Widget, & Cross-Module Integration Tests)
- **UI Design System:** Dark Premium theme (Void Black `#0A0D10`, Steel `#28343F`, Performance Lime `#C7F36B`)

---

## 3. Fitur Utama Aplikasi

| Modul Fitur | Deskripsi Fungsional |
|---|---|
| **Beranda / FYP** | Feed vertikal layar penuh dengan auto-looping video, auto-pause saat beralih tab, kontrol mute/unmute, double-tap untuk suka, dan sheet komentar. |
| **Marketplace** | Katalog komponen otomotif dengan pencarian nama/merek, filter kategori, badge kompatibilitas mobil, dan detail spesifikasi suku cadang. |
| **Buat (Create)** | Modal pembuatan konten terpadu: unggah postingan baru dengan penautan mobil garasi atau buat listing jual suku cadang baru. |
| **Pesan (Messages)** | Daftar obrolan aktif dan ruang chat interaktif lengkap dengan kartu referensi produk (*Product Reference Card*) dan pengiriman pesan instan. |
| **Profil & Garasi** | Profil pengguna dengan ringkasan metrik, daftar mobil di garasi (Porsche 911 GT3, Mazda RX-7 FD3S, Civic Type R FK8), grid postingan dengan view counter, dan tab tersimpan terpusat. |
| **Vehicle Showcase** | Layar inspeksi mobil unggulan dengan 4 hotspot interaktif (Knalpot, Suspensi, Velg, Rem) yang menampilkan modal telemetri dan foto komponen riil. |

---

## 4. Persyaratan Instalasi (*Prerequisites*)

Sebelum menjalankan proyek, pastikan perangkat pengembangan telah terpasang:
- **Flutter SDK:** versi `>=3.0.0`
- **Dart SDK:** versi `>=3.0.0`
- **Android Studio / VS Code** dengan Flutter & Dart plugin
- **Android SDK & Emulator:** Pixel_10a atau perangkat Android fisik dengan mode USB Debugging aktif.

---

## 5. Cara Menjalankan Aplikasi (*Run Project*)

1. **Clone repositori atau buka direktori proyek:**
   ```bash
   cd "C:\Faiz\My project\autoverse"
   ```

2. **Unduh dependensi proyek:**
   ```bash
   flutter pub get
   ```

3. **Jalankan emulator Android:**
   Buka Android Device Manager atau jalankan lewat perintah:
   ```bash
   flutter emulators --launch Pixel_10a
   ```

4. **Jalankan aplikasi:**
   ```bash
   flutter run
   ```

---

## 6. Cara Menjalankan Pengujian Otomatis (*Testing*)

Proyek ini dilengkapi dengan 63 automated test cases mencakup Unit Test, Widget Test, dan E2E Integration Test:

```bash
# Menjalankan seluruh pengujian otomatis
flutter test

# Menjalankan static analysis linting
flutter analyze

# Build debug APK untuk verifikasi Android
flutter build apk --debug
```

**Status Baseline Verifikasi:**
- `flutter analyze`: **0 issues found**
- `flutter test`: **63/63 passed** (100% lolos)
- `flutter build apk --debug`: **Sukses ter-build**

---

## 7. Struktur Direktori Tingkat Tinggi (*High-Level Folder Structure*)

```text
autoverse/
├── android/               # Konfigurasi platform Android & Gradle
├── assets/                # Aset gambar & video runtime aktif
│   ├── images/
│   │   ├── avatars/       # Foto profil / avatar pengguna
│   │   ├── posts/         # Thumbnail statis untuk video postingan
│   │   ├── products/      # Foto suku cadang riil marketplace & showcase
│   │   └── vehicles/      # Foto hero mobil otentik (Porsche, RX-7, Civic FK8)
│   └── videos/
│       └── fyp/           # File video lokal 9:16 untuk feed Beranda
├── docs/                  # Dokumentasi arsitektur dan alur data
│   ├── PROJECT_STRUCTURE.md
│   └── FEATURE_AND_DATA_FLOW.md
├── lib/                   # Seluruh kode sumber aplikasi Dart/Flutter
│   ├── core/              # Tema, palet warna, tipografi, dan konstanta global
│   ├── data/              # Model data dan dummy data terstruktur
│   ├── features/          # Modul fitur (home, marketplace, messages, create, profile, showcase, navigation)
│   └── main.dart          # Entry point aplikasi
├── test/                  # 63 suite pengujian otomatis
└── pubspec.yaml           # Deklarasi dependensi dan aset
```

Untuk rincian tanggung jawab setiap berkas dan folder, silakan baca [docs/PROJECT_STRUCTURE.md](file:///c:/Faiz/My project/autoverse/docs/PROJECT_STRUCTURE.md).

---

## 8. Navigasi & Layar Utama (*Navigation Overview*)

Aplikasi menggunakan `MainShell` dengan `IndexedStack` untuk mempertahankan state di antara 5 destinasi utama pada `GlobalBottomNavBar`:

1. **Beranda (`HomeFypScreen`):** Feed video FYP layar penuh.
2. **Marketplace (`MarketplaceHomeScreen`):** Katalog suku cadang dan filter kompatibilitas.
3. **Tombol Buat (+):** Membuka `CreateActionModal` untuk navigasi ke `CreatePostScreen` atau `CreateListingScreen`.
4. **Pesan (`ConversationsListScreen`):** Daftar percakapan aktif.
5. **Profil (`MyProfileScreen`):** Garasi pribadi, metrik, grid postingan, dan konten tersimpan.

---

## 9. Batasan MVP Saat Ini (*Current MVP Limitations*)

1. **In-Memory State Persistence:** State aplikasi (postingan baru, obrolan, item tersimpan, dan listing produk baru) tersimpan di memori runtime selama aplikasi berjalan. State bertahan saat navigasi antar tab dan rotasi layar, namun akan di-reset saat aplikasi ditutup total (belum terhubung ke database cloud remote seperti Firebase/Supabase).
2. **Media Picker Mocking:** Pemilihan gambar pada layar Buat Postingan dan Buat Listing menggunakan galeri lokal demo (*pre-populated assets*), bukan picker galeri native Android.
3. **Akun Pengguna Tunggal:** Profil yang aktif saat ini berfokus pada persona *Aditya Pratama* (`@aditya_gt3`) sebagai showcase fungsionalitas aplikasi.
