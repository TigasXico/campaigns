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

## Roles & Responsibilities

| Role | Handles |
|------|---------|
| **User** | Records voice notes, pastes transcriptions, confirms changes, posts articles to WA |
| **Recorder App** | Records audio, shows volume meter, transcribes via Whisper, copies to clipboard |
| **Goose** | Processes transcriptions, manages cache, generates BBCode articles |

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