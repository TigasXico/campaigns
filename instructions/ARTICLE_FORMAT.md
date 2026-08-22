# Article Format -- WorldAnvil BBCode

Defines the BBCode format for articles created on WorldAnvil (WA). All articles are pushed to WA via the MCP API. Local copies are saved under `articles/output/` as `.bbcode` files for reference.

---

## Direct-Push Workflow (decided 2026-08-22)

1. Generate the article from cache and push immediately (create or update). No pre-approval show-and-wait.
2. Choose and apply the visibility class yourself (defaults below); DM notes always go in the GM Only container.
3. Reply with the article's edit-view link plus applied settings (template, category, visibility class).
4. The user edits directly on WA (Advanced Editor/Euclid ONLY).
5. On the user's done signal: fetch the final version from WA -> save it as the canonical local copy under `articles/output/` -> update `cache/wa_article_registry.md`.

Edit-view link: prefer a URL returned by the API; otherwise give `https://www.worldanvil.com/w/<world_slug>/a/<article_slug>` and tell the user to open the editor from there.

---

## Cache-to-Article Mapping

**Cache-to-article mapping is NOT 1-to-1.** A single cache entity file does not automatically become a single WA article. Before generating any WA content, determine the appropriate mapping:

| Mapping Strategy | When to Use |
|-----------------|-------------|
| **One cache entity = one WA article** | Default case. Entity has focused, coherent content suitable for a single article. |
| **One cache entity = multiple WA articles** | Entity has extensive or distinct sub-topics (e.g., a continent file with geography, history, and culture sections that each deserve their own article). |
| **Multiple cache entities = one WA article** | Several small entities cover closely related topics better presented together (e.g., minor NPCs in a faction article, or a collection of related items). |
| **Content added to an existing WA article** | New information belongs with an already-published topic rather than warranting its own article. |
| **No WA article needed** | Some cache entities serve only as internal reference (e.g., campaign notes, session planning files) and don't need publication. |

The mapping strategy is chosen by the agent and reported in the push summary; the user can override it during their WA editing pass (Direct-Push Workflow, 2026-08-22).

---

There is **no enforced article template**. Each article's structure depends on its entity type and content. The `instructions/ENTITY_TYPES.md` file provides **recommended section headings** per entity type, but these are guidelines, not rules.

---

## Article Templates on WorldAnvil

WA offers many templates. Each has its own prompts and fields. We use the **template type** parameter when creating articles via the MCP.

### Template Selection Guide

Use the correct WA template based on what the article is about.

| Template | WA Slug | Use For | Example |
|----------|---------|---------|---------|
| **Generic Article** | `article` | Default when no other template fits. No prompts. | Events, campaign notes, meta-lore |
| **Character** | `character` | NPCs, PCs, deities, any individual with agency | FX, Kaelthor, Balor |
| **Location, Geographic** | `geography` | Continents, regions, natural features, planes of existence | Kythoria, The Frostmaw, The Underdark |
| **Location, Settlement** | `settlement` | Cities, towns, villages of any size | Skywatch, Emberforge, Stonefall |
| **Location, Building** | `building` | Specific buildings, structures, landmarks | The High Septon, Site Gamma-7 |
| **Organization** | `organization` | Countries, religions, guilds, clans, factions, companies | First Alliance, Crimson Covenant, Skallfang Clan |
| **Item** | `item` | Artifacts, weapons, tools, food, clothing, magical items | Khar'zul's Blade, Medallion of Vex |
| **Species** | `species` | Plants, animals, races, intelligent species | Dragonborn, Drow, Elves |
| **Natural Law** | `law` | Magic systems, rules of physics, how the world works | Arcane Weave, Reactive Crystals |
| **Myth / Legend** | `myth` | Myths, prophecies, urban legends, creation stories | The Divine Conspiracy, The Originals |
| **Document** | `document` | Books, scrolls, written documents with hidden text | In-world texts |
| **Tradition / Ritual** | `tradition` | Festivals, ceremonies, cultural practices, social constructs | (campaign-specific) |
| **Profession** | `profession` | Unique jobs in your world | Adventuring Classes |
| **Condition** | `condition` | Diseases, mutations, transformations, RPG conditions | (campaign-specific) |
| **Material** | `material` | Unique materials | Arcane-Reactive Crystals |
| **Technology** | `technology` | How a technology works in general terms | (campaign-specific) |
| **Ethnicity** | `ethnicity` | Cultures, sub-cultures, people sharing common ancestry | (campaign-specific) |
| **Spell** | `spell` | Specific spells, rituals, magical manifestations | (campaign-specific) |
| **Military Unit** | `military-formation` | Special types of military formation | (campaign-specific) |
| **Title** | `title` | Specific ranks or titles | (campaign-specific) |
| **Vehicle** | `vehicle` | Moving structures with transportation as primary goal | (campaign-specific) |
| **Language** | `language` | Conlangs, naming languages | (campaign-specific) |
| **Plot** | `plot` | RPG session planning, novel outlining | (campaign-specific) |
| **Session Report** | `report` | Campaign session recaps and planning | Session logs |
| **Prose** | `prose` | Short stories, scenes, narrative writing | (campaign-specific) |

### Template Choice & BBCode Safety

A historical claim that non-`article` templates strip BBCode closing tags (`[/article]`) was **disproven**: a live tag-survival test on the `myth` template (2026-08-22) confirmed ALL BBCode lands intact -- links, containers, formatting, closing tags included.

**Rule:** Choose the most specific fitting template from the Selection Guide above; generic `article` is only the fallback when nothing fits. Round-trip fetch after creation to verify what landed (standard practice for any push).

### Template-Specific Fields

Some templates accept special fields via the `fields` parameter. These vary by template:

| Template | Fields Available |
|----------|-----------------|
| character | `localization`, `manifestation`, `anatomy`, `traits`, `seeded`, `authornotes`, `culture` |
| species | `anatomy`, `traits`, `seeded`, `authornotes` |
| law | `lawtype`, `manifestation`, `seeded`, `authornotes` |
| item | `itemtype`, `seeded`, `authornotes` |
| organization | `organizationtype`, `seeded`, `authornotes` |
| location | `locationtype`, `seeded`, `authornotes` |

Use these fields for structured data. Content in these fields also gets Markdown-to-BBCode conversion; embedded raw BBCode passes through verbatim.

---

## Content Format (Markdown + Embedded BBCode)

**EDITOR RULE:** This world uses the **Advanced Editor (Euclid)**. NEVER open/save articles in the Visual Editor (Plutarch) -- it does not support containers or custom BBCode and will silently break them.

Content is written as **explicit BBCode** (deterministic rendering under Euclid); Markdown may be mixed in and the MCP auto-converts it. Blank lines create paragraphs (`[p]` optional). The converter **preserves** embedded BBCode tags (like `[article:]`, `[subcontainer:]`, `[secret:]`). Always round-trip fetch after major pushes to verify.

### Markdown Elements (Auto-Converted by MCP)

| Element | Write As | Converts To |
|---------|----------|-------------|
| Heading | `## Title` | `[h2]Title[/h2]` |
| Bold | `**text**` | `[b]text[/b]` |
| Italic | `*text*` | `[i]text[/i]` |
| Strikethrough | `~~text~~` | `[s]text[/s]` |
| Horizontal rule | `---` | `[hr]` |
| Link | `[text](url)` | `[url=url]text[/url]` |

### BBCode Elements (Write Directly)

| Element | Write As | Notes |
|---------|----------|-------|
| Cross-article link (by slug) | `[article:SLUG]Display Name[/article]` | Use the WA article's SLUG. Preferred format; take SLUG from the create reply or registry. |
| Cross-article link (by UUID) | `@[Display Name](Article:UUID)` | Alternative format using WA article UUID. |
| Subscriber container (DEFAULT gate) | `[subcontainer:GROUP_UUID]content[/subcontainer]` | Content renders ONLY to members of that subscriber group. Zero UI steps, fully automatable. UUIDs in registry. |
| Inline secret embed (fallback) | `[secret:SECRET_UUID]` | Requires creating the secret entity via API AND assigning its access group manually in the WA UI. Use only when containers don't fit. |
| GM metadata note | `[subcontainer:0a5c796a-9e4a-4731-979d-07ac9c05d97e]**GM Note:** text[/subcontainer]` | GM Only group UUID. |

### Important: Lists

**Use `- item` for unordered lists, NOT `* item`.** The markdown converter processes italic (`*text*`) BEFORE lists, so `* item` becomes `[i]item[/i]` instead of `[li]item[/li]`.

**Correct:**
```
- First item
- Second item
```
Converts to: `[ul][li]First item[/li][li]Second item[/li][/ul]`

**Incorrect:**
```
* First item
* Second item
```
Converts to: `[i] First item[/i][i] Second item[/i]` (BROKEN)

### Spacing & Flare Rules (decided 2026-08-22)

- **No blank lines between BBCode blocks** - Euclid renders them as extra vertical gaps ("spaced and weird"). Write blocks back-to-back, one per line.
- **Add styling flare to every lore article**: [hr] separators between major sections, a [quote] epigraph under the title, icon classes, columns/spoilers where fitting. Epigraphs and light connective wording may be generated directly; the user polishes wording during their WA editing pass.
- **Prefer specific templates** (myth, law, geography, settlement, building, organization, item, species, character...) over generic "article" whenever the entity fits. BBCode tag survival is NOT template-dependent (verified live on `myth`, 2026-08-22).

### NOT Auto-Converted Elements

These BBCode elements must be written directly (no Markdown equivalent):
- `[img]`, `[map]`, `[block]` (embeds)
- `[aloud]`, `[spoiler]` (containers)
- `[row]`, `[col]` (columns)

---

## Cross-Article Linking

**CANONICAL FORMAT (2026-08-22):** `@[Display Name](<template>:UUID)` mentions ONLY -- verified working live. The `[article:SLUG]...[/article]` tag does NOT render reliably on WA; do NOT use it for new content. `<template>` = the TARGET article's template type (law, myth, article, character, ...). Placeholder tokens resolve to this mention format.

### Two Valid Formats

Both formats work on every template type:

#### Option 1: `[article:SLUG]Name[/article]` (preferred)

```
[article:the-great-sacrifice-article]The Great Sacrifice[/article]
```

**Requirements:**
- `SLUG` must be the actual WA slug (returned in the create reply)
- If the target article doesn't exist yet, this renders as plain text

#### Option 2: `@[Name](Article:UUID)`

```
@[The Great Sacrifice](Article:6bcf7b43-006e-40d2-a1da-16c5a787c39e)
```

**Requirements:**
- `UUID` must be the WA article's actual UUID
- WA renders this as a link even if the article is private/draft

### Getting Article UUIDs and Slugs

After creating an article, its UUID is returned in the API response and its slug can be determined by fetching it back:

```
const result = await Worldanvilmcp.worldanvilCreateArticle({...});
const articleId = result.id;  // UUID like "6bcf7b43-..."

// Fetch back to get slug
const article = await Worldanvilmcp.worldanvilGetArticle({article_id: articleId});
const slug = article.slug;  // e.g. "the-great-sacrifice-article"
```

Record both in `cache/wa_article_registry.md`.

### Order of Creation Matters

To have valid cross-links from day 1, create articles **bottom-up** (foundations first). Articles created in later phases can link to articles from earlier phases whose UUIDs and slugs are already known.

### Placeholder Strategy

When creating article content that needs to link to an entity whose WA article doesn't exist yet:

1. Use the cache entity ID as a placeholder:
   ```
   @[First Alliance](Article:PLACEHOLDER_the_first_alliance)
   @[Crimson Covenant](Article:PLACEHOLDER_the_crimson_covenant)
   @[Balor Skallfang](Article:PLACEHOLDER_balor_skallfang)
   ```

2. The format is: `Article:PLACEHOLDER_<cache_entity_id>`

3. After the target article is created and you have its real UUID, resolve the placeholder everywhere it appears:
   - Scan `cache/wa_article_registry.md` for all articles that contain this placeholder
   - For each article that contains the placeholder, fetch its current WA content
   - Replace `@[Name](Article:PLACEHOLDER_entity_id)` with `[article:<slug-from-create-reply>]Name[/article]` in the content
   - Update the WA article via `worldanvilUpdateArticle({article_id, content: updatedContent})`
   - Update the local `.bbcode` file
   - Update the registry to mark the placeholder as resolved

4. Placeholders are tracked in `cache/wa_article_registry.md` under the `## Pending Placeholders` section.

### Resolving Placeholders (Step-by-Step)

When a new article is created on WA, resolve all placeholders pointing to it:

```
1. Get new article SLUG from the creation response (create reply includes slug; verified 2026-08-22)
2. Look up "new_entity_id" in registry's Pending Placeholders table
   -> Finds all articles that reference PLACEHOLDER_new_entity_id
3. For each source article:
   a. Fetch current WA content via worldanvilGetArticle({article_id})
   b. Replace "@[Name](Article:PLACEHOLDER_new_entity_id)" with "[article:<slug>]Name[/article]"
   c. Push update via worldanvilUpdateArticle({article_id, content})
   d. Update local .bbcode file
4. Mark placeholder as resolved in registry
```

---

## Access Control (Subscriber Groups)

### Strategy (decided 2026-08-21)

1. **Subcontainers are the default gating mechanism**: `[subcontainer:GROUP_UUID]content[/subcontainer]`. Fully automatable end-to-end (references the group UUID directly, no per-article UI work). Confirmed working live + official docs (Grandmaster tier).
2. **Secrets are the fallback**, used only if containers don't fit a case. Secrets embed inline via `[secret:SECRET_UUID]`; each secret needs its access group assigned manually in the WA UI.
3. **Whole-article visibility is fully automatable** (verified 2026-08-22): pass fields: { state: "private", subscribergroups: [{ id: "<GROUP_UUID>" }], isWip, isDraft } to worldanvilCreateArticle / worldanvilUpdateArticle. The MCP merges fields into the top-level API body and the proxy forwards bodies verbatim. The create reply returns the article's UUID AND slug.
4. Full official tag reference: https://www.worldanvil.com/learn/bbcode-tutorials/basic-bbcode

### Visibility Review Step (mandatory before every upload; decided 2026-08-22)

Choose ONE visibility class for every article and state it in the push summary (Direct-Push Workflow: no pre-approval):
1. **Fully private, no subscriber groups** -- GM eyes only (no groups attached).
2. **Private + subscriber groups** -- visible only to GM and the listed player group(s).
3. **Public with private sections** -- public body; DM notes/secrets wrapped in [subcontainer:<GM Only UUID>]...[/subcontainer] or per-character group containers.
DM notes are ALWAYS limited to the GM Only group, regardless of class.

### Rules

| Content Type | Access Level | How |
|-------------|--------------|-----|
| Public lore, history, geography | Public (no tag) | Write normally |
| Party discoveries, shared knowledge | Public (no tag) | Party knowledge is public in this setting |
| DM-only secrets, true motives, future events | Restricted | `[subcontainer:<GM Only UUID>]...[/subcontainer]` |
| Per-character secrets, backstory | Restricted | `[subcontainer:<CharacterGroup UUID>]...[/subcontainer]` |
| Whole article GM-eyes-only | Private, no groups | fields: { state: "private" } |
| Whole article for specific player(s) | Private + groups | fields: { state: "private", subscribergroups: [{ id: "<GROUP_UUID>" }] } |

### Available Subscriber Groups (UUIDs)

Full UUID table lives in `instructions/CACHE_FORMAT.md` (Secrets section) and `cache/wa_article_registry.md`. Every player character has its own subscriber group (Aegon, Aurora, Balor, Bardolemeu, Kaelyn, Nyra, Odessa, Sanzo, Zan), plus **GM Only**. New groups: fetch via `worldanvilListSubscribergroups`, then record in both files.

> NOTE: API-created content must stay Euclid-edited. Opening an article in the Visual Editor and saving destroys containers/custom BBCode.

---

## Article Creation via WA MCP

### Creating a New Article

```
Worldanvilmcp.worldanvilCreateArticle({
  title: "Article Title",
  world_id: "a07186fa-ce6a-40d0-b9fb-2377f33c9cd3",
  template: "myth",      // pick per Template Selection Guide
  content: "## Markdown content with @[Name](Article:uuid) links",
  category_id: "category-uuid"
})
```

**After creation:**
1. Capture the returned article UUID AND slug (both are in the create reply; verified 2026-08-22)
2. Fetch the article back to verify the content landed correctly (and to grab the real slug if ever needed)
3. Save local copy → `articles/output/<entity_id>.bbcode`
4. Update registry → `cache/wa_article_registry.md`

### Updating an Existing Article

```
Worldanvilmcp.worldanvilUpdateArticle({
  article_id: "article-uuid",
  content: "## Updated content with @[Name](Article:uuid) links"
})
```

### Cross-Link Update Pattern

When creating a new article, it may need to link to existing articles AND existing articles may need to be updated to link back to the new one:

1. Create new article with `@[Existing Name](Article:existing-uuid)` links
2. Update existing articles to add `@[New Name](Article:new-uuid)` back-links
3. Execute both operations in one pass and report

---

## WA Category Structure

| Category | WA ID | Parent | For |
|----------|-------|--------|-----|
| Characters | `59015c22-a174-43a0-9125-07e465616dad` | (none) | NPCs, Deities |
| Player Characters | `4791a56f-b2ac-46cf-849b-7afd54402a15` | Characters | PC profiles |
| Locations | `e89bfe08-a029-4414-bdf7-d685f05b52ff` | (none) | All locations |
| Organizations | `7d5a1bd4-b287-4211-b396-1361c73061ff` | (none) | All organizations |
| Events | `1d06691b-0621-4c02-b059-1d29f0da4911` | (none) | Historical events |
| Items | `39ef8426-b093-47fc-a404-b3f67e911b54` | (none) | Artifacts, magic items |
| Workings of the World | `688bfe84-fdc8-477d-a805-bea8dd45d052` | (none) | Cosmology, creation myth, magic, lore -- **Phase 0 home** |
| Religion | `207ee603-d485-457b-9deb-652e11c1d825` | (none) | Gods, pantheon, worship |
| Festivals | `ea5f2a1a-b124-466c-a917-9f40f27ebb6c` | (none) | Festivals, ceremonies |
| Session Logs | `a724e278-d1c8-44f5-af3f-6ede51206d37` | (none) | Campaign session recaps |

---

## Article Creation Order

To minimize broken cross-references, create articles **bottom-up** (foundations first):

1. **Workings of the World** -- Cosmology, creation myth, magic, geography, divine conspiracy
2. **Locations (Regions)** -- Continents, major regions
3. **Locations (Settlements)** -- Cities, towns, dungeons
4. **Workings of the World (Society)** -- Species, culture, economy, monsters
5. **Organizations** -- All factions and guilds
6. **Characters (Deities)** -- Pantheon
7. **Characters (NPCs)** -- Key NPCs
8. **Events** -- Timeline entries, history
9. **Items** -- Artifacts, magic items
10. **Characters (Player Characters)** -- PC profiles
11. **Session Logs** -- Campaign recaps (ongoing)

---

## Content Formatting: Present State vs Future Events

Articles describe the world **as it exists when the campaign starts**. Do not include campaign events in the main body.

- **Main body sections** (Overview, History, Description, etc.) = what is true at campaign start
- **`## Campaign Events / Future` section** (gated under `[subcontainer:<GM Only UUID>]`) = prophecies, impending events, planned encounters

---

## Article Directory Structure

Local article copies are saved to `articles/output/` with flat file naming:

```
articles/output/
  the_great_sacrifice.bbcode
  the_sealing_of_kharzul.bbcode
  kharzuls_blade.bbcode
```

File naming uses the **cache entity ID** (snake_case). The `.bbcode` extension indicates content meant for WA.

