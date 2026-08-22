# WorldAnvil Article Registry

Maps local cache entities to published WA articles. Lives in `state_files/` -- this is project metadata, NOT a lore entity (no frontmatter rules apply).
Column vocabulary is defined in `instructions/ARTICLE_FORMAT.md`: Template Type = WA template slug (Template Selection Guide); Category = WA category name (WA Category Structure table); Privacy Class = Class 1 / 2 / 3 (Visibility Review section); Status = draft -> pushed -> final.

This file reflects CURRENT STATE ONLY -- no history. Past values are recoverable from git.

## Column Definitions

| Column | Allowed Values |
|--------|----------------|
| Cache Entity | snake_case id under `cache/`, or `(none)` for user-created WA-only articles |
| Template Type | WA template slug per the Selection Guide (`article`, `character`, `geography`, `settlement`, `building`, `organization`, `item`, `species`, `law`, `myth`, ...) |
| Category | WA category name per the Category Structure table (`Characters`, `Player Characters`, `Locations`, `Organizations`, `Events`, `Items`, `Divinity`, `Laws`, `Religion`, `Festivals`, `Session Logs`) |
| Privacy Class | Class 1 = fully private, no groups; Class 2 = private + subscriber groups; Class 3 = public with gated sections |
| Status | `draft` (not pushed), `pushed` (awaiting user edits), `final` (pulled back post-edit; canonical) |
| Local File | canonical copy under `articles/output/<entity_id>.<template>.bbcode` |

## Important Notes

- **Cache-to-article is NOT 1-to-1.** One cache entity may span multiple WA articles, or content from multiple cache entities may merge into one WA article.
- **Canonical cross-link format:** `@[Display Name](<target-template>:UUID)` for all cross-article links (template = TARGET article's template).
- **Placeholder format:** `@[Display Name](Article:PLACEHOLDER_cache_entity_id)` for articles not yet created. Resolve to `@[Name](<target-template>:UUID)` when the target exists.
- **Slug warning:** Non-`article` templates auto-generate slugs with a template suffix (e.g. `-myth`). Always fetch the article back after creation to confirm slug + content.
- **List format:** Use `- item` not `* item` in markdown sources (italic conversion conflict).

## Cross-Link UUID Reference

| Display Name | Cache Entity | WA UUID |
|--------------|--------------|---------|
| The Originals | the_originals | f58d1435-ffc6-429f-9572-bffa739bfc9c |
| The Great Sacrifice | the_great_sacrifice | 4433d5c7-1415-4837-afae-3d47c20f8f45 |
| The Protective Shield | the_protective_shield | 074714f8-5a2f-4737-8bc3-13822c1d8182 |

## Registry

### Characters

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

### Locations

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

### Organizations

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

### Events

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| the_great_sacrifice | The Great Sacrifice | 4433d5c7-1415-4837-afae-3d47c20f8f45 | the-great-sacrifice-myth | 2026-08-22 | myth | Events | Class 1 | final | articles/output/the_great_sacrifice.myth.bbcode | - |

### Items

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

### Lore and Concepts

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| the_originals | The Originals | f58d1435-ffc6-429f-9572-bffa739bfc9c | the-originals-myth | 2026-08-22 | myth | Divinity | Class 1 | final | articles/output/the_originals.myth.bbcode | - |
| the_protective_shield | The Protective Shield | 074714f8-5a2f-4737-8bc3-13822c1d8182 | the-protective-shield-law | 2026-08-22 | law | Laws | Class 1 | final | articles/output/the_protective_shield.law.bbcode | GM-secret "Divine Magic Loophole" intentionally omitted from live article (cache-only) |
| (none) | Gods, Domains, Planes and Races | de225c27-b257-4157-8c08-e107712d8920 | gods2C-domains2C-planes-and-races-myth | 2026-08-22 | myth | Religion | Class 1 | final | articles/output/gods2C-domains2C-planes-and-races-myth.bbcode | User-created calendar table (month/god/domain/plane/race); user-managed; overlaps the_gods_and_the_deception + the_divine_conspiracy |

### Player Characters

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

### Session Logs

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Template Type | Category | Privacy Class | Status | Local File | Notes |
|--------------|------------------|---------------|---------|---------|---------------|----------|---------------|--------|------------|-------|
| *pending* | | | | | | | | | | |

## Pending Placeholders

RESOLUTION RULE: when the target article is created, take SLUG + UUID + template from the create reply and replace every `@[Name](Article:PLACEHOLDER_<id>)` with `@[Name](<target-template>:<uuid>)` in all referencing articles (fetch -> replace -> update -> local copy), then remove the row below.

| Placeholder | Referenced In |
|-------------|---------------|
| PLACEHOLDER_kythoria | the_originals |
| PLACEHOLDER_the_abominable_end | the_originals, the_protective_shield |
| PLACEHOLDER_the_gods_and_the_deception | the_originals, the_great_sacrifice |
| PLACEHOLDER_the_arcane_weave | the_originals, the_great_sacrifice |
| PLACEHOLDER_the_arcane_reactive_crystals | the_originals, the_great_sacrifice |
| PLACEHOLDER_primal_nature_magic | the_originals, the_great_sacrifice |

## Subscriber Groups on WA

Gate content with `[subcontainer:<GROUP_UUID>]content[/subcontainer]`. If a group appears missing, fetch via `Worldanvilmcp.worldanvilListSubscribergroups` and update this table.

| Group Name | WA UUID | Purpose |
|------------|---------|---------|
| GM Only | 0a5c796a-9e4a-4731-979d-07ac9c05d97e | DM-only content within any article |
| Aegon | 1756d2ea-0002-465e-b034-bcae7dad4382 | Per-character secrets |
| Aurora | a16d351c-4ece-403c-be86-76f59350a31a | Per-character secrets |
| Balor | d9d68013-82ee-4849-9e2d-19f91a2a256a | Per-character secrets |
| Bardolemeu | d28c1328-d182-4710-a51a-2f3ba6d76864 | Per-character secrets |
| Kaelyn | 77ba3007-4990-4803-bf6c-eb953479b122 | Per-character secrets |
| Nyra | ff71dd83-e480-4191-a4dd-b885e94ff6fc | Per-character secrets |
| Odessa | 6c79bf52-9ed9-4f4f-9afc-8c6d4034c6bc | Per-character secrets |
| Sanzo | d25b0be2-4e2a-443c-af94-1367286173c8 | Per-character secrets |
| Zan | a542fbb5-1fde-4cf2-8462-0fbef7ac8084 | Per-character secrets |

Deleted group -- do NOT recreate or re-reference: Player_1_Account.

## Gating Strategy

- DEFAULT gate: `[subcontainer:GROUP_UUID]content[/subcontainer]` (fully automatable). DM notes ALWAYS go in GM Only.
- Whole-article hiding via API fields: `{ state: "private", subscribergroups: [{ id: "<GROUP_UUID>" }], isWip, isDraft }`.
- Visibility classes (defined in `instructions/ARTICLE_FORMAT.md`): Class 1 fully private / Class 2 private + subscriber groups / Class 3 public with gated sections.
- EDITOR: Advanced Editor Euclid ONLY. Never save via Visual Editor -- it destroys containers/custom BBCode.

## WA Categories

| Name | WA ID | Parent | Notes |
|------|-------|--------|-------|
| Characters | 59015c22-a174-43a0-9125-07e465616dad | (none) | NPCs and Deities |
| Player Characters | 4791a56f-b2ac-46cf-849b-7afd54402a15 | Characters | PC profiles |
| Locations | e89bfe08-a029-4414-bdf7-d685f05b52ff | (none) | All locations |
| Organizations | 7d5a1bd4-b287-4211-b396-1361c73061ff | (none) | All organizations |
| Events | 1d06691b-0621-4c02-b059-1d29f0da4911 | (none) | Historical events |
| Items | 39ef8426-b093-47fc-a404-b3f67e911b54 | (none) | Artifacts, magic items |
| Divinity | 688bfe84-fdc8-477d-a805-bea8dd45d052 | (none) | Cosmology, creation myth, magic, lore (private; icon angel) |
| Laws | c0a9622b-66c7-40d7-ba96-26fda88f272f | (none) | Natural laws, world rules (public; icon book-section) |
| Religion | 207ee603-d485-457b-9deb-652e11c1d825 | (none) | Gods, pantheon, worship (pre-existing) |
| Festivals | ea5f2a1a-b124-466c-a917-9f40f27ebb6c | (none) | Festivals, ceremonies (pre-existing) |
| Session Logs | a724e278-d1c8-44f5-af3f-6ede51206d37 | (none) | Campaign session recaps |

## Non-Lore Articles on WA

- 'Test with secret and container' 987f7ba8-2a95-45b6-a01f-66246dd44063 -- user-created; ask user before deleting. References secrets c15ab8bb (GM) + f5b41441 (Balor).

Deleted resources (do NOT recreate, re-reference, or reuse IDs): articles a6aebad5, cdc927d8, 100bee60, 6bcf7b43, def52c7d, d54a2e7d, 027cbd95, 7b0be8b9, 14388e5c; secret-bearing test articles were deleted without cascading their secrets.