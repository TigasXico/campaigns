# Article Format -- WorldAnvil BBCode

Defines the BBCode format for articles created on WorldAnvil (WA). All articles are pushed to WA via the MCP API. Local copies are saved under `articles/output/` as `.bbcode` files for reference.

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

The mapping strategy must be presented to and approved by the user before content is generated.

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

### Important: Use `article` Template for Reliability

**CRITICAL DISCOVERY:** Non-`article` templates (like `item`, `character`, `organization`) wrap the `content` field in HTML processing that **strips BBCode closing tags**, particularly `[/article]`. This means:

```
[article:slug]Display Name[/article]  -->  [article:slug]Display Namearticle  (BROKEN)
```

The `"article"` (generic) template **preserves BBCode tags correctly**.

**Recommendation:** Use `template: "article"` for all articles, even if a more specific template would fit. The trade-off:
- **Gain:** BBCode reliability, cross-links work
- **Lose:** Template-specific prompts and auto-generated relationship panels

If you want template-specific features (family trees, diplomacy webs, etc.), those can be added manually in the content body.

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

Use these fields for structured data. Content in these fields also gets Markdown-to-BBCode conversion but is NOT subject to the `[/article]` stripping issue since they are separate API fields.

---

## Content Format (Markdown + Embedded BBCode)

Content is written in **Markdown with embedded BBCode tags**. The WA MCP auto-converts Markdown to BBCode but **preserves** embedded BBCode tags (like `[article:]`, `[subscribergroup:]`).

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
| Cross-article link (by slug) | `[article:SLUG]Display Name[/article]` | Use the WA article's SLUG. Works ONLY with `template: "article"`. |
| Cross-article link (by UUID) | `@[Display Name](Article:UUID)` | Alternative format using WA article UUID. Survives all templates. |
| Subscriber group block | `[subscribergroup:Name]content[/subscribergroup]` | Name must match a WA subscriber group exactly. |
| GM metadata note | `[subscribergroup:GM Only]**GM Note:** text[/subscribergroup]` | For internal status/tags/notes. |

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

### NOT Auto-Converted Elements

These BBCode elements must be written directly (no Markdown equivalent):
- `[img]`, `[map]`, `[block]` (embeds)
- `[aloud]`, `[spoiler]` (containers)
- `[row]`, `[col]` (columns)

---

## Cross-Article Linking

### Two Valid Formats

Since we discovered that non-`article` templates strip `[/article]` tags, and `[article:SLUG]` requires the exact WA slug, we have two options:

#### Option 1: `[article:SLUG]Name[/article]` (for `template: "article"` only)

```
[article:the-great-sacrifice-article]The Great Sacrifice[/article]
```

**Requirements:**
- The article MUST use `template: "article"` 
- `SLUG` must be the actual WA slug (looked up from the registry after article creation)
- If the target article doesn't exist yet, this renders as plain text

#### Option 2: `@[Name](Article:UUID)` (works with all templates)

```
@[The Great Sacrifice](Article:6bcf7b43-006e-40d2-a1da-16c5a787c39e)
```

**Requirements:**
- `UUID` must be the WA article's actual UUID
- Works regardless of template type
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
   - Replace `Article:PLACEHOLDER_entity_id` with `Article:real-uuid` in the content
   - Update the WA article via `worldanvilUpdateArticle({article_id, content: updatedContent})`
   - Update the local `.bbcode` file
   - Update the registry to mark the placeholder as resolved

4. Placeholders are tracked in `cache/wa_article_registry.md` under the `## Pending Placeholders` section.

### Resolving Placeholders (Step-by-Step)

When a new article is created on WA, resolve all placeholders pointing to it:

```
1. Get new article UUID from creation response
2. Look up "new_entity_id" in registry's Pending Placeholders table
   -> Finds all articles that reference PLACEHOLDER_new_entity_id
3. For each source article:
   a. Fetch current WA content via worldanvilGetArticle({article_id})
   b. Replace "Article:PLACEHOLDER_new_entity_id" with "Article:real-uuid"
   c. Push update via worldanvilUpdateArticle({article_id, content})
   d. Update local .bbcode file
4. Mark placeholder as resolved in registry
```

---

## Access Control (Subscriber Groups)

### Rules

| Content Type | Access Level | How |
|-------------|--------------|-----|
| Public lore, history, geography | Public (no tag) | Write normally |
| Party discoveries, shared knowledge | Public (no tag) | Party knowledge is public in this setting |
| DM-only secrets, true motives, future events | Restricted | `[subscribergroup:GM Only]...[/subscribergroup]` |
| Per-character secrets, backstory | Restricted | `[subscribergroup:CharacterName]...[/subscribergroup]` |
| Full article of DM-only content | Private article state | Set article to `private` during creation |

### Available Subscriber Groups

See `cache/wa_article_registry.md` for current subscriber group UUIDs.

**Existing groups:** Aegon, Aurora, Balor, Bardolemeu, Kaelyn, Nyra, Odessa, Sanzo, Zan, GM Only

---

## Article Creation via WA MCP

### Creating a New Article

```
Worldanvilmcp.worldanvilCreateArticle({
  title: "Article Title",
  world_id: "a07186fa-ce6a-40d0-b9fb-2377f33c9cd3",
  template: "article",   // Use "article" for BBCode reliability
  content: "## Markdown content with @[Name](Article:uuid) links",
  category_id: "category-uuid"
})
```

**After creation:**
1. Capture the returned article UUID
2. Fetch the article back to get its slug
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
3. Present both operations for approval before executing

---

## WA Category Structure

| Category | WA ID | Parent | For |
|----------|-------|--------|-----|
| Characters | *(see registry)* | (none) | NPCs, Deities |
| Player Characters | *(see registry)* | Characters | PC profiles |
| Locations | *(see registry)* | (none) | All locations |
| Organizations | *(see registry)* | (none) | All organizations |
| Events | *(see registry)* | (none) | Historical events |
| Items | *(see registry)* | (none) | Artifacts, magic items |
| Lore and Concepts | *(see registry)* | (none) | Lore, magic, society |
| Session Logs | *(see registry)* | (none) | Campaign session recaps |

---

## Article Creation Order

To minimize broken cross-references, create articles **bottom-up** (foundations first):

1. **Lore and Concepts** -- Cosmology, magic, geography, divine conspiracy
2. **Locations (Regions)** -- Continents, major regions
3. **Locations (Settlements)** -- Cities, towns, dungeons
4. **Lore and Concepts (Society)** -- Species, culture, economy, monsters
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
- **`## Campaign Events / Future` section** (gated under `[subscribergroup:GM Only]`) = prophecies, impending events, planned encounters

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

---

## Summary: Key Lessons from Test Articles

| Issue | Root Cause | Fix |
|-------|-----------|-----|
| `[/article]` stripped | Non-`article` templates process `content` differently | Use `template: "article"` OR use `@[Name](Article:uuid)` format |
| Links not rendering | Slugs were cache entity IDs, not WA slugs | Use actual WA slugs (looked up from registry) |
| `* item` lists broken | Markdown converter processes italic before lists | Use `- item` instead of `* item` |
| Lists mangled in output | Same italic-vs-list conflict | Prefer `template: "article"` which preserves BBCode better |