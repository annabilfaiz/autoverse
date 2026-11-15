# AUTOVERSE — ARSITEKTUR & STRUKTUR KODE SUMBER

Dokumen ini menjelaskan struktur direktori, tanggung jawab setiap modul, dan pemisahan arsitektur dalam repositori **AUTOVERSE**.

---

## 1. Peta Direktori Kode Sumber (`lib/`)

```text
lib/
├── main.dart                                           # Titik masuk utama aplikasi (Application Entry Point)
│
├── core/                                               # Fondasi aplikasi & konfigurasi global
│   └── theme/
│       ├── app_colors.dart                             # Definisi token warna Dark Premium
│       ├── app_theme.dart                              # Konfigurasi ThemeData (Colors, Typography, Components)
│       └── app_typography.dart                         # Definisi gaya teks TextStyle & font Inter
│
├── data/                                               # Lapisan data (Models & Dummy Content)
│   ├── dummy_data.dart                                 # Seed data feed postingan & komentar
│   ├── marketplace_data.dart                           # Seed data katalog suku cadang marketplace
│   ├── messages_data.dart                              # Seed data percakapan & riwayat chat
│   ├── vehicles_data.dart                              # Seed data garasi & mobil showcase
│   └── models/                                         # Definisi entitas data aplikasi
│       ├── comment_model.dart                          # Model data komentar postingan
│       ├── conversation_model.dart                     # Model data percakapan obrolan
│       ├── message_model.dart                          # Model data pesan tunggal dalam chat
│       ├── post_model.dart                             # Model data postingan sosial & video feed
│       ├── product_model.dart                          # Model data produk marketplace
│       └── vehicle_model.dart                          # Model data kendaraan garasi & modifikasi
│
└── features/                                           # Lapisan fitur (Feature-Driven Modules)
    ├── navigation/                                     # Navigasi shell utama & bottom bar
    │   └── presentation/
    │       ├── main_shell.dart                         # Shell 5 tab persisten dengan IndexedStack
    │       └── widgets/
    │           ├── create_action_modal.dart            # Modal pilihan pembuatan konten (Post / Listing)
    │           └── global_bottom_nav_bar.dart          # Bar navigasi bawah 5 destinasi
    │
    ├── home/                                           # Fitur Beranda / FYP Feed
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   ├── home_fyp_screen.dart                # Layar feed FYP dengan PageView vertikal
    │   │   │   └── search_screen.dart                  # Layar pencarian feed & tag
    │   │   └── widgets/
    │   │       ├── comments_bottom_sheet.dart          # Bottom sheet daftar komentar & form kirim
    │   │       ├── content_overlay.dart                # Overlay teks caption, tag, profil kreator
    │   │       ├── right_action_rail.dart              # Tombol aksi samping (Suka, Komentar, Simpan, Bagikan)
    │   │       └── video_feed_item.dart                # Komponen pemutar video vertikal 9:16 + audio
    │   └── state/
    │       └── feed_controller.dart                    # Controller state feed, like, save, dan posting baru
    │
    ├── marketplace/                                    # Fitur Pasar Suku Cadang
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   ├── create_listing_screen.dart          # Formulir pasang iklan suku cadang baru
    │   │   │   ├── marketplace_home_screen.dart        # Layar katalog marketplace & filter
    │   │   │   └── product_detail_screen.dart          # Layar detail produk, spesifikasi & aksi chat
    │   │   └── widgets/
    │   │       ├── marketplace_category_chip.dart      # Chip kategori horizontal
    │   │       ├── marketplace_featured_card.dart      # Kartu banner produk unggulan
    │   │       ├── marketplace_filter_panel.dart       # Panel filter harga & kompatibilitas
    │   │       └── marketplace_product_card.dart       # Kartu grid produk marketplace
    │   └── state/
    │       └── marketplace_controller.dart             # Controller filter kategori, cari, & listing baru
    │
    ├── messages/                                       # Fitur Pesan & Chat Kontekstual
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   ├── chat_room_screen.dart               # Layar ruang obrolan dengan penjual/user
    │   │   │   └── conversations_list_screen.dart      # Layar daftar riwayat percakapan
    │   │   └── widgets/
    │   │       ├── chat_message_bubble.dart            # Bubble pesan (masuk & keluar)
    │   │       ├── chat_message_composer.dart          # Bar input teks pesan & tombol kirim
    │   │       ├── conversation_list_tile.dart         # Tile daftar percakapan
    │   │       └── product_reference_card.dart         # Kartu konteks produk di atas obrolan
    │   └── state/
    │       └── messages_controller.dart                # Controller riwayat chat & pengiriman pesan
    │
    ├── create/                                         # Fitur Pembuatan Postingan Baru
    │   └── presentation/
    │       ├── screens/
    │       │   └── create_post_screen.dart             # Layar form postingan baru & tautan kendaraan
    │       └── widgets/
    │           ├── create_post_media_picker.dart       # Pemilih media/video demo
    │           └── create_post_vehicle_selector.dart   # Dropdown pemilih mobil dari garasi
    │
    ├── profile/                                        # Fitur Profil Pengguna & Koleksi Tersimpan
    │   ├── presentation/
    │   │   ├── screens/
    │   │   │   └── my_profile_screen.dart              # Layar profil utama Aditya Pratama
    │   │   └── widgets/
    │   │       ├── profile_garage_section.dart         # Kartu mobil unggulan & daftar mobil garasi
    │   │       ├── profile_header_section.dart         # Header avatar, nama, bio, & angka statistik
    │   │       ├── profile_post_detail_modal.dart      # Modal preview postingan dari grid
    │   │       └── profile_tabs_section.dart           # Tab bar (Postingan, Tersimpan, Disukai)
    │   └── state/
    │       └── saved_items_controller.dart             # Controller item tersimpan (Post, Produk, Mobil)
    │
    └── showcase/                                       # Fitur Vehicle Showcase Interaktif
        └── presentation/
            ├── screens/
            │   └── featured_vehicle_showcase_screen.dart # Layar inspeksi modifikasi mobil interaktif
            └── widgets/
                ├── component_detail_modal.dart         # Modal spesifikasi telemetri & foto komponen
                ├── showcase_build_posts_section.dart   # Postingan komunitas terkait kendaraan ini
                ├── showcase_hero_section.dart          # Hero foto mobil dengan 4 hotspot interaktif
                └── showcase_specs_inventory.dart       # Daftar part modifikasi terpasang
```

---

## 2. Titik Masuk Aplikasi (`lib/main.dart`)

Berkas `main.dart` bertindak sebagai *entry point* tunggal:
1. Menginisialisasi `WidgetsFlutterBinding.ensureInitialized()`.
2. Mendaftarkan controller bersama di level aplikasi (`FeedController`, `MarketplaceController`, `MessagesController`, `SavedItemsController`) sehingga data tetap bertahan antar-layar.
3. Mengaplikasikan tema gelap kustom `AppTheme.darkTheme`.
4. Merender `MainShell` sebagai layar dasar navigasi.

---

## 3. Tanggung Jawab Direktori `core/`

Folder `core/` hanya memuat aset dan konfigurasi yang digunakan secara lintas-fitur:
- **`app_colors.dart`:** Menstandarkan palet warna Dark Premium:
  - `voidBlack` (`#0A0D10`): Latar belakang utama.
  - `carbon` (`#11171D`): Latar belakang kartu dan bottom sheet.
  - `graphite` (`#192129`): Elemen sekunder dan input field.
  - `steel` (`#28343F`): Border pembatas dan garis pemisah.
  - `accentLime` (`#C7F36B`): Warna aksen interaksi utama.
- **`app_typography.dart`:** Konfigurasi hierarki teks berbasis font *Inter*.
- **`app_theme.dart`:** Konfigurasi menyeluruh untuk `MaterialApp` theme.

---

## 4. Lapisan Data & Dummy (`lib/data/`)

Semua data demo dan model entitas diisolasi dari komponen antarmuka pengguna:
- **`models/`:** Berisi kelas data Dart immutable dengan constructor, method `copyWith()`, serta representasi atribut yang konsisten.
- **Data Dummy:**
  - `dummy_data.dart`: 3 postingan awal dengan video vertikal 9:16 dan komentar.
  - `vehicles_data.dart`: 3 kendaraan otentik (Porsche 911 GT3, Mazda RX-7 FD3S, Honda Civic Type R FK8).
  - `marketplace_data.dart`: 8 listing produk suku cadang otomotif.
  - `messages_data.dart`: 4 utas percakapan pesan.

---

## 5. Kepemilikan State & Controller

Aplikasi tidak menggunakan framework state pihak ketiga yang rumit, melainkan memanfaatkan reactive pattern bawaan Flutter (`ChangeNotifier`):

| Controller | Lokasi File | Tanggung Jawab State |
|---|---|---|
| `FeedController` | `lib/features/home/state/feed_controller.dart` | Mengelola daftar postingan FYP, status Suka, status Simpan, dan penambahan postingan baru dari modul Buat. |
| `MarketplaceController` | `lib/features/marketplace/state/marketplace_controller.dart` | Mengelola filter kategori, kata kunci pencarian produk, serta penambahan listing produk baru. |
| `MessagesController` | `lib/features/messages/state/messages_controller.dart` | Mengelola daftar percakapan, pembuatan percakapan baru dari tombol "Chat Seller", dan pengiriman pesan. |
| `SavedItemsController` | `lib/features/profile/state/saved_items_controller.dart` | Mengelola repositori terpusat untuk item yang disimpan pengguna (Postingan, Produk, dan Kendaraan). |

---

## 6. Penyimpanan Aset Gambar & Video (`assets/`)

Struktur folder aset dirapikan secara ketat agar hanya memuat file yang aktif digunakan:

```text
assets/
├── images/
│   ├── avatars/
│   │   └── avatar_aditya.png                           # Avatar Aditya Pratama (256x256)
│   ├── posts/
│   │   └── video_thumbnail/
│   │       ├── post_civic_fk8_thumbnail.jpg            # Frame poster video Civic FK8 Sentul
│   │       ├── post_mazda_rx7_thumbnail.jpg            # Frame poster video Mazda RX-7 workshop
│   │       └── post_porsche_gt3_thumbnail.jpg          # Frame poster video Porsche GT3 tunnel
│   ├── products/
│   │   ├── product_carbon_ceramic_brake.jpg            # Foto kit rem Carbon-Ceramic Big Brake Kit
│   │   ├── product_forged_wheel.jpg                    # Foto velg BBS FI-R monoblock
│   │   ├── product_performance_coilover.jpg            # Foto coilover ClubSport spec (yellow spring/purple collar)
│   │   ├── product_placeholder.jpg                     # Placeholder netral suku cadang tanpa foto khusus
│   │   └── product_titanium_exhaust.jpg                # Foto knalpot Akrapovic Titanium
│   └── vehicles/
│       ├── vehicle_honda_civic_type_r_fk8_hero.jpg     # Foto otentik Civic Type R FK8 putih
│       ├── vehicle_mazda_rx7_fd3s_hero.jpg             # Foto otentik Mazda RX-7 FD3S biru
│       └── vehicle_porsche_911_gt3_hero.jpg            # Foto otentik Porsche 911 GT3 hitam
└── videos/
    └── fyp/
        ├── fyp_civic_fk8_trackday.mp4                  # Video 9:16 Civic FK8 di sirkuit (10s, 720x1280)
        ├── fyp_mazda_rotary_idle.mp4                   # Video 9:16 RX-7 flames di bengkel (10s, 720x1280)
        └── fyp_porsche_gt3_tunnel.mp4                  # Video 9:16 Porsche GT3 tunnel drive (10s, 720x1280)
```

Seluruh 15 aset di atas didaftarkan di bagian `flutter.assets` pada `pubspec.yaml`.
Semua file sementara (*inbox* dan tangkapan layar eksperimental) telah dieliminasi dari repositori runtime.
