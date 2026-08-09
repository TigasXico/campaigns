# Session Continuity — Lore Development

> ⚠️ This file stores all cross-session context needed to pick up work after a compaction.
> Created: 2026-08-08 | Updated: 2026-08-09 02:36

---

## Work Progress

| Category | Status | Notes |
|----------|--------|-------|
| Magic & The Weave | ✅ **Complete** | All files cached |
| Cosmology & The Planes | ✅ **Complete** | All files cached |
| Gods & Religion | ✅ **Complete** | All 8 gods cached |
| Races & Ancestries | ✅ **Core complete** | Lore files written; some open questions deferred |
| The World & Geography | ✅ **Core complete** | Aetris, Kythoria, regions, eras, civilization defined |
| Society, Economy & Culture | ✅ **Complete** | Full lore file written, reviewed section-by-section, all design decisions finalized |
| Adventuring Classes | ✅ **Complete** | All 12 classes defined, magic source mapping, cultural perception, training, and regional distribution |
| Monsters & Ecology | ✅ **Complete** | Divine conspiracy revealed, planar breaches, B's hoarding instinct, monster hierarchy, Khar'zul, monster types, economy |
| **Khar'zul PC Backstory** | ✅ **Complete** | Balor Skallfang character file, Khar'zul's blade item file, expanded Covenant origins/Project Genesis/hierarchy, First Alliance expansion |

---

## Balor Skallfang — Open Questions (From Backstory)

The following questions emerged from processing the Balor Skallfang backstory. They remain open for the DM to answer:

1. ⏳ **Balor's mother** — Her name and fate remain unknown. Did she flee to protect Balor, or was she running from something else? The blade may have started following them rather than being carried.
2. ⏳ **The recurring dream** — The ashen field, red sky, winged figure. Is this Khar'zul's memories, Balor's own, or a connection between them?
3. ⏳ **What happened after Balor grabbed the blade?** — He remembers grabbing it and the world going dark, but the details between that moment and waking up remain unclear. The village was destroyed — did he do it, or did the fiend?
4. ⏳ **The leather pouch contents** — The medallion symbol, the ruins marked on the map — these need to be defined further.
5. ⏳ **Why did the eye form?** — Is it Khar'zul's consciousness manifesting, the blade developing its own awareness, or something else?
6. ⏳ **Where was the blade sealed and guarded during the years after Khar'zul's defeat?** — It was entrusted to the Skallfang Clan, but exact details of its journey to Hrothgar are unclear.
7. ⏳ **Define the warriors that were present during the battle and sealing of Khar'zul** — Who were the specific heroes of the First Alliance who fought at the sealing?
8. ⏳ **The homeland of Skallfang** — In the most northern territory of the continent, where the strongest monsters appear. Needs naming and detailed geography.
9. ⏳ **Hrothgar's safe room** — A room fully made of stone, with glyphs carved on the walls and hand-made talismans and amulets. Needs definition.
10. ⏳ **The fiend that attacked the village** — Controlled by the Crimson Covenant. Its nature, origin, and exact purpose need definition.
11. ⏳ **Why do Drow revere Lolth?** — Why did Lolth become worshipped by the Drow?
12. ⏳ **Why do Shadow Elves revere the Raven Queen?** — Why did the Raven Queen become worshipped by the Shadow Elves?
13. ⏳ **Balor's mother** — Physical description? Name? Why did she take the blade with her and the baby? Did the blade start following them while they escaped instead?
14. ⏳ **Did Balor ask others about what happened after he grabbed the blade and the world went dark?** — This is a character question that may surface in play.

---

## Session 2 — Corrections & Newly Identified Gaps (2026-08-09)

### Changes Made
1. **First Alliance organization created**: Created `cache/entities/organizations/the_first_alliance.md` — the historic military alliance that defeated three of the Five Monster Generals. Added to `_index.md` and `_master_relationships_map.md` (forward + inverse references across 8 entity sections). Also fixed lingering "Last Alliance" → "First Alliance" in `monsters_and_ecology.md` section header.
2. **Crimson Covenant moved to organizations/**: The Covenant was stored as `type: lore` in `cache/entities/lore/` but is an organization (has hierarchy, membership, goals, headquarters). Created `cache/entities/organizations/the_crimson_covenant.md` with proper Organization section headings (Structure, Membership, Headquarters, Goals, History, Current Activity). Deleted old lore file. Updated `_index.md` type. Updated all references in `_master_relationships_map.md` from `[lore]` to `[organization]`.
3. **Khar'zul's origin**: Corrected from "Nine Hells" to "Abyss" (balors are demons, not devils) in `monsters_and_ecology.md`
4. **Gods' knowledge secret**: Updated `the_gods_and_the_deception.md` secrets tag — they didn't know about B's will at first, but have since discovered it
5. **"Last Alliance" → "First Alliance"**: Corrected in `balor_skallfang.md`
6. **Barbarian "No magic" → "No spells"**: Corrected in `adventuring_classes.md` table (all creatures contain arcane energy, but barbarians don't cast spells)
7. **Backup removed**: Deleted `society_economy_and_culture_backup.md`
8. **"Khar'zul's mother" → "Balor's mother"**: Corrected in `balor_skallfang.md` open questions
9. **First Alliance timeline clarified**: Updated `the_last_stand.md` — the First Alliance was the army of the Last Stand, formed after the capitals were established, and drove the reconquering. Their victory marked the beginning of The Rise of the Mortals.
10. **Crystal cave location**: Updated `society_economy_and_culture.md` — the massive cave lies beneath Skywatch and Weaveheart, extending to the side of Emberforge, covering the entire area where the forest grows on top
11. **Missing relationships added**: `the_originals → primal_nature_magic` (essence suffused nature) and `the_great_sacrifice → the_world_and_geography` (precious metals shaped settlement/economy) added to `_master_relationships_map.md`

### Newly Identified Gaps (Added Tracking)

These gaps were identified during the consistency audit and are now tracked for future refinement:

1. ⏳ **Name the gods** — All 8 gods are identified only by domain (e.g., "God of Light and Life"). Proper names need to be created.
2. ⏳ **Which god claims which race?** — The deception map of which god falsely claims to have created which race is deferred until gods are named.
3. ⏳ **The Originals' true names** — A, B, C's names are "lost or deliberately erased" but remain undefined. Could be campaign lore payoff.
4. ⏳ **Crimson Covenant as part of larger evil council** — The Covenant may be part of a larger council of evil organizations tied to multiple character backstories.
5. ⏳ **The Resurrection Ritual requirements** — The exact method and components needed to resurrect B are deliberately undefined.
6. ⏳ **Which capital has the crystal cave entrance(s)?** — The massive cave is beneath both Skywatch and Weaveheart, with side extensions near Emberforge. Entry points need defining.
7. ⏳ **God of Peace & Twilight + Raven Queen domain boundary** — Both deal with transitions and death. Is death the ultimate transition, making Twilight subordinate? Their relationship needs defining.
8. ⏳ **Exact First Alliance timeline** — The First Alliance was the army of the Last Stand. When exactly did they defeat Khar'zul relative to the founding of the three capitals (~200 years ago)? Clarify.

---

## ⏭️ Next Session — Potential Next Steps

The next instance could:

1. **Process Baldur's backstory open questions** — See "Balor Skallfang — Open Questions" section above
2. **Define the remaining generals** — 2 retreated, 3 defeated (only Khar'zul named)
3. **Name the gods** — Create proper names for all 8 gods (currently identified only by domain)
4. **Map the manufactured divine conflict** — Which gods are allied/rivals
5. **Expand Skallfang Clan homeland** — Geography, settlements, notable NPCs
6. **Process any other PC backstories** — Especially those connected to the Crimson Covenant or the council of evil organizations
7. **Map the Barbarian tribes** — Four great tribes (one per cardinal direction) tied to PC backstory
8. **Calendar month names** — 10 months aligned with gods (post-pantheon review)

### Key Files to Read First
- `cache/_session_continuity.md` — This file for full context
- `cache/entities/characters/balor_skallfang.md` — PC backstory and open questions
- `cache/entities/items/kharzuls_blade.md` — The living prison item
- `cache/entities/lore/the_crimson_covenant.md` — Full rewrite with Project Genesis
- `cache/entities/lore/the_last_stand.md` — First Alliance expansion