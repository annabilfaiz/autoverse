# AUTOVERSE — Stitch Agent Context Kit

This kit gives Google Stitch (through the Stitch MCP server in Antigravity) the product context, visual rules, screen requirements, and phased prompts needed to design the AUTOVERSE mobile MVP.

## Existing Stitch project — do not create another one

- Project title: `AutoVerse Platform`
- Project resource: `projects/217030135943957931`
- Numeric project ID for MCP calls: `217030135943957931`
- Device target: `MOBILE`
- Visibility: Private / Restricted
- Role: Owner
- Last verified state reported by the user: project exists and currently has **zero screens**.

Always verify the current project and screens with Stitch MCP before writing. Do not assume the project is still empty if screens have since been created.

## Read these files in order

1. `PRODUCT_BRIEF.md` — product intent and settled decisions.
2. `DESIGN.md` — semantic design source of truth for Stitch.
3. `DESIGN_SYSTEM.md` — detailed design rules and known approved tokens.
4. `SCREEN_SPECIFICATION.md` — screen-by-screen requirements.
5. `INTERACTION_FLOWS.md` — navigation and interaction behavior.
6. `VISUAL_QUALITY_RULES.md` — quality bar and anti-generic-AI guardrails.
7. `STITCH_PROJECT_STRUCTURE.md` — project/screen naming and organization.
8. `STITCH_AGENT_MASTER_PROMPT.md` — master instruction for the Stitch agent.
9. `PROMPT_SEQUENCE.md` — staged prompts; use one phase at a time.
10. `tokens/autoverse.tokens.json` — machine-readable design token subset.

## Reference assets

- `assets/original_vehicle_showcase_sketch.png`: the user's own rough sketch for the Featured Vehicle area. Interpret the concept: vehicle as the central hero, component callouts around it, compact stats, and posts below. Improve the composition; do not copy the rough geometry literally.
- `assets/welcome_screen_before_revision.png`: screenshot of the earlier Welcome design. This is a **before / avoid-repeating reference**, not an approved target. It looked too much like a photograph with text placed over it and a separate footer panel. Improve the art direction rather than reproducing it.

## Non-negotiable product decisions

- This is an exploration and learning project, not a monetization-first startup brief.
- Target is a native-feeling mobile app designed for later Flutter/Dart implementation on Android and iOS.
- Four balanced primary pillars: Home / FYP, Marketplace, Messaging, and Profile + Vehicle Showcase (the last two ideas are one combined pillar).
- Home is a full-screen, vertical, short-video feed inspired by TikTok's interaction pattern. It is **not** an Instagram image/card feed.
- Profile represents the person. Featured Vehicle represents their automotive identity. My Garage contains the user's other vehicles.
- A post can be created directly from a vehicle and linked to that vehicle, optionally to a component.
- Featured Vehicle is a showcase and identity surface, not a sales listing.
- Installed components, marketplace listings, and compatibility are different data concepts.
- Product-context chat is a reference card, not checkout.
- Login/register are mock flows for the MVP; no backend, database, payment, or real auth is designed.
- Stories, visual AI/Lens search, real-time chat infrastructure, checkout/payment, 3D vehicle viewer, OBD telemetry, and advanced recommendation systems are deferred.

## Recommended first action

Before generating any screen:
1. Read the files above.
2. Inspect the available Stitch MCP tool names and their actual schemas.
3. Verify `projects/217030135943957931` with `get_project` and `list_screens`.
4. Check `list_design_systems` for an existing system. Do not create duplicate systems.
5. Upload this kit's `DESIGN.md` and create/apply the Stitch design system if the relevant tools are available. If the MCP surface differs, report the actual available tools and use the closest supported workflow; do not invent tool names or parameters.
6. Only then start with the Welcome exploration prompt in `PROMPT_SEQUENCE.md`.

## Working style

Design one module at a time. Generate, inspect, refine, and verify each screen before moving forward. Use the same existing Stitch project. Do not generate the whole application in one prompt.
