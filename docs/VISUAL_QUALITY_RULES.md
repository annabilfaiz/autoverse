# AUTOVERSE — Visual Quality and Anti-Generic-AI Rules

Treat these rules as hard constraints during generation and refinement.

## 1. Avoid the generic AI look

- Do not create a generic futuristic dashboard, racing-game HUD, random glows, or neon outlines on every surface.
- Do not use meaningless micro-labels, fake telemetry, fake verification badges, lorem ipsum, or fabricated claims.
- Do not repeat one generic card layout across screens with different purposes.
- Do not use decorative icons that do not communicate an action or category.
- Avoid excessive pill chips, badges, borders, nested cards, and floating glass panels.
- Avoid perfect symmetry when it makes a composition feel artificial; prioritize optical alignment and editorial rhythm.
- Do not paste text over a random car photo and call it an art-directed welcome screen.

## 2. Icon consistency

- One coherent outline icon family only.
- Consistent stroke weight, optical alignment, and label spacing.
- Standard icons 20–24 px; tap targets at least 44 px.
- Same action uses the same icon across the product.
- Never overlap icons, labels, counts, or hit areas.
- Avoid mixing outline, filled, emoji, and decorative icon styles without a clear system.

## 3. Spacing and alignment

- Use the 4 px spacing rhythm.
- Align screen titles, search fields, card edges, and list rows.
- Keep consistent row heights and text baselines.
- Do not manually nudge repeated elements into approximate positions; use a consistent grid and repeatable layout logic.
- Ensure bottom navigation, captions, action rails, and keyboard regions do not overlap.
- Validate 360, 390, and 430 px widths.

## 4. Photography and media

- Prefer credible automotive editorial photography with realistic proportions and coherent lighting.
- Do not combine unrelated image styles or inconsistent color grading on one screen.
- Avoid third-party brand signage, watermarks, malformed vehicles, impossible reflections, duplicated parts, and unreadable text embedded in images.
- Use one dominant hero image where appropriate; avoid competing imagery.
- Do not place fake specs or stats inside photographs.
- For FYP, use portrait video placeholder/preview treatment; do not present still-image cards as the final feed structure.

## 5. Home must be unmistakably full-screen video

- Video fills screen edge-to-edge.
- Right-side action rail is vertically spaced and clearly separated from counts.
- Creator/caption/vehicle metadata stays lower-left.
- For You / Following and search are near the top.
- Bottom navigation floats over a subtle scrim.
- No Instagram-style post cards, no photo grid, no toolbar underneath media, and no Stories row.
- Vertical swipe/paging is the primary interaction.

## 6. Profile and Featured Vehicle

- Profile identity remains scannable.
- Featured Vehicle is the signature, not a dense specification spreadsheet.
- Use 2–4 tidy component callouts and no more than three compact stats in the profile-sized version.
- Callout connectors must not cross or collide.
- Performance values are owner-entered/demo unless explicitly verified.
- A showcased part is not automatically a listing.

## 7. Marketplace

- Product cards prioritize image, title, IDR price, condition, and location.
- Vehicle compatibility must be explicit and distinct from installed parts.
- Find Parts for Your Vehicle is discoverable but not more visually dominant than normal product search.
- No payment/checkout UI in MVP.

## 8. Messaging

- Inbox rows scan quickly with consistent avatar alignment and clear preview/time hierarchy.
- Chat bubbles use consistent widths, spacing, and sender alignment.
- Product reference card is clearly contextual, not a payment panel.
- Composer is safe-area and keyboard aware.
- Do not fabricate real-time presence/typing signals; if shown for visual placeholder, label it as demo only.

## 9. Density and hierarchy

- One clear primary action per screen area.
- Use whitespace for hierarchy.
- Avoid multiple competing CTAs.
- Do not repeat metadata in both title and badge.
- Use realistic copy lengths and test wrapping.
- Avoid microtext for essential information.

## 10. Deliverable quality

- Every screen has one clear purpose.
- Design is coherent across the system but screen-specific layouts remain appropriate.
- No icon collisions, broken text, awkward spacing, inconsistent edges, or random decorative elements.
- Show default and key relevant states: empty, loading, error, disabled, validation, selected.
- Use the existing Stitch project and a consistent design system; do not create duplicate projects or duplicate design systems.
- Generate in phases. Do not generate the entire application in one pass.
