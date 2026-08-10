# WorldAnvil Lore Cache  -  Format Specification

> Defines the structure and constraints for all lore entity files in `cache/entities/`.
> Files MUST be optimized for LLM consumption  -  concise, machine-readable, modular.

---

## File Format

Each entity file is a Markdown document with:
1. **Frontmatter** (YAML, between `---` delimiters)
2. **Body** (Markdown sections)

---

## Frontmatter Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `id` | [ok] | Snake-case unique ID | `city_of_embermoor` |
| `type` | [ok] | Entity type (see `ENTITY_TYPES.md`) | `location` |
| `name` | [ok] | Display name | `City of Embermoor` |
| `status` | [ok] | `draft`, `active`, `review` | `active` |
| `created` | [ok] | ISO date created | `2026-08-01` |
| `updated` | [ok] | ISO date last updated | `2026-08-08` |
| `tags` | [x] | Optional tags for categorization | `[secret, divine, campaign]` |
| `secrets` | [x] | Subscriber groups who should see hidden content | `[gm-only, tier-2]` |
| `related` | [x] | List of related entity IDs | `[the_great_sacrifice, the_arcane_weave]` |

---

## Body Sections

### Standard Sections (all entity types)
- `## Overview`  -  Brief description (2-3 sentences max)
- `## Description`  -  Detailed description (keep under 250 words)
- `## Notes`  -  Campaign notes, lore context

### Type-Specific Sections
See `ENTITY_TYPES.md` for per-type required sections (e.g., `## Structure` for organizations, `## Appearance` for characters).

---

## [emoji] Size Constraints (MANDATORY)

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
- `society_economy_and_culture.md` -> `society.md` + `economy.md` + `culture.md`
- `monsters_and_ecology.md` -> `monsters.md` + `monster_ecology.md`
- Character with long backstory -> main file + `character_name_backstory.md`

---

## Writing Style

- **Be concise.** Use bullet points, tables, and lists over prose paragraphs.
- **Prefer tables** for structured data (relationships, hierarchies, timelines).
- **Avoid redundant wording.** "The god of light" -> "God of Light".
- **Use YAML frontmatter** for metadata  -  don't repeat it in the body.
- **Link entities** in `related` frontmatter field instead of inline prose links.

---

---

##  Audit Checklist (Mandatory Per-Entity Review)

Every entity file must pass the following checks before creation or modification:

### [emoji] Canon Check
- [ ] Does this entity respect the timeline? (events before ~200 YA, ~200 YA founding, ~20 YA to present)
- [ ] Does geographic placement match the known map? (three capitals east, frontier west, north monster-held)
- [ ] Does this respect the divine conspiracy? (gods hide the truth, Originals are secret, invasion was orchestrated)
- [ ] Does this respect the core themes? (survival through unity, divine deception, hoarding instinct, three-way standoff)

### [emoji] Connection Check
- [ ] Does the `related` field link to at least 2-3 existing entities?
- [ ] Does this answer or create any open question tracked in `_session_continuity.md`?
- [ ] Does this create a new open question that should be tracked?

### [edit] Style Check
- [ ] File under 12KB? (mandatory)
- [ ] Overview under 100 words? (mandatory)
- [ ] Uses concise bullet points over prose paragraphs?
- [ ] Frontmatter complete (id, type, name, status, created, updated)?
- [ ] Secrets properly gated with `subscribergroup` in BBCode articles?

### [emoji] Prohibited Content
- **No autonomous lore generation.** Every piece of new lore must originate from user input.
- **No unapproved narrative commitments.** Never write lore that commits the user to a specific plot direction without presenting alternatives first.
- **No silent fixes.** If you spot a potential inconsistency, flag it to the user before correcting it.

---

Secrets are hidden sections that should only be visible to specific WorldAnvil subscriber groups (e.g., "GM Only", "Tier 2").

### In the Cache
Add `secrets` to frontmatter with the list of allowed subscriber groups:
```yaml
secrets: [gm-only, tier-2]
```

Use `## [emoji] Section Name` for secret body sections so they're easily identifiable during article generation.

### In Articles (BBCode)
When generating articles, wrap secret sections in BBCode subscriber-group tags.

---

## Relationship Documentation

Relationships between entities are tracked in `cache/_master_relationships_map.md`. Each relationship entry should:

- Be concise (1 line per relationship)
- Use `entity_a -> entity_b (relationship_type)` format
- Relationship types: `allies`, `enemies`, `parent`, `child`, `location`, `member_of`, `owns`, `created_by`, `contains`, `knows_about`, `connected_to`
- Add inverse relationships automatically

**Note:** The full relationships map is a **Tier 3** resource (~31KB). Load it only when performing a relationship audit. For normal tasks, state relationships in entity frontmatter's `related` field instead.