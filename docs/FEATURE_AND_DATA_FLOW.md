# AUTOVERSE — ALUR FITUR & DATA (FEATURE & DATA FLOW)

Dokumen ini menjelaskan alur interaksi pengguna (*user interaction flows*) dan propagasi data antar-modul pada aplikasi **AUTOVERSE**.

---

## 1. Alur Pemutaran Video FYP & Siklus Hidup (*Video Playback & Lifecycle Flow*)

```text
[MainShell (Tab Index 0: Beranda)]
            │
            ▼
   [HomeFypScreen] ─── PageView.builder (Vertical Swipe)
            │
            ├── isCurrentPost (true jika index cocok dengan post aktif)
            ├── isActiveTab (true jika MainShell berada di tab Beranda)
            │
            ▼
    [VideoFeedItem]
            │
            ├── Inisialisasi VideoPlayerController.asset(videoAsset)
            ├── Loop pemutaran aktif (setLooping(true))
            │
            ├── Event: Pengguna beralih ke tab Marketplace / Pesan
            │     └─► isActiveTab = false ──► controller.pause() (Audio & video berhenti)
            │
            ├── Event: Pengguna kembali ke tab Beranda
            │     └─► isActiveTab = true  ──► controller.play() (Otomatis melanjutkan)
            │
            ├── Event: Aplikasi di-minimize (didChangeAppLifecycleState)
            │     └─► AppLifecycleState.paused ──► controller.pause()
            │
            ├── Interaksi Tap 1x: Toggle play/pause manual (muncul ikon indikator di tengah)
            └── Interaksi Tap 2x: Trigger suka/like postingan (animasi ikon hati melayang)
```

**Karakteristik Kode:**
- Menggunakan `WidgetsBindingObserver` di `_VideoFeedItemState` untuk mendeteksi siklus hidup aplikasi (*AppLifecycleState*).
- Indikator mute/unmute melayang di kanan atas layar FYP mengontrol volume pemutar video (`setVolume(0.0)` vs `setVolume(1.0)`).

---

## 2. Alur Interaksi Sosial FYP (Suka, Simpan, Komentar, Ikuti)

```text
[RightActionRail]
   │
   ├── Tombol Suka (Heart Icon):
   │     └─► FeedController.toggleLike(postId)
   │           ├─► Memperbarui post.isLiked & post.likeCount
   │           └─► notifyListeners() ──► UI Beranda ter-update seketika
   │
   ├── Tombol Simpan (Bookmark Icon):
   │     └─► FeedController.toggleSave(postId)
   │           ├─► Memperbarui post.isSaved & post.saveCount
   │           ├─► Menyinkronkan ke SavedItemsController.toggleSavePost(post)
   │           └─► Postingan langsung muncul di Tab "Tersimpan" Profil Pengguna
   │
   ├── Tombol Komentar (Chat Bubble Icon):
   │     └─► showModalBottomSheet(CommentsBottomSheet)
   │           ├─► Menampilkan daftar komentar riil
   │           └─► Pengguna mengetik & kirim ──► FeedController.addComment(postId, newComment)
   │
   └── Tombol Ikuti (Follow Button):
         └─► FeedController.toggleFollow(postId)
               └─► Memperbarui creator.isFollowing pada feed
```

---

## 3. Alur Publikasi Postingan Baru (*Create Post to Feed, Profile, & Showcase*)

```text
1. [GlobalBottomNavBar] (+) 
       └─► Muncul [CreateActionModal] (Pilih "Buat Postingan")
               └─► Navigasi ke [CreatePostScreen]

2. Pengguna mengisi formulir di [CreatePostScreen]:
       ├── Memilih media / video dari galeri demo
       ├── Mengetik teks caption & hashtag
       └── Memilih mobil dari garasi (misal: "2022 Porsche 911 GT3")

3. Menekan tombol "Publikasikan":
       │
       ▼
   PostModel baru dibuat dengan:
       - id: unik (timestamp)
       - authorUsername: '@aditya_gt3'
       - linkedVehicleId: 'veh_porsche_gt3'
       - mediaAsset & videoAsset
       │
       ▼
   FeedController.addPost(newPost)
       ├─► Post ditambahkan ke posisi teratas allPosts ([0])
       ├─► authorPostCount bertambah (+1)
       └─► notifyListeners()

4. Dampak Propagasi Lintas-Modul:
       ├── Layar Beranda (FYP): Post baru langsung tampil sebagai item pertama di feed.
       ├── Layar Profil: Angka "Postingan" bertambah dan item muncul di baris awal Grid.
       └── Layar Showcase: Post baru muncul di bagian "Build Updates" kendaraan Porsche.
```

---

## 4. Alur Marketplace ke Komunikasi Penjual (*Product Detail to Chat*)

```text
[MarketplaceHomeScreen]
   │
   ├── Filter kategori suku cadang (Semua, Mesin, Knalpot, Suspensi, Rem, Eksterior)
   ├── Pencarian teks (berdasarkan nama produk atau merk)
   └── Klik kartu produk [MarketplaceProductCard]
         │
         ▼
[ProductDetailScreen]
   ├── Menampilkan spesifikasi teknis lengkap & kecocokan kendaraan
   ├── Tombol "Simpan Produk" ──► SavedItemsController.toggleSaveProduct(product)
   └── Tombol "Hubungi Penjual" (Chat Seller):
         │
         ▼
     MessagesController.getOrCreateConversationForProduct(
         sellerUsername: product.sellerUsername,
         product: product
     )
         │
         ▼
     Navigasi langsung ke [ChatRoomScreen]:
         ├── Menampilkan [ProductReferenceCard] di atas percakapan
         │     (Foto thumbnail produk, nama suku cadang, dan harga IDR)
         └── Mengirim pesan inkuiri pembeli secara instan ke penjual
```

---

## 5. Alur Sistem Konten Tersimpan Terpusat (*Saved Items System*)

Sistem penyimpanan terpadu dikelola oleh `SavedItemsController` dan disajikan dalam `MyProfileScreen`:

```text
                     [SavedItemsController]
                         (State Manager)
                                ▲
       ┌────────────────────────┼────────────────────────┐
       │                        │                        │
[Simpan di FYP]       [Simpan di Marketplace]   [Simpan di Showcase]
(Bookmark Postingan)      (Bookmark Produk)      (Bookmark Kendaraan)
       │                        │                        │
       ▼                        ▼                        ▼
savedPosts (List)       savedProducts (List)    savedVehicles (List)
       │                        │                        │
       └────────────────────────┼────────────────────────┘
                                │
                                ▼
         [MyProfileScreen ──► Tab "Tersimpan"]
                                │
                 Segmented Chip Selector:
      ┌─────────────────────────┼─────────────────────────┐
      ▼                         ▼                         ▼
[Postingan (n)]          [Marketplace (n)]         [Kendaraan (n)]
Menampilkan grid         Menampilkan daftar        Menampilkan kartu
thumbnail video          produk tersimpan          mobil tersimpan
```

---

## 6. Alur Inspeksi Komponen *Vehicle Showcase*

```text
[FeaturedVehicleShowcaseScreen] (Porsche 911 GT3)
   │
   ├── [ShowcaseHeroSection]:
   │     Menampilkan foto mobil sudut 3/4 dengan 4 hotspot interaktif:
   │     ├── Hotspot 1: Knalpot (Exhaust)
   │     ├── Hotspot 2: Suspensi (Coilovers)
   │     ├── Hotspot 3: Velg (Wheels)
   │     └── Hotspot 4: Rem (Carbon Ceramic Brakes)
   │
   └── Klik pada salah satu Hotspot:
         │
         ▼
     Membuka [ComponentDetailModal]:
         ├── Banner foto komponen suku cadang riil
         ├── Nama spesifikasi dan merek modifikasi
         ├── Metrik telemetri (Tenaga, Bobot, Damping, Suhu Kerja)
         └── Tombol "Lihat di Marketplace" untuk menemukan suku cadang terkait
```
