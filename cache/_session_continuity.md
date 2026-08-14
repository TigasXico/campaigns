# Session Continuity -- Lore Development

> Stores cross-session context needed to resume work after compaction.
> Created: 2026-08-08 | Updated: 2026-08-14

---

## Session Log

### 2026-08-14 - Kingdom Retcon & Capital Content Approval (not yet committed)

**File manifest:**
- `cache/locations/drakhaven.md` -- REWRITTEN with approved content: D1 (smirky acceptance), D3, D4 kept. D2 (engineered fall) reverted.
- `cache/locations/elyndor.md` -- REWRITTEN with approved content: E3 (architecture + sacred river confluence), E4 kept. E1 (first to fall), E2 (crystals) reverted.
- `cache/locations/kazadur.md` -- REWRITTEN with approved content: K1 (sealed halls), K2 (king ordered sealing, ground shook, blueprints for Emberforge; "most devastating" reverted), K3 (grew downward/inward; wealthiest rulers reverted, held months reverted), K4 kept. NOTE: Now includes NE mining cluster (retcon).
- `cache/locations/hearthglen.md` -- REWRITTEN with approved content: H1 (annihilated cruelly), H2 (hidden vaults), H3 (agricultural breadbasket), H4 (cozy visual). NOTE: Now receives raw metals from Kazadur for minting (retcon).
- `cache/locations/everquill.md` -- REWRITTEN with approved content: Q1 (paper capital, scholarly), Q2 (archivists fled with records), Q3 (Great Archive vaults), Q4 (towers/clock towers/parchment).
- `cache/locations/stonefist.md` -- REWRITTEN with approved content: S4 (visual) kept. S1 (2-year siege), S2 (war-code), S3 (childhood warrior details) reverted.
- `cache/locations/the_northeast_settlement_cluster.md` -- REWRITTEN. Now dwarven territory (part of Kingdom of Kazadur). Mint reference removed (mint is in Hearthglen now). Focus is mining + transport to Hearthglen.
- `cache/events/kythorian_timeline.md` -- E11 updated with retcon: Kazadur in NE (mines), Hearthglen (mint), raw metals flow between them.
- `cache/lore/the_world_and_geography.md` -- Era of Foundation updated with retcon + kingdom naming format.
- `cache/lore/races_and_ancestries.md` -- Racial Homelands updated with retcon.
- `cache/lore/economy.md` -- Mint section split: "The Royal Mint (Hearthglen)" + "The Northeast Mining Cluster (Kazadur)".
- `cache/locations/the_verdant_reaches.md` -- Added related elyndor; Overview updated to note it was part of the Kingdom of Elyndor's territory.
- `cache/locations/the_northeast_settlement_cluster.md` -- Cluster structure defined: Kazadur = major settlement; logistics hub (halfling shipping coordination); metal mining town; gemstone mining town. Mining towns open to all races.
- `cache/locations/kazadur.md` -- Geography updated with cluster structure.
- `cache/lore/economy.md` -- Cluster description updated (Kazadur as major settlement; removed "two smaller export settlements" superseded detail).
- `cache/_session_continuity.md` -- this entry.

**Key decisions this session:**
- Six kingdoms established. Kingdom name = capital city name. Kingdoms: Drakhaven (Humans), Elyndor (Elves), Kazadur (Dwarves), Hearthglen (Halflings), Everquill (Gnomes), Stonefist (Half-Orcs).
- Drakhaven: self-styled "capital of Kythoria" -- other races accepted it with a smirk/making light fun of humans for being self-centric.
- Kazadur is in the NE, containing the mining cluster (all currency metals/gemstones mined there). Raw materials shipped to Hearthglen for minting and distribution.
- Hearthglen (Halflings) = home of the royal mint, perfect accountants, agricultural breadbasket.
- Everquill (Gnomes) = paper capital, scholarly, records/law/maps, Great Archive.
- Uncommon races (Genasi, Dragonborn, Tieflings) had no kingdoms; they grouped in large villages.
- All six kingdoms fell to the monster invasion. Capitals nearer the shores fell first (general rule).
- Verdant Reaches = part of the Kingdom of Elyndor's territory.
- NE cluster (dwarven mining region) + Hearthglen (halfling mint) separated economic roles.

**Open follow-ups:**
- [hourglass] Kingdom capitals' exact map locations -- to be pinned when the continent map is finalized

**Cleanup:**
- `cache/locations/the_northeast_settlement_cluster.md` DELETED (merged into kazadur.md). All references updated to point to kazadur or hearthglen as appropriate.
- Naming Gaps section removed from session continuity. The only unnamed major settlements were the 6 kingdom capitals, now all named.

### 2026-08-14 - Remove Seraphina Vex Character (not yet committed)

**File manifest:**
- `cache/characters/NPC/seraphina_vex.md` -- DELETED. Character removed per player request (player will develop their own lore for Balor's mother)
- `cache/_index.md` -- removed seraphina_vex row
- `cache/characters/PC/Balor/balor_skallfang.md` -- "The Flight" section rewritten; "Seraphina Vex" replaced with "Balor's mother"; Vex family details removed; related entry removed; open question 1 changed from [OK] to [?] (backstory pending player input)
- `cache/characters/PC/Kaelyn/kaelyn.md` -- removed seraphina_vex related entry and speculative connection between Seraphine the nanny and Seraphina Vex
- `cache/events/kythorian_timeline.md` -- removed E86 (Seraphina Vex Dies) and E89 (Seraphina Vex's Family Captured) event blocks
- `cache/events/pc_backstory_timeline.md` -- removed E86/E89 blocks and table rows; Balor event count 8 -> 6 (E56-E58, E90-E92)
- `cache/items/kharzuls_blade.md` -- "Seraphina" replaced with "Balor's mother" in open question 3
- `cache/items/the_medallion_of_vex.md` -- Seraphina/Vex family references replaced with "Balor's mother"/"his mother"; seraphina tag and related entry removed
- `cache/organizations/the_crimson_covenant.md` -- Seraphina/Vex family references replaced with "Balor's mother"; related entry removed
- `cache/campaign_notes/timeline_integration_questions.md` -- Seraphina references replaced with "Balor's mother"
- `cache/_session_continuity.md` -- this entry

**Key decisions:**
- Balor's mother is now referenced only as "Balor's mother" (placeholder) until the player provides her backstory
- E86/E89 removed from both timelines -- her death and family capture lore is player-owned now
- "The Medallion of Vex" item keeps its name for now (in-world name); may be revisited once player backstory lands
- [hourglass] Player backstory for Balor's mother -- pending input, then update: name, family, fate, and any affected events/caches/medallion lore

### 2026-08-14 - Timeline Restructure (committed 2565d0d)

**File manifest:**
- `cache/events/kythorian_timeline.md` -- COMPLETE REWRITE. New dating system (plain years; Year 0 = Mortal Kingdoms; Year 500 = campaign start; negatives for pre-0). 65 events (E01-E65) in year-block format across 6 eras (Primordial Times, Age of Creation, Mortal Kingdoms, Abominable End, Rise of Mortals, Current Era). Visibility markers added ([PUBLIC]/[SECRET]/[PUBLIC MYTH - FALSE]/[SECRET - TRUE]). Event IDs usable in entity `related` fields (e.g. "timeline E38").

**Key decisions this session:**
- E01-E07 secret; E08 public; E09 public myth (fake creation story)
- E15/E16/E23 secret (protection end, planar breaches, deployment)
- E24 First Alliance spans 192-500 (ongoing)
- E36 single general defeat at 279 (was two)
- E43/E51 public myths (Lolth/Raven Queen race creation) flagged FALSE
- E44/E52 true origins added (Project Genesis byproducts) at 303/339
- E53 Shadar-Kai Shadowfell at 344 (corrected from 310)
- E60 Thromvuld B-crystal discovery secret
- WA timeline on WorldAnvil shows only [PUBLIC] + [PUBLIC MYTH - FALSE] events to players

**Open follow-ups:**
- [ok] Timeline file 23.35 KB -- resolved as exception (added to CACHE_FORMAT.md)
- [hourglass] WA timeline on WorldAnvil still uses old BCE/CE dating -- needs manual update by user to match new plain-year format
- [hourglass] Entity `related` fields not yet updated to reference event IDs (E##) -- future task

### 2026-08-14 - PC Backstory Timeline Integration (E77-E87) (committed 8d3ba54)

**File manifest:**
- `cache/events/kythorian_timeline.md` -- 70 insertions, 5 deletions

**Key decisions:**
- Balor's birth corrected to Year 480 (Nyra is also Year 480 -- Balor and Nyra are the same age at campaign start)
- All PC backstory events use [SECRET] visibility (GM-only)
- Kaelyn is age 150 at campaign start (born Year 350)
- No relationship/frontmatter changes to entity files -- deferred

### 2026-08-14 - Balor/Kaelyn Event Resolution (E88-E92) (not yet committed)

**File manifest:**
- `cache/events/kythorian_timeline.md` -- added E88-E92 (5 events), intro updated to E01-E92

**Key decisions:**
- Aurora: the "joins Circle of the Stars" event was merged -- she became a druid of the Circle at the skylight cave moment (not a separate event)
- Kaelyn's first surface visit added at Year 380 (implied by age 30; age 150 anchor)

---

## All Open Questions

### PC-Specific Open Questions (by Character)

#### Aegon (6)
1. Who was Aegon's biological father? Mother died in childbirth, father disappeared -- deliberate erasure?
2. What exactly did Paul know? His dying words suggest he discovered something about the Order.
3. Who attacked Paul's chapel? Investigation produced no results. (Evidence planted by Order frames the Crimson Covenant.)
4. The jealous/fanatic members -- how far will they go to claim Aegon's power?
5. The old capital -- the High Septon is there. What other secrets does it hold?
6. B's influence on Aegon -- will his visions grow clear enough to reveal the truth about the Originals and the gods' deception?

#### Balor (4)
1. Balor's mother's secondary intelligence cache -- hidden in NE ruins. What exactly did she leave?
2. The Medallion's hidden compartment -- coordinates written in Old Abyssal. Where do they lead?
3. Did Balor ask the clan elders about the blackout? He did. They found him unconscious. Guilt unresolved.
4. The Avatar state -- can Balor trigger it intentionally? Or only when Khar'zul seizes control?

#### Kaelyn (5)
1. The crystal growth -- how fast? What triggers acceleration? Way to stop it?
2. Kaelyn's connection to other B-touched -- will she sense Aurora's constellations? Will Aegon see her in visions?
3. The Black Willow's crystal cave -- what secrets lie beneath the tree's roots?
4. Seraphine's past -- did she leave records? Connected to Balor's story?
5. The Azure Boneyard -- can it be found again? Is the dragon's consciousness still present?

#### Odessa (7)
1. Where is Eryx's proof? Hidden cache, guild intelligence, or lost?
2. Where exactly does Valen command? Which monster-held territory?
3. What will Odessa do after Valen is dead? She has no plan beyond the kill.
4. Will she learn the truth about her parentage (Valen is her father)? And if so, how?
5. Who else in the elven military knew about the surrender to the Covenant?
6. Will the Venom-Weavers support Odessa's final mission, or try to hold her back?
7. What became of Odessa's biological mother? Alive? Does she remember?

#### Zan (6)
1. What happened to Sophie? Is she alive? Where is she held?
2. Where is J.B. now? Still running his guild? Retired? Dead?
3. Where are the Flesh Architects' other facilities?
4. What does the Raven Queen want from Zan? Why did she mark him? Why did she save him?
5. Will Zan's B-touched resonance draw unwanted attention? From the Covenant? From the gods? From other B-touched?
6. What will happen when Zan meets Dun'vis? Fight? Revelation? Understanding?

#### Aurora (4)
1. What happened to Polaris? Captured by Covenant? Turned Drow/Shadow Elf? Leading monster pack?
2. Where exactly is Elarwyn? The Verdant Reaches are vast -- specific location unmapped.
3. Will the white fox (B's manifestation) return? When, and what will it lead to?
4. What do the hidden constellations spell out? A map to something important?

#### Bardolemeu (13) -- Needs player input on open questions
1. What was the mentor's name? The old musician who taught him remains unnamed.
2. What happened to the mentor? Vanished -- silenced? By whom? Alive or dead?
3. What specific secrets did the mentor know? Family's Covenant ties? Something bigger?
4. Who are Bardolemeu's parents? Names, personalities, current status.
5. Does he have siblings? How many? Rivals? Allies?
6. How does his family view his departure? Angry? Worried? Searching?
7. What is his current relationship with his family? Any contact?
8. Where exactly are the family's theatres located? Which cities?
9. How old was he when he left?
10. How long has he been wandering?
11. When did he discover his bardic magic? Awakening story?
12. Will he return to his family's theatres? Under what circumstances?
13. Does he seek reconciliation or confrontation with his family?

#### Nyra (12) -- Backstory processed, remaining open questions
1. [hourglass] **Who were Nyra's parents?** Genasi rangers who researched elemental convergence. Still unnamed.
2. [hourglass] **Where is Khel'vin now?** Parted ways after Cavern of Discovery. Location unknown.
3. [hourglass] **Who is the caretaker?** Beautiful woman with bright eyes, long black hair, 50s. Identity unknown.
4. [hourglass] **Khel'vin's white dragon father** -- alive, dead, or hidden?
5. [hourglass] **Remaining three elementals** -- where are Fire, Water, Earth located?
6. [hourglass] **What were Nyra's parents researching?** (DM decision pending -- suggested: Elemental Convergence Theory)
7. [hourglass] **Why would the Crimson Covenant capture them?** (DM decision pending)
8. [hourglass] **What is inside the smaller locked box? How does it unlock?** (DM decision pending -- suggested: Elemental Resonance Lockbox)
9. [hourglass] **Why are the four elements' essences required?** (DM decision pending -- suggested: Primal Resonance Key)
10. [hourglass] **Who placed the staff in the Cavern of Discovery?** It bears druidic carvings. Deliberate placement?
11. [hourglass] **Does Nyra ever learn the truth about Khel'vin's injury?** (Divine agent vs. rockslide)
12. [hourglass] **Which city?** City location to be pinned during map creation

#### Sanzo (4) -- Entirely empty, waiting on player (Guilherme/Gui)
1. Where was Sanzo trained? Which monastery? Does it still exist?
2. Why is he adventuring? What drove him to leave his training?
3. What monastic tradition does he follow? Open Hand? Shadow? Sun Soul?
4. Does his monastery hold any ancient knowledge? Pre-invasion records? Hidden truths?

---

### GM Design Decisions (8 remaining)

1. Four Unnamed Generals -- names, creature types, domains, status (2 defeated, 2 retreated)
2. Blade's journey -- how did it pass from Skallfang to Covenant (~150 to ~20 YA)?
3. Covenant founders -- name the original dissident scholars who fled the First Alliance
4. Three Kings -- name the founders of the Last Stand
5. Era of Foundation -- pre-invasion history at high level
6. Larger evil council -- is the Crimson Covenant part of something bigger?
7. Monster Ecology details -- tainted zones, nesting grounds
8. Monster Economy details -- named merchants, guilds, industries dealing in monster parts
9. Rite of Ash -- exact requirements (duration, cost, failure conditions)

---

### Location & Item Open Questions

#### The Medallion of Vex (3)
1. The hidden compartment coordinates -- written in Old Abyssal. Where do they lead?
2. Covenant response -- what happens if Balor uses the medallion openly at a Covenant facility?
3. The Infernal inscription -- what does the micro-text along the crescent actually say?

#### The Azure Boneyard (2)
1. Does the dragon's consciousness linger? Kaelyn felt a connection -- could it still be present through the crystals?
2. More crystals? Are there larger deposits deeper in the cave system?

#### The Frostmaw (3)
1. The Whispering Glacier's prophecy -- Skallfang elders claim the glacier speaks. Natural? Magical? Something more?
2. The Bonefields burial chambers -- what weapons/artifacts lie beneath the frozen earth?
3. Why was the Frostmaw never conquered? The monster army had the numbers. Was there another reason?

#### The Underdark Forest (4)
1. Exact location on the continent map -- to be defined when map is finalized
2. Current leadership -- with Lyndale presumed dead, who now leads? Solyn?
3. Crystal cave at the Black Willow's roots -- how deep? What secrets?
4. Siege damage -- how did the monster invasion siege affect the Underdark?

#### Khar'zul's Blade (1)
1. What are the exact requirements for the Rite of Ash? Full parameters (duration, cost, failure conditions) undefined.

---



---

### Remaining Lore Open Questions

1. Balor's mother's intelligence cache in northeastern ruins -- what exactly did she leave?
2. Kaelyn's crystal heart growth -- triggers, acceleration, possible reversal
3. Black Willow's crystal cave -- deeper exploration beneath the roots
4. Paul's chapel attack -- Order of Scales framed the Crimson Covenant on Aurelius's command (GM note documented, specifics flexible)
5. Crystal cave deeper exploration beneath capitals -- B's crystal cluster sentience?
6. Monsters_and_ecology.md: Remaining loyalist command -- who commands loyalist forces today?
7. Crystal-corrupted apex -- what happens to a dragon or similarly powerful creature?
8. Monster categories by plane -- open for flexible encounter design
9. Mortal discoverers -- which arcanists have uncovered parts of the truth?
10. Detailed monster ecology -- specific tainted zones, nesting grounds, adapted wildlife