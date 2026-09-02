# Session Prep Workflow

Repeatable process for preparing a campaign session. Ensures nothing slips through the cracks -- party state, open threads, roadmap position, and the idea bank all get checked.

**Critical perspective:** Every session prep document is **printed and brought to the game table** to assist in running the session. Every line you write either helps the GM run the session smoothly or is wasted ink. The patterns below are designed to maximize the former and eliminate the latter.

---

## Step 1 -- Load Context

Load the following into context:

- `state_files/_session_continuity.md` -- Current state snapshot, open questions
- `campaign_notes/campaign_roadmap.md` -- High-level campaign structure and revelations
- `campaign_notes/idea_bank.md` -- Loose idea seeds, notes, and ToDos
- `campaign_notes/resources.md` -- External DM resources to **suggest** to the user (donjon, Sly Flourish, etc.) -- I recommend, user executes

## Step 2 -- Review Continuity

Review the current state:

- **Party state** -- Level, resources, HP/spells/rest status, inventory concerns
- **Last session recap** -- What happened, what was left unresolved
- **Open questions** -- Which tracked open questions are alive right now
- **PC arcs** -- Which character arcs are in motion or dormant

## Step 3 -- Check Roadmap Position

Identify where the party is on the campaign roadmap:

- **Current phase** -- Which revelation layer is active
- **Upcoming revelations** -- What should be seeded or paid off soon
- **Timing** -- Where are we in the monster-wave / Gamma-7 / PC arc timing

## Step 4 -- Scan the Idea Bank

Spin through every entry in `campaign_notes/idea_bank.md`. For each entry, ask:

- Does this fit the current campaign phase?
- Does this connect to the current location or situation?
- Does this involve a PC, NPC, or faction that's about to be relevant?
- Would this enrich or distract from the session focus?

Surface all applicable seeds and present them to the user with your recommendation.

## Step 5 -- Present Findings, Pause for User Direction

Present a structured summary of everything above:

1. **State snapshot** -- Party resources, open threads, position
2. **Roadmap relevance** -- What revelations are on deck
3. **Idea bank matches** -- Which seeds fit. Your recommendation for weave-in vs save-for-later.
4. **Prep proposals** -- Your suggested session structure (scenes, encounters, NPC beats, pacing)

Then **pause**. The user provides:
- Their own vision for what they want this session to be
- Direction on which threads to pursue or ignore
- Approval or modification of idea-bank seeds to include
- Any new content they want to develop (new NPCs, locations, items, etc.)
- Explicit go-ahead to proceed to drafting

**Do not proceed past this step until the user gives direction.**

## Step 6 -- Create or Update Cache Files (As Needed)

If the user's direction requires new or modified lore entities:

1. Create new files in `cache/<type>/<entity_id>.md` following CACHE_FORMAT.md
2. Update existing cache files if new information about known entities emerged
3. Run A1-A4 audits for any new lore (per Rule 3 in .goosehints)
4. If new entities have WA articles ready in cache, push them per the Direct-Push Workflow

**Type:** This step is optional -- only run if the user's direction demands it.

## Step 7 -- Draft Session Prep

Write `campaign_notes/session_X_prep.md`. The document is organized by **location/scene order**, not by clock. The GM adjusts pacing at the table.

### Table-Ready Formatting Rules

These rules exist because the document will be **printed and used at the table**. Every piece of content must be instantly scannable and actionable.

#### R1. "Facts to Convey" Bullet Lists (Replaces Narrative Prose)

**NEVER** generate descriptive paragraphs or read-aloud text. Instead, write a `**facts to convey:**` / `**arrival facts:**` bullet list of the information to transmit. The GM weaves these into their own narration at the table.

| Instead of... | Write... |
|---|---|
| *"The facility crouches in the valley like a wounded animal. A collapsed dome at its center..."* | **Arrival facts - convey from the ridge:**<br>- Valley below: collapsed dome center (stone ribs clawing sky)<br>- Broken tower snapped at half-height, leaning east<br>- No smoke, no movement, no sound |

This applies to: room descriptions, arrival scenes, NPC interaction beats, travel atmosphere, discovery moments, environmental details.

#### R2. GM-Facing Emotional Beats (Not Player-Facing Prompts)

**NEVER** write second-person narration meant to be read aloud to a player. Instead, write a `**Facts to communicate:**` bullet list of the information to transmit, followed by a GM instruction.

| Instead of... | Write... |
|---|---|
| *"Zan -- you've known for sixteen years what they did to you. But you've never seen it written down. What do you do?"* | **Facts to communicate (to Zan's player):**<br>- First time seeing his subject number in an official document<br>- They had a system, a process, and he was processed<br>- **Ask:** what does he do? |

This applies to: PC-specific beats, emotional reveals, private tells, backstory connections.

#### R3. Room Descriptions = Bullet Facts + Map Layout Checklist

Every room/location gets two parts:

1. **`[Location] - facts to convey:`** -- Bullet list of what's in the room, what's visible, what's notable
2. **`Map Layout:`** -- with `[ ]` checkboxes for:
   - Room size in squares (e.g., 8x8 squares, 40x40 ft)
   - Entry points
   - Items to draw on the battlemap
   - Lighting conditions
   - Terrain features (difficult terrain, cover, hazards)

This makes the room description scannable at a glance and serves as a battlemap prep checklist.

#### R4. NPCs = Name, Race, Age, One Distinctive Feature Only

Random/unaffiliated NPCs are written as a single table row with **four fields max**:

| Trait | Detail |
|---|---|
| **Race** | Human |
| **Gender** | Male |
| **Age** | Late 40s |
| **Distinctive Feature** | Missing left ear -- clean cut, old scar. Wears a brass earring on the remaining ear. |

No "Role," "Demeanor," "Knows," or "Hook" fields. The GM at the table only needs a name, a physical hook, and their own improv. **Do not exceed 4 lines per NPC.**

#### R5. No Pacing Timers / Session Structure Table

**Do not** include a timeline table estimating minutes per section. No "Part 1: 30-45 min, Part 2: 15-20 min" breakdowns. The document flows by **location/scene order** -- the GM uses their own judgment at the table.

#### R6. No Quick Reference Card / Summary Section

**Do not** duplicate information at the end of the document. No separate "Quick Reference Card" or "Printable Summary." Embed all reference information (DCs, loot, NPC names, room summaries) **in the sections where they are used**. One source of truth.

#### R7. No Draft Notes / Flagged Markers

**Do not** include `[Flagged for review]`, `[Draft]`, `[Discuss with GM]`, or any other unresolved markers. The session prep document is a **table-ready tool**. Any unresolved lore questions or open decisions must be resolved **before** the document is written.

#### R8. No Timeline Pressure Overhead (Unless Actionable at the Table)

**Do not** include multi-paragraph analysis of timeline windows, contingency plans, or strategic breakdowns. If a timer is relevant at the table, write it as a **single line** under the relevant section:

> *Full moon in 4 days.*

The GM does not need to re-read a strategic analysis during a session.

#### R9. Skill Checks = DC Tables Only

All investigation, perception, and skill check information is consolidated into a single **DC table** per location. No narrative paragraphs describing what a check reveals.

| DC | Check | Result |
|----|-------|--------|
| 12 | Nature/Religion | Funerary rite site. Pre-dates all known religions. Safe. |
| 15 | Perception | Beneath the altar: 3 bone tokens (skull, leaf, star). |

---

### Required Content

Every session prep MUST include:

- **Cold open** -- How the session starts (recap facts + scene)
- **Scenes and encounters** in order of location/flow
- **PC beats** -- Per-character moments, secrets, frictions to protect
- **Mechanics** -- Stat blocks, DCs, loot, key rules
- **3-4 random NPCs** (per R4 format)
- **Loot tables** with uncommon-rarity items, skewed toward consumables, gemstones, gear, and setting trinkets
- **Stat blocks** at the end of the document for quick reference

## Step 8 -- Update Continuity Snapshot

Update `state_files/_session_continuity.md`:

- **State changes** -- Party position, resources, resolved open questions
- **New open questions** -- Anything the session setup creates
- **Next steps** -- Update the prep queue
- **Delete used idea bank entries** -- Remove any seeds that were woven into this session

## Step 9 -- Commit

Per the normal commit protocol (see WORKFLOW.md Step 9):

1. Run `scripts/sync-index.ps1` if cache files changed
2. Present a change summary
3. Propose a commit message
4. Wait for user approval, then commit and push

---

### Prep Approach
- GM has all afternoons + weekends for prep.
- Method: define target location, sketch POIs in vicinity, build random tables (loot, travel encounters), create 3-4 NPCs per session (name, race, age, one distinctive feature only -- per R4), prepare 1-2 maps as needed (otherwise theater of the mind).
- Prep is driven by session goals, not a fixed script.
- The document is written to be **printed and used at the table**. Every line serves the GM running the session. If it doesn't help at the table, cut it.