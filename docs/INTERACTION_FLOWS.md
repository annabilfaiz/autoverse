# AUTOVERSE — Interaction and Navigation Flows

## 1. Main navigation

Four primary destinations:
1. Home / FYP
2. Marketplace
3. Messages
4. Profile

A central Create control is an action shortcut, not a fifth destination. It can open a compact action sheet with Create Video Post, Add Vehicle, and Create Marketplace Listing. Each action routes to its corresponding form.

## 2. Authentication flow

- Welcome → Create Account → Register → mock account success → Home or Profile onboarding destination.
- Welcome → Sign In → Login → mock login success → Home.
- Login → Forgot Password → email form → confirmation → Login.
- Login/Register are mock-only. Do not imply a real backend session, real reset email, or social identity provider unless explicitly requested.

## 3. FYP flow

- Home opens on For You.
- For You / Following tabs switch the feed source while preserving the same full-screen video layout.
- Vertical swipe advances to the next video.
- Right rail: creator profile/follow, like, comments, save, share, optional audio.
- Vehicle chip opens the corresponding Vehicle Detail.
- Creator name/avatar opens Public Profile.
- Comments opens Post Detail / Comments.
- Create shortcut → Create Video Post.
- Create Video Post → Select Vehicle → optional Select Component → Publish → new video post appears in the feed and linked vehicle's Posts/Build Updates.

## 4. Profile / Garage flow

- Bottom tab Profile → My Profile.
- My Profile → Edit Profile → Save → return to My Profile with changes.
- Featured Vehicle → Vehicle Detail.
- Vehicle callout → Component Detail.
- My Garage → Add Vehicle → Save → new vehicle appears in Garage.
- Vehicle Detail → Add Component → Save → component appears in Build.
- Owner can set one vehicle as Featured; selecting a different one removes Featured status from the previous vehicle.
- Public Profile → Follow/Unfollow updates relationship state; Message opens or creates conversation.

## 5. Marketplace flow

- Bottom tab Marketplace → Marketplace Home.
- Search or category → Search Results / Filters.
- Find Parts for Your Vehicle → select/change vehicle → filtered compatible results.
- Product Card → Product Detail.
- Product Detail → Chat Seller → existing/new Conversation with Product Context.
- Create shortcut → Create Listing → Publish → listing appears in Marketplace.
- Installed component is not automatically listed. Listing a component requires an explicit Create Listing action and ownership selection.

## 6. Messaging flow

- Bottom tab Messages → Inbox.
- Inbox row → Conversation.
- Conversation → send a non-empty message → message appears immediately; inbox preview and timestamp update.
- Inbox → New Message → search/select user → Conversation.
- Product Detail → Chat Seller → conversation with product reference card.
- Product reference card → View Listing → Product Detail.

## 7. Supporting flow

- Search icon → Global Search; user, vehicle, video, and product results open their relevant detail screens.
- Notification row opens the relevant profile, post, product, or conversation.
- Profile settings icon → Settings.

## 8. State behavior to communicate in prototype

- Like, save, follow, selected filters, created posts, vehicles, components, listings, and sent messages should show immediate state changes.
- Switching main tabs should not conceptually reset current page state (scroll/feed context, selected filters, inbox state, profile context). This is a Flutter implementation requirement; prototype should communicate persistent navigation where possible.
- Data is local/mock for MVP. Do not show real cloud sync, payment, server authentication, or delivery state.

## 9. Modal and overlay conventions

- Use bottom sheets for quick contextual actions: Create menu, share, filter controls, and compact component preview.
- Use full screens for complex forms and detail pages.
- Every overlay needs a clear close/back affordance and safe-area behavior.
- Avoid stacking multiple bottom sheets or dialogs unnecessarily.
