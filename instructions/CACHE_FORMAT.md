# WorldAnvil Lore Cache — Format Specification

> Defines the structure and constraints for all lore entity files in `cache/entities/`.
> Files MUST be optimized for LLM consumption — concise, machine-readable, modular.

---

## File Format

Each entity file is a Markdown document with:
1. **Frontmatter** (YAML, between `---` delimiters)
2. **Body** (Markdown sections)

---

## Frontmatter Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `id` | ✅ | Snake-case unique ID | `city_of_embermoor` |
| `type` | ✅ | Entity type (see `ENTITY_TYPES.md`) | `location` |
| `name` | ✅ | Display name | `City of Embermoor` |
| `status` | ✅ | `draft`, `active`, `review` | `active` |
| `created` | ✅ | ISO date created | `2026-08-01` |
| `updated` | ✅ | ISO date last updated | `2026-08-08` |
| `tags` | ❌ | Optional tags for categorization | `[secret, divine, campaign]` |
| `secrets` | ❌ | Subscriber groups who should see hidden content | `[gm-only, tier-2]` |
| `related` | ❌ | List of related entity IDs | `[the_great_sacrifice, the_arcane_weave]` |

---

## Body Sections

### Standard Sections (all entity types)
- `## Overview` — Brief description (2-3 sentences max)
- `## Description` — Detailed description (keep under 250 words)
- `## Notes` — Campaign notes, lore context

### Type-Specific Sections
See `ENTITY_TYPES.md` for per-type required sections (e.g., `## Structure` for organizations, `## Appearance` for characters).

---

## 📏 Size Constraints (MANDATORY)

> **Every KB of entity file = money spent on every turn that loads it.**
> Keep files small enough that multiple can be loaded without exploding the context.

| Constraint | Limit | Rationale |
|-----------|-------|-----------|
| **Max file size** | **12 KB** | Above this, split into sub-files |
| **Max overview** | **100 words** | Quick skimmable summary |
| **Max description** | **250 words** | Deeper detail without bloat |
| **Max sections** | **8 per file** | If more needed, split the entity |
| **Max open questions** | **5 per file** | Use tracker in `_session_continuity.md` for more |

### When to Split a File
If a file exceeds 12KB, split it. Common patterns:
- `society_economy_and_culture.md` → `society.md` + `economy.md` + `culture.md`
- `monsters_and_ecology.md` → `monsters.md` + `monster_ecology.md`
- Character with long backstory → main file + `character_name_backstory.md`

---

## Writing Style

- **Be concise.** Use bullet points, tables, and lists over prose paragraphs.
- **Prefer tables** for structured data (relationships, hierarchies, timelines).
- **Avoid redundant wording.** "The god of light" → "God of Light".
- **Use YAML frontmatter** for metadata — don't repeat it in the body.
- **Link entities** in `related` frontmatter field instead of inline prose links.

---

## Secrets & Subscriber Gating

Secrets are hidden sections that should only be visible to specific WorldAnvil subscriber groups (e.g., "GM Only", "Tier 2").

### In the Cache
Add `secrets` to frontmatter with the list of allowed subscriber groups:
```yaml
secrets: [gm-only, tier-2]
```

Use `## 🔒 Section Name` for secret body sections so they're easily identifiable during article generation.

### In Articles (BBCode)
When generating articles, wrap secret sections in BBCode subscriber-group tags.

---

## Relationship Documentation

Relationships between entities are tracked in `cache/_master_relationships_map.md`. Each relationship entry should:

- Be concise (1 line per relationship)
- Use `entity_a → entity_b (relationship_type)` format
- Relationship types: `allies`, `enemies`, `parent`, `child`, `location`, `member_of`, `owns`, `created_by`, `contains`, `knows_about`, `connected_to`
- Add inverse relationships automatically

**Note:** The full relationships map is a **Tier 3** resource (~31KB). Load it only when performing a relationship audit. For normal tasks, state relationships in entity frontmatter's `related` field instead.