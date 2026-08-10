# Session Continuity -- Lore Development

> Stores cross-session context needed to resume work after compaction.
> Created: 2026-08-08 | Updated: 2026-08-11

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
| Cost Optimization | In Progress | Steps 1-3 complete, Steps 4-5 pending. See `cache/plan_cost_optimization.md` |
| **Odessa Merikh PC Backstory** | **Complete** | Enhanced file written, NPCs created, org created, index synced |

---

## Cost Optimization Plan -- Resumption Point

**Plan file**: `cache/plan_cost_optimization.md`

**Completed:**
- Step 1 (Merge Context) -- 23 merges, 12 files -- committed in `7541b26`
- Step 2 (Add Missing `related:`) -- 79 entries, 29 files -- committed in `db2a455`

**Completed:**
- Step 3 (Global Content Check) -- 48 context merges, 29 files -- committed in Step 3 commit

**Next: Step 4 -- Build Query Script**
- Build `scripts/get-entity-relationships.ps1` for on-demand relationship queries
- Replace the static 43KB master map

**Committed:**
- `7541b26` -- Cost optimization batch 1 (unicode, frontmatter, context merges)
- `db2a455` -- Added 79 missing related: entries

**Validation:** `powershell -ExecutionPolicy Bypass -File scripts/validate-relationships.ps1` confirms all 380 relationships present.

---

## Open Question Tracker

### Balor Skallfang (3 open)
- [?] Seraphina's intelligence cache in northeastern ruins
- [?] The Medallion's hidden compartment -- coordinates in Old Abyssal
- [?] The Avatar state -- can Balor trigger it intentionally?

### Gods & Pantheon (2 open)
- [?] The Originals' true names (A, B, C)
- [?] Vesper/Raven Queen boundary (deferred)

### Monsters & Ecology (10 open)
- [?] The Four Unnamed Generals -- 3 defeated + 2 retreated
- [?] Remaining Loyalist Command
- [?] Crystal-Corrupted Apex -- corrupted dragon?
- [?] Resurrection Ritual -- exact method
- [?] Mortal Discoverers -- which arcanists know?
- [?] The Blackmail Threshold -- CC vs gods leverage
- [?] Monster Army's Breaking Point
- [?] Detailed Monster Ecology -- tainted zones
- [?] Monster Economy Details -- guilds, merchants
- [?] Monster Categories by Plane -- open for flexibility

### Society, Geography & Place Names (10 open)
- [?] The Great Circuit -- Crassian's Dust Circle
- [?] NE settlement cluster names, SE port name, E port name
- [?] Crystal cave deeper exploration
- [?] Pre-invasion culture -- Era of Foundation
- [?] Notable NPCs -- city leaders, guildmasters
- [?] The black market -- underworld faction potential
- [?] Specific guild detail write-ups
- [?] Exact First Alliance timeline
- [?] Calendar festival articles -- create pages for 8 festivals

### Crimson Covenant & Blade (2 open)
- [?] Larger evil council -- is CC part of something bigger?
- [?] Rite of Ash exact requirements

### Kaelyn (7 open)
- [?] Solyn's current status
- [?] Lyndale's current status
- [?] Crystal heart growth -- triggers, acceleration, control
- [?] Connection to other B-touched
- [?] Black Willow's crystal cave secrets
- [?] Seraphine's hidden records
- [?] Azure Boneyard -- can it be found again?

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
- [?] B's influence on Aegon -- will visions reveal truth?

### Seraphina Vex (4 open)
- [?] Intelligence caches -- what's in each?
- [?] Second journal location
- [?] Medallion's second purpose
- [?] Other Vex bloodline descendants alive?

### Odessa Merikh (6 open)
- [?] **Where is Eryx's proof?** Hidden cache, guild intelligence, or lost?
- [?] **Where exactly does Valen command?** Which monster-held territory?
- [?] **What will Odessa do after Valen is dead?** She has no plan beyond the kill.
- [?] **Will she learn the truth about her parentage?** And if so, how?
- [?] **Who else in the elven military knew about the surrender to the Covenant?** Are there other survivors who could be implicated?
- [?] **Will the Venom-Weavers support Odessa's final mission?** Or will they try to hold her back?
- [?] **What became of Odessa's biological mother?** Alive, dead, captive, or lost? A source of closure or another wound?

---

## Timeline Management

> Master timeline: `cache/entities/events/kythorian_timeline.md`
> Any future event with a defined timeframe MUST be added to this file.

**How to maintain:**
1. When creating a time-bound entity, open `kythorian_timeline.md`
2. Insert chronologically with ### heading format
3. Include: Timeframe, Description, entity references
4. Update file's `updated` and `related` frontmatter fields