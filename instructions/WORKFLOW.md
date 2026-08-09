# WorldAnvil Lore Keeper — Workflow

This document defines the canonical 5-step workflow for capturing, processing, and publishing D&D lore for a WorldAnvil (WA) setting.

---

## The 5-Step Workflow

### Step 1 — Record
- The user records a voice note (braindump, character idea, location description, plot hook, etc.) using the Python recorder app (`recorder/recorder.py`).
- The app provides:
  - Live microphone volume bar (always-on, to confirm audio is being captured).
  - Pause / resume capability.
  - Each recording is saved as a numbered timestamped file under `recordings/`.
  
### Step 2 — Transcribe
- The recorder app transcribes the audio using **Whisper** (medium or large model, local).
- The transcription text is **automatically copied to the clipboard** so the user can paste it into the Goose chat.

### Step 3 — Process
- **Goose** receives the pasted transcription as user input.
- Goose reads the transcription and analyzes it against the existing lore cache (`cache/`).
- Goose **summarizes** what needs to happen:
  - **New entities** to create (characters, locations, organizations, events, items, lore/concepts).
  - **Existing entities** to update.
  - **New relationships** or relationship changes.
  - **Secrets** that need to be added (for specific subscriber groups).
- **Timeline awareness:** When processing, distinguish between:
  - **Pre-campaign lore** — what is true at campaign start (goes in main body sections).
  - **Future/prophesied events** — things that will happen during the campaign (goes in `## Campaign Events` sections, gated by subscriber group).
- Goose presents this summary to the user for confirmation before making any changes.

### Step 4 — Cache Update
- Goose creates or updates lore files in `cache/entities/`.
- The cache is the **single source of truth** for all lore. It is optimized for LLM consumption (see `CACHE_FORMAT.md`).
- Goose updates `cache/_index.md` if new entities are created.
- Goose updates `cache/_master_relationships_map.md` with any new or changed relationships.

### Step 5 — Article Generation
- Based on the cache changes, Goose generates **WA-ready articles** in **BBCode** (see `ARTICLE_FORMAT.md`).
- **New entities** → full new articles (saved to `articles/output/` as `.bbcode` files).
- **Existing entities** → a summary of *individual changes needed* per article, listing each edit required (section by section).
- Articles include:
  - Proper BBCode formatting.
  - Cross-article links using WA `[article]` BBCode tags.
  - Secret sections using WA subscriber group restrictions.
- The user manually copies the generated BBCode to WA.

---

## ⚡ Cost Optimization Protocol (MANDATORY)

> **Context is money.** Each turn costs $0.08-0.12. Every unnecessary KB of context adds cost.
> Follow these rules strictly to keep sessions affordable.

### R1 — Context Budget Tiers
Before starting any task, determine which tier of files you need and load ONLY those:

| Tier | When to Load | Max Target |
|------|-------------|------------|
| **T0 — Always** | `_session_continuity.md` (pruned), `WORKFLOW.md`, `CACHE_FORMAT.md` | ~20KB |
| **T1 — Primary** | Entity files DIRECTLY related to the current task | ~30KB |
| **T2 — Reference** | Cross-domain files — only if the task spans multiple categories | ~40KB |
| **T3 — Rare** | `_master_relationships_map.md` — only for relationship audits | ~31KB |

**Examples:**
- Processing a monster lore update → Load only `monsters_and_ecology.md`
- Creating a new location → Load only that location type's templates
- Full consistency audit → Load T0 + T2 + T3

### R2 — Prefer `edit` Over `write`
- For small changes to existing files, always use `edit` (find/replace) instead of `write` (overwrite)
- `edit` changes only the affected tokens; `write` re-processes the entire file
- Batch multiple edits into one tool call when possible

### R3 — Delegate Expensive Sub-Tasks
If a task would require loading 3+ large entity files (>90KB total), split the work:

```
You (orchestrator) — Loads only T0 (~20KB)
 ├─ Sub-agent A → Loads & processes economy files
 ├─ Sub-agent B → Loads & processes monster files
 └─ You → Synthesize results
```

Each sub-agent has a small, focused context. Use `delegate(async: true)` for parallel work, then `load(taskId)` to collect results. **Never load 3+ large files into one context.**

### R4 — Turn Budget Awareness
- The `<turn-budget>` in context tells you how many turns remain
- Early in budget (lots left) → normal work
- Middle budget → batch operations, reduce exploration
- Low budget → make reasonable assumptions, skip optional work, finish

### R5 — File Reading Discipline
- Never re-read a file already in your current context
- When working with `_session_continuity.md`, extract what you need in one pass
- Prefer `execute_typescript` with batched read/write operations over separate tool calls

### R6 — Session Compaction
- If `_session_continuity.md` grows past **12KB**, prune it:
  - Remove open questions that have been ✅ resolved for more than 2 sessions
  - Shorten question descriptions to 1 line each
  - Archive detailed session logs to `cache/archived/`
- Mark resolved questions with ✅ and keep the last 3 sessions of deltas only

### R7 — Batch Tool Operations
- ALWAYS batch multiple tool operations into ONE `execute_typescript` call
- WRONG: Separate `shell` calls for read, then edit
- RIGHT: One `execute_typescript` with an async `run()` that reads, transforms, and writes

---

## Version Control & Commit Protocol

> **Mandatory**: Every Goose work session must end with a commit summary. Do not make changes silently.

### Step 6 — Suggest Commit

After every session of updates (cache changes, article generation, or any file modifications), Goose **must**:

#### 6.1 — Summarize Changes
Present the user with a clear summary of everything that was done:

```
## Changes Summary

### Files Modified
- `cache/entities/characters/balor_skallfang.md` — Updated backstory section, added new personality trait
- `cache/_session_continuity.md` — Marked "Gods & Religion" as ✅ complete
- `cache/_master_relationships_map.md` — Added relationship: Balor ↔ Raven Queen (↔ allies)

### Files Created
- `cache/entities/events/the_great_war.md` — New entity: Great War (historical event)
- `articles/output/the_great_war.bbcode` — Generated WA article

### Content Details
For each file, briefly note:
- **What changed** (added, modified, deleted sections)
- **Key content decisions** made
- **Any open questions** left in the file
```

#### 6.2 — Suggest a Commit Message
Propose a descriptive commit message in conventional format:

```
type(scope): brief description

- Bullet list of specific changes
- Links to any related entities
```

**Examples:**
```
feat(lore): add Balor Skallfang character and Raven Queen relationship

- Created cache/entities/characters/balor_skallfang.md with full backstory
- Updated cache/_master_relationships_map.md with Balor ↔ Raven Queen (allies)
- Added campaign events section to both character files
- Generated articles/output/balor_skallfang.bbcode

feat(articles): publish BBCode articles for the divine pantheon

- Generated articles for all 6 gods (forge, light, nature, peace, wealth, wisdom)
- Each article includes subscriber-gated secret sections
- Updated cache/_session_continuity.md with progress
```

#### 6.3 — Wait for Approval
**Do not commit or push automatically.** Present the summary and commit message to the user and wait for explicit approval (e.g., "Approved", "Go ahead", "Commit it"). Only after receiving approval should you:

```bash
git add .
git commit -m "<suggested message>"
git push
```

#### 6.4 — Cross-Session Continuity
- Always update `cache/_session_continuity.md` with the session's file manifest before finishing.
- If the user rejects the commit or asks for changes, iterate on the summary and re-present.

---

## Roles & Responsibilities

| Role | Handles |
|------|---------|
| **User** | Records voice notes, pastes transcriptions, confirms changes, posts articles to WA, **approves commits** |
| **Recorder App** | Records audio, shows volume meter, transcribes via Whisper, copies to clipboard |
| **Goose** | Processes transcriptions, manages cache, generates BBCode articles, **suggests commits and waits for approval** |

---

## Session Continuity Rule

> **Critical**: The file `cache/_session_continuity.md` must be **kept updated** at all times. This is the bridge between work sessions and survives context compactions.

### When to Update
- **After completing** a major lore category (e.g., Gods & Religion) — mark it ✅ and add design decisions.
- **When deferring** an open question — document it with ⏳ and context.
- **When making a design decision** that affects future categories — record the rationale.
- **When creating/updating files** — update the file manifest section.
- **When starting a new category** — update the todo list and "Next Up" section.

### What to Include
| Section | Content |
|---------|---------|
| **Work Progress** | Table of all categories with ✅/⏳/❌ status |
| **Design Decisions** | Key choices made, with rationale and alternatives considered |
| **Open Questions** | Deferred items, unresolved questions, pending decisions |
| **Files Created/Updated** | Manifest of changes made in the current session |
| **Next Up** | The next category with specific questions to answer |

### Format Rules
- Use `✅ **Complete**` for finished categories
- Use `⏳ **Next**` for the current active category
- Use `❌ Not started` for untouched categories
- Use `⏳ ` prefix for each open question
- Update the "Updated" date at the top of the file on every change

---

## Naming Conventions

- **Entity IDs**: `snake_case` format, e.g. `city_of_embermoor`, `the_whispering_knives`
- **Entity files**: `<entity_id>.md` stored in `cache/entities/<type>/`
- **Article files**: `<entity_id>.bbcode` stored in `articles/output/`
- **Recording files**: `recording_YYYYMMDD_HHMMSS.wav`