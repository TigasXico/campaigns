---
id: session_continuity
type: campaign_note
name: "Session Continuity Log"
status: active
created: 2026-08-09
updated: 2026-08-20
---

## Session: Timeline Sync & Corrections (2026-08-20)

### Files Modified

| File | Change |
|------|--------|
| `cache/events/kythorian_timeline.md` | **E60 year 500 -> 493** (Thormvuld crystal discovery, synced to WA). **E63** "Two-thirds" -> "Three-quarters" (monster army reconquered area, synced to WA). **NEW E86** -- Crystal Influence: 90% at year 300 (added to match WA). Updated timestamp. |
| `cache/_index.md` | Added `site_gamma-7` (auto-synced). |

### WA Corrections Made

| History Event | ID | Change |
|---------------|:--:|--------|
| Perfect Vessel Engineered | `5e7b39de` | Year **445 -> 458** (synced to local) |
| Balor is Conceived | `6acb9282` | Year **459 -> 479** (synced to local) |

### Validation Note

The `kythorian_timeline.md` file is ~36KB, well above the 12KB entity file cap. Flagged for user awareness.

### No New Open Questions

All changes were data corrections with no new unanswered lore questions introduced.

### Files Created

| File | Change |
|------|--------|
| `campaign_notes/session_1_prep.md` | **NEW** -- Full Session 1 prep document using the hybrid "Debt" concept. FX summons the heist party to a safe house in Stonefall. He found a symbol (the Broken Crown) in the Thormvuld documents. Nyra and Aegon arrive separately. Hook: investigate Site Gamma-7. |
| `cache/locations/stonefall.md` | **NEW** -- Frontier town on the edge of Last Stand territory. Contains FX's safe house. |
| `cache/locations/site_gamma-7.md` | **NEW** -- Abandoned Flesh Architects research outpost, three days into the frontier. |

### Files Modified

| File | Change |
|------|--------|
| `cache/characters/NPC/fx.md` | Updated with post-heist state (rattled), discovery of the symbol, knowledge of "Arquitetos", Site Gamma-7 reference. |
| `cache/_index.md` | Added stonefall, site_gamma-7 entries. |

### Key Lore Decisions Made

1. **The Symbol (The Broken Crown)**: A circle with three sweeping curves, one broken. Only Zan, Kaelyn, and Aurora recognize it from their pasts (private tells). The other four PCs discover their connections later through gameplay.
2. **FX's knowledge**: He knows the symbol and the name "Arquitetos" (Architects). He does NOT know the name "Flesh Architects" or "Crimson Covenant." He is holding this close.
3. **Site Gamma-7**: Decommissioned Flesh Architects outpost. Catalyst Project research. Party's first destination.
4. **Party cohesion**: Driven by debt to FX, shared mystery, and personal stakes (each PC has a reason to go).
5. **Pacing**: Zero lore dumps in Session 1. Only the symbol is revealed. All connections emerge through play over many sessions.

### Session 1 Party

Zan, Aurora, Bardolemeu, Kaelyn, Balor, Nyra, Aegon
**Not present:** Odessa, Sanzo

### Open Questions

- What is inside Site Gamma-7? (To be designed for Session 2)
- Where are the remaining three elemental crystals?
- What happened to Sophie (Subject 241)?
- What is in Balor's mother's cache?
- What does Bardolemeu's mentor's note say?
- When will Odessa rejoin the party?

---

## Session: Workflow Review and Test Articles (2026-08-20)

### Workflow Changes Finalized

| Decision | Details |
|----------|---------|
| **A1-A4 audits** | Only mandatory for new lore creation, NOT for every session |
| **Source of truth** | WA is the published source of truth. Cache is the working copy. |
| **Cache-to-article mapping** | NOT 1-to-1. One cache entity can split into multiple WA articles or merge into existing ones. |
| **Subscriber groups** | Created per-PC groups + GM Only. Party content = public. DM-only content = `[subscribergroup:GM Only]` or private article state. |
| **No article template** | Entity type guides structure, but no one-size-fits-all template enforced. |
| **Tags** | Removed from frontmatter schema. Tags field deprecated. |
| **Relationships** | Dropped typed labels (`allies`, `enemies`). Free-text descriptions only. No automatic inverse relationship generation. |
| **Cross-linking** | Links woven into body text, not just Related Articles section. `[article:SLUG]Name[/article]` format using WA slugs. |

### WA Infrastructure Created

| Resource | Items |
|----------|-------|
| **Subscriber groups created** | Aegon, Aurora, Balor, Bardolemeu, Nyra, Odessa, Sanzo, GM Only |
| **Categories created** | Characters, Locations, Organizations, Events, Items, Session Logs, Player Characters (subcat of Characters) |
| **Test articles created** | The Great Sacrifice, The Sealing of Khar'zul, Khar'zul's Blade (The Living Prison) |

### Test Article Details

| Article | WA ID | Slug | Category | Features Demonstrated |
|---------|-------|------|----------|---------------------|
| The Great Sacrifice | 6bcf7b43 | the-great-sacrifice-article | Events | Public content, cross-links in body, headings, lists |
| The Sealing of Khar'zul | def52c7d | the-sealing-of-khar-zul-article | Events | Cross-links, GM Only subscriber group sections |
| Khar'zul's Blade (The Living Prison) | d54a2e7d | khar-zul-s-blade-the-living-prison-item-1 | Items | Tables, GM Only sections, Balor-specific subscriber group |

### Instruction Files Updated

| File | Key Changes |
|------|-------------|
| `instructions/WORKFLOW.md` | Updated audit rules, subscriber strategy, WA-first syncing, creation order, cross-linking strategy |
| `instructions/CACHE_FORMAT.md` | Removed typed relationship labels, removed tags, removed auto-inverse requirements, simplified frontmatter |
| `instructions/ARTICLE_FORMAT.md` | Removed enforced template, mixed Markdown/BBCode content format, WA MCP creation instructions, registry lookups |
| `instructions/ENTITY_TYPES.md` | Removed tags from example frontmatter and schema table |

### Files Created

| File | Description |
|------|-------------|
| `cache/wa_article_registry.md` | Maps cache entity IDs to WA article IDs, slugs, URLs. Also tracks subscriber groups and WA categories. |
| `articles/output/the_great_sacrifice.bbcode` | Local copy of test article content for The Great Sacrifice |
| `articles/output/the_sealing_of_kharzul.bbcode` | Local copy of test article content for The Sealing of Khar'zul |
| `articles/output/kharzuls_blade.bbcode` | Local copy of test article content for Khar'zul's Blade |

### BBCode Format Verified

The MCP auto-converts Markdown to BBCode. Written content uses:
- Markdown for headings, bold, italic, lists, tables
- `[article:SLUG]Name[/article]` for cross-links
- `[subscribergroup:Name]...[/subscribergroup]` for restricted content

Valid template values for `worldanvilCreateArticle`: `article` (generic), `character`, `location`, `organization`, `item`, `law`, `species`, etc. Use `"article"` for events and lore.

### Placeholder System Implemented

**The working cross-link format:** `@[Display Name](Article:UUID)`
**The placeholder format:** `@[Display Name](Article:PLACEHOLDER_cache_entity_id)`

Changes made:
- `instructions/ARTICLE_FORMAT.md` -- Added proper placeholder format and resolution step-by-step process
- `cache/wa_article_registry.md` -- Added `## Pending Placeholders` table tracking all placeholders across all existing articles, with resolution process documentation
- `instructions/WORKFLOW.md` -- Added Step 5 (Resolve Placeholders) to the canonical workflow
- The 3 test articles on WA now use `@[Name](Article:UUID)` format with real UUIDs for existing articles and `Article:PENDING` temporarily (will update to `Article:PLACEHOLDER_entity_id` format next)

### BBCode Investigation Findings (Finalized)

| Finding | Resolution |
|---------|-----------|
| `[article:SLUG]name[/article]` format works but requires exact WA slug | Use `@[Name](Article:UUID)` instead -- works with all templates |
| `[/article]` stripped by non-article templates | Use `@-mention` format which survives all templates |
| `* item` converted to italic instead of list | Use `- item` for unordered lists |
| `@[Name](Article:UUID)` renders as clickable link on WA | **CONFIRMED WORKING** -- official cross-link format |
| Placeholder format `Article:PENDING` -> `Article:PLACEHOLDER_id` | New standard for not-yet-created article references |

### Key Investigation Findings (BBCode Fix)

**Problem:** Cross-article links (`[article:slug]text[/article]`) were not rendering on WA.

**Root Causes Identified:**
1. **Wrong slug format** -- Used cache entity IDs (e.g., `the_originals`) instead of WA slug (e.g., `the-great-sacrifice-article`). WA only renders `[article:SLUG]` if an article with that slug exists.
2. **Non-article template strips `[/article]`** -- The `item` template wraps content in HTML-like `<p>` blocks and strips BBCode closing tags. `template: "article"` preserves BBCode correctly.
3. **List marker conflict** -- `* item` markdown was converted to `[i]` (italic) instead of `[li]` (list item) because the MCP converter processes italic BEFORE lists.

**Resolution:**
- Use `@[Display Name](Article:UUID)` for all cross-links -- this is WA's native article mention format that survives all templates
- Use `template: "article"` for all articles to avoid `[/article]` stripping
- Use `- item` instead of `* item` for list items
- Lock existing UUIDs in registry for cross-link reference

**Local instruction files updated accordingly.**

### Remaining Work (for future sessions)

- Create remaining WA articles for all cache entities (following creation order)
- Set up the master index article on WA
- Design Site Gamma-7 content (Session 2 prep)
- Define remaining elemental crystal locations

---

## Session: Article Start & Workflow Refinements (2026-08-21)

### Article 1 Created: The Originals

| Detail | Value |
|--------|-------|
| **WA UUID** | `cdc927d8-2be5-4013-ad7e-87fd3f95da0a` |
| **Slug** | `the-originals-article` |
| **Template** | `myth` |
| **Category** | Lore & Concepts |
| **Status** | Created, NOT YET VALIDATED (content on WA not reviewed) |

### Article 2 Exists (from test phase): The Great Sacrifice

| Detail | Value |
|--------|-------|
| **WA UUID** | `a6aebad5-86bd-41be-84f6-2e5dbfa15124` |
| **Template** | `myth` |
| **Category** | Events |
| **Status** | Test phase, NOT YET VALIDATED |

### Test Articles Deleted

- `the_sealing_of_kharzul` -- Deleted from WA
- `kharzuls_blade` -- Deleted from WA
- Local `.bbcode` files deleted from `articles/output/`

### Workflow Rules Reinforced

| Rule | Details |
|------|---------|
| **Approval gate** | Show EXACT full content before sending to WA. Wait for explicit "approved" or "yes". |
| **Non-1-to-1 mapping** | Cache entity may split across multiple WA articles, merge into existing, or not have an article at all. Mapping decision must be presented BEFORE content generation. |

### Files Updated

| File | Change |
|------|--------|
| `.goosehints` | Rule 1 made more explicit: "Show the exact content" + "Wait for approval" before any WA mutation |
| `instructions/WORKFLOW.md` | Step 4 restructured into 4a (mapping), 4b (content), 4c (approve + send). Step 5 (placeholder resolution) also has explicit approval gate. Step 2 mentions mapping proposal. |
| `instructions/ARTICLE_FORMAT.md` | Added new `## Cache-to-Article Mapping` section at top with mapping strategies table |
| `cache/wa_article_registry.md` | Reset (no articles tracked). Added `the_originals` entry with UUID and slug. Added `the_great_sacrifice` entry with UUID. |
| `cache/_session_continuity.md` | This update |

### Next Actions

1. **Validate** `The Originals` and `The Great Sacrifice` on WA (review content quality, check links, verify formatting)
2. **Continue** article generation in the defined order (Phase 1: Lore & Concepts, 8 articles total)
3. **Resolve placeholders** as new articles are created

- Create remaining WA articles for all cache entities (following creation order)
- Set up the master index article on WA
- Design Site Gamma-7 content (Session 2 prep)
- Define remaining elemental crystal locations