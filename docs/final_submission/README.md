# AUTOVERSE — Automotive Enthusiast & Performance Marketplace

**Project Title:** AutoVerse Mobile Application  
**Target Platform:** Android (Google Pixel / AOSP) & iOS  
**Framework:** Flutter 3.x / Dart 3.x  
**Academic Context:** Capstone / Software Engineering Project Demonstration  
**Verification Status:** 100% Passing Automated Tests (44/44), 0 Analyzer Issues, Emulator Verified  

---

## 1. Project Overview

AutoVerse is a specialized mobile platform designed specifically for automotive enthusiasts, track-day drivers, custom car builders, and performance parts collectors. Combining short-form vertical automotive media, interactive vehicle build showcases with hotspot telemetry, a dedicated aftermarket marketplace, and direct peer-to-peer enthusiast messaging, AutoVerse unifies the fragmented car culture ecosystem into a cohesive, high-performance mobile application.

### Key Value Propositions
- **Home / FYP:** Immersive vertical automotive video and photo reel feed with creator interactions, telemetry tags, and comments.
- **Featured Vehicle Showcase:** Deep-dive interactive vehicle build profiles featuring tappable component hotspots (`Akrapovič Titanium Exhaust`, `BBS FI-R Wheels`, `KW V4 Coilovers`, `Brembo Brakes`), full technical specs, and verified build posts.
- **My Profile & Virtual Garage:** Personal builder profile with active garage collection carousel, metric counters (Posts, Followers, Track Days), 3-tab content grid (Posts, Builds, Saved), and full post inspection modal.
- **Enthusiast Marketplace:** Verified aftermarket parts exchange with category shortcuts, real-time search, price/newest sorting, vehicle compatibility badges, and integrated listing creation.
- **In-App Messaging & Seller Handoff:** Direct conversations with enthusiast sellers featuring automatic marketplace product context cards, unread badges, and responsive message threads.
- **Create Post & Build Linking:** Intuitive post composer allowing creators to link updates directly to vehicles in their garage, propagating content instantly across FYP, Showcase, and Profile.

---

## 2. Visual Identity — Dark Premium

AutoVerse adheres strictly to a purposeful **Dark Premium** automotive design system tailored for OLED mobile displays and evening garage/track-side usage:
- **Void Black (`#0A0D10`):** Core application backdrop, offering deep blacks and minimal battery draw on OLED screens.
- **Carbon (`#11171D`):** Primary elevated surface for cards, navigation bars, bottom sheets, and app bars.
- **Graphite (`#192129`):** Secondary container surface for search bars, chips, and unselected elements.
- **Steel (`#28343F`):** Subtle border delineations, dividers, and structural outlines (never harsh light borders).
- **Performance Lime (`#C7F36B`):** Signature high-visibility racing accent for call-to-actions, verified badges, active tabs, and unread alerts.
- **Ice White (`#F4F6F2`):** Crisp high-contrast primary typography.
- **Titanium (`#A0AAB4`) & Muted Steel (`#687582`):** Balanced secondary and metadata typography.

---

## 3. Technology Stack & Prerequisites

- **Language:** Dart 3.x (`sdk: ^3.13.5`)
- **UI Toolkit:** Flutter 3.x
- **State Management:** Reactive Observer Pattern (`ChangeNotifier`, `ListenableBuilder`, `ValueNotifier`)
- **Navigation:** Persistent `IndexedStack` Bottom Navigation Shell (5 tabs) with native nested `Navigator` stacks.
- **Supported Devices:** Android API 26+ (Tested on Android Emulator Pixel_10a), iOS 13+.
- **Zero Third-Party Bloat:** Built with clean native Flutter SDK primitives and `cupertino_icons` only.

---

## 4. Quickstart & Execution Guide

### Clone and Enter Directory
```bash
cd "c:\Faiz\My project\autoverse"
```

### Install Dependencies
```bash
flutter pub get
```

### Run Static Analysis
```bash
flutter analyze
# Expected output: No issues found!
```

### Run Automated Test Suite
```bash
flutter test
# Expected output: All 44 tests passed!
```

### Launch on Connected Android Emulator
```bash
flutter run
```

### Build Debug APK
```bash
flutter build apk --debug
```

---

## 5. Automated Verification Summary

| Test Suite File | Focus Area | Passing Tests |
|---|---|:---:|
| `test/final_integration_test.dart` | 5-Tab Persistence, Showcase Hotspots, Profile Tabs, Marketplace to Chat Seller Flow, Create Listing Flow | 6 / 6 |
| `test/create_post_test.dart` | Feed Controller, Post Model, Validation, Garage Linking, Cross-module FYP/Profile/Showcase updates | 14 / 14 |
| `test/marketplace_test.dart` | Marketplace Controller, Filters, Search, Sort, Compatibility, Product Detail | 12 / 12 |
| `test/messages_test.dart` | Messages Controller, Unread Count, Seller Conversation Reuse, Message Composer, Tab Persistence | 11 / 11 |
| `test/widget_test.dart` | Smoke and Baseline Shell Render | 1 / 1 |
| **Total Automated Tests** | **Comprehensive Full Regression Suite** | **44 / 44 (100%)** |

---

## 6. Academic Documentation Index

For in-depth evaluation and review, refer to the following documentation files located in `docs/final_submission/`:

1. [PROJECT_STRUCTURE.md](PROJECT_STRUCTURE.md) — Source code directory breakdown, modular architecture, and file inventory.
2. [ARCHITECTURE.md](ARCHITECTURE.md) — Technical architecture, state management patterns, data flow models, and navigation strategy.
3. [FEATURE_DOCUMENTATION.md](FEATURE_DOCUMENTATION.md) — Exhaustive specification and user flows of all 6 application modules.
4. [UI_DESIGN_GUIDELINES.md](UI_DESIGN_GUIDELINES.md) — Design tokens, typography rules, layout spacing, and accessibility criteria.
5. [TESTING_SUMMARY.md](TESTING_SUMMARY.md) — Complete automated test catalog, QA evidence, and emulator test results.
