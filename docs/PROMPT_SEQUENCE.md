# AUTOVERSE — Stitch Agent Prompt Sequence

Use these prompts in order. Each prompt assumes the agent has read `START_HERE.md` and the relevant context files. Do not combine the entire sequence into one request.

## Prompt 0 — Verify existing project and establish design system

Read all project context files. Use the existing Stitch project `projects/217030135943957931` (`AutoVerse Platform`, device `MOBILE`). Do not create another project. Inspect the current project and screens. Check for an existing design system. If none exists, use the available Stitch MCP design-system workflow to upload `DESIGN.md` and create a design system from it; inspect the actual tool schemas and use the exact required input/response fields. If a design system already exists, compare and reuse it rather than creating a duplicate. Report project ID, screen count, available design-system IDs, created/selected design-system ID, and any unavailable operation. Do not generate Welcome or other application screens in this step.

## Prompt 1 — Welcome art-direction exploration

Create exactly two distinct Welcome screen concepts in the existing project, both at 390 × 844 and device type MOBILE:
- A: Immersive Full-Bleed Automotive — high-quality automotive editorial photo integrated with the entire composition, 65–75% hero area, subtle top/bottom gradient transitions, no hard image/footer split.
- B: Editorial Automotive — magazine-inspired composition, deliberate negative space, strong typographic hierarchy, photo and type art-directed together.

Content:
- AUTOVERSE
- Headline: `Your build. Your people. Your scene.`
- Supporting copy: `Showcase your vehicle, discover parts, and connect with enthusiasts who get it.`
- Primary CTA: `Create Account`
- Secondary CTA: `Sign In`

Use authentic/credible automotive photography; avoid visible unrelated signage, watermarks, fake embedded text, and malformed vehicles. Avoid simply pasting text on top of a generic car photo. Do not modify Login/Register. Return screen IDs and visual previews. Do not proceed to other modules.

## Prompt 2 — Refine Welcome and complete Authentication

After the owner selects one Welcome direction, refine only that direction. Then create Login, Register, and Forgot Password using the same visual language. Include field labels, password visibility, validation/error, disabled/loading, and success states as useful. This is a mock authentication flow. No real auth provider or reset email. Connect Welcome → Login/Register → Forgot Password and return flow if Stitch supports prototypes. Do not generate other modules.

## Prompt 3 — Profile and Vehicle Showcase

Create My Profile, Public Profile, Edit Profile, My Garage, Add/Edit Vehicle, Vehicle Detail (Overview/Build/History/Posts), Component Detail, and Add/Edit Component. Treat Featured Vehicle as the signature profile area. Use the user's sketch as concept reference: central vehicle, 2–4 tidy non-crossing perimeter callouts, up to three compact stats, and a clear route to full vehicle detail. Keep identity, vehicle ownership, installed component, and listing concepts distinct. Mark performance values as demo/owner-entered. Include empty garage and relevant edit states. Do not turn the showcase into a listing page.

## Prompt 4 — Home / FYP (critical)

Create Home as a full-screen TikTok-style vertical video feed—not Instagram. One 9:16 video fills screen edge-to-edge. Add top For You/Following and Search; right-side vertical action rail for avatar/follow, like, comments, save, share, optional audio; lower-left creator identity, linked vehicle, caption, restrained hashtags/audio; bottom navigation with four destinations plus central Create shortcut over subtle scrim. Show at least two feed items/states to convey vertical paging. Create Post Detail/Comments, Create Video Post, and Select Vehicle for Post. Video is required for FYP posts. No Stories row, no photo cards, no toolbar below the media.

## Prompt 5 — Marketplace

Create Marketplace Home, Search Results/Filters, Product Detail, and Create Listing. Add product categories, search, IDR pricing, condition, location, seller context, and a discoverable but non-dominant `Find Parts for Your Vehicle` path. Product Detail has `Chat Seller`, not checkout. Keep compatibility distinct from installed parts. A vehicle component is not for sale unless the owner explicitly creates a listing. Include no-results and form-validation states.

## Prompt 6 — Messaging

Create Inbox, Conversation, Conversation with Product Context, and New Message/User Search. Use aligned avatars, readable timestamps, predictable chat bubbles, a keyboard-safe composer, and an explicit product reference card when opened from a listing. Do not invent real-time presence, typing, payment, or delivery infrastructure. Include empty inbox/conversation states.

## Prompt 7 — Supporting screens and consistency pass

Create Global Search, Notifications, Settings, and reusable empty/loading/error/validation/image-fallback states. Review every module for consistent margins, spacing, icon family/size/stroke, typography, corner radii, contrast, line wrapping, and safe areas. Remove decorative clutter, fake badges, repeated metadata, random glows, and any Instagram-like Home patterns. Validate at 360, 390, and 430 px widths where supported.

## Prompt 8 — Final project audit

Use list_screens and get_screen to inspect the exact project. Report all screen names and resource IDs, design system details, incomplete states, prototype/navigation gaps, assumptions, and remaining visual issues. Do not claim interactive prototype connections unless the Stitch output actually supports and confirms them. Provide a compact screen overview or accessible screen previews for review.
