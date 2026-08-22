# WorldAnvil Article Registry

Maps local cache entities to published WA articles. This is the bridge between cache and WA.

## Important Notes

- **Cache-to-article is NOT 1-to-1.** One cache entity may span multiple WA articles, or content from multiple cache entities may merge into one WA article.
- **Cross-link format:** Use `@[Display Name](Article:UUID)` for all cross-article links. This format survives all WA templates.
- **Placeholder format:** Use `@[Display Name](Article:PLACEHOLDER_cache_entity_id)` for articles not yet created. Resolve to real UUID when the target article is created.
- **Prefer specific templates** (myth, law, geography, ...) per the ARTICLE_FORMAT.md Selection Guide; generic `article` is fallback only. BBCode survives all templates (verified on `myth`, 2026-08-22).
- **List format:** Use `- item` not `* item` in markdown to avoid italic conversion conflicts.
- **Slug warning:** Non-`article` templates (e.g. `myth`) auto-generate slugs with `-myth` suffix. Always fetch the article back after creation to get the real slug.

## Placeholder Format

For articles that don't exist yet, use this placeholder format in content:

```
@[Display Name](Article:PLACEHOLDER_cache_entity_id)
```

When the target article is created, scan existing articles for `Article:PLACEHOLDER_entity_id`, replace with the real UUID via `worldanvilUpdateArticle`, and update the local `.bbcode` file.

## Cross-Link UUID Reference

| Display Name | Cache Entity | WA UUID |
|--------------|--------------|---------|
| The Originals | the_originals | f58d1435-ffc6-429f-9572-bffa739bfc9c |
| The Great Sacrifice | the_great_sacrifice | 4433d5c7-1415-4837-afae-3d47c20f8f45 |
| The Protective Shield | the_protective_shield | 074714f8-5a2f-4737-8bc3-13822c1d8182 |

## Registry

### Characters

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Locations

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Organizations

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Events

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| the_great_sacrifice | The Great Sacrifice | 4433d5c7-1415-4837-afae-3d47c20f8f45 | the-great-sacrifice-myth | 2026-08-22 | CANONICAL: template=myth, Events category, Class 1 fully private, compact BBCode + [quote] epigraph. Local copy: articles/output/the_great_sacrifice.myth.bbcode. Old test article (a6aebad5) deleted 2026-08-21. Final pulled + typos fixed via API push 2026-08-22 (chose-to-stand dedup, its/existence, subconscious, spacing). Status: FINAL |

### Items

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Lore and Concepts

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| ~~the_originals~~ | DELETED | cdc927d8-2be5-4013-ad7e-87fd3f95da0a | - | - | Deleted 2026-08-21 (Phase 0 test). Superseded by recreation below. |
| the_originals | The Originals | f58d1435-ffc6-429f-9572-bffa739bfc9c | the-originals-myth | 2026-08-22 | CANONICAL: template=myth, Class 1 fully private, compact BBCode + [quote] epigraph. Old article-template ver (100bee60) deleted 2026-08-22 after user browser-check. Local copy: articles/output/the_originals.myth.bbcode (FINAL pulled 2026-08-22 after user edits). Category now Divinity (= renamed Workings of the World, same UUID 688bfe84). isWip flag cleared via API push 2026-08-22 ~20:05 (user had already cleared draft). Post-final typo fixes pushed same day (its / powerful / casualty sentence rebuild / double-spaces). Status: FINAL |
| the_protective_shield | The Protective Shield | 074714f8-5a2f-4737-8bc3-13822c1d8182 | the-protective-shield-law | 2026-08-22 | CANONICAL: template=law, Workings of the World category, Class 1 fully private. Cache: cache/lore/the_protective_shield.md. Local copy: articles/output/the_protective_shield.law.bbcode (final pulled + typos fixed + stale PLACEHOLDER_the_great_sacrifice resolved to @[The Great Sacrifice](myth:4433d5c7-1415-4837-afae-3d47c20f8f45), API push 2026-08-22). Status: FINAL |
| (user-created) gods_domains_planes_races | Gods, Domains, Planes and Races | de225c27-b257-4157-8c08-e107712d8920 | gods2C-domains2C-planes-and-races-myth | 2026-08-22 | User-made myth-template table: month/god/domain/plane/race calendar. Private. Local: articles/output/gods2C-domains2C-planes-and-races-myth.bbcode. No cache entity - overlaps the_gods_and_the_deception + the_divine_conspiracy. Link via mentions when Phase 1 god articles exist |

### Player Characters

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Session Logs

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

## Pending Placeholders

RESOLUTION RULE (decided 2026-08-22): when the target article is created, take the SLUG from the create reply and replace every "@[Name](Article:PLACEHOLDER_<id>)" with "@[Name](<target-template>:<uuid>)" in all referencing articles (fetch -> replace -> update -> local copy), then mark resolved here.

| Placeholder | Referenced In | Status |
|-------------|---------------|--------|
| PLACEHOLDER_kythoria | the_originals | pending |
| PLACEHOLDER_the_abominable_end | the_originals, the_protective_shield | pending |
| PLACEHOLDER_the_gods_and_the_deception | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_the_arcane_weave | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_the_arcane_reactive_crystals | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_primal_nature_magic | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_founding_of_the_last_stand | (none live; will be re-added by a future draft) | n/a |

Resolved: PLACEHOLDER_the_great_sacrifice -> @[The Great Sacrifice](myth:4433d5c7-1415-4837-afae-3d47c20f8f45) (2026-08-22; canonical link pushed to the_protective_shield; zero placeholders remain in Phase 0 articles)
Resolved: PLACEHOLDER_the_protective_shield -> @[The Protective Shield](law:074714f8-5a2f-4737-8bc3-13822c1d8182) (2026-08-22; live canonical links in the_originals + the_great_sacrifice)

## Subscriber Groups on WA

| Group Name | WA ID | Purpose |
|------------|-------|---------|
| Aegon | 1756d2ea-0002-465e-b034-bcae7dad4382 | Per-character secrets |
| Aurora | a16d351c-4ece-403c-be86-76f59350a31a | Per-character secrets |
| Balor | d9d68013-82ee-4849-9e2d-19f91a2a256a | Per-character secrets |
| Bardolemeu | d28c1328-d182-4710-a51a-2f3ba6d76864 | Per-character secrets |
| Kaelyn | 77ba3007-4990-4803-bf6c-eb953479b122 | Per-character secrets (pre-existing) |
| Nyra | ff71dd83-e480-4191-a4dd-b885e94ff6fc | Per-character secrets |
| Odessa | 6c79bf52-9ed9-4f4f-9afc-8c6d4034c6bc | Per-character secrets |
| Sanzo | d25b0be2-4e2a-443c-af94-1367286173c8 | Per-character secrets |
| Zan | a542fbb5-1fde-4cf2-8462-0fbef7ac8084 | Per-character secrets (pre-existing) |
| GM Only | 0a5c796a-9e4a-4731-979d-07ac9c05d97e | DM-only content within public articles |

## WA Categories

| Name | WA ID | Parent | Notes |
|------|-------|--------|-------|
| Characters | 59015c22-a174-43a0-9125-07e465616dad | (none) | NPCs and Deities |
| Locations | e89bfe08-a029-4414-bdf7-d685f05b52ff | (none) | All locations |
| Organizations | 7d5a1bd4-b287-4211-b396-1361c73061ff | (none) | All organizations |
| Events | 1d06691b-0621-4c02-b059-1d29f0da4911 | (none) | Historical events |
| Items | 39ef8426-b093-47fc-a404-b3f67e911b54 | (none) | Artifacts, magic items |
| Session Logs | a724e278-d1c8-44f5-af3f-6ede51206d37 | (none) | Campaign session recaps |
| Player Characters | 4791a56f-b2ac-46cf-849b-7afd54402a15 | Characters | PC profiles |
| Divinity (was: Workings of the World) | 688bfe84-fdc8-477d-a805-bea8dd45d052 | (none) | RENAMED by user 2026-08-22 (same UUID; slug lore-category, private, icon angel). Home of The Originals. |
| Religion | 207ee603-d485-457b-9deb-652e11c1d825 | (none) | Pre-existing |
| Festivals | ea5f2a1a-b124-466c-a917-9f40f27ebb6c | (none) | Pre-existing |  
| Laws | c0a9622b-66c7-40d7-ba96-26fda88f272f | (none) | NEW 2026-08-22 (public, icon book-section). Home of The Protective Shield. |
## Gating Strategy 2026-08-21  
  
- DEFAULT: [subcontainer:GROUP_UUID]content[/subcontainer] -- fully automatable, no UI steps. GM Only = 0a5c796a-9e4a-4731-979d-07ac9c05d97e, Balor = d9d68013-82ee-4849-9e2d-19f91a2a256a  
- FALLBACK: Secrets via [secret:UUID] inline embeds -- require manual WA-UI group assignment per secret  
- Whole-article hiding: AUTOMATABLE via API (verified live 2026-08-22): pass fields: { state: "private", subscribergroups: [{ id: "<GROUP_UUID>" }], isWip, isDraft } to worldanvilCreateArticle/UpdateArticle (MCP merges fields into top-level body; proxy forwards verbatim). Validated with TEST - State Private Demo (state=private + GM Only attached; deleted after user browser-verified).
- VISIBILITY CLASSES (decided 2026-08-22): before every upload the agent must propose one: (1) fully private, no subscriber groups (GM eyes only); (2) private + subscriber groups (specific players only); (3) public with private sections (subcontainers). DM notes ALWAYS GM Only.  
- EDITOR: world uses Advanced Editor Euclid. NEVER save via Visual Editor -- breaks containers
- DIRECT-PUSH WORKFLOW (2026-08-22): no pre-approval; agent picks visibility class per defaults and reports it; user edits on WA (Euclid only); final pull = canonical local copy.

### Subscriber Group UUIDs (all groups, fetched 2026-08-22)
| Group | UUID |
|-------|------|
| GM Only | 0a5c796a-9e4a-4731-979d-07ac9c05d97e |
| Aegon | 1756d2ea-0002-465e-b034-bcae7dad4382 |
| Aurora | a16d351c-4ece-403c-be86-76f59350a31a |
| Balor | d9d68013-82ee-4849-9e2d-19f91a2a256a |
| Bardolemeu | d28c1328-d182-4710-a51a-2f3ba6d76864 |
| Kaelyn | 77ba3007-4990-4803-bf6c-eb953479b122 |
| Nyra | ff71dd83-e480-4191-a4dd-b885e94ff6fc |
| Odessa | 6c79bf52-9ed9-4f4f-9afc-8c6d4034c6bc |
| Sanzo | d25b0be2-4e2a-443c-af94-1367286173c8 |
| Zan | a542fbb5-1fde-4cf2-8462-0fbef7ac8084 |

(Player_1_Account was deleted from WA by the user on 2026-08-22 -- do not reference or recreate.)  
  
## Test Articles on WA  
  
- DELETED 2026-08-22 (user order, verified 404): TEST - Secrets Demo (027cbd95-9d0f-4eb9-bdb3-50e263ed0370)  
- DELETED 2026-08-22 (user order, verified 404): TEST - Subcontainer Demo (7b0be8b9-4d93-4f45-98dd-d965395116a8)
- DELETED 2026-08-22 (user order, after user browser-verified private+group behavior): TEST - State Private Demo (14388e5c-7990-463e-81ab-721157306277) -- validated fields:{state, subscribergroups} + slug returned in create reply
- Still on WA (user-created; ask user before deleting): 'Test with secret and container' 987f7ba8-2a95-45b6-a01f-66246dd44063 -- embeds secrets c15ab8bb (TEST Secret for GM) + f5b41441 (TEST Secret for Balor); secrets did NOT cascade-delete because this article still references them  