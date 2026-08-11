# Category Audit: characters (Second Pass)
**Date:** 2026-08-11
**Status:** Updated against full context

---

## Files Audited (27 files across 3 subfolders)

### Deities (10)
aloria.md, aurelius.md, crassian.md, kaelthor.md, lolth_the_spider_queen.md, thalkis.md, the_raven_queen.md, tyra.md, vesper.md, vorn.md

### NPCs (8)
eryx_merikh.md, lyndale_velkyn.md, paul.md, rhael.md, satriya_merikh.md, seraphina_vex.md, solyn_velkyn.md, valen_healoris.md

### PCs (9)
aegon.md, aurora_asteria.md, balor_skallfang.md, bardolemeu_romeo.md, kaelyn.md, nyra.md, odessa_merikh.md, sanzo.md, zan_vaelis_zandorian.md

---

## A1 - Remaining Contradictions

| # | File | Contradiction | Severity | Fix |
|---|------|--------------|----------|-----|
| 1 | balor_skallfang.md | **14,829 bytes (~14.5 KB)** -- exceeds 12KB mandatory cap. | [!] Moderate | Split into main file + backstory supplement. |
| 2 | kaelyn.md | **18,651 bytes (~18.2 KB)** -- exceeds 12KB cap by 54%. Largest file in cache. | [!] Moderate | Split into main file + backstory supplement. |
| 3 | odessa_merikh.md | **16,746 bytes (~16.4 KB)** -- exceeds 12KB cap. | [!] Moderate | Split into main file + backstory/GM notes supplement. |
| 4 | aurora_asteria.md | **12,579 bytes (~12.3 KB)** -- barely exceeds 12KB cap. | [x] Minor | Trim GM Notes section or split into supplement. |

**Resolved in this pass:**
- tyra.md double `---` YAML error -- FIXED
- vorn.md double `---` YAML error -- FIXED
- vesper.md indented `created` YAML error -- FIXED
- Deity race claims unmapped -- FIXED (all 10 deities now link to races_and_ancestries with their false claim)
- Deities having no secrets -- REMOVED from findings (divine deception secrets are centralized in the_gods_and_the_deception.md by design)

---

## A2 - Remaining Narrative Gaps

| # | File | Gap | Impact | Status |
|---|------|-----|--------|--------|
| 1 | sanzo.md | Entire backstory missing. Player (Guilherme/Gui) must provide. | Zero hooks into lore web. | Player input required. |
| 2 | bardolemeu_romeo.md | Family name, theater locations, family reaction all undefined. | No entities for "half the theaters." | Open. |
| 3 | nyra.md | Mystery box, blue dragon location, parents, divine attacker all TBD. | 4 major unknowns. | Open. |
| 4 | zan_vaelis_zandorian.md | Experimenter, escape method, teleport stability, family all TBD. | Core definition missing. | Open. |
| 5 | Deities (global) | Holy symbols not defined for any deity. | Worship lacks physical symbols. | Open. |
| 6 | Deities (global) | Vesper/Raven Queen boundary deferred. Both have twilight/transition themes. | Potential domain conflict. | Open (tracked in session continuity). |
| 7 | seraphina_vex.md | "Seraphine" (Drow nanny) vs "Seraphina Vex" -- connection unresolved. | Dangling thread between Kaelyn and Balor. | Open. |
| 8 | kaelyn.md | Crystal growth triggers undefined. Azure Boneyard lost. | 2 remaining open questions. | Open. |
| 9 | kaelyn.md | Overheating mechanic has no mechanical/HP cost. | Player cannot track consequence. | Open. |

**Resolved in this pass:**
- Solyn's current status -- RESOLVED (solyn_velkyn.md: acting leader of House Velkyn)
- Lyndale's current status -- RESOLVED (lyndale_velkyn.md: burned, hidden, vengeful)
- Deity race claims -- RESOLVED (races_and_ancestries.md full table + deity related links)
- Deity domain city -- REMOVED (churches define their main temples in organization files)

---

## A3 - Connection Opportunities (unchanged from first pass)

| Source | Target | Relationship |
|--------|--------|-------------|
| kaelyn | zan_vaelis_zandorian | Both Covenant-created races (Drow/Shadow Elf) -- no link. |
| kaelyn / seraphina_vex | balor_skallfang | Seraphine (nanny) may be Seraphina Vex. |
| nyra | the_azure_boneyard | Blue dragon connection to Kaelyn's boneyard. |
| aurelius | the_gods_and_the_deception | Explicit link for Paul's murder. |
| nyra | skywatch | Air genasi favored in Skywatch -- no location link. |
| bardolemeu_romeo | the_crimson_covenant | Family theaters may be CC hubs -- no link. |
| sanzo | the_originals | Monks access ki = B's essence directly. |

---

## A4 - Creative Variants (unchanged from first pass)

See first-pass report for full options on: Sanzo's backstory, Deity race claims (now resolved), Nyra's mystery box.

---

## File Health Summary

| File | Size (B) | Under 12KB? | Has `related`? | Has Secrets? | A1 | A2 |
|------|----------|-------------|----------------|-------------|----|----|
| aloria.md | ~770 | [ok] Yes | [ok] Yes (4) | [x] No | 0 | 1 |
| aurelius.md | ~1,470 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 1 |
| crassian.md | ~840 | [ok] Yes | [ok] Yes (4) | [x] No | 0 | 1 |
| kaelthor.md | ~850 | [ok] Yes | [ok] Yes (5) | [x] No | 0 | 1 |
| lolth_the_spider_queen.md | ~830 | [ok] Yes | [ok] Yes (4) | [x] No | 0 | 1 |
| thalkis.md | ~850 | [ok] Yes | [ok] Yes (5) | [x] No | 0 | 1 |
| the_raven_queen.md | ~840 | [ok] Yes | [ok] Yes (4) | [x] No | 0 | 1 |
| tyra.md | ~930 | [ok] Yes | [ok] Yes (5) | [x] No | 0 | 1 |
| vesper.md | ~810 | [ok] Yes | [ok] Yes (4) | [x] No | 0 | 1 |
| vorn.md | ~940 | [ok] Yes | [ok] Yes (5) | [x] No | 0 | 1 |
| eryx_merikh.md | 3,800 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 0 |
| lyndale_velkyn.md | 5,490 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 0 |
| paul.md | 4,761 | [ok] Yes | [ok] Yes (8) | [ok] Yes | 0 | 0 |
| rhael.md | 2,821 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 0 |
| satriya_merikh.md | 3,662 | [ok] Yes | [ok] Yes (6) | [ok] Yes | 0 | 0 |
| seraphina_vex.md | 8,464 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 1 |
| solyn_velkyn.md | 6,565 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 0 |
| valen_healoris.md | 7,010 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 0 |
| aegon.md | 10,038 | [ok] Yes | [ok] Yes (11) | [ok] Yes | 0 | 0 |
| aurora_asteria.md | 12,579 | [x] No | [ok] Yes (12) | [ok] Yes | 1 | 0 |
| balor_skallfang.md | 14,829 | [x] No | [ok] Yes (12) | [ok] Yes | 1 | 0 |
| bardolemeu_romeo.md | 3,980 | [ok] Yes | [ok] Yes (5) | [ok] Yes | 0 | 1 |
| kaelyn.md | 18,651 | [x] No | [ok] Yes (18) | [ok] Yes | 1 | 2 |
| nyra.md | 3,975 | [ok] Yes | [ok] Yes (7) | [ok] Yes | 0 | 4 |
| odessa_merikh.md | 16,746 | [x] No | [ok] Yes (9) | [ok] Yes | 1 | 0 |
| sanzo.md | 2,925 | [ok] Yes | [ok] Yes (3) | [ok] Yes | 0 | 4 |
| zan_vaelis_zandorian.md | 4,002 | [ok] Yes | [ok] Yes (6) | [ok] Yes | 0 | 4 |

**Summary:** 4 files over 12KB cap (unchanged), all YAML errors FIXED, deity race claims ADDED, kaelyn open questions partially RESOLVED.

---

## Files Updated in This Pass

| File | Changes |
|------|---------|
| Deity/tyra.md | Fixed double `---`, added race claim (Dragonborn), updated date |
| Deity/vorn.md | Fixed double `---`, added race claim (Half-Orcs), updated date |
| Deity/vesper.md | Fixed indented `created` field, added race claim (Genasi) |
| Deity/aloria.md | Added race claim (Humans) |
| Deity/aurelius.md | Added race claim (Gnomes) |
| Deity/kaelthor.md | Added race claim (Elves) |
| Deity/thalkis.md | Added race claim (Dwarves) |
| Deity/lolth_the_spider_queen.md | Added race claim (Drow) |
| Deity/the_raven_queen.md | Added race claim (Shadow Elves) |
| Deity/crassian.md | Added race claim (Halflings) |
| PC/Kaelyn/kaelyn.md | Resolved Solyn/Lyndale status open questions, updated relationships |
