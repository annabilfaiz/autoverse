# AUTOVERSE — PROJECT STRUCTURE & SOURCE CODE INVENTORY
**Document Version:** 1.0.0  
**Target:** Academic Software Evaluation & Code Review  

---

## 1. Architectural Directory Layout

The AutoVerse Flutter project follows a **Feature-Driven Clean Architecture** pattern. Code is grouped primarily by functional domain (features), while shared foundational logic (theme, tokens, global models, and seed repositories) is consolidated in `core/` and `data/`.

```
autoverse/
├── android/                         # Native Android project configuration & Gradle scripts
├── assets/
│   └── images/                      # Curated automotive photos & enthusiast profile avatars
├── docs/                            # Documentation repository
│   ├── archive/                     # Preserved legacy sprint reports & historical test logs
│   ├── assets/
│   │   └── final_qa/                # Verified high-resolution emulator screenshots (Sprint 05)
│   ├── final_submission/            # Academic review documents (this folder)
│   └── asset_generation_manifest.md # Gemini AI image generation specifications
├── lib/
│   ├── core/                        # Design tokens, theme definition, and typography
│   │   └── theme/
│   │       ├── app_colors.dart      # Dark Premium color palette constants
│   │       ├── app_theme.dart       # Global ThemeData configuration
│   │       └── app_typography.dart  # Inter font styles & text hierarchy
│   ├── data/                        # Seed data repositories and data contracts
│   │   ├── models/                  # Immutable entity definitions
│   │   │   ├── comment_model.dart
│   │   │   ├── conversation_model.dart
│   │   │   ├── message_model.dart
│   │   │   ├── post_model.dart
│   │   │   ├── product_model.dart
│   │   │   └── vehicle_model.dart
│   │   ├── dummy_data.dart          # FYP initial feed seed items
│   │   ├── marketplace_data.dart    # Performance parts inventory
│   │   ├── messages_data.dart       # Seed direct messages & seller chats
│   │   └── vehicles_data.dart       # Aditya's garage & showcase vehicles
│   ├── features/                    # Domain-isolated functional modules
│   │   ├── create/                  # Create Post module
│   │   ├── home/                    # Home FYP short-form automotive feed & search
│   │   ├── marketplace/             # Marketplace, Product Detail, Create Listing
│   │   ├── messages/                # Conversation List, Chat Room, Product Context
│   │   ├── navigation/              # 5-position bottom navigation shell
│   │   ├── profile/                 # My Profile, Garage carousel, 3-tab content
│   │   └── showcase/                # Featured Vehicle Showcase with interactive hotspots
│   └── main.dart                    # Application entry point
├── test/                            # Comprehensive automated test suites (44 tests)
│   ├── create_post_test.dart        # 14 tests for post creation & cross-module linking
│   ├── final_integration_test.dart  # 6 full end-to-end integration tests
│   ├── marketplace_test.dart        # 12 marketplace unit & widget tests
│   ├── messages_test.dart           # 11 messaging controller & widget tests
│   └── widget_test.dart             # Smoke test
├── pubspec.yaml                     # Dependencies & asset declarations
└── analysis_options.yaml            # Strict linter rules (flutter_lints)
```

---

## 2. Feature Modularity & File Inventory

To ensure clean code maintenance and adhere to Single Responsibility Principles (SRP), all monolithic screens were refactored into modular, dedicated presentation widgets:

### 2.1 Navigation Module (`lib/features/navigation/`)
- `presentation/main_shell.dart` *(125 lines)*: Root persistent tab controller managing 5-position `IndexedStack` (Home, Marketplace, Create, Messages, Profile).
- `presentation/widgets/global_bottom_nav_bar.dart` *(108 lines)*: Custom Dark Premium bottom navigation bar with elevated active indicator and prominent Performance Lime action button.
- `presentation/widgets/create_action_modal.dart` *(98 lines)*: Bottom action sheet offering choices between "New Post / Build Update" and "Sell Part / Create Listing".

### 2.2 Home / FYP Module (`lib/features/home/`)
- `presentation/screens/home_fyp_screen.dart` *(310 lines)*: PageView vertical reel feed with autoplay simulation and dynamic creator badge.
- `presentation/screens/search_screen.dart` *(260 lines)*: Real-time enthusiast search screen supporting vehicle, builder, and part queries.
- `presentation/widgets/video_feed_item.dart`: Single feed video/photo container with dark gradient overlays.
- `presentation/widgets/content_overlay.dart`: Creator username, verified badge, caption, hashtags, and vehicle link tag.
- `presentation/widgets/right_action_rail.dart`: Interactive action rail (Like with count, Comment sheet trigger, Bookmark/Save, Share counter).
- `presentation/widgets/comments_bottom_sheet.dart`: Draggable modal sheet for reading and submitting enthusiast comments.
- `state/feed_controller.dart`: Reactive controller managing feed items, likes, saves, comments, and author post counts.

### 2.3 Showcase Module (`lib/features/showcase/`)
- `presentation/screens/featured_vehicle_showcase_screen.dart` *(235 lines)*: Master vehicle showcase container.
- `presentation/widgets/showcase_hero_section.dart` *(142 lines)*: 16:9 vehicle hero image with 4 interactive pulsing hotspots (`Akrapovič Exhaust`, `BBS Wheels`, `KW V4 Suspension`, `Brembo Brakes`).
- `presentation/widgets/component_detail_modal.dart` *(165 lines)*: Bottom modal sheet displaying detailed component specifications, price, and fitment info when a hotspot is tapped.
- `presentation/widgets/showcase_specs_inventory.dart` *(152 lines)*: Technical telemetry grid (Engine, Power, Torque, 0-100 km/h, Drivetrain, Weight) and aftermarket parts manifest.
- `presentation/widgets/showcase_build_posts_section.dart` *(138 lines)*: Verified build updates and track-day log entries associated specifically with this vehicle.

### 2.4 Profile Module (`lib/features/profile/`)
- `presentation/screens/my_profile_screen.dart` *(98 lines)*: Master profile screen coordinating header, garage, and content tabs.
- `presentation/widgets/profile_header_section.dart` *(165 lines)*: Profile banner, avatar, verified tag, bio, and key metrics (Posts, Followers, Following, Track Days).
- `presentation/widgets/profile_garage_section.dart` *(140 lines)*: Horizontal garage carousel displaying owned vehicles with active status pills.
- `presentation/widgets/profile_tabs_section.dart` *(190 lines)*: 3-tab content switcher (Posts grid, Builds inventory, Saved parts) with smooth state management.
- `presentation/widgets/profile_post_detail_modal.dart` *(155 lines)*: Full-screen post detail viewer when tapping any item in the profile grid.

### 2.5 Marketplace Module (`lib/features/marketplace/`)
- `presentation/screens/marketplace_home_screen.dart` *(345 lines)*: Catalog browser with search header, category chips, featured carousel, and products grid.
- `presentation/screens/product_detail_screen.dart` *(410 lines)*: Comprehensive part detail page with specifications table, seller profile, and "Chat Seller" handoff.
- `presentation/screens/create_listing_screen.dart` *(380 lines)*: Modal flow for listing parts with price, category, condition, and vehicle compatibility.
- `presentation/widgets/marketplace_category_chip.dart` *(65 lines)*: Interactive category filter pill.
- `presentation/widgets/marketplace_filter_panel.dart` *(110 lines)*: Category and sort option bottom sheet selector.
- `presentation/widgets/marketplace_featured_card.dart` *(120 lines)*: Highlighted banner card for high-demand performance items.
- `presentation/widgets/marketplace_product_card.dart` *(135 lines)*: Staggered grid card displaying part image, price in IDR, compatibility badge, and wishlist toggle.
- `state/marketplace_controller.dart`: Reactive controller managing search query, category filter, sort order, wishlist items, and new listings.

### 2.6 Create Post Module (`lib/features/create/`)
- `presentation/screens/create_post_screen.dart` *(272 lines)*: Clean post authoring view.
- `presentation/widgets/create_post_media_picker.dart` *(175 lines)*: Media preview container with photo badge and horizontal thumbnail strip.
- `presentation/widgets/create_post_vehicle_selector.dart` *(145 lines)*: Radio-style vehicle linking selector populated from Aditya's garage.

### 2.7 Messages Module (`lib/features/messages/`)
- `presentation/screens/conversations_list_screen.dart` *(204 lines)*: Active message threads with search filter and unread counter.
- `presentation/screens/chat_room_screen.dart` *(284 lines)*: Two-way message thread with pinned product context card.
- `presentation/widgets/conversation_list_tile.dart` *(180 lines)*: Clean conversation item tile with online status, product chip, and unread pill.
- `presentation/widgets/chat_message_bubble.dart` *(115 lines)*: Asymmetric Dark Premium chat bubble with timestamp and delivery ticks.
- `presentation/widgets/chat_message_composer.dart` *(95 lines)*: Integrated message input bar with auto-scroll and send action.
- `presentation/widgets/product_reference_card.dart` *(110 lines)*: Pinned header card showing part photo, title, price, and "View Part" navigation.
- `state/messages_controller.dart`: Reactive controller managing conversation threads, unread counters, message dispatch, and seller conversation creation.

---

## 3. Code Maintainability & Quality Metrics

1. **Zero Over-sized Files:** No source file exceeds 410 lines; primary screens average 180–300 lines.
2. **Zero Analyzer Warnings:** Project passes `flutter analyze` with 0 errors, 0 warnings, and 0 linter hints.
3. **100% Test Coverage on Core Flows:** 44 automated tests verify every user journey from state changes to widget interactions.
4. **Encapsulated State:** Controllers never expose mutable internal lists; mutations occur via explicit methods (`addPost`, `sendMessage`, `addListing`, `toggleWishlist`).
