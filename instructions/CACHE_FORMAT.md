# Cache Format — LLM-Optimized Lore Repository

This document defines the structure, format, and conventions for the lore cache files located in `cache/`. The entire cache is designed to be **easily consumed and edited by LLMs** — minimal styling, maximal clarity, machine-parseable.

---

## Cache File Hierarchy

```
cache/
├── _index.md                        # Registry of ALL entities (single source of truth for what exists)
├── _master_relationships_map.md     # Global relationship graph across all entities
└── entities/
    ├── characters/
    ├── locations/
    ├── organizations/
    ├── events/
    ├── items/
    └── lore/
```

---

## 1. `_index.md` — Entity Registry

A single flat list of all entities in the cache. Sorted alphabetically by entity ID. LLM-friendly table format.

### Format:

```markdown
# WorldAnvil Lore Cache — Entity Index

| ID | Type | Name | Status | Updated |
|----|------|------|--------|---------|
| city_of_embermoor | location | City of Embermoor | active | 2026-08-08 |
| high_king_theron | character | High King Theron Ironveil | draft | 2026-08-08 |
| ... | ... | ... | ... | ... |
```

**Rules:**
- One row per entity, no duplicates.
- When adding a new entity: insert row in alphabetical order.
- When updating: edit the `Status` and/or `Updated` column.
- When removing: delete the row entirely.

---

## 2. `_master_relationships_map.md` — Global Relationship Graph

A single file that maps **all relationships between all entities**. This is the LLM's quick-reference for navigation. Updated whenever a relationship changes.

### Format:

Each entity gets a section. Relationships are listed as bullet points with a **direction indicator** and a **relationship type**.

```markdown
# Master Relationships Map

## high_king_theron_ironveil [character]
- governs → city_of_embermoor [location] — Ruler of the city
- leads → the_order_of_the_gilded_quill [organization] — Founder and Grandmaster
- allied_with → lady_seraphina_dawnweaver [character] — Political alliance

## city_of_embermoor [location]
- ruled_by ← high_king_theron_ironveil [character] — The High King rules here
- hosts → the_guildhall_of_crafters [organization] — Guildhall located in the city
- neighbor_to → the_verdant_woods [location] — Forests bordering the city
```

### Direction Conventions

| Symbol | Meaning |
|--------|---------|
| `→` | Subject → Target (e.g. "person leads organization", "location contains item") |
| `←` | Subject ← Target (inverse, shown for convenience) — only include if the forward relationship is NOT from the current entity. If A→B already listed under A, B's entry shows B←A. |

### Rules:
- **Every relationship** appears in both directions (once under each entity's section), so the LLM can navigate from either endpoint.
- **Bidirectional relationships** (e.g. allies, marriage) use `↔` symbol.
- **Relationship type** (governs, leads, allied_with, etc.) is kept as a single verb or short phrase.
- **Description** is a brief clarification (1-10 words).
- When adding a new entity: create a new section in alphabetical position.
- When removing an entity: remove its section AND remove all references to it from other entities' sections.

---

## 3. Entity Files

Located in `cache/entities/<type>/<entity_id>.md`. Structure is defined in `instructions/ENTITY_TYPES.md`.

### Present State Rule

The body of every entity file describes the entity **as it exists when the campaign starts**:
- The `## History` section ends at campaign start.
- The `## Overview`, `## Background`, `## Geography`, etc. reflect the state at campaign start.
- Any future events, prophecies, planned developments, or destinies go in a dedicated `## Campaign Events` section at the end of the body (or in the `secrets` frontmatter field where appropriate).
- This keeps the cache timeline-clean and prevents confusion about what the party knows vs. what is yet to happen.

### Key rules for LLM editing:

1. **Never remove frontmatter fields** — only update their values.
2. **Never use images or complex formatting** in the body — plain markdown only.
3. **Keep each section focused** — one idea per subsection.
4. **The `related` field in frontmatter** is a SHORT summary. Full relationship details live in `_master_relationships_map.md`.
5. **The `secrets` field** in frontmatter is a summary. Full secret text can be in the body under a `## Secrets` section.

---

## 4. Editing Rules for LLMs

When editing the cache, always follow this sequence:

1. **Read** `_index.md` — what exists?
2. **Read** relevant entity files — what do we know?
3. **Read** `_master_relationships_map.md` — how is everything connected?
4. **Edit** entity files (create new / update existing).
5. **Update** `_index.md` (add/update rows as needed).
6. **Update** `_master_relationships_map.md` (add/update/remove relationship entries across BOTH sides).

This ensures the cache remains internally consistent at all times.