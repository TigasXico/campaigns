# WorldAnvil Lore Cache -- Format Specification

Defines the structure and constraints for all lore entity files in `cache/`.
Files MUST be optimized for LLM consumption -- concise, machine-readable, modular.

---

## File Format

Each entity file is a Markdown document with:
1. **Frontmatter** (YAML, between `---` delimiters)
2. **Body** (Markdown sections)

---

## Frontmatter Fields

| Field | Required | Description | Example |
|-------|----------|-------------|---------|
| `id` | YES | Snake-case unique ID | `city_of_embermoor` |
| `type` | YES | Entity type (character, location, organization, event, item, lore, species, campaign_note) | `location` |
| `name` | YES | Display name | `City of Embermoor` |
| `status` | YES | `draft`, `active`, `review`, `complete` | `active` |
| `created` | YES | ISO date created | `2026-08-01` |
| `updated` | YES | ISO date last updated | `2026-08-08` |
| `related` | Optional | List of related entity IDs with directional relationship descriptions | See format below |
| `secrets` | Optional | Array of secrets tied to this entity (see SECRETS section below) | See below |

### Tags Field

The `tags` field has been **removed** from the standard frontmatter. Tags were found to provide limited utility for the LLM workflow. If a specific entity needs categorization, use the body sections or the index table.

---

## Relationship Format

Relationships are tracked in each entity file's `related:` frontmatter. They are **directional** from the source entity's perspective.

### Format

```yaml
related:
  - target_entity_id: Free-text description of the relationship from this entity's perspective
```

### Examples

```yaml
related:
  - the_thormvuld_family: FX orchestrated the heist against the Thormvulds
  - the_arcane_reactive_crystals: FX's mission was to acquire B-crystal samples
  - the_flesh_architects: FX discovered the Thormvulds are running experiments similar to the Flesh Architects
```

### Rules

1. **Directional from source**: The description should read as "THIS entity --verb--> target entity"
2. **No type labels**: Use free-text descriptions, not fixed relationship types (e.g., no `(allies)`, `(enemies)` labels)
3. **No automatic inverses**: If entity A links to entity B in A's `related:` field, that is sufficient. Do NOT automatically add a reverse entry to entity B's `related:` field -- unless there is a distinct relationship worth documenting from B's perspective
4. **Timeline rule**: Entities link TO the timeline. The timeline does NOT link back (its `related:` field stays empty to prevent bloat)

### Querying

Use `scripts\get-entity-relationships.ps1` for relationship queries:
- `-Entity id` -- relationships FROM this entity
- `-Target id` -- relationships TO this entity (inbound lookups)
- `-Network id` -- full ego network (both directions)
- `-All` -- full map
- `-Stats` -- summary statistics
- `-Validate` -- ensure all targets have valid entity files

---

## Body Sections

### Standard Sections (all entity types)
- `## Overview` -- Brief description (2-3 sentences max)
- `## Description` -- Detailed description (keep under 250 words)
- `## Notes` -- Campaign notes, lore context

### Type-Specific Sections
See `instructions/ENTITY_TYPES.md` for per-type recommended sections.

### Present State vs Future Events

The body of every entity file describes the entity **as it exists when the campaign starts**. Do not include events or developments that occur during or after the campaign's beginning in the main sections.

Future-facing content goes in:
- A `## Campaign Events` section at the end of the body (for prophecies, planned events, future plot developments)
- The `secrets` frontmatter field (for gated content)

---

## Size Constraints (MANDATORY)

> Every KB of entity file = money spent on every turn that loads it.

| Constraint | Limit | Rationale |
|-----------|-------|-----------|
| Max file size | **12 KB** | Above this, split into sub-files |
| Max overview | **100 words** | Quick skimmable summary |
| Max description | **250 words** | Deeper detail without bloat |
| Max sections | **8 per file** | If more needed, split the entity |
| Max open questions | **5 per file** | Use tracker in `_session_continuity.md` for more |

### Exceptions to the 12KB Cap

- **Player Character (PC) entity files** -- exempt (full backstory files)
- **Master timeline** (`cache/events/kythorian_timeline.md`) -- exempt (central chronological reference)

### When to Split

If a file exceeds 12KB, split it. Common patterns:
- `society_economy_and_culture.md` -> `society.md` + `economy.md` + `culture.md`
- Character with long backstory -> main file + `character_name_backstory.md`

---

## Secrets

Secrets are hidden sections that should only be visible to specific WorldAnvil subscriber groups.

### In the Cache

Add `secrets` to frontmatter with the list of allowed subscriber groups:

```yaml
secrets:
  - text: "Detailed secret content here"
    access: GM Only
  - text: "Character-specific secret"
    access: Balor
```

Use `## [GM] Section Name` for secret body sections so they're easily identifiable during article generation.

### In Articles (BBCode)

When generating WA articles, wrap secret sections in BBCode subscriber-group tags:
```
[subscribergroup:GM Only]content[/subscribergroup]
[subscribergroup:Balor]character-specific content[/subscribergroup]
```

### Available Subscriber Groups

See `cache/wa_article_registry.md` for current subscriber group IDs and names.

---

## Writing Style

- **Be concise.** Use bullet points, tables, and lists over prose paragraphs.
- **Prefer tables** for structured data (relationships, hierarchies, timelines).
- **Avoid redundant wording.** "The god of light" -> "God of Light".
- **Use YAML frontmatter** for metadata -- don't repeat it in the body.
- **Link entities** in `related` frontmatter field using the format above.

---

## Audit Checklist (Mandatory Per-Entity Review)

Every entity file must pass the following checks before creation or modification:

### Canon Check
- [ ] Does this entity respect the timeline? (events before ~200 YA, ~200 YA founding, ~20 YA to present)
- [ ] Does geographic placement match the known map? (three capitals east, frontier west, north monster-held)
- [ ] Does this respect the divine conspiracy? (gods hide the truth, Originals are secret, invasion was orchestrated)
- [ ] Does this respect the core themes? (survival through unity, divine deception, hoarding instinct, three-way standoff)

### Connection Check
- [ ] Does the `related` field link to at least 2-3 existing entities?
- [ ] Does this answer or create any open question tracked in `_session_continuity.md`?

### Style Check
- [ ] File under 12KB? (mandatory)
- [ ] Overview under 100 words? (mandatory)
- [ ] Uses concise bullet points over prose paragraphs?
- [ ] Frontmatter complete (id, type, name, status, created, updated)?
- [ ] Secrets properly gated in BBCode articles?

### Prohibited Content
- **No autonomous lore generation.** Every piece of new lore must originate from user input.
- **No unapproved narrative commitments.** Never write lore that commits the user to a specific plot direction without presenting alternatives first.
- **No silent fixes.** If you spot a potential inconsistency, flag it to the user before correcting it.