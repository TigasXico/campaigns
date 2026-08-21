---
id: wa_article_registry
type: campaign_note
name: "WorldAnvil Article Registry"
status: active
created: 2026-08-20
updated: 2026-08-22
---

# WorldAnvil Article Registry

Maps local cache entities to published WA articles. This is the bridge between cache and WA.

## Important Notes

- **Cache-to-article is NOT 1-to-1.** One cache entity may span multiple WA articles, or content from multiple cache entities may merge into one WA article.
- **Cross-link format:** Use `@[Display Name](Article:UUID)` for all cross-article links. This format survives all WA templates.
- **Placeholder format:** Use `@[Display Name](Article:PLACEHOLDER_cache_entity_id)` for articles not yet created. Resolve to real UUID when the target article is created.
- **Use `template: "article"`** for all articles to ensure BBCode tag preservation.
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
| The Originals | the_originals | cdc927d8-2be5-4013-ad7e-87fd3f95da0a |
| The Great Sacrifice | the_great_sacrifice | a6aebad5-86bd-41be-84f6-2e5dbfa15124 |

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
| ~~the_great_sacrifice~~ | DELETED | a6aebad5-86bd-41be-84f6-2e5dbfa15124 | - | - | Deleted 2026-08-21 (Phase 0 content treated as test). Local backup: articles/output/the_great_sacrifice.bbcode. Recreate with final strategy. |

### Items

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Lore and Concepts

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| ~~the_originals~~ | DELETED | cdc927d8-2be5-4013-ad7e-87fd3f95da0a | - | - | Deleted 2026-08-21 (Phase 0 content treated as test). Local backup: articles/output/the_originals.bbcode. Recreate with final strategy. |

### Player Characters

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

### Session Logs

| Cache Entity | WA Article Title | WA Article ID | WA Slug | Created | Notes |
|--------------|------------------|---------------|---------|---------|-------|
| *pending* | | | | | |

## Pending Placeholders

| Placeholder | Referenced In | Status |
|-------------|---------------|--------|
| PLACEHOLDER_kythoria | the_originals | pending |
| PLACEHOLDER_the_abominable_end | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_the_gods_and_the_deception | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_the_arcane_weave | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_the_arcane_reactive_crystals | the_originals, the_great_sacrifice | pending |
| PLACEHOLDER_founding_of_the_last_stand | the_great_sacrifice | pending |

Resolved: PLACEHOLDER_the_great_sacrifice -> a6aebad5-86bd-41be-84f6-2e5dbfa15124 (2026-08-21)

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
| Workings of the World | 688bfe84-fdc8-477d-a805-bea8dd45d052 | (none) | Pre-existing. DECIDED 2026-08-22: Phase 0 home (The Originals, The Great Sacrifice). |
| Religion | 207ee603-d485-457b-9deb-652e11c1d825 | (none) | Pre-existing |
| Festivals | ea5f2a1a-b124-466c-a917-9f40f27ebb6c | (none) | Pre-existing |  
## Gating Strategy 2026-08-21  
  
- DEFAULT: [subcontainer:GROUP_UUID]content[/subcontainer] -- fully automatable, no UI steps. GM Only = 0a5c796a-9e4a-4731-979d-07ac9c05d97e, Balor = d9d68013-82ee-4849-9e2d-19f91a2a256a  
- FALLBACK: Secrets via [secret:UUID] inline embeds -- require manual WA-UI group assignment per secret  
- Whole-article hiding: Private + subscriber group, set in WA UI -- API cannot do it  
- EDITOR: world uses Advanced Editor Euclid. NEVER save via Visual Editor -- breaks containers

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
- Still on WA (user-created; ask user before deleting): 'Test with secret and container' 987f7ba8-2a95-45b6-a01f-66246dd44063 -- embeds secrets c15ab8bb (TEST Secret for GM) + f5b41441 (TEST Secret for Balor); secrets did NOT cascade-delete because this article still references them  
