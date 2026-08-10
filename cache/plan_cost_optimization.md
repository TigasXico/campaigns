# Cost Optimization  -  Master Relationship Map Restructuring Plan

**Goal**: Eliminate the 43KB `_master_relationships_map.md` and replace it with an on-demand query script, ensuring zero information loss.

---

## Current Status (2026-08-10 19:47)

### Step 1 — Merge Context ? DONE
- 23 useful context points merged from master map into entity file descriptions
- 12 entity files updated: aetris, aegon, aurora_asteria, balor_skallfang, kaelyn, seraphina_vex, the_medallion_of_vex, the_crimson_covenant, the_council_accord, the_frostmaw, the_ecumenical_council, the_gods_and_the_deception
- All descriptions are additive (no information lost)
- Git: committed in `7541b26`

### Step 2 — Add Missing `related:` Entries ? DONE
- 79 missing entries added across 29 entity files
- All 380 master-map relationships now have `related:` entries in entity files
- Zero descriptions made up — all taken from master map
- 8 orphaned relationships still point to old `society_economy_and_culture` (split file)
- Git: committed in `db2a455`

### Step 3 — Global Content Check ? NEXT
- Re-scanned ALL 380 relationships comparing master map vs entity files
- 138 cases where master had more context; merged ~48 useful context points
- 29 entity files updated with refined descriptions; all 380 relationships still validated

### Step 4 — Build Query Script ?
- Build `scripts/get-entity-relationships.ps1` or TypeScript version
- Accept entity IDs as params ? return only their relationships
- Test against current master map output

### Step 5 — Cutover ?
- Archive/delete `_master_relationships_map.md` (save ~43KB per turn)
- Update `_index.md` and `WORKFLOW.md` to use query script
- Update the 8 orphaned `society_economy_and_culture` references

---

## Step 1: Merge Useful Context from Master Map -> Entity Files

**What**: Go through the ~47 cases where the master map has genuinely useful extra context that the entity file's `related:` description lacks. Update the entity file's description to include it.

**Validation**: `git diff` to review all changes. Pause for user review.

**Estimated**: ~47 entity file edits

---

## Step 2: Add Missing `related:` Entries to Entity Files

**What**: Go through the 79 cases where a relationship exists in the master map but has NO `related:` entry in the entity file. For each one:
  - If I know the relationship description from context -> add it with a meaningful description
  - If I DON'T know -> ask the user, never make one up

**Validation**: `git diff` to review all changes. Re-run `validate-relationships.ps1` to confirm all 380 master-map relationships now exist in entity files with descriptions. Pause for user review.

**Estimated**: ~79 entity file edits

---

## Step 3: Global Content/Context Check

**What**: One final comparison pass. For EVERY relationship (not just the ones we changed), verify that the entity file description captures the same context as the master map description. Surface any remaining discrepancies.

**Validation**: Present findings to user for input. Nothing changed without approval.

**Estimated**: Full re-scan of 380 relationships

---

## Step 4: Build On-Demand Relationship Query Script

**What**: Create a script (PowerShell) that:
  - Scans all entity files in `cache/entities/`
  - Parses the `related:` frontmatter field
  - Accepts one or more entity IDs as parameters
  - Returns only the matching relationships
  - Can also return ALL relationships if no entity specified

**Validation**: Run the script, compare output against current `_master_relationships_map.md`. Make sure the same information is returned. Pause for user review.

**Estimated**: 1 script file

---

## Step 5: Delete Master Map & Update Workflow

**What**: 
  - Archive or delete `_master_relationships_map.md`
  - Update `_index.md` to remove the reference
  - Update `WORKFLOW.md` to reference the query script instead of loading the map
  - Make the query script discoverable

**Validation**: Verify workflow references are correct. Do a test run.

**Estimated**: 3-4 file edits
