# Session Continuity — Lore Development

> ⚠️ This file stores all cross-session context needed to pick up work after a compaction.
> Created: 2026-08-08 | Updated: 2026-08-09 06:35

---

## Work Progress

| Category | Status | Notes |
|----------|--------|-------|
| Magic & The Weave | ✅ **Complete** | All files cached |
| Cosmology & The Planes | ✅ **Complete** | All files cached |
| Gods & Religion | ✅ **Complete** | All 10 gods cached, named, with secrets scrubbed. Public creation myth & race deception map documented. Calendar with 10 months & 10-day week finalized. |
| Races & Ancestries | ✅ **Complete** | Deception map (which god claims which race) finalized. Unclaimed races (Tieflings) noted. |
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

## 🗺️ Master Open Question Tracker

> All 45 open questions from across the lore cache, organized by category. Status is tracked here and in individual entity files.
> Status: ⏳ = Open, ✅ = Answered
> Updated: 2026-08-09

### A 🔴 Balor Skallfang — Character Mysteries
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 1 | ⏳ | **Balor's mother** — Name? Fate? Did she flee to protect or escape? | `balor_skallfang.md` |
| 2 | ⏳ | **The recurring dream** — Ashen field, red sky, winged figure. Whose memories? | `balor_skallfang.md` |
| 3 | ⏳ | **The blackout** — What happened after Balor grabbed the blade? Did he destroy the village? | `balor_skallfang.md` |
| 4 | ⏳ | **Leather pouch contents** — Medallion symbol? Ruins marked on the map? | `balor_skallfang.md` |
| 5 | ⏳ | **Why did the eye form?** — Khar'zul's consciousness, blade awareness, or something else? | `kharzuls_blade.md` |
| — | ✅ | **Adventurers' Guild name:** Drakh Ix'thar. Members: Ix'thari. Ranks to be defined in Draconic. HQ: old capital in center of continent. | `session_continuity.md` |
| — | ✅ | **Crassian's Dust Circle:** The Great Circuit renamed. Named after dust cloud from trade caravans upon completion. | `session_continuity.md` |
| 6 | ⏳ | **Blade's journey** — Exact path from sealing through Skallfang Clan to Hrothgar | `kharzuls_blade.md` |
| 7 | ⏳ | **Heroes of the First Alliance** — Who were the warriors at Khar'zul's sealing? | `balor_skallfang.md` |
| 8 | ⏳ | **Skallfang homeland** — Needs naming and detailed geography | `balor_skallfang.md` |
| 9 | ⏳ | **Hrothgar's safe room** — Glyphs, talismans, purpose? | `balor_skallfang.md` |
| 10 | ⏳ | **The fiend** — Nature, origin, purpose of Covenant-controlled attacker | `balor_skallfang.md` |

### B 🟠 Worship Questions — Drow & Shadow Elves
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 11 | ⏳ | **Why do Drow revere Lolth?** — She didn't create them, yet they worship her | `races_and_ancestries.md` |
| 12 | ⏳ | **Why do Shadow Elves revere the Raven Queen?** — Same logic | `races_and_ancestries.md` |

### C 🟡 Gods & Pantheon — Name Everything
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 13 | ✅ | **Name the 8 gods** — Aloria, Thalkis, Kaelthor, Aurelius, Crassian, Vesper, Lolth, Raven Queen | `the_gods_and_the_deception.md` |
| 14 | ✅ | **Which god claims which race?** — See races_and_ancestries.md deception table | `races_and_ancestries.md` |
| 15 | ⏳ *(Deferred)* | **Vesper/Raven Queen boundary** — Deferred until full manufactured divine conflict review | `session_continuity.md` |
| 16 | ✅ | **Manufactured divine conflict map** — Lolth, Raven Queen & Vorn publicly blamed; 7 recognized churches. Half-Orcs distrusted despite fighting in First Alliance. Vorn worship is secret. | `the_gods_and_the_deception.md`, `races_and_ancestries.md` |
| 17 | ✅ | **Pantheon review — 10 gods** (8 originals + Vorn & Tyra) — Calendar implications | `society_economy_and_culture.md` |
| 18 | ⏳ | **The Originals' true names** — A, B, C — lost or deliberately erased | `the_originals.md` |
| 19 | ⏳ | **Festival articles** — Create dedicated cache pages for each of the 8 festivals | `society_economy_and_culture.md` |
| 20 | ✅ | **Calendar month names** — 10 months named after gods; 10-day week; creation story order | `society_economy_and_culture.md` |

### D 🟢 Monsters & Ecology — The Remaining Generals
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 21 | ⏳ | **The Four Unnamed Generals** — 3 defeated + 2 retreated. Only Khar'zul named | `monsters_and_ecology.md` |
| 22 | ⏳ | **Remaining Loyalist Command** — Who commands monster forces today? | `monsters_and_ecology.md` |
| 23 | ⏳ | **Crystal-Corrupted Apex** — What happens to a dragon that becomes corrupted? | `monsters_and_ecology.md` |
| 24 | ⏳ | **Resurrection Ritual requirements** — Exact method to resurrect B | `monsters_and_ecology.md` |
| 25 | ⏳ | **Mortal Discoverers** — Which arcanists know parts of the truth? | `monsters_and_ecology.md` |
| 26 | ⏳ | **The Blackmail Threshold** — How far can CC push the gods? | `monsters_and_ecology.md` |
| 27 | ⏳ | **Monster Army's Breaking Point** — Would they turn on gods if they knew truth? | `monsters_and_ecology.md` |
| 28 | ⏳ | **Detailed Monster Ecology** — Tainted zones, nesting grounds, adapted wildlife | `monsters_and_ecology.md` |
| 29 | ⏳ | **Monster Economy Details** — Specific guilds, merchants, industries | `monsters_and_ecology.md` |
| 30 | ⏳ | **Monster Categories by Plane** — Deliberately open for flexibility | `monsters_and_ecology.md` |

### E 🔵 Society, Geography & Place Names
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 31 | ⏳ | **Adventurers' Guild name** — Continent-wide guild needs a name | `society_economy_and_culture.md` |
| 32 | ⏳ | **Guild member nickname** — What are members called? | `society_economy_and_culture.md` |
| 33 | ⏳ | **The Great Circuit** — Overland trade route needs a name | `society_economy_and_culture.md` |
| 34 | ⏳ | **Northeast settlement cluster** — 1 major + 3 minor + 2 export towns need names | `society_economy_and_culture.md` |
| 35 | ⏳ | **Southeastern port** — Main sea trade hub needs a name | `society_economy_and_culture.md` |
| 36 | ⏳ | **Eastern port** — Secondary port needs a name | `society_economy_and_culture.md` |
| 37 | ⏳ | **Crystal cave entrances** — Which capital(s) have access points? | `session_continuity.md` |
| 38 | ⏳ | **Crystal cave deeper exploration** — What lies deeper in the cave? | `the_arcane_reactive_crystal_cave.md` |
| 39 | ⏳ | **Pre-invasion culture** — Era of Foundation remains undefined | `session_continuity.md` |
| 40 | ⏳ | **Notable NPCs** — City leaders, guildmasters, high priests | `session_continuity.md` |
| 41 | ⏳ | **The black market** — Could become an underworld faction | `session_continuity.md` |
| 42 | ⏳ | **Specific guild detail write-ups** — Organization entities for major guilds | `session_continuity.md` |
| 43 | ⏳ | **Exact First Alliance timeline** — When did they defeat Khar'zul relative to capitals? | `session_continuity.md` |

### F 🟣 Crimson Covenant & Blade Details
| # | Status | Question | Source File |
|---|--------|----------|-------------|
| 44 | ⏳ | **Larger evil council?** — Is CC part of a larger evil org tied to other PC backstories? | `session_continuity.md` |
| 45 | ⏳ | **Rite of Ash exact requirements** — Prayer parameters in Old Abyssal undefined | `kharzuls_blade.md` |

## 🔄 Instance Handoff — Current State (2026-08-09 19:59)

> This file was last updated during a session that renamed Veridius → Aurelius across the entire cache.
> Below is everything a new goose instance needs to pick up context immediately.

### What's Been Completed
- **10 gods named**: Aloria, Thalkis, Kaelthor, Aurelius (was Veridius), Crassian, Vesper, Lolth, Raven Queen, Vorn, Tyra
- **Race Deception Map**: Which god falsely claims which race — 1-to-1 mapping, no overlap
- **Calendar**: 10 months (god-named, creation-order), 10-day week (domain-named), festivals on day matching month order (4 work / 2 rest / 3 work / 1 rest pattern)
- **Public Creation Myth**: False creation story documenting the "order of creation" the gods fabricated
- **Manufactured Divine Conflict Map (Q16)**: Lolth, Raven Queen & Vorn publicly blamed for monster invasion. Their churches (Coven of the Spider, Order of the Raven, Iron Host) banned from Last Stand. Half-Orcs distrusted despite fighting in First Alliance. Vorn worship is secret. Only the 7 recognized churches (Aloria, Thalkis, Kaelthor, Aurelius, Crassian, Vesper, Tyra) sit on the Ecumenical Council.
- **Character restructuring**: Characters moved to Deity/ (10 files), PC/ (balor_skallfang.md), NPC/ subfolders. Secrets column removed from all deity files.
- **Ecumenical Council**: Reduced to 7 members; clergy do NOT know the divine conflict is fake (only gods know)

### All Open Questions (45 tracked in Master Open Question Tracker above)
- **A (Balor Skallfang)** — 10 open questions (#1-10)
- **B (Worship)** — 2 open (#11-12): Why Drow revere Lolth, why Shadow Elves revere Raven Queen
- **C (Gods)** — 4 open (#15: Vesper/Raven Queen boundary, #18: Originals' true names, #19: festival articles)
- **D (Monsters)** — 10 open (#21-30)
- **E (Society)** — 13 open (#31-43): Adventurers' Guild name & nickname, trade route names, settlement names, cave entrances, timeline
- **F (Covenant)** — 2 open (#44-45)

### Quick Wins to Pick Up First
1. ✅ **Name the Adventurers' Guild** — Drakh Ix'thar, members Ix'thari. Ranks to be defined in Draconic. HQ in old capital (center of continent).
2. ✅ **Name trade routes** — The Great Circuit → **Crassian's Dust Circle**
3. **Name settlements** — NE cluster (#34), SE port (#35), E port (#36), Skallfang homeland (#8) — *(Deferred)*
4. **Define why Drow/Shadow Elves revere their gods** (#11-12) — *(Deferred pending player Drow lore review)*
5. **Define the Skallfang homeland** (#8) — *(Deferred)*

### Last Change Before Commit
- Renamed god **Veridius → Aurelius** globally across all 8 affected files + deity file rename

---

## 📜 Timeline Management

> The file `cache/entities/events/kythorian_timeline.md` is the **master timeline** for all events in Kythoria.
> **Any future event or entity that has an associated time or date MUST be added to this file.**
> This includes new campaign events, backstory events, historical events, or any event with a defined timeframe.

**How to maintain:**
1. When creating a new entity with a timeframe (event, location founding, character backstory, historical occurrence), open `kythorian_timeline.md`
2. Find the correct chronological position in the event list
3. Insert the event in order by timeframe, maintaining the ### heading format
4. Include: Timeframe, Description, and related entity references
5. If a new era is needed, add it at the appropriate chronological position
6. Update the `updated` field in the file's frontmatter
7. Add the entity to the `related` field in the timeline file's frontmatter

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

