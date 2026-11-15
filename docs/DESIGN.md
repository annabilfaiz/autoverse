# AUTOVERSE Design Language

This file is the semantic visual source of truth for Google Stitch. Use it when creating the AUTOVERSE design system and when generating or editing all mobile screens. Preserve these values unless the project owner explicitly approves a change.

## Brand character

AUTOVERSE is a premium, enthusiast-led automotive social platform. Its visual language should feel cinematic, confident, modern, editorial, and grounded in real automotive culture. It should not resemble a generic dark dashboard, a racing game HUD, a crypto product, or a template social app.

Brand line: **Drive. Connect. Explore.**

## Color system

### Foundations
- Void Black — `#0A0D10`: primary app canvas and dark background.
- Carbon — `#11171D`: primary surface and form background.
- Graphite — `#192129`: raised surface, subtle panel, selected neutral surface.
- Steel — `#28343F`: low-emphasis border and divider.

### Accent
- Performance Lime — `#C7F36B`: primary CTA, selected tab, active state, or a single key highlight. Use sparingly; do not flood large surfaces with lime.
- Lime Soft — `#263426`: subtle active/selected background.

### Typography colors
- Ice White — `#F4F6F2`: primary text.
- Titanium — `#A0AAB4`: secondary text.
- Muted Steel — `#687582`: tertiary labels and placeholders; never use for essential information with insufficient contrast.

### Semantic colors
- Success — `#65D69A`.
- Warning — `#FFBE69`.
- Error — `#FF7272`.
- Info — `#70B9FF`.

## Typography

Use Inter, or the closest available neutral sans-serif. Keep typography crisp and restrained.
- Display: 32 px / 38 px, bold; major vehicle title or rare hero headline.
- H1: 24 px / 30 px, bold; page title.
- H2: 20 px / 26 px, semibold; section title.
- H3: 16 px / 22 px, semibold; card/list title.
- Body: 14 px / 20 px, regular.
- Body Strong: 14 px / 20 px, semibold.
- Caption: 12 px / 16 px, regular.
- Micro: 10 px / 14 px, medium; secondary metadata only, never essential content.
- Button: 14 px / 18 px, semibold.

Do not shrink text just to fit. Reflow, wrap, or truncate intentionally.

## Spacing and dimensions

Use a 4 px base grid: 4, 8, 12, 16, 20, 24, 32, 40 px.
- Standard horizontal page margin: 20 px.
- Standard section gap: 24 px.
- Card internal padding: 16 px.
- Compact element gap: 8 px.
- Minimum touch target: 44 × 44 px.
- Bottom navigation: approximately 64–72 px plus device safe-area inset.
- Base mobile frame: 390 × 844 px; verify 360 × 800 and 430 × 932 px.

## Shape and surfaces
- Small badge: 8 px radius.
- Input: 12 px radius.
- Standard card: 16 px radius.
- Large vehicle/media surface: 20–24 px radius where appropriate.
- Pills: full radius, only for filters/status where useful.
- Prefer tonal separation over heavy shadows. Avoid borders around every element.

## Iconography
- Use one consistent outline icon family.
- Standard glyph sizes: 20 px compact action, 24 px primary navigation, up to 28 px prominent hero control.
- Consistent stroke, optical alignment, and icon-to-label spacing.
- Icon-only actions need a clear meaning and at least 44 px touch area.
- Never mix unrelated icon families, decorative emoji icons, or random glyphs.
- Never allow icons, counts, labels, or touch areas to collide.

## Automotive imagery
- Use believable, high-quality automotive photography with coherent vehicle proportions, perspective, and natural or intentionally cinematic lighting.
- Use real/credible photo assets where possible. Generated visuals may be used as illustrative assets but must not be represented as real user-generated footage or verified vehicle evidence.
- Avoid visible third-party logos/signage, watermarks, impossible reflections, duplicated parts, strange wheels, malformed body panels, and unreadable embedded text.
- Plan image crop around the vehicle silhouette and text-safe region before placing overlays.
- Keep color grading coherent within each screen.
- Never embed fake performance numbers into imagery.

## Signature pattern: Featured Vehicle

- Treat the vehicle as the central hero and the owner's automotive identity.
- A profile-sized variant can show 2–4 perimeter callouts and no more than three compact stats.
- Callout connectors must be short, tidy, and non-crossing. Prefer perimeter labels/numbered hotspots to lines that cross the vehicle body.
- Do not turn the hero into a specification spreadsheet.
- Tapping a callout should open a component detail surface or the full Vehicle Detail screen.
- Distinguish owner-entered stats from measured/verified data.

## Signature pattern: FYP video feed

- One 9:16 portrait video fills the entire screen edge-to-edge behind UI.
- Top overlay: understated For You / Following tabs and search.
- Right rail: avatar/follow, like, comments, save, share, optional audio disc; each in separate evenly spaced slots.
- Lower-left overlay: username, optional verified marker only if justified, linked vehicle, short caption, restrained hashtags, optional original-audio label.
- Bottom navigation floats over a subtle dark scrim and respects device insets.
- The video is the content. No Instagram-style post card, no image tile feed, no toolbar below a post, and no Stories carousel.

## Interaction states

Design default, selected/pressed, disabled, loading, error, and empty states where relevant. Forms need inline validation states. Lists/feed need empty/loading/error states. Chat needs an empty state and a keyboard-safe composer. Image areas need a fallback state.

## Responsive behavior

Use 390 × 844 px as the primary design target. Reflow naturally at 360 × 800 and 430 × 932. Do not rely on brittle absolute positions. Respect status and home-indicator safe areas. Ensure captions, right-side action rails, bottom navigation, and keyboard areas do not overlap.

## Quality bar

Every screen should feel like it was laid out intentionally by a senior mobile product designer. The hierarchy, crop, spacing, alignment, and icon placement must be deliberate. Remove anything decorative that does not serve content, navigation, or interaction. A clean and believable layout is better than a visually busy one.
