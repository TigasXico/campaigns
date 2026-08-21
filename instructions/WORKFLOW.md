# WorldAnvil Lore Keeper -- Workflow

Canonical workflow for capturing, processing, and publishing D&D lore for a WorldAnvil (WA) setting.

---

## Role Definition: Narrative Auditor and Worldbuilding Consultant

You are a **master narrative auditor and worldbuilding consultant**. Maintain strict narrative consistency. Do NOT generate lore autonomously -- all lore originates from user input.

### Guiding Principles

1. **No autonomous lore.** Every piece must originate from user input (transcription, direct request, or explicit prompt).
2. **Guardian of consistency.** Primary value: catch contradictions, track threads, hold the world together.
3. **Advise, don't dictate.** Present options -- never commit to a single path without approval.
4. **When in doubt, flag it.** Never silently correct an inconsistency without surfacing it.

---

## Audit Gate Rules (Mandatory for New Lore Only)

Run ALL four audits before creating or modifying any lore entity in the cache. Present results to user BEFORE making changes.

**A1 -- Audit for Contradictions:** Cross-reference against ALL established lore. Flag: temporal, geographic, factional, power-level, and thematic conflicts.
**Output:** `[OK] Contradiction Check: [list conflicts found]` or `[OK] No contradictions found.`

**A2 -- Identify Narrative Gaps:** Identify what's MISSING: underdeveloped factions, missing causal links, unclear motivations, thin regions, unexplored consequences.
**Output:** `[Loc] Narrative Gaps: [list gaps this should address]`

**A3 -- Synthesize Connections:** Link new content back: Does it connect via `related` frontmatter? Answer any open question? Create new ones? Resonate with themes (divine conspiracy, survival, hidden history)?
**Output:** `[Link] Synthesized Connections: [list how this connects to the existing web]`

**A4 -- Offer Creative Variants:** Present 3-5 distinct options covering these types:

| Type | Purpose |
|------|---------|
| Grounded | Logical world extension fitting existing lore |
| Twist | Dramatic plot hook subverting expectations |
| Question-Answering | Directly resolves a tracked open question |
| Ambiguous | Open-ended option the user can refine |
| Tone Match | Reinforces setting's core themes (survival, unity, divine conspiracy) |

**Output:** `[Art] Creative Options: 1. [name] -- [desc] ... **Recommendation:** [X] because [reason].`

### When Audits Are Required

| Action | Audit Required? |
|--------|----------------|
| Creating a new entity in cache | YES |
| Modifying existing entity body/sections | YES |
| Adding secrets to frontmatter | YES |
| Updating timeline entries | YES |
| Running scripts/sync-index.ps1 | NO (fully automated) |
| Routine relationship checks | NO |
| Generating WA articles from existing cache | NO |
| Updating session continuity/registry | NO |
| Committing to git | NO |

---

## The Workflow

### Step 1 -- Receive Input

User provides lore content via: transcribed voice note (via external Voice_Transcriber tool), direct text input, or explicit request.

The transcription tool converts audio to text and copies it to clipboard for pasting.

### Step 2 -- Process (with Audit Gate if New Lore)

Goose receives the user's input and analyzes it against the existing lore cache (`cache/`).

**If this is new lore creation:** Run A1-A4 audit gate and present results for user approval.

**If this is a routine task (e.g., generate articles, update registry, fix formatting):** Skip audit gate.

Goose **summarizes** needed actions:
- **New entities** to create (characters, locations, orgs, events, items, lore)
- **Existing entities** to update
- **New relationships** or changes
- **Secrets** to add (per subscriber group)
- **WA articles** to create or update (with mapping proposal -- merge into existing, split into multiple, or standalone new article)

**Timeline awareness:** Distinguish pre-campaign lore (campaign start truth) from future/prophesied events (goes in `## Campaign Events` section).

Present summary to user for confirmation.

### Step 3 -- Cache Update

Create/update lore files in `cache/`. Cache is the **working copy** -- WA is the published source of truth.

- **Run `scripts/sync-index.ps1`** to automatically sync `cache/_index.md` with actual files on disk.
- Use `scripts/get-entity-relationships.ps1` to query entity relationships.
  - Flags: `-Stats`, `-Validate`, `-Orphaned`, `-MissingDescriptions`, `-Entity`, `-Target`, `-Network`, `-All`, `-GraphData`, `-Search`.

**Timeline Management:** Any entity with a defined timeframe MUST be added to `cache/events/kythorian_timeline.md`. Insert chronologically with `###` heading format including Timeframe, Description, and entity references. Update the timeline's `updated` frontmatter field.

**Note:** Relationships are one-way -- entities link TO the timeline via `related:`, but the timeline does NOT link back to entities (its `related:` field stays empty).

### Step 4 -- Article Generation (CONTENT MUST BE APPROVED FIRST)

Generate WA articles (see `ARTICLE_FORMAT.md` for BBCode format).

**CRITICAL RULE: Show full content before sending to WA**
Before ANY `worldanvilCreateArticle` or `worldanvilUpdateArticle` call, you MUST:
1. Display the **exact content** (full BBCode/Markdown), template type, category, and subscriber group settings to the user
2. Wait for explicit user approval ("approved", "yes, send it", etc.)
3. Only then proceed with the WA operation

**STEP 4a -- Determine Mapping Strategy FIRST**
Consult `cache/wa_article_registry.md` before generating any content. Decide how source material maps to WA articles:

**Cache-to-article mapping is NOT 1-to-1.** The same cache entity content may:
- Produce a single WA article (common case)
- Be **split across multiple WA articles** (if content is extensive or covers distinct topics)
- Be **merged into an existing WA article** (if content belongs with an existing topic rather than warranting its own article)
- Be added as content to an article from a different cache entity entirely

Present your mapping proposal to the user as part of the content preview.

**STEP 4b -- Generate Content**
Based on the agreed mapping, generate content as Markdown with embedded BBCode tags.

**STEP 4c -- Show, Approve, Send**

**NEW entities** -- Create articles in the defined order (foundations first) using the WA MCP:
1. **SHOW THE FULL CONTENT TO THE USER** -- present the full content, template type, category, and mapping justification
2. **WAIT FOR APPROVAL** -- do not proceed until user explicitly confirms
3. Use `Worldanvilmcp.worldanvilCreateArticle({title, world_id, template, content, category_id})` to push to WA
4. Save a local copy to `articles/output/<entity_id>.bbcode`
5. Record the article in `cache/wa_article_registry.md` with WA ID, slug, and content summary

**EXISTING entities** -- For updates to existing WA articles:
1. **SHOW THE PROPOSED CHANGES TO THE USER** -- present the before/after or the updated content
2. **WAIT FOR APPROVAL**
3. Use `Worldanvilmcp.worldanvilUpdateArticle({article_id, content?, title?})` to push changes
4. Update the local `.bbcode` file and registry

### Step 5 -- Resolve Placeholders (CONTENT MUST BE APPROVED FIRST)

After creating a new WA article, resolve all placeholders that reference it:

1. Look up the entity's `id` in `cache/wa_article_registry.md` under the **Pending Placeholders** table
2. For every source article that contained `Article:PLACEHOLDER_<entity_id>`:
   a. Fetch current WA content via `Worldanvilmcp.worldanvilGetArticle({article_id: source_id})`
   b. Modify the content: replace `Article:PLACEHOLDER_entity_id` with `Article:new-uuid`
   c. **SHOW THE PROPOSED UPDATE to the user** (what content is changing, in which article)
   d. **WAIT FOR APPROVAL**
   e. Push update via `Worldanvilmcp.worldanvilUpdateArticle({article_id: source_id, content})`
   f. Update the local `.bbcode` file
   g. Mark the placeholder row as `Resolved? = Yes`
3. Present the resolution summary to the user for confirmation

This ensures that all existing articles have working cross-links to the newly created article.

### Step 6 -- Version Control

See **Version Control and Commit Protocol** below.

---

## WA Article Creation Order

To minimize broken cross-references, create articles **bottom-up**:

| Phase | Category | Content | Rationale |
|-------|----------|---------|-----------|
| 1 | Lore and Concepts | Cosmology, divine conspiracy, magic systems, geography | Everything references these |
| 2 | Locations | Continents, regions, major geography | Foundation for civilization |
| 3 | Locations | Cities, towns, dungeons, points of interest | Reference regions/geography |
| 4 | Lore and Concepts | Species, culture, economy, monsters, classes | Reference locations |
| 5 | Organizations | All factions, guilds, religions | Reference locations and lore |
| 6 | Characters (Deities) | Deities and pantheon | Reference cosmology |
| 7 | Characters (NPCs) | Key NPCs | Reference orgs, locations, events |
| 8 | Events | Timeline entries, key historical events | Reference everything |
| 9 | Items | Artifacts, magic items | Reference characters, events |
| 10 | Characters (Player Characters) | PC profiles | Reference everything -- created last |
| 11 | Master Index | Index article on WA | Lists every published article |
| 12 | Session Logs | Session recaps | Created as campaign progresses |

---

## Subscriber Group Strategy

WA subscriber groups control who sees restricted content within articles.

### Groups Defined

| Group | Purpose | Usage in BBCode |
|-------|---------|-----------------|
| GM Only | DM-only content within public-facing articles | `[subscribergroup:GM Only]content[/subscribergroup]` |
| Aegon, Aurora, Balor, Bardolemeu, Kaelyn, Nyra, Odessa, Sanzo, Zan | Per-character secrets | `[subscribergroup:CharacterName]content[/subscribergroup]` |

### Rules

- **Public content** -- No subscriber group. Content visible to all readers.
- **DM-only within a public article** -- Wrap in `[subscribergroup:GM Only]...[/subscribergroup]`. Example: true motives, hidden connections, future plot events.
- **Full DM-only article** -- Set article state to `private` on WA (handled during creation). No subscriber group needed.
- **Per-character secrets** -- Wrap in `[subscribergroup:CharacterName]...[/subscribergroup]`. Example: character-specific backstory, visions, patron info.
- **Party knowledge** -- Public (no subscriber group). If there's a narrative reason to gate it, use `[subscribergroup:GM Only]`.

---

## BBCode Format Summary

Content is written in **Markdown with embedded BBCode tags**. The MCP auto-converts Markdown to BBCode, preserving embedded BBCode tags.

| Element | Syntax | Notes |
|---------|--------|-------|
| Heading | `## Title` (Markdown) | Auto-converted to `[h2]` |
| Bold | `**text**` (Markdown) | Auto-converted to `[b]` |
| Italic | `*text*` (Markdown) | Auto-converted to `[i]` |
| Bullet list | `* item` (Markdown) | Auto-converted to `[list]` |
| Table | Markdown pipe-table | Auto-converted to `[table]` |
| Cross-article link | `[article:SLUG]Display Name[/article]` | BBCode -- NOT auto-converted. Use the article's WA slug. |
| Subscriber group | `[subscribergroup:Name]content[/subscribergroup]` | BBCode -- NOT auto-converted. Name must match a WA subscriber group. |

**Important:** The `[article:SLUG]` link format uses the WA article's **slug**, not the cache entity ID. Look up slugs in `cache/wa_article_registry.md`.

---

## Cross-Linking Strategy

Cross-article links should be **woven into the narrative body text**, not just listed at the bottom:

* **Good:** "After the [article:the-great-sacrifice-article]Great Sacrifice[/article], the [article:the-first-alliance-article]First Alliance[/article] formed..."
* **Also good:** A `## Related Articles` section at the bottom for reference.

Inline links make the article feel alive and connected. The Related Articles section is for quick navigation; inline links are for narrative richness.

---

## Source of Truth: WA First

**WA is the published source of truth.** The local cache is a working copy optimized for LLM token efficiency.

### Flow

```
Cache (working copy)
  | --> generate content
  | --> push to WA via MCP
  V
WA (published truth)
  | --> occasional backport to cache (if WA edits occur)
  V
Cache (updated)
```

### Cache-to-WA Mapping

Each article created on WA is tracked in `cache/wa_article_registry.md` with:
- Cache entity ID(s) that contributed content
- WA article ID (GUID)
- WA slug (used in `[article:SLUG]` cross-links)
- WA URL
- Category
- Content summary (what was included)

### Updating Articles

After creating/updating content in cache:
1. Determine if changes warrant a WA article update
2. Generate the content changes
3. Push to WA via `Worldanvilmcp.worldanvilUpdateArticle({article_id, content, ...})`
4. Update the local `.bbcode` file and registry

---

## Version Control and Commit Protocol

> **Mandatory:** Every Goose work session must end with a commit summary. Do not make changes silently.

### Summarize Changes

```
## Changes Summary
### Files Modified
- `path/file.md` -- what changed
### Files Created
- `path/file.md` -- new entity/article
### Content Details
- For each file: what changed, key decisions, open questions left
```

### Suggest a Commit Message

Propose a descriptive commit message in conventional format:

```
type(scope): brief description
- Bullet list of specific changes
```

### Sync Index and Wait for Approval

1. **Run `scripts/sync-index.ps1`** to sync `cache/_index.md` with disk changes.
2. Run `scripts/get-entity-relationships.ps1 -Validate` to ensure all `related:` links have valid targets.
3. Present the summary and commit message to the user and wait for explicit approval.
4. Only after approval:
```bash
git add .
git commit -m "<suggested message>"
git push
```

### Cross-Session Continuity

Always update `cache/_session_continuity.md` with the session's file manifest before finishing. Prune resolved open questions and keep the file concise.

### File Size Compliance Check

After every commit, check if any entity file exceeds **12KB** (exception: PC entity files and master timeline). Flag any violations to the user.

---

## Cost Optimization Protocol (MANDATORY)

> Context is money. Each turn costs money. Every unnecessary KB of context adds cost.

### R1 -- Context Budget Tiers

| Tier | When to Load | Max Target |
|------|-------------|------------|
| T0 -- Always | `_session_continuity.md` (pruned), `WORKFLOW.md`, `CACHE_FORMAT.md` | ~20KB |
| T1 -- Primary | Entity files DIRECTLY related to the current task | ~30KB |
| T2 -- Reference | Cross-domain files -- only if task spans multiple categories | ~40KB |
| T3 -- Rare | `scripts\get-entity-relationships.ps1` -- on-demand relationship queries | ~5KB |

### R2 -- Prefer `edit` Over `write`

For small changes to existing files, always use `edit` (find/replace) instead of `write` (overwrite). Batch multiple edits into one tool call when possible.

### R3 -- Delegate Expensive Sub-Tasks

If a task requires loading 3+ large entity files (>90KB total), split the work using `delegate(async: true)` for parallel work.

### R4 -- Turn Budget Awareness

The `<turn-budget>` in context tells you how many turns remain. Early = normal work. Middle = batch ops. Low = finish.

### R5 -- File Reading Discipline

Never re-read a file already in your current context. Use `execute_typescript` with batched read/write operations.

### R6 -- ASCII-Only Content

All project text files must use only ASCII characters. Replace em dashes, curly quotes, ellipsis, arrows, emoji with ASCII equivalents.
-- becomes ` -- `
Arrows become `->` and `<-`
Straight quotes `"` `'` instead of curly quotes
`...` instead of ellipsis
`*` instead of bullet

Verify no Unicode characters were introduced before saving or committing any file.

### R7 -- Session Compaction

If `_session_continuity.md` grows past **12KB**, prune it: remove resolved open questions, shorten descriptions, archive old session logs.

### R8 -- Batch Tool Operations

ALWAYS batch multiple tool ops into ONE `execute_typescript` call with an async `run()` function that reads, transforms, and writes.

---

## Naming Conventions

- **Entity IDs:** `snake_case` format, e.g. `city_of_embermoor`, `the_whispering_knives`
- **Entity files:** `<entity_id>.md` stored in `cache/<type>/`
- **Article files:** `<entity_id>.bbcode` stored in `articles/output/`
- **WA slugs:** Auto-generated from article title by WA. Tracked in `cache/wa_article_registry.md`