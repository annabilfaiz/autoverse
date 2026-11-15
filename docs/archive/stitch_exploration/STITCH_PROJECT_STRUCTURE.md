# AUTOVERSE — Stitch Project Structure and Naming

## Existing project

- Project title: `AutoVerse Platform`
- Resource: `projects/217030135943957931`
- Numeric project ID: `217030135943957931`
- Device type: `MOBILE`
- No screens were present at the last user-confirmed inspection. Re-check before creating.

Do not create another project. Do not rename or overwrite unrelated projects.

## Screen naming convention

Use stable, descriptive screen names with numeric prefixes so that list_screens results remain easy to scan:

- `00 Welcome — Immersive`
- `00 Welcome — Editorial`
- `01 Login`
- `02 Register`
- `03 Forgot Password`
- `10 Home — For You Video`
- `11 Home — Following Video`
- `12 Post Detail & Comments`
- `13 Create Video Post`
- `14 Select Vehicle for Post`
- `20 My Profile`
- `21 Public Profile`
- `22 Edit Profile`
- `23 My Garage`
- `24 Add / Edit Vehicle`
- `25 Vehicle Detail — Overview`
- `26 Vehicle Detail — Build`
- `27 Component Detail`
- `28 Add / Edit Component`
- `30 Marketplace Home`
- `31 Marketplace Search & Filters`
- `32 Product Detail`
- `33 Create Listing`
- `40 Messages Inbox`
- `41 Conversation`
- `42 Conversation — Product Context`
- `43 New Message / User Search`
- `50 Global Search`
- `51 Notifications`
- `52 Settings`
- Supporting states should use suffixes, e.g. `— Empty`, `— Loading`, `— Error`, `— Validation`.

If Stitch offers a way to group screens, group by prefix/module. If not, use the prefixes consistently in screen titles.

## Phased creation order

1. Design system + Welcome exploration.
2. Authentication finalization.
3. Profile & Garage.
4. Home / FYP.
5. Marketplace.
6. Messaging.
7. Supporting screens and review.

This differs from implementation order only where required for visual exploration. Do not generate all modules at once.

## Stitch project vs Figma file

Stitch project and Figma file are different resources. Do not refer to Stitch screens as Figma pages or assume Stitch supports all Figma-native constructs. Use the Stitch screen and design-system operations actually exposed by the MCP server. When transferring to Figma, reconstruct approved screens using native Figma frames/components/variables as needed.
