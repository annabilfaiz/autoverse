# AUTOVERSE — Detailed Design System Specification

`DESIGN.md` is the compact semantic source of truth for Stitch. This file provides additional details for prompting, reviewing, and mapping the design to Flutter.

## 1. Design scope

- Mobile-first application, Android and iOS.
- Primary frame: 390 × 844 px.
- Responsive checks: 360 × 800 and 430 × 932 px.
- Full-screen FYP video is the main exception to standard 20 px page margins; it is edge-to-edge.
- Use safe areas for status bar, home indicator, and navigation gestures.

## 2. Known approved visual values

These values reflect the project's current approved visual direction and the existing Figma Foundations. The earlier Figma Foundation reportedly contains 47 variables and 9 Inter text styles. This Stitch kit only enumerates the values explicitly available in the project brief; do not invent names or claim to reproduce all 47 Figma variables. If an additional semantic token is needed, propose it clearly and keep it consistent with the palette.

| Token | Value | Use |
|---|---|---|
| `color.background.void` | `#0A0D10` | Main canvas |
| `color.surface.carbon` | `#11171D` | Main surface |
| `color.surface.graphite` | `#192129` | Elevated surface |
| `color.border.steel` | `#28343F` | Subtle dividers |
| `color.accent.lime` | `#C7F36B` | Main CTA / active state |
| `color.accent.limeSoft` | `#263426` | Soft active fill |
| `color.text.primary` | `#F4F6F2` | Primary copy |
| `color.text.secondary` | `#A0AAB4` | Secondary copy |
| `color.text.muted` | `#687582` | Tertiary copy |
| `color.semantic.success` | `#65D69A` | Success |
| `color.semantic.warning` | `#FFBE69` | Warning |
| `color.semantic.error` | `#FF7272` | Error |
| `color.semantic.info` | `#70B9FF` | Info |

## 3. Typography scale

Use Inter consistently. Keep font weights, line-height, and baseline alignment stable across screens.

| Style | Size | Line height | Weight |
|---|---:|---:|---|
| Display | 32 | 38 | 700 |
| H1 | 24 | 30 | 700 |
| H2 | 20 | 26 | 600 |
| H3 | 16 | 22 | 600 |
| Body | 14 | 20 | 400 |
| Body Strong | 14 | 20 | 600 |
| Caption | 12 | 16 | 400 |
| Micro | 10 | 14 | 500 |
| Button | 14 | 18 | 600 |

## 4. Spacing and layout

- Base unit: 4 px.
- Scale: 4 / 8 / 12 / 16 / 20 / 24 / 32 / 40.
- Page margin: 20 px on standard pages.
- Section spacing: 24 px.
- Card padding: 16 px.
- Dense row gap: 8 px.
- Minimum interactive target: 44 px.
- Bottom navigation visual height: 64–72 px plus safe area.
- Prefer consistent left/right alignment across headings, search fields, cards, and rows.

## 5. Components and recurring patterns

Stitch should keep repeated patterns visually consistent even if the current Stitch environment does not expose a native reusable-component library. Do not claim components are native Figma instances. Reuse the same dimensions, spacing, color, typography, and interaction logic across generated screens.

Patterns to keep consistent:
- Primary / secondary / tertiary buttons.
- Text fields with label, helper, focus, error, disabled states.
- Search field.
- Tabs and filter chips.
- Avatar and user identity row.
- Bottom navigation with four destinations and a central Create action shortcut.
- Video action rail.
- Featured Vehicle hero and component callouts.
- Garage vehicle row/card.
- Component row/detail.
- Marketplace product card and seller row.
- Message conversation row and chat bubbles.
- Bottom sheet, dialog, snackbar, empty/error/loading states.

## 6. Primary navigation

Four destinations only: Home, Marketplace, Messages, Profile. A central Create control may appear as a visually distinct shortcut between destinations, but it is not a fifth destination. Keep navigation placement and active-state treatment consistent on all four main pages. On FYP, navigation overlays the video with a subtle bottom scrim.

## 7. Screen-specific layout rules

### Home / FYP

Full-screen portrait video, top tabs, right-side action rail, lower-left content, bottom nav overlay. No card feed, no Stories row, no toolbar below the media.

### Profile

Identity first, Featured Vehicle immediately after identity, then My Garage and content tabs/gallery. Do not put every specification in the profile header. Public profile must not expose private data.

### Featured Vehicle

The vehicle is the hero. Use 2–4 perimeter callouts in profile variant; up to three compact stats. Full component inventory belongs on Vehicle Detail.

### Marketplace

The search field and categories should be obvious. `Find parts for your vehicle` should be easy to discover but not overpower the standard shopping experience. Product card hierarchy: image, title, price, condition, location, optional seller/reputation. Avoid arbitrary promotional banners.

### Messaging

Inbox rows should scan quickly. In conversation, message bubbles have consistent max width, spacing, and sender alignment. Product reference card is visually distinct but not a checkout panel. Composer remains above keyboard/safe area.

## 8. Figma / Flutter handoff expectations

The Stitch output is design source material. Final approved frames will be reviewed and, where needed, reconstructed as native Figma components. Flutter implementation should use shared tokens and reusable widgets. Do not assume Stitch-generated HTML is the final Flutter implementation.
