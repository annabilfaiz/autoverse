# Source Notes and Workflow References

## Project-derived decisions

The product and visual decisions in this kit are based on the AUTOVERSE project discussion and the previously prepared Figma Agent Context Kit. These are the user's settled requirements and should take priority over generic design assumptions.

## Stitch workflow references checked while preparing this kit

- Google Codelab — Design-to-Code with Antigravity and Stitch MCP: https://codelabs.developers.google.com/design-to-code-with-antigravity-stitch
- Google Labs Code — Stitch Skills repository: https://github.com/google-labs-code/stitch-skills
- Stitch Design System skill — Manage design systems: https://github.com/google-labs-code/stitch-skills/tree/main/plugins/stitch-design/skills/manage-design-system
- Stitch DESIGN.md skill: https://github.com/google-labs-code/stitch-skills/tree/main/plugins/stitch-utilities/skills/design-md

## Operational note

Stitch MCP tool availability and schemas can evolve. The agent must inspect the tools available in the active Antigravity session before calling any operation. In particular, verify whether `upload_design_md`, `create_design_system_from_design_md`, `list_design_systems`, `apply_design_system`, `generate_screen_from_text`, `edit_screens`, `generate_variants`, `list_screens`, and `get_screen` are actually exposed. Use exact live schemas. Do not invent parameters when a tool is unavailable.

The Google Codelab demonstrates Stitch → MCP → Antigravity with a React/Tailwind example. AUTOVERSE's final implementation target is Flutter/Dart; Stitch output is a design reference and should be translated into Flutter-native widgets rather than blindly copied as React code.
