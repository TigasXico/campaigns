# Cost Optimization  -  Master Relationship Map Restructuring Plan

**Goal**: Eliminate the 43KB `_master_relationships_map.md` and replace it with an on-demand query script, ensuring zero information loss.

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
