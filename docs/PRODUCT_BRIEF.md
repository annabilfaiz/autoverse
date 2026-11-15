# AUTOVERSE — Product Brief

## 1. Product summary

AUTOVERSE is a mobile-first automotive social platform for people who are interested in cars and motorcycles. It combines short-form automotive video discovery, an automotive marketplace, direct messaging, and personal profiles with a distinctive vehicle showcase / garage.

The product should feel like one coherent automotive community—not four unrelated apps stitched together. The vehicle is a central identity object: users can showcase vehicles they own, document builds and modifications, publish posts linked to a vehicle, and let other people explore the vehicle's specifications and installed components.

This is an app-building and experience-exploration project. Do not design around monetization, investor storytelling, or complex enterprise workflows. Prioritize a high-quality, believable, usable mobile experience that can later be implemented as a Flutter MVP using local dummy data.

## 2. The four balanced pillars

### A. Home / For You Page (FYP)

A full-screen, vertically swipeable short-video experience inspired by TikTok's interaction model. One portrait video fills the screen edge-to-edge. A vertical action rail sits on the right. Creator identity, linked vehicle, caption, hashtags, and optional original audio sit near the lower-left. `For You` / `Following` and search sit near the top. Bottom navigation overlays the video with a subtle scrim and safe-area padding.

The main FYP is video-first. Static photography belongs in profile/vehicle galleries or detail pages, not in the FYP's primary feed format.

### B. Profile + Vehicle Showcase (one combined pillar)

Profile is the user's identity: avatar, display name, username, bio, posts, followers, following, and profile actions. The **Featured Vehicle** is a signature showcase within the profile, not a separate marketplace item. It should feel deliberately art-directed and make the user's vehicle worth exploring.

The user's original sketch suggests a central vehicle with component callouts around it, compact performance/build stats, and posts below. Translate this into a clean, premium, responsive layout. Avoid crossing connector spaghetti, overlapping labels, or too many callouts. Show 2–4 compact callouts in the profile hero; expose the complete component list on the vehicle detail page.

Users can own multiple vehicles. One may be set as Featured Vehicle; the others appear in My Garage. The vehicle detail experience can contain Overview, Build / Components, History, and related Posts. Performance numbers are optional and must be labeled as owner-entered, demo, or sourced/verified as appropriate—never invent telemetry.

### C. Marketplace

A focused marketplace for vehicles, spare parts, wheels, tires, accessories, and automotive items. The interface includes normal search/categories and a discoverable but non-dominant path to search parts compatible with a selected vehicle.

Keep these concepts distinct:
- **Installed component:** a part documented as currently fitted to a specific user's vehicle.
- **Marketplace listing:** an item intentionally offered for sale by a seller.
- **Compatibility:** vehicle models that a listing is claimed to fit.

A component displayed on a vehicle is not automatically for sale. A listing only exists when the owner explicitly creates one. Product Detail has a `Chat Seller` action. No checkout, cart payment, escrow, shipping integration, or payment success state in the MVP.

### D. Messaging

Direct messages between users. Inbox provides conversation search, recent-message previews, timestamps, and unread indicators. Conversation supports text messages. When started from Product Detail, show a contextual product reference card with image, title, and price. The card is reference context only and does not imply payment or checkout.

## 3. Target audience and brand tone

- Car and motorcycle enthusiasts, owners, modifiers, collectors, and people searching for parts.
- Confident, enthusiast-led, editorial, tactile, and premium.
- Not a racing-game dashboard, crypto/fintech interface, generic social template, or overly futuristic HUD.
- Use natural, believable sample copy. Avoid AI filler, fake metrics, excessive labels, or exaggerated claims.
- Sample marketplace prices should use Indonesian Rupiah (IDR) and sample locations can use Indonesian cities, while interface copy can remain consistently English for the first design pass.

## 4. MVP and technical constraints

- Flutter / Dart implementation follows the design phase.
- Design for Android and iOS mobile layouts.
- Base frame: 390 × 844 px; check 360 × 800 and 430 × 932.
- Use local dummy data for the first implementation. No backend/database required.
- State should persist while switching pages/tabs during the running session; app-restart persistence is out of scope.
- Mock login/register only; no real server authentication.
- Make primary visible interactions understandable and prototype-able, but do not invent backend systems.

## 5. Deferred scope

- Stories / Garage Stories.
- AI camera Lens / visual part recognition.
- Real-time presence, typing indicators, and push delivery.
- Checkout, cart payment, escrow, shipping integration.
- Server authentication, backend, and cloud persistence.
- 3D vehicle viewer, OBD telemetry, live dyno integrations.
- Advanced recommendation algorithms and moderation operations.

## 6. Brand direction

- Working name: AUTOVERSE (not necessarily final legal/product name).
- Working line: `Drive. Connect. Explore.`
- Visual direction: Dark Premium / Modern Automotive Editorial.
- Primary accent: Performance Lime `#C7F36B`, used sparingly.
- Natural automotive photography, strong compositions, clean alignment, deliberate negative space, consistent iconography, useful UI chrome only.
