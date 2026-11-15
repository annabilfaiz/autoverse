# AUTOVERSE — Full MVP Screen Specification for Stitch

## General screen requirements

- Device target: MOBILE.
- Primary viewport: 390 × 844 px.
- Check 360 × 800 and 430 × 932 px for important screens.
- Use native, screen-level design output from Stitch; do not create one flattened poster as the final deliverable.
- Keep one screen per clear screen name. Add a small number of meaningful state screens where they demonstrate important behavior.
- Use realistic sample content, Indonesian locations, and IDR prices where relevant.

## 00 — Authentication

### 00.1 Welcome / Splash entry

- Treat this as the brand's first impression, not a generic login template.
- Direction: Cinematic Automotive Editorial.
- Explore two approaches before choosing one: (A) immersive full-bleed photography with a natural dark gradient transition into the CTA area; (B) more structured automotive magazine/editorial composition with deliberate negative space.
- Hero image should occupy roughly 65–75% of the visual field, but the overall composition must feel integrated—not simply a photo with text pasted on top.
- Use AUTOVERSE brand mark/wordmark, concise headline, concise supporting copy, primary Create Account, secondary Sign In.
- Suggested headline: `Your build. Your people. Your scene.`
- Suggested supporting copy: `Showcase your vehicle, discover parts, and connect with enthusiasts who get it.`
- Avoid third-party logos/signage, watermarks, and synthetic-looking car renders.
- Use the existing welcome screenshot in assets only as a negative reference: do not repeat the hard image/footer split or basic text-on-photo treatment.

### 00.2 Login

- Brand mark and concise welcome-back copy.
- Email field.
- Password field with visibility control.
- Forgot Password link.
- Primary Sign In CTA.
- Link to Register.
- Clear invalid email, missing password, loading, and incorrect-credentials examples.

### 00.3 Register

- Display name, username, email, password, confirm password.
- Password visibility controls.
- Terms acknowledgement.
- Primary Create Account action.
- Link to Login.
- Inline validation states and helpful username guidance.

### 00.4 Forgot Password

- Clear explanation of the reset flow.
- Email field.
- Send reset instructions action.
- Invalid email state and confirmation state.
- This is a mock/prototype flow; no email is actually sent.

## 01 — Home / For You Page

### 01.1 FYP default

This is a critical product requirement. It must read immediately as a TikTok-style vertical short-video feed, not Instagram.

- One 9:16 portrait video fills the entire screen edge-to-edge behind the UI.
- Video is the content, not a thumbnail inside a card.
- Vertical swipe is the primary feed interaction. Create at least two feed items/states to communicate paging.
- Top overlay: compact For You / Following tabs and search icon.
- Right action rail, each action in its own evenly spaced slot: creator avatar with small follow control, like + count, comments + count, save + count, share + count, optional original-audio disc if space permits.
- Lower-left overlay: creator name, optional verified marker only where justified, linked vehicle chip, short caption (2–3 lines visible), restrained hashtags, optional audio metadata.
- Bottom navigation: four destinations (Home, Marketplace, Messages, Profile) plus central Create shortcut; overlay the video with a subtle scrim and safe-area spacing.
- Do not add Stories.
- Do not use a scrolling card feed, static-image carousel, grid, or like/comment/share toolbar underneath a post.

### 01.2 Following feed state

- Same layout as FYP default.
- Only creator source/tab state changes; do not redesign the whole screen.
- Show selected tab state clearly.

### 01.3 Post Detail / Comments

- Opened from the comment control.
- Keep media context visible in a compact media area or top header.
- Comments form a clean, readable list/bottom sheet.
- Consistent avatar, name, timestamp, comment, reply/like affordance.
- Composer pinned above safe area/keyboard.
- Show linked vehicle where relevant.

### 01.4 Create Video Post

- Video-first preview/selection area.
- Caption field.
- Optional hashtags.
- Link Vehicle selector.
- Optional Link Component selector only after a vehicle has been selected.
- Visibility selector.
- Publish action.
- Video required; caption optional; component must belong to selected vehicle.

### 01.5 Select Vehicle for Post

- Search/filter vehicles in the user's garage.
- Each row shows vehicle image, manufacturer/model, generation/year.
- Clear selected state.
- Empty garage state with Add Vehicle action.

## 02 — Profile + Vehicle Showcase

### 02.1 My Profile

- Avatar, display name, @username, concise bio.
- Posts, Followers, Following in a balanced stats row.
- Edit Profile and Share Profile actions.
- Featured Vehicle hero directly below identity block.
- My Garage for additional vehicles.
- Content tabs such as Posts, Garage, Saved. Saved is private to owner by default.
- Posts may use a tidy media grid; tapping a video opens its video detail/feed context.

### 02.2 Public Profile

- Same identity hierarchy.
- Follow and Message actions replace Edit Profile.
- Public Featured Vehicle, public garage entries, public post gallery.
- Do not reveal private vehicle fields or personal data.

### 02.3 Edit Profile

- Avatar change affordance.
- Display name, username, bio.
- Save action and validation examples.

### 02.4 Featured Vehicle hero

- A distinct signature area, inspired by the user's sketch.
- The vehicle is the central visual subject.
- Compact profile version: 2–4 restrained component callouts and no more than three stats.
- No connector lines crossing each other; no callout collisions with the vehicle, stats, or text.
- Vehicle name, generation/year, concise build status.
- Example stats (e.g. HP, torque, component count) must be clearly illustrative/owner-entered; do not imply measured telemetry.
- View Vehicle action opens full Vehicle Detail.

### 02.5 My Garage

- List/collection of vehicles owned by the user.
- One vehicle marked Featured.
- Each item shows vehicle image, make/model, year/generation, concise build label.
- Add Vehicle CTA.
- Empty state.

### 02.6 Add/Edit Vehicle

- Vehicle image selector.
- Manufacturer, model, year (required).
- Generation, transmission, engine capacity, power, torque (optional).
- Owner-entered performance fields explicitly labeled.
- Public visibility controls for optional fields.
- Set as Featured toggle.
- Validation and save feedback.

### 02.7 Vehicle Detail / Showcase

- Large vehicle hero photograph.
- Vehicle identity: make/model/generation/year.
- Tabs: Overview, Build, History, Posts.
- Optional stats row.
- Components grouped into Engine, Exterior, Interior, Suspension, Wheels & Tires, Braking, Audio, Performance, Maintenance.
- Owner sees Add Component; public visitor sees only permitted public information.
- Find Similar Parts / Find Parts for This Vehicle can navigate to Marketplace with vehicle context.
- This page remains a showcase, not a sales page.

### 02.8 Component Detail

- Component image, name, category, brand/model.
- Specifications and install date if supplied by owner.
- Notes/description.
- Optional Find Similar / Compatible Products action.
- No Buy, Offer, Chat Seller, or For Sale controls unless an explicit separate listing exists.

### 02.9 Add/Edit Component

- Category, name, brand, product/model, photo, install date, notes.
- Save validation.
- Component must reference an existing vehicle.

## 03 — Marketplace

### 03.1 Marketplace Home

- Marketplace title and search field.
- Categories: Parts, Wheels & Tires, Exterior, Interior, Engine/Performance, Accessories, Vehicles, Other.
- Clear but non-dominant `Find parts for your vehicle` entry point.
- Product grid/list with consistent cards.
- Product card hierarchy: image, title, IDR price, condition, location; seller/rating only when known.
- Avoid excessive promo banners and meaningless badges.

### 03.2 Search Results & Filters

- Persistent query.
- Tabs/filters by result category as appropriate.
- Filters: category, condition (new/used), compatible vehicle, price range, location.
- Clear selected filters action.
- Compatibility is separate from installed components.
- Empty search result state.

### 03.3 Product Detail

- Product image gallery.
- Title, price, condition, category.
- Seller identity and profile link.
- Description/specifications.
- Compatible vehicles if provided.
- Primary `Chat Seller` CTA.
- No checkout/payment flow.

### 03.4 Create Listing

- Product photo area.
- Title, category, price, condition, description.
- Optional compatible vehicle selector (multi-select where useful).
- Optional link to an installed component only if owner deliberately lists their own part for sale.
- Publish action and validation.

## 04 — Messaging

### 04.1 Inbox

- Page title `Messages`.
- Search conversations.
- Optional filters: All, Unread, Marketplace.
- Conversation rows: avatar, name, last message, timestamp, unread indicator.
- Consistent row height and avatar alignment.
- Empty state and New Message action.

### 04.2 Conversation

- Header with avatar, name, profile navigation, more actions.
- Message bubbles with consistent sender alignment and timestamp.
- Text composer with send action.
- Do not add attachments unless designed as a working MVP interaction.
- Keyboard-safe composer.

### 04.3 Conversation with Product Context

- Same as Conversation, with contextual product reference card at top.
- Card includes thumbnail, listing title, price, seller context.
- Clearly a reference to the listing; not a checkout panel.
- `View Listing` may return to Product Detail.

### 04.4 New Message / User Search

- User search field.
- Suggested/recent users.
- Search result rows.
- Selecting a user opens or begins a conversation.

## 05 — Supporting screens

### 05.1 Global Search

- Search across users, vehicles, videos, and products.
- Clear result categories/tabs.
- Reuse established search field and result row patterns.

### 05.2 Notifications

- Activity list for likes, comments, follows, and marketplace/chat events where relevant.
- Group recent/earlier.
- Consistent avatar, copy, timestamp hierarchy.

### 05.3 Settings

- Account, Privacy & Safety, Notifications, Appearance, Help & Support, About.
- Keep simple; deeper settings are deferred.

### 05.4 Reusable states

- Empty FYP.
- Empty garage.
- No marketplace results.
- Empty inbox/conversation.
- Failed image fallback.
- Form validation error.
- Loading/skeleton.
- Recoverable error with retry.
- Disabled CTA and success feedback where relevant.
