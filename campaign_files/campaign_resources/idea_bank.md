# Idea Bank
Last updated: 2026-09-19

A loose collection of campaign seeds, scattered notes, and pending ToDos.
Entries are deleted when used (the session prep or cache file they informed becomes the permanent record).
Prefix entries with `[TODO]` for actionable tasks vs loose ideas/notes.

---

## [TODO] Give Zan a +1 heavy crossbow

**Description:** Zan went down at the start of Session 2 combat. Sucked for the player. He's wanted a +1 heavy crossbow and it's appropriate for his level. Freebie -- no quest attached. Maybe it's among the loot at Gamma-7 or something FX stashed for the party.

**Related:** [PC:Zan] [location:Site Gamma-7]

---

## [TODO] Zan wants a Dagger of Venom

**Description:** Player expressed interest. Could be a Gamma-7 find, a reward from FX, or tied to the Raven Queen thread. Not urgent but good to keep on the radar.

**Related:** [PC:Zan] [item:Dagger of Venom]

---

## Physical prop secrets for each player

**Description:** Give real-life physical props that represent the secrets/open questions each player is chasing. Example for Nyra: a matrioska of 4 boxes, give her a key for each elemental they defeat. The innermost box holds a written paper with a major reveal tied to her backstory and the campaign. Need to brainstorm the rest of the party:
- What prop for each PC?
- What secret/reveal lives inside?
- When does each unlock happen?
- How does the prop itself communicate without needing me to explain?

**Related:** [PC:Nyra] [PC:Aegon] [PC:Aurora] [PC:Balor] [PC:Bardolemeu] [PC:Kaelyn] [PC:Zan] [quest:Elemental Crystals]

---

## Khar'zul progression -- forced Warlock level

**Description:** Review Khar'zul progression setbacks and consequences. Interesting idea: force Balor to spend a level on Warlock (Hexblade?) to represent the growing relationship and dependency between him and Khar'zul. Balor's player is unaware of what the consequences are after the first unlock stage. Makes the progression mechanical, not just narrative. Needs design -- when does it trigger? Does it replace a class level or add on top? How do we handle milestone leveling with this?

**Related:** [PC:Balor] [item:Khar'zul's Blade] [organization:The Crimson Covenant] [arc:Balor's Heritage]

---

## [TODO] Balor is looking for medium armor

**Description:** Player expressed interest. Keep an eye out for loot opportunities -- maybe at Gamma-7 or among fallen Covenant agents.

**Related:** [PC:Balor]

---

## Kaelyn's leather-bound book from the Thormvuld vault

**Description:** Kaelyn found a leather book sealed with arcane runes inside the Thormvuld vault. She gave it to FX to open/decode. Need to define what she finds. Should tie into her backstory as a reward -- not just generic lore. Possible angles:
- A record of crystal-heart experiments mentioning a predecessor subject
- A map to someone connected to her past (a surviving researcher? another subject?)
- A journal with a cipher that only she can read (linking to her forgotten past)
- Something that reveals her connection to the Weave / B's essence directly

**Related:** [PC:Kaelyn] [organization:The Thormvuld Family] [NPC:FX] [lore:The Arcane Weave] [item:Kaelyn's Crystal Heart]

---

## Zan is a bloodline descendant of the Raven Queen

**Description:** The Raven Queen took mortal form in the past, had offspring. Zan is one of her descendants. The other Gods don't know. Big implications:
- When Zan learns about the Divine Genocide / the gods' conspiracy, this changes everything
- Possible endgame angle: the Raven Queen might fight alongside the party against the other Gods -- she'd want to preserve her mortal descendants
- Does she know Zan exists? Has she been subtly protecting him?
- Connection to the Catalyst Project -- did the Flesh Architects know? Did they choose him specifically?

**Related:** [PC:Zan] [character:The Raven Queen] [organization:The Flesh Architects] [arc:The Catalyst Project] [secret:Divine Conspiracy]

---

---

## [TODO] Make a full map of Kythoria in Inkarnate

**Description:** Need a proper campaign map. Current map is text-based references only. Inkarnate can produce the world/regional maps that players can reference and that helps with spatial storytelling. Scope: start with the three capitals + frontier region, Gamma-7 area. Can expand as campaign progresses.

**Related:** [location:Kythoria] [location:The Frontier] [location:Stonefall] [location:Weaveheart] [location:Drakhaven]

---

## [TODO] Review Khar'zul stage 2 for Balor (currently at level 4)

**Description:** Balor has unlocked stage 2 of Khar'zul's Blade progression. He's now at level 4. Need to review whether the current mechanics are balanced -- is stage 2 too OP for his level? Does it need adjustment? Check the existing item design in `cache/items/kharzuls_blade.md`, cross-reference with party power level, and propose tuning if needed.

**Related:** [PC:Balor] [item:Khar'zul's Blade]

---

## Custom wind item for Nyra (Air Genasi)

**Description:** Nyra (Air Genasi) wants wind abilities in combat -- tactical movement, attack enhancements, battlefield control. Not OP, but flavorful and useful. Design a custom item (or feat/ability) that gives her limited wind-themed options. Possible approaches:
- A wind-charm amulet that lets her cast *Gust of Wind* or *Gust* cantrip 1/short rest
- A charge-based system: accumulate "wind charges" by moving without attacking, spend on push/pull effects
- A reaction that lets her deflect ranged attacks with a gust
- Passive: doubled jump distance + fall damage reduction (genasi flavor upgrade)
- Scales with level (more charges or bigger effects as she grows)

**Related:** [PC:Nyra] [species:Genasi]

---

## Custom Wild Magic Surge table for Kaelyn

**Description:** Kaelyn has a disease that's making her magic unstable -- part of why she's out in the world exploring. Design a custom Wild Magic Surge table tied to her condition. Not a full Wild Magic Sorcerer subclass, but a curated table of ~20-30 effects that trigger on a d20 roll (maybe on a 1 after casting a spell, scaling with symptom severity). Effects should feel thematic to her backstory (crystal heart, unstable magic, memory gaps, connection to the Weave / B's essence). Some should be beneficial, some chaotic, some dangerous -- but none so punishing they make the player afraid to cast spells.

**Related:** [PC:Kaelyn] [lore:The Arcane Weave] [lore:The Arcane Reactive Crystals] [item:Kaelyn's Crystal Heart]

---

## State file: "Next Time" event triggers

**Description:** Create a state file (e.g. `state_files/_next_triggers.md`) that stores conditional events to be resolved the next time a specific trigger occurs. Examples of what it would track:
- **Next long rest:** Balor rolls a Wisdom saving throw if he uses Khar'zul's ability X; Kaelyn and Zan roll Constitution saving throws or progress another stage in the lycanthropy curse.
- **Next battle:** Whether Balor uses Khar'zul's ability X (and consequences thereof).
- **Next dawn/dusk:** A vision or dream sequence for a specific PC.
- **Next visit to town:** An NPC approaches the party with news.
- **Next short rest:** A conversation trigger between two specific PCs.

The file would be checked at session start and updated as triggers fire. Entries are deleted once resolved. Keeps the DM from having to remember everything in the moment.

**Related:** [workflow:Session Prep] [state:Party State] [meta:DM Tools]

---

## Sophie as a living descendant of the Raven Queen

**Description:** Sophie (Subject 241) might also be a bloodline descendant of the Raven Queen -- just like Zan. This creates a paired set of mortal descendants carrying "Original energy" within them. Both could be used in a ritual to bring back Entity B, serving as valuable pieces because their blood carries residual divine essence from a god that is itself a fragment of an Original. Opens up:
- The ritual requires both Zan and Sophie as living anchors/conduits
- Raises the stakes: the Flesh Architects may try to recapture Sophie (they already know about Zan)
- Raven Queen's reaction -- protecting her descendants vs. the larger stakes
- Does Sophie know? Is this why she fled? Or is she unaware?

**Related:** [PC:Zan] [NPC:Sophie] [character:The Raven Queen] [organization:The Flesh Architects] [arc:The Catalyst Project] [entity:Entity B]

---

## Sophie killed Balor's mother

**Description:** Sophie (Subject 241) might be the one who killed Balor's mother (Lady Skallfang). This would inject intense intra-party drama:
- Balor has believed the Crimson Covenant killed his mother -- discovering it was Sophie changes everything
- Sophie fled the Catalyst Project; Balor's mother was a Covenant loyalist -- Sophie's escape could have involved a confrontation
- Zan would be caught between his bond with Sophie and his loyalty to Balor
- Could be a slow-burn reveal: Sophie recognizes Balor's name/tattoo/sigil, becomes distant, eventually confesses
- Forces the party to deal with moral complexity -- Sophie was fleeing torture/experimentation, not acting as an assassin

**Related:** [NPC:Sophie] [PC:Balor] [organization:The Crimson Covenant] [organization:The Flesh Architects] [organization:The Skallfang Clan] [arc:Balor's Heritage]

---

## Customized anti-party squad from the Thormvuld

**Description:** The Thormvuld Family assembles a customized squad specifically trained and equipped to counter the known abilities of each party member. Sent to hunt down and arrest the party. Ideas:
- Each member of the squad is a specialist who counters one PC (e.g., an abjurer to counter Kaelyn's magic; a grappler/brute for Balor; a fast striker to pin Zan; an enchanter for Bardolemeu; a silence/hunter for Nyra)
- Could be recurring antagonists if they survive encounters
- Would force the party to adapt tactics, creating memorable combat scenarios
- Squad members could have their own personalities and motivations -- not just disposable mooks
- The Thormvuld learns and evolves -- if the party beats them, the next version incorporates counter-tactics

**Related:** [organization:The Thormvuld Family] [NPC:Lord Keylor Thormvuld] [meta:Encounter Design]

---

## A "Great Reset" at Year 0 -- the Originals considered restarting

**Description:** After the Originals created and nurtured the mortal races, A and C wanted to start over -- reset creation entirely. This event (or near-event) could explain why mortal history begins at Year 0. Implications:
- Provides a reason for historical documents reporting the existence of the Originals and their plans to sub-divide into gods
- Some records survived, hidden in vaults -- the party could discover them
- Explains why the Originals ultimately chose to fragment into the 10 gods rather than destroy everything -- Entity B's sacrifice may have prevented the reset
- The decision to reset vs. fragment could have been the schism that led to B's sacrifice
- Adds ancient ruins/lost archives as discovery locations
- Historical documents from *before* Year 0 could contradict the Church's official narrative

**Related:** [lore:The Originals] [lore:The Gods and the Deception] [lore:Cosmology and the Planes] [entity:Entity A] [entity:Entity B] [entity:Entity C] [location:Site Gamma-7]

---

## More than 10 gods existed previously

**Description:** The current pantheon of 10 gods may not be the original set. Other gods existed and have vanished -- proving that gods can die, fade, or be erased. Ideas:
- Evidence could be found in ancient ruins: temples to forgotten gods, hymns with extra names scratched out, dead divine domains
- The Church suppresses knowledge of vanished gods because it undermines their narrative of divine permanence
- Why did they vanish? Killed by the other gods? Faded from lack of worship? Merged with surviving gods?
- Some vanished gods might be connected to the ViF's goal of ending divine tyranny -- proof that it's possible
- Could explain why the current 10 gods hoard worship so aggressively -- they're terrified of being next

**Related:** [lore:The Gods and the Deception] [lore:Cosmology and the Planes] [secret:Divine Conspiracy] [organization:Veritas in Fractum]

---

## Dragons subdue/force/cooperate with another race for armor

**Description:** Dragons cannot naturally wear manufactured armor (anatomical constraints). To overcome this, they subdue, force, or cooperate with another race to either:
- Craft armor specifically fitted to dragon anatomy
- Install the dragon inside a mobile armored construct (dragon-piloted golem?)
- Use enchantment to reshape armor dynamically
- Partner with a race that can wear armor on the dragon's behalf (mounted riders with shared protective magic?)
- Opens up a new faction: the armorer-smiths who serve dragons, possibly unwillingly
- Could tie to Dragonborn history -- were dragonborn created to serve this purpose?

**Related:** [species:Dragonborn] [lore:Races and Ancestries] [organization:The Order of the Scales] [meta:Worldbuilding]

---

## One of the monster army's missing Generals is part of ViF

**Description:** The Abominable End monster army had 5 generals, and some of them went missing. One of those missing generals secretly joined Veritas in Fractum. Possibilities:
- They defected from the monster army and faked their disappearance to work toward ViF's goals in secret
- They went underground and have been gathering information for 400 years
- They know the truth about the Abominable End and the gods' conspiracy
- They could be an ancient mentor figure who emerges to guide the party -- or a morally grey figure who's done terrible things for the "greater good"
- Their ViF membership connects the monster army era directly to the present conspiracy
- Each ViF member organization might have been founded/advised by a different general

**Related:** [organization:Veritas in Fractum] [organization:The First Alliance] [event:The Abominable End] [lore:The Last Stand] [meta:Plot Arc]

---