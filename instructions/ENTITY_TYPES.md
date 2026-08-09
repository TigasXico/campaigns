# Entity Types & Schemas

Defines all entity categories used in the lore cache and their required/optional fields.

---

## Entity Categories

| Category | Folder | Description |
|----------|--------|-------------|
| **Character** | `cache/entities/characters/` | NPCs, PCs, deities, legendary figures |
| **Location** | `cache/entities/locations/` | Continents, nations, cities, dungeons, regions |
| **Organization** | `cache/entities/organizations/` | Guilds, factions, religions, military orders |
| **Event** | `cache/entities/events/` | Battles, festivals, cataclysms, historical milestones |
| **Item** | `cache/entities/items/` | Artifacts, magic items, relics, legendary weapons |
| **Lore/Concept** | `cache/entities/lore/` | Magic systems, cultural practices, prophecies, laws, philosophies |
| **Campaign Note** | `cache/entities/campaign_notes/` | GM-facing design decisions, worldbuilding rationale, meta-lore, session continuity |

---

## Entity File Schema

Every entity file (`cache/entities/<type>/<entity_id>.md`) MUST contain the following structure:

```yaml
---
id: entity_id_in_snake_case
type: character|location|organization|event|item|lore|campaign_note
name: "Display Name"
status: draft|active|revised|archived
tags:
  - tag1
  - tag2
related:
  - entity_id_1: relationship_description
  - entity_id_2: relationship_description
secrets:
  - text: "Secret content about this entity"
    access: subscriber_group_name
  - text: "Another secret"
    access: subscriber_group_name
created: YYYY-MM-DD
updated: YYYY-MM-DD
---
```

### Frontmatter Fields

| Field | Required | Description |
|-------|----------|-------------|
| `id` | ✅ | Unique snake_case identifier |
| `type` | ✅ | One of the 6 entity types above |
| `name` | ✅ | Display name (can include spaces, diacritics) |
| `status` | ✅ | Lifecycle status of this entity |
| `tags` | ❌ | Freeform tags for filtering & categorization |
| `related` | ❌ | Links to other entity IDs with a brief description of the relationship |
| `secrets` | ❌ | Array of secrets tied to this entity (see SECRETS section below) |
| `created` | ✅ | Date entity was first created in cache |
| `updated` | ✅ | Date of last modification |

### Body Section

After the frontmatter, the body contains **narrative content** in plain Markdown. Sections are separated by `##` headings. Content must be:

- **Concise** — LLM-friendly, no fluff.
- **Factual** — lore descriptions, history, appearance, personality, etc.
- **Organized** — use consistent section headings per entity type.

---

## Recommended Section Headings by Entity Type

> **IMPORTANT:** The body of every entity file describes the entity **as it exists when the campaign starts**. Do not include events or developments that occur during or after the campaign's beginning in the main sections. Use a `## Campaign Events` section at the end of the body (or the `secrets` frontmatter field) for any future-facing content. See `ARTICLE_FORMAT.md` — *Present State vs Future Events* for details.

### Character
`## Overview` · `## Appearance` · `## Personality` · `## Background` · `## Abilities` · `## Goals` · `## Relationships` · `## Secrets`

### Location
`## Overview` · `## Geography` · `## History` · `## Notable Features` · `## Inhabitants` · `## Points of Interest` · `## Secrets`

### Organization
`## Overview` · `## Structure` · `## Membership` · `## Goals` · `## Headquarters` · `## History` · `## Secrets`

### Event
`## Overview` · `## Date` · `## Causes` · `## Participants` · `## Outcome` · `## Aftermath` · `## Secrets`

### Item
`## Overview` · `## Description` · `## Properties` · `## History` · `## Current Location` · `## Secrets`

### Lore/Concept
`## Overview` · `## Principles` · `## Practice` · `## Significance` · `## Variations` · `## Secrets`

### Campaign Note
`## Overview` · `## Design Rationale` · `## Key Decisions` · `## Implications` · `## Open Questions`

---

## Entity IDs

- Format: `snake_case`
- Must be unique across ALL entity types
- Use descriptive but concise IDs
- Examples: `high_king_theron_ironveil`, `the_sunken_citadel_of_thalassar`, `the_order_of_the_gilded_quill`

## Tags

Tags should be used for cross-cutting concerns:
- `#player-character` / `#npc` / `#deity`
- `#capital` / `#dungeon` / `#region`
- `#faction` / `#religion` / `#guild`
- `#artifact` / `#consumable`
- `#plot-hook` / `#lore-secret`
- `#campaign:campaign_name`