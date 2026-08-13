# Article Format  -  WorldAnvil BBCode

Defines the BBCode format for articles generated to be posted on WorldAnvil (WA). All output articles are saved under `articles/output/` as `.bbcode` files.

---

## WA Article Structure  -  Mirroring the Local Cache

The article structure on WorldAnvil should mirror the local cache structure for consistency and easy navigation.

### WA Category Hierarchy

```
World: [Campaign/World Name]
|-- Characters               (WA Category)
|   |-- [Individual Character Articles]
|-- Locations                (WA Category)
|   |-- [Individual Location Articles]
|-- Organizations            (WA Category)
|   |-- [Individual Organization Articles]
|-- Events                   (WA Category)
|   |-- [Individual Event Articles]
|-- Items                    (WA Category)
|   |-- [Individual Item Articles]
|-- Lore & Concepts          (WA Category)
|   |-- [Individual Lore Articles]
|-- Session Logs             (WA Category)  -  optional
|   |-- [Session Recap Articles]
|-- Player Characters        (WA Category)  -  player-facing
|   |-- [PC Profile Articles]
|-- _Master Index            (WA Article, uncategorized or pinned)
    -> Lists every article with a brief description (mirrors `cache/_index.md`)
```

### Category-Entity Mapping

| Cache Folder | WA Category | Article Naming Convention |
|---|---|---|
| `characters/` | Characters | `[entity_id]` -> WA slug: `entity_id` |
| `locations/` | Locations | `[entity_id]` -> WA slug: `entity_id` |
| `organizations/` | Organizations | `[entity_id]` -> WA slug: `entity_id` |
| `events/` | Events | `[entity_id]` -> WA slug: `entity_id` |
| `items/` | Items | `[entity_id]` -> WA slug: `entity_id` |
| `lore/` | Lore & Concepts | `[entity_id]` -> WA slug: `entity_id` |

### The _Master Index Article

A single "master index" article on WA that mirrors `cache/_index.md`. Should be formatted as:

```
[h1]World Index  -  All Articles[/h1]

This index mirrors the lore cache and lists every article in this world.

[h2]Characters[/h2]
[list]
[*] [article:high_king_theron]High King Theron[/article]  -  Ruler of the Ironveil Dynasty
[*] ...
[/list]

[h2]Locations[/h2]
[list]
[*] [article:city_of_embermoor]City of Embermoor[/article]  -  Capital of the Northern Realms
[*] ...
[/list]
... (repeated for each entity type)
```

### Per-Article Structure

Each individual article on WA follows the section structure defined in `instructions/ENTITY_TYPES.md` (Recommended Section Headings by Entity Type). The cache entity file's body sections map 1:1 to the article's BBCode sections.

Defines the BBCode format for articles generated to be posted on WorldAnvil (WA). All output articles are saved under `articles/output/` as `.bbcode` files.

---

## Subscriber Groups (Access Control)

WA uses subscriber groups to gate content. Define groups upfront per world. The following groups MUST exist on the WA world settings:

### Core Groups

| Group ID | Name | Purpose |
|----------|------|---------|
| `all-party` | All Party Members | Shared party knowledge  -  anything the whole party knows but the public doesn't |
| `gm-only` | Game Master Only | Meta-plot, encounter details, lore the DM crafts behind the scenes |

### Per-Player Groups

Create one subscriber group per player character:

| Group ID | Name | Purpose |
|----------|------|---------|
| `player-character-1` | Player: [Character Name] | Secrets specific to that character's backstory, visions, patron info |
| `player-character-2` | Player: [Character Name] | (same) |

### Custom Groups (created as needed)

Examples:
| Group ID | Name | Purpose |
|----------|------|---------|
| `faction-silver-circle` | The Silver Circle | Members of a secret faction |
| `deity-followers-morak` | Followers of Morak | Those who serve the god of secrets |

---

## BBCode Syntax Reference

### Headings
```
[h1]Main Title[/h1]
[h2]Section Title[/h2]
[h3]Subsection Title[/h3]
```

### Text Formatting
```
[b]bold[/b]
[i]italic[/i]
[u]underline[/u]
```

### Lists
```
[list]
[*] First item
[*] Second item
[/list]
```

### Tables
```
[table]
[th]Header 1[/th][th]Header 2[/th]
[td]Cell 1[/td][td]Cell 2[/td]
[td]Cell 3[/td][td]Cell 4[/td]
[/table]
```

### Cross-Article Links
```
[article:entity_id]Display Name[/article]
```
The `entity_id` must match the WA article slug (use the same snake_case ID from the cache).

### Secret / Restricted Content
```
[subscribergroup:all-party]This is shared party knowledge, hidden from the audience.[/subscribergroup]

[subscribergroup:player-character-1]This is a secret only this specific player knows.[/subscribergroup]

[subscribergroup:gm-only]This is behind-the-scenes DM information that no player should see.[/subscribergroup]
```

### Multiple Groups (same content)
Nest or separate  -  WA's BBCode supports one group per tag. For content visible to multiple groups, create separate blocks or combine into a broader group:
```
[subscribergroup:all-party]The party found a strange amulet in the ruins.[/subscribergroup]
[subscribergroup:gm-only]The amulet is actually a bound celestial's prison, and it will try to possess whoever wears it.[/subscribergroup]
```

---

## Article Template

Every article MUST follow this template structure:

```
[h1][b]Entity Name[/b][/h1]

[subscribergroup:gm-only]
[b]GM Note:[/b] Brief metadata note for the DM  -  status, tags, related articles.
[/subscribergroup]

[h2]Overview[/h2]
General description of the entity. What is it? Where is it? Why does it matter?

(For characters: include race, class, alignment, visible traits)
(For locations: include region, size, population, climate)
(For organizations: include type, alignment, membership size, headquarters)

[h2]History[/h2]
Key historical events involving this entity. In chronological order.

[h2]Notable Information[/h2]
Facts, rumors, legends known to the wider world. What would a scholar know?

[subscribergroup:all-party]
[h2]What the Party Knows[/h2]
Information the party has discovered during the campaign but isn't public knowledge.
[/subscribergroup]

[subscribergroup:gm-only]
[h2]DM Notes[/h2]
Behind-the-scenes information: true motives, hidden connections, plot hooks, encounter details.
[/subscribergroup]

[subscribergroup:gm-only]
[h2]Campaign Events / Future[/h2]
Events, prophecies, or developments that have not yet occurred at campaign start. 
Includes plot hooks, planned encounters, character destinies, and any lore that will 
unfold during the campaign. Nothing in this section is known to the world at large.
[/subscribergroup]

[h2]Related Articles[/h2]
[list]
[*] [article:related_entity_id]Related Entity Name[/article]  -  Brief description of connection
[*] [article:another_entity_id]Another Entity[/article]  -  Brief description
[/list]
```

---

## Article Generation Rules

When generating articles for new entities:

1. **Use the template above** as the base structure.
2. **Fill every section** with content derived from the cache entity file.
3. **Use `[subscribergroup]` blocks** wherever content is NOT public knowledge.
4. **Cross-link** all mentioned entities using `[article:id]name[/article]`.
5. **Secrets from the cache** go under `## DM Notes` (gm-only), `## What the Party Knows` (all-party), or per-character sections as appropriate.
6. **File name**: `<entity_id>.bbcode` in `articles/output/`.

### Present State vs Future Events  -  CRITICAL RULE

**Articles describe the world as it exists when the campaign starts.** Lore, conditions, relationships, and knowledge must reflect the starting state  -  not what will happen later.

- The main body sections (`## Overview`, `## History`, `## Notable Information`, etc.) describe only **what is true at campaign start**.
- **Anything that hasn't happened yet**  -  prophecies, impending events, planned invasions, character destinies, future plot developments  -  MUST go in a dedicated section called:

  ```
  [h2]Campaign Events / Future[/h2]
  ```

  This section should be gated under the appropriate subscriber group:
  - `[subscribergroup:gm-only]` for plot hooks, planned encounters, future twists the DM hasn't revealed.
  - `[subscribergroup:all-party]` for known prophecies, foreseen events, or upcoming plans the party is aware of at campaign start.

- **Examples of what goes in the Future section:**
  - A prophecy about the destruction of a city -> `[subscribergroup:all-party]` (if the party knows the prophecy)
  - The BBEG's planned ritual in 3 months -> `[subscribergroup:gm-only]`
  - A character's hidden destiny to become a lich -> `[subscribergroup:gm-only]`
  - An invasion fleet that hasn't sailed yet -> `[subscribergroup:gm-only]` or `[subscribergroup:all-party]` depending on knowledge

- **The `## History` section** ends at campaign start. Do not include events that happen during or after the campaign's beginning.

When updating existing articles (summaries of changes):

1. Present a bullet list of **each individual change** needed.
2. For each change, specify: **Which article**, **Which section**, **What to add/remove/modify**, **The exact BBCode to insert**.
3. Do NOT regenerate the full article  -  only describe the changes.

---

## Secret Distribution Guidelines

| Type of Content | Group |
|-----------------|-------|
| Public lore, history, geography | No restriction |
| Party's discoveries, theories, ongoing quests | `all-party` |
| Character's personal backstory, visions, patron | Specific `player-character-N` |
| True motives of NPCs, future plot events, traps, monster stats | `gm-only` |
| Faction-internal secrets not yet revealed | `gm-only` or custom faction group |
| **Prophecies, impending events, future plot hooks (Campaign Events)** | `gm-only` (default) or `all-party` if known to party at campaign start |