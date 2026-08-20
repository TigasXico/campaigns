---
name: worldanvil-mcp
description: Rules, syntax specifications, and API signature references for interacting with the WorldAnvil MCP server to perform CRUD operations on campaign worlds, articles, BBCode formatting, maps, variables, and lore entities.
---

# WorldAnvil MCP - API Reference

## Calling Convention
All WA MCP functions are called via execute_typescript as Worldanvilmcp.functionName({params}).
Example: Worldanvilmcp.worldanvilListWorlds({})

## World Info (already in context)
World: "Aetris" (id: a07186fa-ce6a-40d0-b9fb-2377f33c9cd3)
Subscriber Groups: Kaelyn, Zan (for per-character secrets via [subscribergroup:group_name])

## Core CRUD Pattern
Most entity types follow the same 4-function pattern:
- worldanvilList<Type>({world_id?, offset?, limit?})
- worldanvilGet<Type>({<type>_id})
- worldanvilCreate<Type>({title, world_id, content?})
- worldanvilUpdate<Type>({<type>_id, title?, content?})
- worldanvilDelete<Type>({<type>_id})

Exceptions noted below.

## Articles (most important)
worldanvilListArticles({world_id, template?}) - template filters by type (character|location|organization|event|item|lore)
worldanvilGetArticle({article_id})
worldanvilCreateArticle({title, world_id, template, content?, fields?})
  - template: required - character|location|organization|event|item|lore
  - fields: template-specific (localization, manifestation, lawtype, anatomy, traits, seeded, authornotes, etc.)
  - Markdown auto-converted to BBCode in content AND fields
worldanvilUpdateArticle({article_id, title?, content?, fields?})
worldanvilDeleteArticle({article_id})

## Categories
worldanvilListCategories / Get / Create / Update / Delete
- CreateCategory: {title, world_id, content?, parent_category_id?}

## Images
worldanvilListImages({world_id, offset?, limit?})
worldanvilGetImage / UpdateImage / DeleteImage

## Maps & Markers
worldanvilListMaps({world_id})
worldanvilGetMap / CreateMap / UpdateMap / DeleteMap
worldanvilListMarkers({map_id}) / ListMarkersInGroup({markergroup_id})
worldanvilGetMarker / CreateMarker / UpdateMarker / DeleteMarker
worldanvilListLayers({map_id}) / GetLayer / CreateLayer / UpdateLayer / DeleteLayer
worldanvilListMarkergroups({map_id}) / GetMarkergroup / CreateMarkergroup / UpdateMarkergroup / DeleteMarkergroup
worldanvilListMarkertypes() / GetMarkertype / CreateMarkertype / UpdateMarkertype / DeleteMarkertype

## Timelines & History Events
worldanvilListTimelines({world_id})
worldanvilGetTimeline / CreateTimeline / UpdateTimeline / DeleteTimeline
  - UpdateTimeline: can attach history events via history_ids param
worldanvilListHistories({world_id})
worldanvilGetHistory / CreateHistory / UpdateHistory / DeleteHistory
  - CreateHistory requires year field (not just title/world_id)
  - After creating, call UpdateTimeline with history_ids to attach

## Secrets (GM-only content)
worldanvilListSecrets({world_id})
worldanvilGetSecret / CreateSecret / UpdateSecret / DeleteSecret
- Used for hiding info from players in articles

## Subscriber Groups (access control)
worldanvilListSubscribergroups({world_id})
worldanvilGetSubscribergroup / CreateSubscribergroup / UpdateSubscribergroup / DeleteSubscribergroup

## Variables (reusable snippets)
worldanvilListVariablecollections({world_id}) - ALWAYS call before creating
worldanvilGetVariablecollection / CreateVariablecollection / UpdateVariablecollection / DeleteVariablecollection
  - CreateVariablecollection: {title, world_id, prefix} - prefix is 3-6 lowercase chars
  - Variables accessed as [prefix:key] in BBCode articles
  - Prefix CANNOT be changed later without breaking all references
worldanvilListVariables({variablecollection_id})
worldanvilGetVariable / CreateVariable / UpdateVariable / DeleteVariable
  - CreateVariable: {key, value, type, variablecollection_id}
  - type: "string" (title-display, hover tooltip), "rendered" (inline BBCode), "link" (clickable), "number"

## Notebooks & Notes (session journals)
worldanvilListNotebooks({world_id}) - API may be broken per WA docs
worldanvilGetNotebook / CreateNotebook / UpdateNotebook / DeleteNotebook
worldanvilListNotesections({notebook_id})
worldanvilGetNotesection / CreateNotesection / UpdateNotesection / DeleteNotesection
worldanvilListNotes({notesection_id})
worldanvilGetNote / CreateNote / UpdateNote / DeleteNote

## Manuscripts (long-form writing)
worldanvilListManuscripts({world_id})
worldanvilGetManuscript / CreateManuscript / UpdateManuscript / DeleteManuscript
worldanvilListManuscriptversions({manuscript_id})
worldanvilGetManuscriptversion / CreateManuscriptversion / UpdateManuscriptversion / DeleteManuscriptversion
worldanvilListManuscriptparts({manuscriptversion_id})
worldanvilGetManuscriptpart / CreateManuscriptpart / UpdateManuscriptpart / DeleteManuscriptpart
worldanvilListManuscriptbeats({manuscriptpart_id})
worldanvilGetManuscriptbeat / CreateManuscriptbeat / UpdateManuscriptbeat / DeleteManuscriptbeat
worldanvilListManuscriptbookmarks / Manuscripttags / Manuscriptstats / Manuscriptlabels / Manuscriptplots
- Each with Get/Create/Update/Delete

## Canvases (visual boards)
worldanvilListCanvases({world_id})
worldanvilGetCanvas / CreateCanvas / UpdateCanvas / DeleteCanvas

## Blocks & Block Templates (statblocks)
worldanvilListBlocks({world_id})
worldanvilListBlocksInFolder({blockfolder_id})
worldanvilGetBlock / CreateBlock / UpdateBlock / DeleteBlock
  - CreateBlock requires BlockTemplate ID
worldanvilListBlocktemplates() / GetBlocktemplate / CreateBlocktemplate / UpdateBlocktemplate / DeleteBlocktemplate
  - GetBlocktemplate with granularity=2 to get parts
worldanvilListBlockfolders({world_id})
worldanvilGetBlockfolder / CreateBlockfolder / UpdateBlockfolder / DeleteBlockfolder

## RPG Systems
worldanvilListRpgsystems() / GetRpgsystem

## User
worldanvilGetIdentity() - current user info
worldanvilGetUser / UpdateUser - lookup other users

## BBCode Notes
- Markdown in content/fields auto-converts to BBCode
- NOT converted: @-mentions, embeds ([img], [map], [block]), advanced containers ([aloud], [spoiler]), columns ([row], [col])
- Article links: [article:id]Display Name[/article]
- Secrets: [subscribergroup:group_name]hidden content[/subscribergroup]
- Semantic tags preferred: [quote], [aloud], [code]
- Use @-mention-style references for cross-linking articles
