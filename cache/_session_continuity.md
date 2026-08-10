# Session Continuity  -  Lore Development

> Stores cross-session context needed to resume work after compaction.
> Created: 2026-08-08 | Updated: 2026-08-10

---

## Work Progress

| Category | Status | Notes |
|----------|--------|-------|
| Magic & The Weave | Complete | All files cached |
| Cosmology & The Planes | Complete | All files cached |
| Gods & Religion | Complete | 10 gods named, secrets scrubbed. Calendar (10 months, 10-day week) finalized. |
| Races & Ancestries | Complete | Deception map finalized. Unclaimed races (Tieflings) noted. |
| The World & Geography | Core complete | Aetris, Kythoria, regions, eras defined |
| Society, Economy & Culture | Complete | Full lore file written, all design decisions finalized |
| Adventuring Classes | Complete | All 12 classes defined, magic source map, training, regional distribution |
| Monsters & Ecology | Complete | Divine conspiracy, planar breaches, B's hoarding, hierarchy, Khar'zul, monster economy |
| Khar'zul PC Backstory | Complete | Balor Skallfang, Khar'zul's blade, expanded Covenant, Project Genesis, First Alliance |

---

## Major Restructuring (2026-08-09)  -  Cost Optimization

Files split/trimmed to reduce context bloat, following 12KB max file size mandate:

**Split files:**
- `society_economy_and_culture.md` (35KB) -> `society.md` + `economy.md` + `culture_and_society.md`
- `monsters_and_ecology.md` (33KB) -> `monsters_and_ecology.md` + `the_divine_conspiracy.md` + `monster_economy.md`
- `adventuring_classes.md` (31KB) -> `adventuring_classes.md` + `class_training_and_culture.md`

**Trimmed files (to under 12KB):**
- `the_gods_and_the_deception.md`, `the_crimson_covenant.md`, `balor_skallfang.md`, `kythorian_timeline.md`

**Other changes:**
- `_session_continuity_pre.txt` (39KB) archived to `cache/archived/`
- Added Cost Optimization Protocol (7 mandatory rules) to WORKFLOW.md
- Added 12KB max file size mandate to CACHE_FORMAT.md
- `_master_relationships_map.md` now Tier 3 (load only for audits)

## Session 2  -  Corrections (2026-08-09)

1. Created `the_first_alliance.md`. Updated index + relationships.
2. Crimson Covenant moved from `lore/` to `organizations/`.
3. Khar'zul's origin: Nine Hells -> Abyss (balors are demons).
4. Gods discovered B's will after invasion (updated deception secrets tag).
5. "Last Alliance" -> "First Alliance" in balor_skallfang.md.
6. Barbarian "No magic" -> "No spells" in adventuring_classes.md.
7. Crystal cave location: beneath Skywatch + Weaveheart, extending toward Emberforge.
8. Added missing relationships: the_originals <-> primal_nature_magic, the_great_sacrifice <-> the_world_and_geography.

### Gaps Identified
- The Originals' true names (A, B, C)  -  lost/erased. Campaign payoff.
- Resurrection Ritual requirements  -  deliberately undefined.
- Crystal cave entrances  -  which capital(s)?
- Exact First Alliance timeline  -  relative to capital founding (~200ya).

---

## Session 3  -  Balor Open Questions Resolved (2026-08-09)

**Resolved:** Balor's mother (Seraphina Vex), blackout cause, pouch contents, eye formation, blade's journey, Skallfang homeland (Frostmaw), Hrothgar's safe room, the fiend (Nalfeshnee).

**Files created:** `seraphina_vex.md`, `the_medallion_of_vex.md`, `the_frostmaw.md`

**Files updated:** `balor_skallfang.md`, `kharzuls_blade.md`, `the_skallfang_clan.md`, `kythorian_timeline.md`, `_index.md`

**Remaining Balor open questions (3):** Did Balor ask about blackout? (yes, no one saw  -  character exploration). Seraphina's intelligence cache in NE ruins. Medallion's hidden compartment coordinates.

---

## Instance Handoff  -  Current State (2026-08-09 19:59)

> Last change: Renamed Veridius -> Aurelius across entire cache.

**What's Been Completed**
- 10 gods named: Aloria, Thalkis, Kaelthor, Aurelius, Crassian, Vesper, Lolth, Raven Queen, Vorn, Tyra
- Race Deception Map: 1-to-1 mapping, no overlap
- Calendar: 10 months (god-named, creation-order), 10-day week (domain-named), festivals
- Manufactured Divine Conflict: Lolth, Raven Queen & Vorn publicly blamed. Their churches banned. Half-Orcs distrusted. Vorn worship secret. Only 7 recognized churches on Ecumenical Council.
- Character restructuring: 10 deity files (secrets removed), PC/NPC subfolders.
- Ecumenical Council: 7 members; clergy don't know conflict is fake (only gods know)

**Key Sessions Completed**
- Balor PC backstory fully resolved (mother, blade, clan, blackout)
- Kaelyn PC backstory fully drafted (28KB  -  pending split)
- Aurora PC backstory fully drafted (15KB  -  pending split)
- Aegon PC backstory fully drafted (12KB)
- Seraphina Vex NPC fully drafted (12KB)

---

## Open Question Tracker

### Balor Skallfang (3 open)
- [?] Seraphina's intelligence cache in northeastern ruins
- [?] The Medallion's hidden compartment  -  coordinates in Old Abyssal
- [?] The Avatar state  -  can Balor trigger it intentionally?

### Gods & Pantheon (3 open)
- [?] The Originals' true names (A, B, C)
- [?] Festival articles  -  create cache pages for 8 festivals
- [?] Vesper/Raven Queen boundary (deferred)

### Monsters & Ecology (10 open)
- [?] The Four Unnamed Generals  -  3 defeated + 2 retreated
- [?] Remaining Loyalist Command
- [?] Crystal-Corrupted Apex  -  corrupted dragon?
- [?] Resurrection Ritual  -  exact method
- [?] Mortal Discoverers  -  which arcanists know?
- [?] The Blackmail Threshold  -  CC vs gods leverage
- [?] Monster Army's Breaking Point
- [?] Detailed Monster Ecology  -  tainted zones
- [?] Monster Economy Details  -  guilds, merchants
- [?] Monster Categories by Plane  -  open for flexibility

### Society, Geography & Place Names (13 open)
- [?] Adventurers' Guild name  -  Drakh Ix'thar. Members: Ix'thari
- [?] The Great Circuit  -  Crassian's Dust Circle
- [?] NE settlement cluster names, SE port name, E port name
- [?] Crystal cave entrances  -  which capital(s)?
- [?] Crystal cave deeper exploration
- [?] Pre-invasion culture  -  Era of Foundation
- [?] Notable NPCs  -  city leaders, guildmasters
- [?] The black market  -  underworld faction potential
- [?] Specific guild detail write-ups
- [?] Exact First Alliance timeline
- [?] Skallfang homeland (in cache)

### Crimson Covenant & Blade (2 open)
- [?] Larger evil council  -  is CC part of something bigger?
- [?] Rite of Ash exact requirements

### Kaelyn (7 open)
- [?] Solyn's current status
- [?] Lyndale's current status
- [?] Crystal heart growth  -  triggers, acceleration, control
- [?] Connection to other B-touched
- [?] Black Willow's crystal cave secrets
- [?] Seraphine's hidden records
- [?] Azure Boneyard  -  can it be found again?

### Aurora (4 open)
- [?] Polaris exact fate (captured/experimented/Drow/Shadow Elf/monster pack leader)
- [?] Elarwyn's exact location in Verdant Reaches
- [?] White fox will return?
- [?] What do the hidden constellations spell out?

### Aegon (5 open)
- [?] Who was Aegon's biological father? Why abandon them?
- [?] What exactly did Paul know?
- [?] Who attacked Paul's chapel? (GM note: Order framed CC)
- [?] Jealous/fanatic members in the Order
- [?] B's influence on Aegon  -  will visions reveal truth?

### Seraphina Vex (4 open)
- [?] Intelligence caches  -  what's in each?
- [?] Second journal location
- [?] Medallion's second purpose
- [?] Other Vex bloodline descendants alive?

---

## Timeline Management

> Master timeline: `cache/entities/events/kythorian_timeline.md`
> Any future event with a defined timeframe MUST be added to this file.

**How to maintain:**
1. When creating a time-bound entity, open `kythorian_timeline.md`
2. Insert chronologically with ### heading format
3. Include: Timeframe, Description, entity references
4. Update file's `updated` and `related` frontmatter fields

---

## Next Session  -  Potential Next Steps

1. Name the NE settlement cluster settlements
2. Name the SE port and E port
3. Define remaining monster generals (only Khar'zul named)
4. Map the manufactured divine conflict
5. Process other PC backstories (especially CC-connected)
6. Map the Four Barbarian Tribes

### Key Files to Read First
- `cache/_session_continuity.md`  -  This file (current handoff)
- `_index.md`  -  Entity registry
- Current PC backstory files in `cache/entities/characters/PC/`
