# Session Prep Workflow

Repeatable process for preparing a campaign session. Ensures nothing slips through the cracks -- party state, open threads, roadmap position, and the idea bank all get checked.

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

Write `campaign_notes/session_X_prep.md` following the established format:

- **Cold open** -- How the session starts (recap + scene)
- **Structure** -- Scenes, encounters, NPC beats in order
- **Mechanics** -- Stat blocks, DCs, loot, key rules
- **PC beats** -- Per-character moments, secrets, frictions to protect
- **Fail-forward** -- What happens if the party fails or goes off-script

### ⚠️ Note: Narrative Text Prohibited

**NEVER** generate text meant to be narrated directly to the players. Instead, show a **bullet point list** of the relevant information to transmit (key facts, sensory details, NPC dialogue beats, revelations, etc.). The DM will weave these into their own narration at the table.

**Every session prep MUST also include:**
- **3–4 random NPCs** (unaffiliated — name, race, gender, age, distinct feature per NPC)
- **Loot tables** with uncommon-rarity items, skewed toward consumables, gemstones, gear, and setting trinkets

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