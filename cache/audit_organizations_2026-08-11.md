# Category Audit: organizations (Second Pass)
**Date:** 2026-08-11
**Status:** Updated against full context — ALL categories complete

---

## Files Audited (20 files — 2 newly created)

the_adventurers_guild.md, the_circle_of_the_wild.md, the_council_accord.md, the_coven_of_the_spider.md, the_crimson_covenant.md, the_ecumenical_council.md, the_first_alliance.md, the_four_barbarian_tribes.md, the_guild_of_the_spark.md, the_iron_host.md [NEW], the_order_of_the_currency.md, the_order_of_the_dawn.md, the_order_of_the_protectors.md, the_order_of_the_raven.md, the_order_of_the_scales.md, the_pack_of_tyra.md [NEW], the_skallfang_clan.md, the_thormvuld_family.md, the_venom_weavers.md, the_vigil_of_the_dusk.md

---

## A1 - Remaining Contradictions

| # | File | Contradiction | Severity | Fix |
|---|------|--------------|----------|-----|
| None | -- | -- | -- | -- |

**Resolved in this pass:**
- Coven of the Spider banned status — FIXED (removed Ecumenical Council member reference)
- Order of the Raven banned status — FIXED (removed Ecumenical Council member reference)
- Order of the Raven main temple in Weaveheart — FIXED (changed to hidden sanctuary)
- the_ecumenical_council.md broken links to the_pack_of_tyra and the_iron_host — FIXED (both entities now exist)
- the_skallfang_clan.md YAML formatting — FIXED (removed problematic colon-quote sequence)
- the_crimson_covenant.md duplicate `access: gm-only` — FIXED (removed duplicate line)

---

## A2 - Remaining Narrative Gaps

| # | File | Gap | Status |
|---|------|-----|--------|
| 1 | the_four_barbarian_tribes.md | Tribes unnamed, no leaders, no territories. | Open. |
| 2 | the_thormvuld_family.md | Named family members undefined. | Open. |
| 3 | the_skallfang_clan.md | Blade theft TODO unresolved. | Open. |
| 4 | the_adventurers_guild.md | Guild ranks in Draconic undefined. | Open. |

**Resolved in this pass:**
- Missing entity: the_pack_of_tyra — CREATED
- Missing entity: the_iron_host — CREATED
- Adventurers' Guild nickname (Ix'thari) — already existed; ranks remain TBD

---

## A3 - Connection Opportunities (updated)

| Source | Target | Status |
|--------|--------|--------|
| the_order_of_the_raven | zan_vaelis_zandorian | [ok] Added in this pass. |
| the_ecumenical_council | the_gods_and_the_deception | [ok] Added in this pass. |
| the_ecumenical_council | the_crimson_covenant | [ok] Added in this pass. |
| the_adventurers_guild | the_crimson_covenant | [ok] Added in this pass. |

---

## A4 - Creative Variants (unchanged)

See first pass report.

---

## File Health Summary

| File | Size (B) | Under 12KB? | Has `related`? | Has Secrets? | A1 | A2 |
|------|----------|-------------|----------------|-------------|----|----|
| the_adventurers_guild.md | ~4,300 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 1 |
| the_circle_of_the_wild.md | 2,061 | [ok] Yes | [ok] Yes (4) | [ok] Yes | 0 | 0 |
| the_council_accord.md | 2,245 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 0 |
| the_coven_of_the_spider.md | ~2,200 | [ok] Yes | [ok] Yes (3) | [ok] Yes | 0 | 0 |
| the_crimson_covenant.md | ~9,100 | [ok] Yes | [ok] Yes (11) | [ok] Yes FIXED | 0 | 0 |
| the_ecumenical_council.md | ~3,200 | [ok] Yes | [ok] Yes (18) | [x] No | 0 | 0 |
| the_first_alliance.md | 8,229 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 0 |
| the_four_barbarian_tribes.md | 2,663 | [ok] Yes | [ok] Yes (3) | [ok] Yes | 0 | 1 |
| the_guild_of_the_spark.md | 1,900 | [ok] Yes | [ok] Yes (4) | [ok] Yes | 0 | 0 |
| the_iron_host.md [NEW] | ~2,500 | [ok] Yes | [ok] Yes (2) | [ok] Yes | 0 | 0 |
| the_order_of_the_currency.md | 2,356 | [ok] Yes | [ok] Yes (4) | [ok] Yes | 0 | 0 |
| the_order_of_the_dawn.md | 2,017 | [ok] Yes | [ok] Yes (3) | [ok] Yes | 0 | 0 |
| the_order_of_the_protectors.md | 3,323 | [ok] Yes | [ok] Yes (6) | [ok] Yes | 0 | 0 |
| the_order_of_the_raven.md | ~2,200 | [ok] Yes | [ok] Yes (6) | [ok] Yes | 0 | 0 |
| the_order_of_the_scales.md | 2,648 | [ok] Yes | [ok] Yes (6) | [ok] Yes | 0 | 0 |
| the_pack_of_tyra.md [NEW] | ~2,500 | [ok] Yes | [ok] Yes (3) | [ok] Yes | 0 | 0 |
| the_skallfang_clan.md | ~6,300 | [ok] Yes | [ok] Yes (5) | [ok] Yes FIXED | 0 | 1 |
| the_thormvuld_family.md | 2,292 | [ok] Yes | [ok] Yes (4) | [ok] Yes | 0 | 1 |
| the_venom_weavers.md | 3,846 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 0 |
| the_vigil_of_the_dusk.md | 2,028 | [ok] Yes | [ok] Yes (4) | [ok] Yes | 0 | 0 |

Note: the_ecumenical_council.md still has no secrets field — the file serves as a public reference, so this may be intentional.

---

## Files Updated/Created in This Pass

| File | Changes |
|------|---------|
| the_coven_of_the_spider.md | Removed false "Member of Ecumenical Council" reference |
| the_order_of_the_raven.md | Removed false council reference; changed main temple to hidden sanctuary; added zan link |
| the_crimson_covenant.md | Fixed duplicate `access: gm-only` line |
| the_skallfang_clan.md | Fixed YAML formatting in secrets |
| the_ecumenical_council.md | Added links to the_gods_and_the_deception and the_crimson_covenant |
| the_adventurers_guild.md | Added link to the_crimson_covenant |
| the_pack_of_tyra.md | **[NEW]** Created — Tyra's recognized church |
| the_iron_host.md | **[NEW]** Created — Vorn's banned church |
