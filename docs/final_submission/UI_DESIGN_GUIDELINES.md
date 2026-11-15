# AUTOVERSE — UI DESIGN GUIDELINES & DESIGN SYSTEM
**Document Version:** 1.0.0  
**Design Theme:** Dark Premium Automotive  
**Target:** Visual Evaluation & Design Consistency  

---

## 1. Design Philosophy

The AutoVerse visual system is purpose-built for automotive enthusiasts. It draws inspiration from modern supercar digital cockpits, telemetry dashboards, and motorsport timing screens. 

### Core Design Pillars
1. **Dark Premium Immersion:** High-contrast dark backgrounds ensure that vivid photography of painted automotive bodywork and exotic metal components take center stage.
2. **Precision Engineering:** UI components favor crisp borders, technical monospace data readouts, and subtle mechanical accents over gratuitous gradients or decorative shadows.
3. **Ergonomic Mobile Touchpoints:** Critical navigation and interactive elements are concentrated within the thumb-reachable bottom zone of mobile viewports.

---

## 2. Color Palette & Design Tokens

| Token Name | Hex Code | Role in Application |
|---|---|---|
| `AppColors.voidBlack` | `#0A0D10` | Base background color for the application canvas; maximum battery efficiency on OLED screens. |
| `AppColors.carbon` | `#11171D` | Elevated surface background for cards, bottom sheets, navigation bars, and top app bars. |
| `AppColors.graphite` | `#192129` | Secondary surface for search fields, unselected chips, and avatar backgrounds. |
| `AppColors.steel` | `#28343F` | Primary border color, hairline dividers, and inactive state outlines. |
| `AppColors.performanceLime` | `#C7F36B` | Primary signature accent; used for CTAs, active tab indicators, verified badges, and unread counters. |
| `AppColors.iceWhite` | `#F4F6F2` | Primary typography color; crisp high-contrast legibility. |
| `AppColors.titanium` | `#A0AAB4` | Secondary typography, specifications labels, and inactive icon states. |
| `AppColors.mutedSteel` | `#687582` | Muted metadata, timestamps, character counts, and placeholders. |
| `AppColors.error` | `#FF4B4B` | Destructive actions, validation error banners, and critical warnings. |
| `AppColors.success` | `#00D26A` | Online presence dots and transaction completion indicators. |

---

## 3. Typography Scale & Hierarchies

AutoVerse adopts **Inter** as its primary typeface, prized for its optical legibility at small sizes and crisp rendering on high-density mobile screens.

```
Headline H1:   28px / Semi-bold (w700) / Tracking: -0.5 / Color: Ice White
Headline H2:   22px / Semi-bold (w700) / Tracking: -0.3 / Color: Ice White
Headline H3:   16px / Semi-bold (w600) / Tracking:  0.0 / Color: Ice White
Body Strong:   14px / Semi-bold (w600) / Line-height: 1.4 / Color: Ice White
Body:          14px / Regular (w400)   / Line-height: 1.4 / Color: Ice White
Caption:       12px / Regular (w400)   / Tracking:  0.2 / Color: Titanium
Micro / Tag:   10px / Bold (w700)      / Tracking:  1.2 (Uppercase) / Color: Muted Steel
```

---

## 4. Spacing & Spatial Layout System

All layouts adhere strictly to an **8-Point Grid System** with 4pt half-steps for fine alignment:

- **4 dp:** Micro spacing between badges and inline icons.
- **8 dp:** Standard inter-item spacing in lists and chip rails.
- **12 dp:** Inner card padding and input vertical paddings.
- **16 dp:** Standard screen edge margins and section separation.
- **20 dp:** Prominent screen horizontal padding for high readability.
- **24–32 dp:** Major vertical section breaks between distinct module blocks.

---

## 5. Component Style Specifications

### 5.1 Cards & Containers
- **Background:** `AppColors.carbon` (`#11171D`)
- **Border:** `Border.all(color: AppColors.steel, width: 1.0)`
- **Corner Radius:** `BorderRadius.circular(12)` to `16`
- **Clip Behavior:** `Clip.antiAlias` to prevent image leakage over rounded borders.

### 5.2 Buttons & CTAs
- **Primary Action (Elevated):**
  - Background: `AppColors.performanceLime` (`#C7F36B`)
  - Foreground: `AppColors.voidBlack` (`#0A0D10`)
  - Font Weight: `FontWeight.w700`
  - Shape: Rounded Stadium (`BorderRadius.circular(18)` to `24`)
- **Secondary Action (Outlined):**
  - Background: Transparent or `AppColors.graphite`
  - Border: `BorderSide(color: AppColors.steel)`
  - Foreground: `AppColors.iceWhite`

### 5.3 Chips & Filters
- **Default State:** Background `AppColors.carbon`, border `AppColors.steel`, text `AppColors.titanium`.
- **Selected State:** Background `AppColors.performanceLime.withValues(alpha: 0.12)`, border `AppColors.performanceLime`, text `AppColors.performanceLime`.

### 5.4 Form Inputs
- **Container:** Background `AppColors.carbon`, border `AppColors.steel`, border radius `12px`.
- **Focused State:** Border changes to `AppColors.performanceLime` with subtle glow.
- **Placeholder Style:** `AppColors.mutedSteel`, regular weight.

---

## 6. Accessibility & Contrast Verification

- **Text Contrast Ratios:**
  - `Ice White (#F4F6F2)` on `Void Black (#0A0D10)` achieves a contrast ratio of **18.2:1** (exceeding WCAG AAA standard of 7:1).
  - `Performance Lime (#C7F36B)` on `Void Black (#0A0D10)` achieves a contrast ratio of **15.4:1** (exceeding WCAG AAA).
  - `Titanium (#A0AAB4)` on `Carbon (#11171D)` achieves a contrast ratio of **6.2:1** (exceeding WCAG AA for body text).
- **Minimum Touch Targets:** All interactive icons and buttons enforce a minimum tappable area of 44 × 44 dp.
