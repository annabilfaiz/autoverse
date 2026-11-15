# AUTOVERSE — FEATURE SPECIFICATION & USER FLOWS
**Document Version:** 1.0.0  
**Target:** Academic Demonstration & Functional Evaluation  

---

## Feature 1: Home / FYP (For You Page)

### 1.1 Purpose
Delivers a fast, full-bleed automotive media experience modeled after enthusiast video/photo reels. Showcases vehicle exhaust sounds, track runs, telemetry recordings, and build progress updates.

### 1.2 Key Capabilities
- **Vertical Reel Swiping:** Implemented with `PageView.builder` (scroll direction: vertical) for smooth 60fps transitions between automotive posts.
- **Creator Context Overlay:** Features creator avatar, display name, handle (`@aditya_gt3`), verified badge, timestamp, post caption, and parsed hashtag pills.
- **Linked Vehicle Tag:** When a post is associated with a specific car, a dedicated chip (e.g. `🏎️ 2023 Porsche 911 GT3`) renders prominently above the caption.
- **Engagement Action Rail:** Right-aligned interactive column supporting:
  - Like button with dynamic heart animation and live counter.
  - Comment trigger opening a draggable bottom sheet with enthusiast discussion.
  - Bookmark/Save toggle with persistent state.
  - Share button with share count.
- **Search Header & Creator Navigation:** Header bar includes top search shortcut (`SearchScreen`) and direct profile link.

---

## Feature 2: Featured Vehicle Showcase

### 2.1 Purpose
Provides an interactive digital showroom for signature automotive builds. Demonstrates detailed aftermarket modifications with interactive visual callout hotspots.

### 2.2 Key Capabilities
- **Hero Stance & Hotspots:** Displays a high-resolution 16:9 vehicle stance (e.g., *2023 Porsche 911 GT3 (992)*) equipped with 4 pulsing callout hotspots positioned precisely over modified components:
  1. `Akrapovič Evolution Line Titanium Exhaust` (rear bumper)
  2. `BBS FI-R Forged Monobloc 20" Wheels` (wheel hub)
  3. `KW Variant 4 3-Way Adjustable Coilovers` (suspension assembly)
  4. `Brembo GT-R Billet Monobloc Big Brake Kit` (front caliper)
- **Component Inspection Modal:** Tapping any hotspot opens a Dark Premium bottom sheet with full engineering specs, material composition, retail pricing (in IDR), and verified fitment data.
- **Telemetry & Technical Specs:** Comprehensive performance grid detailing Engine (`4.0L Naturally Aspirated Flat-6`), Power (`510 HP @ 8,400 RPM`), Torque (`470 Nm`), 0-100 km/h (`3.4 sec`), Top Speed (`318 km/h`), and Kerb Weight (`1,435 kg`).
- **Verified Build Updates:** Filtered reel of recent track telemetry, oil analyses, and dyno sessions tagged specifically to this vehicle.

---

## Feature 3: My Profile & Virtual Garage

### 3.1 Purpose
Serves as the builder's identity hub, displaying reputation badges, track records, vehicle ownership history, and published content.

### 3.2 Key Capabilities
- **Enthusiast Header:** High-resolution garage banner, profile avatar, verified enthusiast badge, bio (`Porsche track enthusiast | Sentul Circuit regular`), and verified builder stats:
  - `Posts`: Dynamic count reflecting seed plus newly published posts.
  - `Followers`: `14.2K`
  - `Following`: `382`
  - `Track Days`: `48 Sessions`
- **Virtual Garage Carousel:** Horizontally scrollable collection of vehicles in the user's stable:
  - *2023 Porsche 911 GT3 (992)* — Status: `Active Build`
  - *1997 Mazda RX-7 (FD3S)* — Status: `Track Ready`
  - *2023 Honda Civic Type R (FL5)* — Status: `Daily Driver`
  - Direct *"View Showcase"* action button seamlessly opening the showcase module.
- **3-Tab Content Switcher:**
  1. `Posts`: Staggered 3-column media grid. Tapping any post opens the `ProfilePostDetailModal`.
  2. `Builds`: Tabular inventory of ongoing modification projects with completion percentages.
  3. `Saved`: Curated wishlist of bookmarked performance parts from the Marketplace.

---

## Feature 4: Enthusiast Marketplace

### 4.1 Purpose
A curated aftermarket exchange for automotive components, racing equipment, wheels, and aerodynamic upgrades with built-in vehicle compatibility verification.

### 4.2 Key Capabilities
- **Category Filter Rail:** Instant category switching between `All Parts`, `Exhaust`, `Wheels`, `Suspension`, `Brakes`, and `Engine`.
- **Real-Time Catalog Search:** Instant client-side filtering matching part names, manufacturers (e.g. *Akrapovič*, *BBS*, *KW*), and vehicle models.
- **Sorting Engine:** Dynamic sorting by `Price: Low to High`, `Price: High to Low`, and `Newest Arrivals`.
- **Product Card Architecture:** Dark Carbon card with high-resolution product imagery, verified price in Indonesian Rupiah (`Rp 45.000.000`), seller badge, compatibility pill, and quick wishlist toggle.
- **Product Detail View:** In-depth product view featuring seller reputation badges, delivery assurances, technical specifications table, vehicle compatibility matrix, and a prominent *"Chat Seller"* call to action.

---

## Feature 5: Create Listing

### 5.1 Purpose
Empowers individual builders and specialty speed shops to list performance parts for sale directly within the application.

### 5.2 Key Capabilities
- **Seller Flow Entry:** Accessible from the global `CreateActionModal` by selecting *"Sell Part / Create Listing"*.
- **Comprehensive Listing Form:**
  - Part title, category dropdown, manufacturer brand, and condition selector (`Brand New` / `Lightly Used` / `Track Tested`).
  - Price entry in Indonesian Rupiah (IDR).
  - Compatible vehicle tags input.
  - Technical description and fitment notes.
- **Immediate Catalog Sync:** Upon submission, the new part is added directly to `MarketplaceController` and appears instantly at the top of the Marketplace catalog and in category filters.

---

## Feature 6: In-App Messaging & Seller Handoff

### 6.1 Purpose
Enables real-time communication between prospective parts buyers and sellers with automatic product listing context.

### 6.2 Key Capabilities
- **Conversations List Screen:** Clean list of active threads displaying participant avatar with online indicator, verified checkmark, last message preview, unread indicator badge, and a distinctive **Marketplace Product Chip** when a chat is linked to a listing.
- **Seller Handoff:** Tapping *"Chat Seller"* on any Marketplace product detail screen automatically opens or creates a thread with that seller.
- **Pinned Product Reference Card:** The top of the chat room features a sticky reference card displaying the part thumbnail, title, price, and a *"View Part"* button to inspect listing details without losing conversation state.
- **Chat Room Composer:** Asymmetric Dark Premium chat bubbles with delivery timestamps, double-check delivery indicators, auto-scroll behavior, and strict validation against empty submissions.

---

## Feature 7: Create Post & Garage Vehicle Integration

### 7.1 Purpose
Allows enthusiasts to capture build updates, track logs, and modifications, directly linking them to a specific car in their virtual garage.

### 7.2 Key Capabilities
- **Curated Media Selector:** High-resolution preview with optional selection from the user's automotive photo library.
- **Caption Composer:** Multiline text field with real-time character count (`0 / 500`) and automatic regex extraction of automotive hashtags (e.g., `#Porsche`, `#GT3`, `#TrackDay`).
- **Garage Vehicle Linking:** Optional selector populating owned cars from `VehiclesData.getAdityaGarageVehicles()`. Selecting a vehicle highlights the card in Performance Lime.
- **Cross-Module Publishing:** Publishing updates `FeedController` in real time:
  - Post is immediately visible at the top of Home FYP.
  - Linked vehicle badge appears on the post card.
  - Post is reflected in the user's Profile post count and Profile media grid.
  - Post appears under the *Verified Build Updates* section of the linked vehicle's showcase.
