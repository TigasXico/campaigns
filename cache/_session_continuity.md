# Session Continuity -- Lore Development

> Stores cross-session context needed to resume work after compaction.
> Created: 2026-08-08 | Updated: 2026-08-11

---

## Work Progress

| Category | Status | Notes |
|----------|--------|-------|
| Audit: All 7 categories | [ok] Complete | 27/27 contradictions resolved. 42 files fixed across 2 passes. |
| Entity count | 90 files | All entity files have related: entries and valid links. |
| Index | [ok] Synced | _index.md reflects all 90 entities on disk. |

---

## Open Question Tracker

### Player-Dependent Backstories (4)
- [?] sanzo -- entirely empty, needs player (Guilherme/Gui) input
- [?] bardolemeu_romeo -- family name, theaters, family members undefined
- [?] nyra -- mystery box, blue dragon, parents, divine attacker all TBD
- [?] zan_vaelis_zandorian -- experimenter, escape method, teleport stability, family TBD

### GM Design Decisions (12)
- [?] Four Unnamed Generals -- names, creature types, domains, status (2 defeated, 2 retreated)
- [?] Vesper / Raven Queen boundary -- separate gods or aspects?
- [?] Blade's journey -- how did it pass from Skallfang to Covenant (~150 to ~20 YA)?
- [?] Planar Pact details -- which gods made deals with which planes?
- [?] Covenant founders -- name the original dissident scholars
- [?] Three Kings -- name the founders of the Last Stand
- [?] Era of Foundation -- pre-invasion history at high level
- [?] Source of demonic tissue -- Covenant experiments origin
- [?] Larger evil council -- is CC part of something bigger?
- [?] Monster Ecology details -- tainted zones, nesting grounds
- [?] Monster Economy details -- named merchants and guilds
- [?] Rite of Ash exact requirements

### File Size Cap Violations (4)
- [!] kaelyn.md -- 18.6KB (needs split: main + backstory supplement)
- [!] odessa_merikh.md -- 16.7KB (needs split: main + GM notes)
- [!] balor_skallfang.md -- 14.8KB (needs split: main + backstory)
- [!] aurora_asteria.md -- 12.6KB (trim or split GM notes)

### Naming Gaps (6)
- [?] The Eastern Port -- no proper name
- [?] The Southeastern Port -- no proper name
- [?] NE Settlement Cluster -- unnamed major + 3 minor settlements
- [?] Old Capital of Kythoria -- unnamed (High Septon location)
- [?] Frontier Forward Operating Base -- unnamed
- [?] The Four Barbarian Tribes -- unnamed

### Other Open Questions
- [?] The Originals' true names (A, B, C)
- [?] Seraphina's intelligence cache in northeastern ruins
- [?] The Medallion's hidden compartment -- coordinates in Old Abyssal
- [?] Kaelyn: crystal heart growth triggers, Black Willow's cave secrets, Seraphine's records
- [?] Paul's chapel attack (Order of Scales framed CC on Aurelius's order)
- [?] Crystal cave deeper exploration beneath capitals
- [?] Larger evil council -- is CC part of something bigger?
- [?] The Great Circuit -- Crassian's Dust Circle
- [?] Calendar festival articles -- create pages for festivals
- [?] Notable NPCs -- city leaders, guildmasters

---

## Timeline Management

> Master timeline: `cache/entities/events/kythorian_timeline.md`
> Any future event with a defined timeframe MUST be added to this file.

**How to maintain:**
1. When creating a time-bound entity, open `kythorian_timeline.md`
2. Insert chronologically with ### heading format
3. Include: Timeframe, Description, entity references
4. Update file's `updated` and `related` frontmatter fields
