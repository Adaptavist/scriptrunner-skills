# Copying Asset Schemas Between Sites

- Platform: cloud
- Feature: script-console
- Tags: extend, administer, organise, system
- Language: groovy
- Doc ID: example-cloud-copying-asset-schemas-between-licences-cloud
- Source: https://examples.scriptrunner.io/scripts/copying-asset-schemas-between-licences-cloud

## Overview

This script helps synchronise Atlassian Assets schemas between different sites when no out-of-the-box option is available. 
It is useful for keeping schemas consistent across multiple environments, such as sharing the same setup between sites or aligning test environments with production. 
Where current Atlassian REST APIs do not support full migration, the script imports the schema and generates a report highlighting any differences, dependencies, or items that require manual follow-up.

## Good to Know

* To execute this script you will need to create API tokens with access permissions to both the source and target instances. These can use different credentials but the API key and email addresses should match. 
* Instructions for how to create your [API tokens](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/)
* As a best practice, you can store them as [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables).

## Description

#### Overview

This script helps synchronise Atlassian Assets schemas between different sites when no out-of-the-box option is available. 
It is useful for keeping schemas consistent across multiple environments, such as sharing the same setup between sites or aligning test environments with production. 
Where current Atlassian REST APIs do not support full migration, the script imports the schema and generates a report highlighting any differences, dependencies, or items that require manual follow-up.

#### Good to Know
* To execute this script you will need to create API tokens with access permissions to both the source and target instances. These can use different credentials but the API key and email addresses should match. 
* Instructions for how to create your [API tokens](https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/)
* As a best practice, you can store them as [Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables).

## Script

```groovy
import groovy.json.JsonSlurper
logger.info ("Version 40")
// =============================================================================
// CONFIGURATION — update all values before running
// =============================================================================

// Source instance (the instance you are copying FROM)
final String SOURCE_BASE_URL  = 'https://source-instance.atlassian.net'
final String SOURCE_EMAIL     = 'user@source-example.com'
final String SOURCE_API_TOKEN = 'SOURCE_API_TOKEN_HERE' // It is recommended that this is stored using a Script Variable rather than direct insertion in the script

// Target instance (the instance you are copying INTO)
final String TARGET_BASE_URL  = 'https://target-instance.atlassian.net'
final String TARGET_EMAIL     = 'user@target-example.com'
final String TARGET_API_TOKEN = 'TARGET_API_TOKEN_HERE' // It is recommended that this is stored using a Script Variable rather than direct insertion in the script

// Name of the Assets object schema to synchronise
final String SCHEMA_NAME = 'My Asset Schema'

// Set to true to also synchronise all objects (rows) inside the schema.
// Set to false to synchronise only the schema structure (object types + attributes).
final boolean COPY_OBJECTS = true

// ── Sync behaviour ────────────────────────────────────────────────────────────
// UPDATE_EXISTING — when true, existing object types, attributes, and objects
//   in the target are compared with the source and updated if they differ.
//   When false, existing content is left untouched (create-only mode).
final boolean UPDATE_EXISTING = true

// REPORT_ORPHANS — when true, content found in the target but absent from the
//   source is reported in the log (object types, attributes, and objects).
//   Orphans are never deleted — this is a report-only flag.
final boolean REPORT_ORPHANS = true

// Set to true to run Step 7 validation after the sync.
final boolean VALIDATE = true

// ── Icon-only mode ────────────────────────────────────────────────────────────
// Set ICONS_ONLY to true to run ONLY Step 3.5 (icon library sync) and skip
// all other steps. Useful for a first-pass icon migration, or for re-running
// the icon sync in isolation after adding new custom icons to the source.
// When true, COPY_OBJECTS, UPDATE_EXISTING, REPORT_ORPHANS, and VALIDATE are
// all effectively ignored.
final boolean ICONS_ONLY = false

// Objects fetched per AQL page (max 1000).
final int OBJECT_PAGE_SIZE = 500

// ── Timeout management ────────────────────────────────────────────────────────
// ScriptRunner Cloud has a 240s execution limit. For large schemas, run the
// script multiple times. Duplicate detection ensures objects are never created
// twice, so re-runs safely skip what already exists.
//
// OBJECT_BATCH_LIMIT — max objects to CREATE OR UPDATE per run (0 = unlimited).
//   Recommended: set to 150 to stay well within the 240s limit.
//   Re-run until the summary shows "Created: 0, Updated: 0".
//
// OBJECT_START_AT — skip this many source objects before starting.
//   Use this for explicit offset control across runs.
//
// NOTE: Pre-loading target objects with attributes (required for comparison)
//   is more expensive than the original copy script. For very large schemas
//   (>5000 objects), reduce OBJECT_PAGE_SIZE or OBJECT_BATCH_LIMIT accordingly.
final int OBJECT_BATCH_LIMIT = 150  // set to 0 to disable
final int OBJECT_START_AT    = 0    // 0 = start from the beginning

// =============================================================================
// ASSETS API BASE URL (Atlassian global Assets API — same for all instances)
// =============================================================================
final String ASSETS_API = 'https://api.atlassian.com/jsm/assets/workspace'

// =============================================================================
// HELPER: GET — returns raw parsed JSON (Map or List) via JsonSlurper.
// =============================================================================
Object assetsGet(String url, String email, String token) {
    def resp = get(url)
        .header('Accept', 'application/json')
        .basicAuth(email, token)
        .asString()
    if (resp.status != 200) {
        throw new AssertionError(
            "GET ${url} failed [${resp.status}]: ${resp.body}" as Object
        )
    }
    String body = resp.body as String
    logger.debug "GET ${url} → ${body.take(300)}"
    return new JsonSlurper().parseText(body)
}

// =============================================================================
// HELPER: POST — returns parsed Map response via JsonSlurper.
// =============================================================================
Map assetsPost(String url, String email, String token, Map payload) {
    def resp = post(url)
        .header('Content-Type', 'application/json')
        .header('Accept', 'application/json')
        .basicAuth(email, token)
        .body(payload)
        .asString()
    if (resp.status < 200 || resp.status >= 300) {
        throw new AssertionError(
            "POST ${url} failed [${resp.status}]: ${resp.body}" as Object
        )
    }
    String body = resp.body as String
    logger.debug "POST ${url} → ${body.take(300)}"
    return new JsonSlurper().parseText(body) as Map
}

// =============================================================================
// HELPER: PUT — returns parsed Map response via JsonSlurper.
// =============================================================================
Map assetsPut(String url, String email, String token, Map payload) {
    def resp = put(url)
        .header('Content-Type', 'application/json')
        .header('Accept', 'application/json')
        .basicAuth(email, token)
        .body(payload)
        .asString()
    if (resp.status < 200 || resp.status >= 300) {
        throw new AssertionError(
            "PUT ${url} failed [${resp.status}]: ${resp.body}" as Object
        )
    }
    String body = resp.body as String
    logger.debug "PUT ${url} → ${body.take(300)}"
    return new JsonSlurper().parseText(body) as Map
}

// =============================================================================
// HELPER: resolve workspace ID for a given instance
// =============================================================================
String getWorkspaceId(String baseUrl, String email, String token) {
    def resp = get("${baseUrl}/rest/servicedeskapi/assets/workspace")
        .header('Accept', 'application/json')
        .basicAuth(email, token)
        .asString()
    assert resp.status == 200 :
        "Could not fetch workspace for ${baseUrl} [${resp.status}]: ${resp.body}"
    Map parsed = new JsonSlurper().parseText(resp.body as String) as Map
    List values = parsed.get('values') as List
    assert values && !values.isEmpty() :
        "No Assets workspace found for ${baseUrl}"
    return (values.first() as Map).get('workspaceId') as String
}

// =============================================================================
// HELPER: extract a List<Map> from an Assets API response that may be either:
//   • A plain JSON array  → [ {...}, {...} ]
//   • A wrapped object    → { "objectschemas": [...] } / { "values": [...] }
// =============================================================================
List<Map> extractList(Object raw, String... candidateKeys) {
    if (raw instanceof List) {
        return (raw as List).collect { it as Map }
    }
    Map m = raw as Map
    for (String key : candidateKeys) {
        if (m.containsKey(key) && m.get(key) instanceof List) {
            return (m.get(key) as List).collect { it as Map }
        }
    }
    logger.warn "extractList: none of ${candidateKeys} found in keys ${m.keySet()}. Returning empty list."
    return []
}

// =============================================================================
// HELPER: topological sort — parents before children
// =============================================================================
List<Map> topoSort(List<Map> objectTypes) {
    List<Map>   sorted    = []
    Set<String> added     = [] as Set<String>
    List<Map>   remaining = objectTypes.collect { it as Map }

    int maxPasses = objectTypes.size() + 1
    int pass = 0
    while (!remaining.isEmpty() && pass < maxPasses) {
        pass++
        List<Map> nextRemaining = []
        remaining.each { Map ot ->
            String  parentId = ot.get('parentObjectTypeId') as String
            boolean isRoot   = !parentId || parentId == '0' || parentId == 'null'
            if (isRoot || added.contains(parentId)) {
                sorted << ot
                added  << (ot.get('id') as String)
            } else {
                nextRemaining << ot
            }
        }
        remaining = nextRemaining
    }

    if (!remaining.isEmpty()) {
        logger.warn "${remaining.size()} object type(s) had unresolvable parents — appending at end."
        sorted.addAll(remaining)
    }
    return sorted
}

// =============================================================================
// HELPER: safely read a boolean from a parsed JSON value.
// NEVER use the Elvis operator (?:) for booleans — Groovy treats false as
// falsy, so `false ?: true` returns true, breaking pagination logic.
// =============================================================================
boolean safeBool(Object raw, boolean defaultValue) {
    return (raw instanceof Boolean) ? (raw as Boolean) : defaultValue
}

// =============================================================================
// HELPER: extract the icon ID string from an object type map.
// The Assets API stores icon IDs as UUID strings, NOT integers.
// Example: { "icon": { "id": "c7c705b8-326e-4e86-8a99-1adec6132b1a", ... } }
// Returns an empty string when no icon field is present.
// =============================================================================
String extractIconId(Map ot) {
    def iconRaw = ot.get('icon')
    if (iconRaw instanceof Map) {
        def rawId = (iconRaw as Map).get('id')
        if (rawId != null) return rawId as String
    }
    // Fallback: top-level 'iconId' field (some API versions)
    def iconIdRaw = ot.get('iconId')
    if (iconIdRaw != null) return iconIdRaw as String
    return ''
}

// =============================================================================
// HELPER: build a canonical string representation of an object's attribute
// values for comparison across instances. Uses attribute NAME (not ID) and
// referenced object LABEL (not ID) so the result is stable across instances.
// System attributes (Name, Created, Updated) are excluded.
// =============================================================================
String canonicalAttrValues(List<Map> attrs) {
    List<String> parts = []
    attrs.each { Map attr ->
        Map otAttr = attr.get('objectTypeAttribute') as Map
        if (!otAttr) return
        // Exclude system-managed attributes from comparison
        def sysFlag = otAttr.get('system')
        if (sysFlag instanceof Boolean && (sysFlag as Boolean)) return
        String attrName = otAttr.get('name') as String ?: ''
        List<Map> vals = (attr.get('objectAttributeValues') as List ?: [])
            .collect { it as Map }
        List<String> valStrs = vals.collect { Map v ->
            Map refObj = v.get('referencedObject') as Map
            if (refObj) {
                return "ref:${refObj.get('label') as String ?: ''}"
            }
            // FIX (v38): use searchValue as fallback when value is null.
            // Group and Status attributes store null in 'value' and the
            // human-readable name in 'searchValue'.
            String val = v.get('value') as String
            if (!val) val = v.get('searchValue') as String
            return val ?: ''
        }.sort()
        parts << "${attrName}:${valStrs.join(',')}"
    }
    return parts.sort().join('|')
}

// =============================================================================
// HELPER: resolve a source icon UUID to its target equivalent using the map
// built in Step 3.5. Returns an empty string when the icon could not be
// mapped (caller should omit iconId from the payload in that case so the
// API assigns the workspace default rather than rejecting the request).
// =============================================================================
String resolveIconId(String srcIconId, Map<String, String> iconIdMap) {
    if (!srcIconId) return ''
    String mapped = iconIdMap.get(srcIconId)
    return mapped ?: ''
}

// =============================================================================
// HELPER: build a full hierarchical path for an object type by walking up the
// parent chain. Uses names at every level so the result is stable across
// instances (IDs differ; names should match after a sync).
// Example: "Infrastructure > Hardware > Servers"
// A depth cap of 20 prevents infinite loops on corrupt parent references.
// =============================================================================
String getOtPath(String otId, Map<String, Map> otById) {
    List<String> parts   = []
    String       current = otId
    int          depth   = 0
    while (current != null && !current.isEmpty() && current != '0' && current != 'null' && depth < 20) {
        Map ot = otById.get(current)
        if (!ot) break
        parts.add(0, ot.get('name') as String ?: '')
        String parentId = ot.get('parentObjectTypeId') as String
        if (!parentId || parentId == '0' || parentId == 'null') break
        current = parentId
        depth++
    }
    return parts.join(' > ')
}

// =============================================================================
// HELPER: safely convert an attribute ID string to an Integer for use in
// API payloads. The Assets API requires objectTypeAttributeId as an integer,
// not a string — sending a string causes attribute values to be silently
// ignored (same issue as typeValue which was already fixed).
// =============================================================================
int toAttrIdInt(String attrId) {
    try {
        return Integer.parseInt(attrId)
    } catch (NumberFormatException ignored) {
        logger.warn "  Could not parse attribute ID '${attrId}' as integer — using 0"
        return 0
    }
}

// =============================================================================
// HELPER: parse a 400 error message from AssertionError and return the set of
// target attribute IDs that the API rejected.
//
// The Assets API returns errors in the form:
//   {"errorMessages":[],"errors":{"rlabs-insight-attribute-1881":"Invalid Group(s)"}}
// The attribute ID is the numeric suffix of the error key.
//
// Used by the retry loops in Step 6 to remove only the failing attribute(s)
// from the payload and retry — so valid attributes (Date, Status, etc.) are
// still synced even when one attribute (e.g. Group) is invalid in the target.
// =============================================================================
Set<Integer> extractFailingAttrIds(String errMsg) {
    Set<Integer> ids = [] as Set<Integer>
    if (!errMsg) return ids
    try {
        // The error body starts after the last ': ' in the AssertionError message
        int jsonStart = errMsg.lastIndexOf(': {')
        String jsonStr = jsonStart >= 0
            ? errMsg.substring(jsonStart + 2).trim()
            : errMsg.substring(errMsg.indexOf('{')).trim()
        Map errorMap = new groovy.json.JsonSlurper().parseText(jsonStr) as Map
        Map errors   = errorMap.get('errors') as Map
        if (!errors) return ids
        errors.keySet().each { String key ->
            // Key format: "rlabs-insight-attribute-1881"
            String[] parts = (key as String).split('-')
            try { ids << Integer.parseInt(parts.last()) }
            catch (NumberFormatException ignored) {}
        }
    } catch (Throwable ignored) {}
    return ids
}

// =============================================================================
// STEP 1 — Resolve workspace IDs
// =============================================================================
logger.info '=== STEP 1: Resolving workspace IDs ==='

String sourceWsId = getWorkspaceId(SOURCE_BASE_URL, SOURCE_EMAIL, SOURCE_API_TOKEN)
String targetWsId = getWorkspaceId(TARGET_BASE_URL, TARGET_EMAIL, TARGET_API_TOKEN)

logger.info "Source workspace : ${sourceWsId}"
logger.info "Target workspace : ${targetWsId}"

// =============================================================================
// STEP 2 — Find the schema in the source instance
// =============================================================================
logger.info "=== STEP 2: Finding schema '${SCHEMA_NAME}' in source ==="

Object schemaListRaw = assetsGet(
    "${ASSETS_API}/${sourceWsId}/v1/objectschema/list",
    SOURCE_EMAIL, SOURCE_API_TOKEN
)

List<Map> sourceSchemas = extractList(
    schemaListRaw, 'objectschemas', 'values', 'schemas'
)

logger.info "Schemas found in source: ${sourceSchemas.size()}"
sourceSchemas.each { Map s ->
    logger.info "  - id=${s.get('id')}, name=${s.get('name')}, key=${s.get('objectSchemaKey')}"
}

Map sourceSchema = sourceSchemas.find { Map s ->
    (s.get('name') as String) == SCHEMA_NAME
} as Map

assert sourceSchema :
    "Schema '${SCHEMA_NAME}' not found in source. " +
        "Available: ${sourceSchemas.collect { (it as Map).get('name') }}"

String sourceSchemaId  = sourceSchema.get('id') as String
String sourceSchemaKey = sourceSchema.get('objectSchemaKey') as String
logger.info "Found source schema: id=${sourceSchemaId}, key=${sourceSchemaKey}"

// =============================================================================
// STEP 3 — Find or create the schema in the target instance
// =============================================================================
logger.info '=== STEP 3: Finding or creating schema in target ==='

Object tgtSchemaListRaw = assetsGet(
    "${ASSETS_API}/${targetWsId}/v1/objectschema/list",
    TARGET_EMAIL, TARGET_API_TOKEN
)
List<Map> targetSchemas = extractList(
    tgtSchemaListRaw, 'objectschemas', 'values', 'schemas'
)

Map existingTargetSchema = targetSchemas.find { Map s ->
    (s.get('name') as String) == SCHEMA_NAME
} as Map

String targetSchemaId
String targetSchemaKey
if (existingTargetSchema) {
    targetSchemaId  = existingTargetSchema.get('id') as String
    targetSchemaKey = existingTargetSchema.get('objectSchemaKey') as String
    logger.info "Schema '${SCHEMA_NAME}' already exists in target " +
        "(id=${targetSchemaId}, key=${targetSchemaKey})"

    // Sync schema-level description if it has changed
    if (UPDATE_EXISTING) {
        String srcDesc = sourceSchema.get('description') as String ?: ''
        String tgtDesc = existingTargetSchema.get('description') as String ?: ''
        if (srcDesc != tgtDesc) {
            try {
                assetsPut(
                    "${ASSETS_API}/${targetWsId}/v1/objectschema/${targetSchemaId}",
                    TARGET_EMAIL, TARGET_API_TOKEN,
                    [name       : sourceSchema.get('name'),
                     description: srcDesc]
                )
                logger.info "  Updated schema description"
            } catch (AssertionError e) {
                logger.warn "  Could not update schema description: ${e.message}"
            }
        }
    }
} else {
    Map newSchemaBody = [
        name           : sourceSchema.get('name'),
        objectSchemaKey: sourceSchema.get('objectSchemaKey'),
        description    : sourceSchema.get('description') ?: ''
    ]
    Map createdSchema = assetsPost(
        "${ASSETS_API}/${targetWsId}/v1/objectschema/create",
        TARGET_EMAIL, TARGET_API_TOKEN, newSchemaBody
    )
    targetSchemaId  = createdSchema.get('id') as String
    targetSchemaKey = createdSchema.get('objectSchemaKey') as String
    logger.info "Created target schema: id=${targetSchemaId}, key=${targetSchemaKey}"
}

// =============================================================================
// STEP 3.5 — Sync icon library
// =============================================================================
logger.info '=== STEP 3.5: Syncing icon library ==='

Map<String, String> iconIdMap          = [:]
String              defaultFallbackIconId = ''

try {
    // ── 3.5a: Fetch global (built-in) icons from the TARGET workspace ─────────
    Map<String, String> tgtGlobalIconIdByName = [:]
    try {
        Object globalIconRaw = assetsGet(
            "${ASSETS_API}/${targetWsId}/v1/icon/global",
            TARGET_EMAIL, TARGET_API_TOKEN
        )
        List<Map> globalIcons = extractList(globalIconRaw, 'values', 'icons')
        globalIcons.each { Map gi ->
            String gName = gi.get('name') as String
            String gId   = gi.get('id') as String
            if (gName && gId) {
                tgtGlobalIconIdByName[gName] = gId
                if (!defaultFallbackIconId) defaultFallbackIconId = gId
            }
        }
        logger.info "  Loaded ${tgtGlobalIconIdByName.size()} global icons from target workspace"
        logger.debug "  Global icon names: ${tgtGlobalIconIdByName.keySet().sort()}"
    } catch (Throwable globalEx) {
        logger.warn "  Could not fetch global icons: ${globalEx.message}"
        logger.warn "  Will fall back to OT-embedded icon data only."
    }

    // ── 3.5b: Collect unique icons from source OTs ────────────────────────────
    Object srcOtIconRaw = assetsGet(
        "${ASSETS_API}/${sourceWsId}/v1/objectschema/${sourceSchemaId}/objecttypes/flat",
        SOURCE_EMAIL, SOURCE_API_TOKEN
    )
    List<Map> srcOtsForIcons = extractList(
        srcOtIconRaw, 'objectTypes', 'values', 'objecttypes'
    )

    Object tgtOtIconRaw = assetsGet(
        "${ASSETS_API}/${targetWsId}/v1/objectschema/${targetSchemaId}/objecttypes/flat",
        TARGET_EMAIL, TARGET_API_TOKEN
    )
    List<Map> tgtOtsForIcons = extractList(
        tgtOtIconRaw, 'objectTypes', 'values', 'objecttypes'
    )

    logger.info "  Source OTs: ${srcOtsForIcons.size()}, Target OTs: ${tgtOtsForIcons.size()}"

    Map<String, Map> srcIconsByName = [:]
    srcOtsForIcons.each { Map ot ->
        Map icon = ot.get('icon') as Map
        if (icon && icon.get('name')) {
            srcIconsByName[icon.get('name') as String] = icon
        }
    }

    Map<String, Map> tgtIconsByName = [:]
    tgtOtsForIcons.each { Map ot ->
        Map icon = ot.get('icon') as Map
        if (icon && icon.get('name')) {
            String tgtIconName = icon.get('name') as String
            tgtIconsByName[tgtIconName] = icon
            if (!defaultFallbackIconId) {
                defaultFallbackIconId = icon.get('id') as String
            }
        }
    }

    logger.info "  Unique source icons: ${srcIconsByName.size()}, " +
        "Unique target icons: ${tgtIconsByName.size()}"
    logger.info "  Source icons by name: ${srcIconsByName.keySet().sort()}"

    int iconsMatched  = 0
    int iconsUploaded = 0
    int iconsFailed   = 0

    srcIconsByName.each { String iconName, Map srcIcon ->
        String srcIconId = srcIcon.get('id') as String

        // ── Priority 1: match via global icon list (built-in icons) ───────────
        if (tgtGlobalIconIdByName.containsKey(iconName)) {
            String tgtIconId = tgtGlobalIconIdByName.get(iconName)
            iconIdMap[srcIconId] = tgtIconId
            iconsMatched++
            logger.info "  [global] Matched '${iconName}': src=${srcIconId} → tgt=${tgtIconId}"
            return
        }

        // ── Priority 2: match via existing target OTs in this schema ──────────
        if (tgtIconsByName.containsKey(iconName)) {
            String tgtIconId = (tgtIconsByName.get(iconName) as Map).get('id') as String
            iconIdMap[srcIconId] = tgtIconId
            iconsMatched++
            logger.info "  [schema] Matched '${iconName}': src=${srcIconId} → tgt=${tgtIconId}"
            return
        }

        // ── Priority 3: skip built-in icons that failed global lookup ─────────
        String iconUrl = (srcIcon.get('url128') ?: srcIcon.get('url48') ?: srcIcon.get('url16')) as String
        boolean isBuiltIn = iconUrl?.contains('assets-media.atlassian.com')

        if (isBuiltIn) {
            logger.warn "  [builtin] '${iconName}' not found in global list — " +
                "will use fallback icon for OTs that reference it"
            iconsFailed++
            return
        }

        // ── Priority 4: upload custom icon binary ─────────────────────────────
        if (!iconUrl) {
            logger.warn "  No URL for icon '${iconName}' (id=${srcIconId}) — skipping"
            iconsFailed++
            return
        }

        try {
            def dlResp = get(iconUrl)
                .header('Accept', 'image/*,*/*')
                .basicAuth(SOURCE_EMAIL, SOURCE_API_TOKEN)
                .asBinary()

            if (dlResp.status != 200) {
                logger.warn "  Download failed for '${iconName}' [${dlResp.status}] — skipping"
                iconsFailed++
                return
            }

            def ulResp = post("${ASSETS_API}/${targetWsId}/v1/icon")
                .header('Accept', 'application/json')
                .basicAuth(TARGET_EMAIL, TARGET_API_TOKEN)
                .field('file', dlResp.body as InputStream, 'image/png')
                .field('name', iconName)
                .asString()

            if (ulResp.status < 200 || ulResp.status >= 300) {
                logger.warn "  Upload failed for '${iconName}' [${ulResp.status}]: " +
                    "${(ulResp.body as String)?.take(200)}"
                iconsFailed++
                return
            }

            Map   uploadedIcon = new JsonSlurper().parseText(ulResp.body as String) as Map
            String tgtIconId   = uploadedIcon.get('id') as String
            iconIdMap[srcIconId]     = tgtIconId
            tgtIconsByName[iconName] = uploadedIcon
            if (!defaultFallbackIconId) defaultFallbackIconId = tgtIconId
            iconsUploaded++
            logger.info "  [upload] '${iconName}': src=${srcIconId} → tgt=${tgtIconId}"

        } catch (Exception innerEx) {
            logger.warn "  Error processing icon '${iconName}': ${innerEx.message}"
            iconsFailed++
        }
    }

    logger.info "Icon sync: matched=${iconsMatched}, uploaded=${iconsUploaded}, failed=${iconsFailed}"

    // ── Fallback: scan other target schemas for any still-unresolved icons ────
    if (iconIdMap.size() < srcIconsByName.size()) {
        logger.info "  Fallback: scanning other target schemas for unmatched icons..."
        Set<String> unmappedSrcIds = srcIconsByName.values()
            .collect { (it as Map).get('id') as String }
            .findAll { !iconIdMap.containsKey(it) } as Set<String>

        targetSchemas.each { Map schema ->
            if (unmappedSrcIds.isEmpty()) return
            String schemaId = schema.get('id') as String
            if (schemaId == targetSchemaId) return

            try {
                Object fbOtRaw = assetsGet(
                    "${ASSETS_API}/${targetWsId}/v1/objectschema/${schemaId}/objecttypes/flat",
                    TARGET_EMAIL, TARGET_API_TOKEN
                )
                List<Map> fbOts = extractList(fbOtRaw, 'objectTypes', 'values', 'objecttypes')
                fbOts.each { Map fbOt ->
                    Map fbIcon = fbOt.get('icon') as Map
                    if (!fbIcon || !fbIcon.get('name')) return
                    String fbIconName = fbIcon.get('name') as String
                    String fbIconId   = fbIcon.get('id') as String
                    Map srcIcon = srcIconsByName.get(fbIconName) as Map
                    if (srcIcon) {
                        String srcIconId = srcIcon.get('id') as String
                        if (!iconIdMap.containsKey(srcIconId)) {
                            iconIdMap[srcIconId] = fbIconId
                            unmappedSrcIds.remove(srcIconId)
                            if (!defaultFallbackIconId) defaultFallbackIconId = fbIconId
                            logger.info "  Fallback matched '${fbIconName}' from schema ${schemaId}: " +
                                "src=${srcIconId} → tgt=${fbIconId}"
                        }
                    }
                }
            } catch (Throwable ignored) {
                // Non-fatal — skip this schema and try the next
            }
        }

        if (!unmappedSrcIds.isEmpty()) {
            logger.warn "  ${unmappedSrcIds.size()} icon(s) still unresolved after all attempts: " +
                "${srcIconsByName.findAll { unmappedSrcIds.contains((it.value as Map).get('id') as String) }.keySet().sort()}"
            if (defaultFallbackIconId) {
                logger.warn "  These OTs will use fallback icon id=${defaultFallbackIconId} " +
                    "so creation does not fail. Update icons manually in the target if needed."
            } else {
                logger.warn "  No fallback icon available — OT creation may still fail for these icons."
            }
        }
    }

    logger.info "  iconIdMap (${iconIdMap.size()} entries): ${iconIdMap}"
    logger.info "  defaultFallbackIconId: ${defaultFallbackIconId ?: '(none)'}"

} catch (Throwable stepEx) {
    logger.warn "  ⚠️  Step 3.5 failed: ${stepEx.message}"
    logger.warn "  Icon sync skipped — continuing with remaining steps."
}

if (ICONS_ONLY) {
    logger.info '=== ICONS_ONLY mode — all subsequent steps skipped ==='
    return "Icon sync complete."
}

// =============================================================================
// STEP 4 — Sync object types (schema structure)
// =============================================================================
logger.info '=== STEP 4: Syncing object types ==='

Object otListRaw = assetsGet(
    "${ASSETS_API}/${sourceWsId}/v1/objectschema/${sourceSchemaId}/objecttypes/flat",
    SOURCE_EMAIL, SOURCE_API_TOKEN
)
List<Map> sourceObjectTypes = extractList(
    otListRaw, 'objectTypes', 'values', 'objecttypes'
)
logger.info "Source object types found: ${sourceObjectTypes.size()}"

// Pre-load existing object types from the TARGET schema
Object tgtOtListRaw = assetsGet(
    "${ASSETS_API}/${targetWsId}/v1/objectschema/${targetSchemaId}/objecttypes/flat",
    TARGET_EMAIL, TARGET_API_TOKEN
)
List<Map> existingTargetOts = extractList(
    tgtOtListRaw, 'objectTypes', 'values', 'objecttypes'
)

// Build ID-keyed lookup maps for path computation
Map<String, Map> srcOtById = [:]
sourceObjectTypes.each { Map sot -> srcOtById[sot.get('id') as String] = sot }

Map<String, Map> tgtOtById = [:]
existingTargetOts.each { Map eot -> tgtOtById[eot.get('id') as String] = eot }

// hierarchical path → full OT map (for comparison and update).
Map<String, Map> existingTargetOtByPath = [:]
existingTargetOts.each { Map eot ->
    String path = getOtPath(eot.get('id') as String, tgtOtById)
    existingTargetOtByPath[path] = eot
}

// FIX: also build a name → list-of-OT map for collision recovery.
Map<String, List<Map>> existingTargetOtsByName = [:]
existingTargetOts.each { Map eot ->
    String name = eot.get('name') as String ?: ''
    if (!existingTargetOtsByName.containsKey(name)) {
        existingTargetOtsByName[name] = []
    }
    existingTargetOtsByName[name] << eot
}

logger.info "Existing target object types: ${existingTargetOts.size()}"

// Track which target OT IDs were matched (for orphan detection)
Set<String> matchedTgtOtIds = [] as Set<String>

// Map: source object type ID → target object type ID
Map<String, String> objectTypeIdMap = [:]

int otCreated = 0
int otUpdated = 0

List<Map> sortedObjectTypes = topoSort(sourceObjectTypes)

sortedObjectTypes.each { Map ot ->
    String srcOtId = ot.get('id') as String
    String otName  = ot.get('name') as String

    String srcOtPath = getOtPath(srcOtId, srcOtById)

    if (existingTargetOtByPath.containsKey(srcOtPath)) {
        Map existingTgtOt  = existingTargetOtByPath.get(srcOtPath)
        String existingId  = existingTgtOt.get('id') as String
        objectTypeIdMap[srcOtId] = existingId
        matchedTgtOtIds << existingId

        if (UPDATE_EXISTING) {
            String srcDesc  = ot.get('description') as String ?: ''
            String tgtDesc  = existingTgtOt.get('description') as String ?: ''
            String srcIcon  = resolveIconId(extractIconId(ot), iconIdMap)
            String tgtIcon  = extractIconId(existingTgtOt)

            logger.info "  Icon check '${otName}': " +
                "srcIcon=${srcIcon ?: '(unmapped)'}, tgtIcon=${tgtIcon}, " +
                "descChanged=${srcDesc != tgtDesc}, " +
                "iconChanged=${srcIcon && srcIcon != tgtIcon}"

            boolean iconChanged = srcIcon && srcIcon != tgtIcon
            if (srcDesc != tgtDesc || iconChanged) {
                Map updateOtBody = [
                    name          : otName,
                    description   : srcDesc,
                    objectSchemaId: targetSchemaId
                ]
                if (iconChanged) updateOtBody['iconId'] = srcIcon
                try {
                    assetsPut(
                        "${ASSETS_API}/${targetWsId}/v1/objecttype/${existingId}",
                        TARGET_EMAIL, TARGET_API_TOKEN,
                        updateOtBody
                    )
                    otUpdated++
                    logger.info "  Updated '${srcOtPath}': src=${srcOtId} → tgt=${existingId}"
                } catch (AssertionError e) {
                    logger.warn "  Failed to update object type '${srcOtPath}': ${e.message}"
                }
            } else {
                logger.info "  Unchanged '${srcOtPath}': src=${srcOtId} → tgt=${existingId}"
            }
        } else {
            logger.info "  Skipped (exists) '${srcOtPath}': src=${srcOtId} → tgt=${existingId}"
        }
        return
    }

    // ── Create new object type ────────────────────────────────────────────────
    String  srcParentId = ot.get('parentObjectTypeId') as String
    boolean isRoot      = !srcParentId || srcParentId == '0' || srcParentId == 'null'

    String createIconId = resolveIconId(extractIconId(ot), iconIdMap)
    if (!createIconId && defaultFallbackIconId) {
        createIconId = defaultFallbackIconId
        logger.warn "  '${otName}': icon unresolved — using fallback icon ${defaultFallbackIconId}"
    }

    Map createOtBody = [
        name          : otName,
        description   : ot.get('description') ?: '',
        objectSchemaId: targetSchemaId
    ]
    if (createIconId) createOtBody['iconId'] = createIconId

    if (!isRoot) {
        String tgtParentId = objectTypeIdMap.get(srcParentId)
        if (tgtParentId) createOtBody['parentObjectTypeId'] = tgtParentId
    }

    try {
        Map createdOt  = assetsPost(
            "${ASSETS_API}/${targetWsId}/v1/objecttype/create",
            TARGET_EMAIL, TARGET_API_TOKEN, createOtBody
        )
        String tgtOtId = createdOt.get('id') as String
        objectTypeIdMap[srcOtId] = tgtOtId
        matchedTgtOtIds << tgtOtId
        // Register in tgtOtById so child OTs can compute their path correctly
        tgtOtById[tgtOtId] = createdOt
        otCreated++
        logger.info "  Created '${otName}': src=${srcOtId} → tgt=${tgtOtId}"

    } catch (AssertionError e) {
        String errMsg = e.message as String ?: ''

        if (errMsg.contains('Name has to be unique')) {
            List<Map> nameMatches = existingTargetOtsByName.get(otName) as List<Map>
            if (nameMatches && !nameMatches.isEmpty()) {
                Map candidate = nameMatches.find { Map c ->
                    !matchedTgtOtIds.contains(c.get('id') as String)
                } as Map ?: nameMatches.first() as Map

                String reuseId = candidate.get('id') as String
                objectTypeIdMap[srcOtId] = reuseId
                matchedTgtOtIds << reuseId
                tgtOtById[reuseId] = candidate
                logger.warn "  ⚠️  Name collision for '${otName}' — reusing existing " +
                    "target OT id=${reuseId} (hierarchy may differ). " +
                    "Consider deleting the orphan OT in the target and re-running."
            } else {
                logger.warn "  Failed to create '${otName}' (name collision) and no " +
                    "existing OT found by that name — skipping: ${errMsg}"
            }
        } else {
            logger.warn "  Failed to create object type '${otName}': ${errMsg}"
        }
    }
}

// ── Report orphan object types ────────────────────────────────────────────────
List<String> orphanOtNames = []
if (REPORT_ORPHANS) {
    existingTargetOts.each { Map tgtOt ->
        String tgtOtId   = tgtOt.get('id') as String
        if (!matchedTgtOtIds.contains(tgtOtId)) {
            String tgtOtPath = getOtPath(tgtOtId, tgtOtById)
            orphanOtNames << tgtOtPath
            logger.info "  ⚠️  ORPHAN object type in target (not in source): " +
                "'${tgtOtPath}' (id=${tgtOtId})"
        }
    }
}

logger.info "Object type sync: created=${otCreated}, updated=${otUpdated}, " +
    "orphans=${orphanOtNames.size()}"

// =============================================================================
// STEP 5 — Sync attributes for each object type
// =============================================================================
logger.info '=== STEP 5: Syncing attributes ==='

Map<String, String>  crossSchemaOtIdMap    = [:]
Map<String, Map>     crossSchemaSchemaInfo = [:]
Map<String, Map>     crossSchemaAttrReport = [:]

Map<String, String> srcSchemaNameById = [:]
sourceSchemas.each { Map s ->
    srcSchemaNameById[s.get('id') as String] = s.get('name') as String
}

Map<String, String> tgtSchemaIdByName = [:]
targetSchemas.each { Map s ->
    tgtSchemaIdByName[s.get('name') as String] = s.get('id') as String
}

Closure resolveCrossSchemaOtId = { String srcOtId ->
    if (crossSchemaOtIdMap.containsKey(srcOtId)) {
        return crossSchemaOtIdMap.get(srcOtId)
    }
    try {
        Map srcOtDetail = assetsGet(
            "${ASSETS_API}/${sourceWsId}/v1/objecttype/${srcOtId}",
            SOURCE_EMAIL, SOURCE_API_TOKEN
        ) as Map
        String srcOtSchemaId = srcOtDetail.get('objectSchemaId') as String
        String srcOtName     = srcOtDetail.get('name') as String

        String srcSchemaName = srcSchemaNameById.get(srcOtSchemaId) ?: srcOtSchemaId

        if (!crossSchemaSchemaInfo.containsKey(srcOtSchemaId)) {
            String tgtSchemaId = tgtSchemaIdByName.get(srcSchemaName)
            crossSchemaSchemaInfo[srcOtSchemaId] = [
                name        : srcSchemaName,
                targetSchemaId: tgtSchemaId,
                present     : (tgtSchemaId != null)
            ]
            String status = tgtSchemaId ? "PRESENT (tgt id=${tgtSchemaId})" : "ABSENT"
            logger.info "  Cross-schema: source schema '${srcSchemaName}' → ${status}"
        }

        Map schemaInfo    = crossSchemaSchemaInfo.get(srcOtSchemaId) as Map
        String tgtSchemaId = schemaInfo.get('targetSchemaId') as String

        if (!tgtSchemaId) {
            crossSchemaOtIdMap[srcOtId] = null
            return null
        }

        Object tgtOtListForSchema = assetsGet(
            "${ASSETS_API}/${targetWsId}/v1/objectschema/${tgtSchemaId}/objecttypes/flat",
            TARGET_EMAIL, TARGET_API_TOKEN
        )
        List<Map> tgtOtsForSchema = extractList(
            tgtOtListForSchema, 'objectTypes', 'values', 'objecttypes'
        )
        Map matchingTgtOt = tgtOtsForSchema.find { Map t ->
            (t.get('name') as String) == srcOtName
        } as Map

        String tgtOtId = matchingTgtOt?.get('id') as String
        crossSchemaOtIdMap[srcOtId] = tgtOtId
        if (tgtOtId) {
            logger.info "  Cross-schema OT resolved: src=${srcOtId} '${srcOtName}' " +
                "→ tgt=${tgtOtId} (schema '${srcSchemaName}')"
        } else {
            logger.warn "  Cross-schema OT '${srcOtName}' not found in target schema " +
                "'${srcSchemaName}' — attribute will be skipped"
        }
        return tgtOtId

    } catch (Throwable ex) {
        logger.warn "  Could not resolve cross-schema OT ${srcOtId}: ${ex.message}"
        crossSchemaOtIdMap[srcOtId] = null
        return null
    }
}

// Map: source attribute ID → target attribute ID
Map<String, String> attributeIdMap = [:]

// Map: target object type ID → target label attribute ID
Map<String, String> labelAttrIdByTgtOtId = [:]

int attrCreated = 0
int attrUpdated = 0
List<String> orphanAttrReport = []

sortedObjectTypes.each { Map ot ->
    String srcOtId = ot.get('id') as String
    String tgtOtId = objectTypeIdMap.get(srcOtId)
    if (!tgtOtId) {
        logger.warn "  Skipping attributes for '${ot.get('name')}' — no target OT ID"
        return
    }

    // --- Fetch source attributes ---
    Object srcAttrRaw = assetsGet(
        "${ASSETS_API}/${sourceWsId}/v1/objecttype/${srcOtId}/attributes",
        SOURCE_EMAIL, SOURCE_API_TOKEN
    )
    List<Map> srcAttributes = extractList(srcAttrRaw, 'values', 'objectTypeAttributes')

    // --- Fetch target attributes ---
    Object tgtAttrRaw = assetsGet(
        "${ASSETS_API}/${targetWsId}/v1/objecttype/${tgtOtId}/attributes",
        TARGET_EMAIL, TARGET_API_TOKEN
    )
    List<Map> tgtAttributes = extractList(tgtAttrRaw, 'values', 'objectTypeAttributes')

    Map<String, Map>    tgtAttrByName     = [:]
    Map<String, String> tgtAttrIdByName   = [:]
    Set<String>         matchedTgtAttrIds = [] as Set<String>

    tgtAttributes.each { Map tgtAttr ->
        String  tgtAttrName = tgtAttr.get('name') as String
        String  tgtAttrId   = tgtAttr.get('id') as String
        boolean isLabel     = tgtAttr.get('label') instanceof Boolean &&
            (tgtAttr.get('label') as Boolean)
        tgtAttrByName[tgtAttrName]   = tgtAttr
        tgtAttrIdByName[tgtAttrName] = tgtAttrId
        if (isLabel) labelAttrIdByTgtOtId[tgtOtId] = tgtAttrId
    }

    List<Map> sysAttributes  = srcAttributes.findAll { Map attr ->
        def f = attr.get('system'); f instanceof Boolean && (f as Boolean)
    }
    List<Map> userAttributes = srcAttributes.findAll { Map attr ->
        def f = attr.get('system'); !(f instanceof Boolean && (f as Boolean))
    }

    logger.info "  '${ot.get('name')}': ${userAttributes.size()} user attr(s), " +
        "${sysAttributes.size()} system attr(s)"

    // --- Sync user-defined attributes ---
    userAttributes.each { Map attr ->
        String srcAttrId = attr.get('id') as String
        String attrName  = attr.get('name') as String
        int    attrType  = (attr.get('type') as Integer) ?: 0

        if (tgtAttrByName.containsKey(attrName)) {
            Map    existingTgtAttr   = tgtAttrByName.get(attrName)
            String existingTgtAttrId = existingTgtAttr.get('id') as String
            attributeIdMap[srcAttrId] = existingTgtAttrId
            matchedTgtAttrIds << existingTgtAttrId

            if (UPDATE_EXISTING) {
                boolean needsUpdate = false

                int tgtType = (existingTgtAttr.get('type') as Integer) ?: 0
                if (attrType != tgtType) needsUpdate = true

                int srcMinCard = (attr.get('minimumCardinality') instanceof Number)
                    ? (attr.get('minimumCardinality') as Number).intValue() : 0
                int tgtMinCard = (existingTgtAttr.get('minimumCardinality') instanceof Number)
                    ? (existingTgtAttr.get('minimumCardinality') as Number).intValue() : 0
                if (srcMinCard != tgtMinCard) needsUpdate = true

                int srcMaxCard = (attr.get('maximumCardinality') instanceof Number)
                    ? (attr.get('maximumCardinality') as Number).intValue() : 1
                int tgtMaxCard = (existingTgtAttr.get('maximumCardinality') instanceof Number)
                    ? (existingTgtAttr.get('maximumCardinality') as Number).intValue() : 1
                if (srcMaxCard != tgtMaxCard) needsUpdate = true

                String srcDesc  = attr.get('description') as String ?: ''
                String tgtDesc  = existingTgtAttr.get('description') as String ?: ''
                if (srcDesc != tgtDesc) needsUpdate = true

                String srcRegex = attr.get('regexValidation') as String ?: ''
                String tgtRegex = existingTgtAttr.get('regexValidation') as String ?: ''
                if (srcRegex != tgtRegex) needsUpdate = true

                if (attrType == 0) {
                    int srcDtId = 0
                    if (attr.get('defaultType') instanceof Map) {
                        def rawId = (attr.get('defaultType') as Map).get('id')
                        if (rawId instanceof Number) srcDtId = (rawId as Number).intValue()
                    }
                    int tgtDtId = 0
                    if (existingTgtAttr.get('defaultType') instanceof Map) {
                        def rawId = (existingTgtAttr.get('defaultType') as Map).get('id')
                        if (rawId instanceof Number) tgtDtId = (rawId as Number).intValue()
                    }
                    if (srcDtId != tgtDtId) needsUpdate = true
                }

                if (needsUpdate) {
                    Map updateBody = [
                        name              : attrName,
                        label             : false,
                        type              : attrType,
                        minimumCardinality: srcMinCard,
                        maximumCardinality: srcMaxCard,
                        hidden            : safeBool(attr.get('hidden'), false),
                        uniqueAttribute   : safeBool(attr.get('uniqueAttribute'), false),
                    ]
                    if (srcDesc)  updateBody['description']     = srcDesc
                    if (srcRegex) updateBody['regexValidation'] = srcRegex

                    if (attrType == 0) {
                        int dtId = 0
                        if (attr.get('defaultType') instanceof Map) {
                            def rawId = (attr.get('defaultType') as Map).get('id')
                            if (rawId instanceof Number) dtId = (rawId as Number).intValue()
                        }
                        updateBody['defaultTypeId'] = dtId
                        if (dtId == 1 || dtId == 3) {
                            updateBody['summable'] = safeBool(attr.get('summable'), false)
                            String sfx = attr.get('suffix') as String
                            if (sfx) updateBody['suffix'] = sfx
                        }
                        if (dtId == 7 || dtId == 10) {
                            String addVal = attr.get('additionalValue') as String
                            if (addVal) updateBody['additionalValue'] = addVal
                        }
                    } else if (attrType == 1) {
                        String srcRefOtId = attr.get('typeValue') as String
                        if (!srcRefOtId || srcRefOtId == 'null') {
                            srcRefOtId = attr.get('typeValueMulti') as String
                        }
                        if (!srcRefOtId || srcRefOtId == 'null') {
                            Map refOtMap = attr.get('referenceObjectType') as Map
                            if (refOtMap) srcRefOtId = refOtMap.get('id') as String
                        }
                        String tgtRefOtId = srcRefOtId ? objectTypeIdMap.get(srcRefOtId) : null
                        if (!tgtRefOtId && srcRefOtId) {
                            tgtRefOtId = resolveCrossSchemaOtId(srcRefOtId) as String
                            if (tgtRefOtId) {
                                String csSchemaName = (crossSchemaSchemaInfo.values()
                                    .find { (it as Map).get('targetSchemaId') != null } as Map)
                                    ?.get('name') as String ?: 'unknown'
                                if (!crossSchemaAttrReport.containsKey(csSchemaName)) {
                                    crossSchemaAttrReport[csSchemaName] = [present: true, attrs: []]
                                }
                                (crossSchemaAttrReport[csSchemaName].attrs as List) << attrName
                            }
                        }
                        if (tgtRefOtId) {
                            try {
                                updateBody['typeValue'] = Integer.parseInt(tgtRefOtId)
                            } catch (NumberFormatException ignored) {
                                updateBody['typeValue'] = tgtRefOtId
                            }
                        } else {
                            if (srcRefOtId) {
                                String csSchemaName = crossSchemaSchemaInfo.values()
                                    .findAll { !(it as Map).get('present') }
                                    .collect { (it as Map).get('name') as String }
                                    .find { true } ?: 'unknown'
                                if (!crossSchemaAttrReport.containsKey(csSchemaName)) {
                                    crossSchemaAttrReport[csSchemaName] = [present: false, attrs: []]
                                }
                                (crossSchemaAttrReport[csSchemaName].attrs as List) << attrName
                            }
                            logger.warn "    '${attrName}': ref OT '${srcRefOtId}' not resolvable — skipping update"
                            return
                        }
                        updateBody['includeChildObjectTypes'] =
                            safeBool(attr.get('includeChildObjectTypes'), false)
                        String addVal = attr.get('additionalValue') as String
                        if (addVal) updateBody['additionalValue'] = addVal
                    }

                    try {
                        assetsPut(
                            "${ASSETS_API}/${targetWsId}/v1/objecttypeattribute/${existingTgtAttrId}",
                            TARGET_EMAIL, TARGET_API_TOKEN, updateBody
                        )
                        attrUpdated++
                        logger.info "    [user] Updated '${attrName}': tgt=${existingTgtAttrId}"
                    } catch (AssertionError e) {
                        logger.warn "    Failed to update '${attrName}': ${e.message}"
                    }
                } else {
                    logger.info "    [user] Unchanged '${attrName}': tgt=${existingTgtAttrId}"
                }
            } else {
                logger.info "    [user] Skipped (exists) '${attrName}': tgt=${existingTgtAttrId}"
            }
            return
        }

        // ── Create new attribute ──────────────────────────────────────────────
        Map createAttrBody = [
            name              : attrName,
            label             : false,
            type              : attrType,
            minimumCardinality: (attr.get('minimumCardinality') instanceof Number)
                ? (attr.get('minimumCardinality') as Number).intValue() : 0,
            maximumCardinality: (attr.get('maximumCardinality') instanceof Number)
                ? (attr.get('maximumCardinality') as Number).intValue() : 1,
            hidden            : safeBool(attr.get('hidden'), false),
            uniqueAttribute   : safeBool(attr.get('uniqueAttribute'), false),
        ]

        String attrDesc  = attr.get('description') as String
        String attrRegex = attr.get('regexValidation') as String
        if (attrDesc)  createAttrBody['description']     = attrDesc
        if (attrRegex) createAttrBody['regexValidation'] = attrRegex

        if (attrType == 0) {
            int dtId = 0
            if (attr.get('defaultType') instanceof Map) {
                def rawId = (attr.get('defaultType') as Map).get('id')
                if (rawId instanceof Number) dtId = (rawId as Number).intValue()
            }
            createAttrBody['defaultTypeId'] = dtId
            if (dtId == 1 || dtId == 3) {
                createAttrBody['summable'] = safeBool(attr.get('summable'), false)
                String sfx = attr.get('suffix') as String
                if (sfx) createAttrBody['suffix'] = sfx
            }
            if (dtId == 7 || dtId == 10) {
                String addVal = attr.get('additionalValue') as String
                if (addVal) createAttrBody['additionalValue'] = addVal
            }
        } else if (attrType == 1) {
            String srcRefOtId = attr.get('typeValue') as String
            if (!srcRefOtId || srcRefOtId == 'null') {
                srcRefOtId = attr.get('typeValueMulti') as String
            }
            if (!srcRefOtId || srcRefOtId == 'null') {
                Map refOtMap = attr.get('referenceObjectType') as Map
                if (refOtMap) srcRefOtId = refOtMap.get('id') as String
            }

            String tgtRefOtId = srcRefOtId ? objectTypeIdMap.get(srcRefOtId) : null
            if (!tgtRefOtId && srcRefOtId) {
                tgtRefOtId = resolveCrossSchemaOtId(srcRefOtId) as String
            }

            if (tgtRefOtId) {
                try {
                    createAttrBody['typeValue'] = Integer.parseInt(tgtRefOtId)
                } catch (NumberFormatException ignored) {
                    createAttrBody['typeValue'] = tgtRefOtId
                }
                if (!objectTypeIdMap.containsKey(srcRefOtId)) {
                    String csSchemaId = crossSchemaSchemaInfo.find { k, v ->
                        crossSchemaOtIdMap.any { oid, tid ->
                            oid == srcRefOtId && tid == tgtRefOtId
                        }
                    }?.key as String
                    String csSchemaName = csSchemaId
                        ? (crossSchemaSchemaInfo.get(csSchemaId) as Map)?.get('name') as String
                        : 'unknown'
                    if (csSchemaName) {
                        if (!crossSchemaAttrReport.containsKey(csSchemaName)) {
                            crossSchemaAttrReport[csSchemaName] = [present: true, attrs: []]
                        }
                        (crossSchemaAttrReport[csSchemaName].attrs as List) << attrName
                    }
                }
            } else {
                if (srcRefOtId) {
                    String csSchemaName = 'unknown'
                    crossSchemaSchemaInfo.each { String schId, Map info ->
                        if (!(info.get('present') as boolean)) {
                            csSchemaName = info.get('name') as String ?: 'unknown'
                        }
                    }
                    if (crossSchemaOtIdMap.containsKey(srcRefOtId)) {
                        crossSchemaSchemaInfo.each { String schId, Map info ->
                            if (!(info.get('present') as boolean)) {
                                csSchemaName = info.get('name') as String ?: csSchemaName
                            }
                        }
                    }
                    if (!crossSchemaAttrReport.containsKey(csSchemaName)) {
                        crossSchemaAttrReport[csSchemaName] = [present: false, attrs: []]
                    }
                    (crossSchemaAttrReport[csSchemaName].attrs as List) << attrName
                }
                logger.warn "    '${attrName}': ref OT '${srcRefOtId}' not resolvable " +
                    "(schema absent in target) — skipping attribute"
                return
            }
            createAttrBody['includeChildObjectTypes'] =
                safeBool(attr.get('includeChildObjectTypes'), false)
            String addVal = attr.get('additionalValue') as String
            if (addVal) createAttrBody['additionalValue'] = addVal
        }

        try {
            Map createdAttr  = assetsPost(
                "${ASSETS_API}/${targetWsId}/v1/objecttypeattribute/${tgtOtId}",
                TARGET_EMAIL, TARGET_API_TOKEN, createAttrBody
            )
            String tgtAttrId = createdAttr.get('id') as String
            attributeIdMap[srcAttrId] = tgtAttrId
            matchedTgtAttrIds << tgtAttrId
            attrCreated++
            logger.info "    [user] Created '${attrName}': src=${srcAttrId} → tgt=${tgtAttrId}"
        } catch (AssertionError e) {
            logger.warn "    Failed to create '${attrName}' [type=${attrType}]: ${e.message}"
            logger.warn "    Payload: ${createAttrBody}"
        }
    }

    // --- Map system attributes by name (source ID → target ID) ---
    sysAttributes.each { Map sysAttr ->
        String srcAttrId = sysAttr.get('id') as String
        String attrName  = sysAttr.get('name') as String
        String tgtAttrId = tgtAttrIdByName.get(attrName)
        if (tgtAttrId) {
            attributeIdMap[srcAttrId] = tgtAttrId
            matchedTgtAttrIds << tgtAttrId
            logger.info "    [sys]  '${attrName}': src=${srcAttrId} → tgt=${tgtAttrId}"
        } else {
            logger.warn "    [sys]  '${attrName}': not found in target — values will be skipped"
        }
    }

    // --- Report orphan attributes for this object type ---
    if (REPORT_ORPHANS) {
        tgtAttributes.each { Map tgtAttr ->
            String tgtAttrId = tgtAttr.get('id') as String
            if (!matchedTgtAttrIds.contains(tgtAttrId)) {
                String orphanName = tgtAttr.get('name') as String
                orphanAttrReport << "'${ot.get('name')}' → '${orphanName}' (id=${tgtAttrId})"
                logger.info "    ⚠️  ORPHAN attribute in target: '${orphanName}' (id=${tgtAttrId})"
            }
        }
    }
}

logger.info "Attribute sync: created=${attrCreated}, updated=${attrUpdated}, " +
    "orphans=${orphanAttrReport.size()}"

if (!crossSchemaSchemaInfo.isEmpty()) {
    logger.info "Cross-schema reference summary:"
    crossSchemaSchemaInfo.each { String schId, Map info ->
        String status = info.get('present') ? '✅ PRESENT' : '❌ ABSENT'
        logger.info "  ${status} — '${info.get('name')}'"
    }
}

// =============================================================================
// HELPER: look up a Jira group by name in the TARGET instance.
//
// Group attribute values store the group name as a string. The same group may
// exist in the target with different casing (e.g. "org-admins" vs "Org-Admins")
// or may not exist at all. This helper queries the Jira groups/picker endpoint
// to find the best match:
//   1. Exact match  → use as-is
//   2. Case-insensitive match → use the target's canonical name
//   3. No match → return null (caller will skip the value)
//
// Results are cached in groupNameCache to avoid repeated API calls for the
// same group name across multiple objects.
// =============================================================================
String resolveGroupInTarget(
    String groupName,
    String tgtBaseUrl,
    String tgtEmail,
    String tgtToken,
    Map<String, String> cache
) {
    if (!groupName) return null
    // Cache key uses the original name; null value means "not found"
    if (cache.containsKey(groupName)) return cache.get(groupName)

    try {
        def resp = get("${tgtBaseUrl}/rest/api/3/groups/picker")
            .header('Accept', 'application/json')
            .basicAuth(tgtEmail, tgtToken)
            .queryString('query', groupName)
            .queryString('maxResults', '20')
            .asString()

        if (resp.status != 200) {
            logger.warn "  Group lookup failed [${resp.status}] for '${groupName}'"
            cache[groupName] = null
            return null
        }

        Map parsed = new groovy.json.JsonSlurper()
            .parseText(resp.body as String) as Map
        List<Map> groups = (parsed.get('groups') as List ?: []).collect { it as Map }

        // Priority 1: exact match
        Map exact = groups.find { Map g ->
            (g.get('name') as String) == groupName
        } as Map
        if (exact) {
            String resolved = exact.get('name') as String
            cache[groupName] = resolved
            logger.info "  Group '${groupName}' → exact match in target"
            return resolved
        }

        // Priority 2: case-insensitive match
        Map ci = groups.find { Map g ->
            (g.get('name') as String)?.equalsIgnoreCase(groupName)
        } as Map
        if (ci) {
            String resolved = ci.get('name') as String
            cache[groupName] = resolved
            logger.info "  Group '${groupName}' → resolved to '${resolved}' " +
                "(case-insensitive match) in target"
            return resolved
        }

        logger.warn "  Group '${groupName}' not found in target Jira instance — " +
            "this attribute value will be skipped. " +
            "Create the group in the target or add a manual mapping."
        cache[groupName] = null
        return null

    } catch (Throwable ex) {
        logger.warn "  Could not look up group '${groupName}': ${ex.message}"
        cache[groupName] = null
        return null
    }
}

// =============================================================================
// HELPER: build the objectAttributeValues payload for a single source
// attribute entry. Returns an empty list when there is nothing to send.
//
// FIX (v35): objectTypeAttributeId MUST be sent as an Integer, not a String.
// The Assets API silently ignores attribute values when the ID is a String.
//
// FIX (v36): Status and Group attributes store their value with a
// referencedObject whose ID points to a status/group object — NOT a regular
// Assets object. The old code tried to look that ID up in objectIdMap, found
// nothing, and silently dropped the value. The correct behaviour is:
//   1. If referencedObject.id IS in objectIdMap → use the mapped target ID
//      (regular Assets object cross-reference).
//   2. If referencedObject.id is NOT in objectIdMap → use referencedObject.label
//      as the plain string value. The Assets API accepts the status name /
//      group name as a string for Status and Group attribute types.
//   3. If there is no referencedObject → use the 'value' field directly,
//      falling back to 'searchValue' when 'value' is null.
// =============================================================================
List<Map> buildAttrValuePayload(
    Map    srcAttr,
    String tgtAttrId,
    Map<String, String> objectIdMap,
    String srcObjId,
    String label,
    String tgtBaseUrl,
    String tgtEmail,
    String tgtToken,
    Map<String, String> groupCache
) {
    Map    otAttr   = srcAttr.get('objectTypeAttribute') as Map
    String attrName = otAttr?.get('name') as String ?: tgtAttrId
    // Assets attribute type: 0=Default, 1=Object, 2=User, 3=Confluence,
    //                        4=Group, 5=Version, 6=Project, 7=Status
    int    attrType = (otAttr?.get('type') instanceof Number)
        ? (otAttr.get('type') as Number).intValue() : 0

    List<Map> rawVals = (srcAttr.get('objectAttributeValues') as List ?: [])
        .collect { it as Map }

    // Log raw values so we can see exactly what the source is returning
    if (!rawVals.isEmpty()) {
        rawVals.each { Map v ->
            Map refObj = v.get('referencedObject') as Map
            logger.info "    [obj ${srcObjId}] attr '${attrName}' raw value: " +
                "value='${v.get('value')}', " +
                "searchValue='${v.get('searchValue')}', " +
                "referencedObject=${refObj ? '[id=' + refObj.get('id') + ', label=' + refObj.get('label') + ']' : 'null'}"
        }
    } else {
        logger.info "    [obj ${srcObjId}] attr '${attrName}' has no values in source"
        return []
    }

    List<Map> mappedVals = rawVals.collect { Map v ->
        Map refObj = v.get('referencedObject') as Map
        if (refObj) {
            String srcRefId = refObj.get('id') as String

            // Case 1: regular Assets object reference — map to target object ID
            String tgtRefId = objectIdMap.get(srcRefId)
            if (tgtRefId) {
                logger.info "    [obj ${srcObjId}] attr '${attrName}': " +
                    "mapped object ref ${srcRefId} → ${tgtRefId}"
                return [value: tgtRefId] as Map
            }

            // Case 2: Status / Group / special type — use the label as the
            // plain string value. The Assets API accepts the status name or
            // group name directly as a string for these attribute types.
            String refLabel = refObj.get('label') as String
            if (refLabel) {
                logger.info "    [obj ${srcObjId}] attr '${attrName}': " +
                    "ref object ${srcRefId} not in objectIdMap — " +
                    "using label '${refLabel}' as string value " +
                    "(Status / Group / special type)"
                return [value: refLabel] as Map
            }

            // Case 3: referencedObject present but no label — fall through to
            // the plain value field below
            logger.warn "    [obj ${srcObjId}] attr '${attrName}': " +
                "ref object ${srcRefId} has no label — trying plain value field"
        }

        // Plain value — use 'value' field; fall back to 'searchValue' when
        // 'value' is null (Group and Status attributes store null in 'value').
        String rawVal = v.get('value') as String
        if (!rawVal) rawVal = v.get('searchValue') as String
        if (!rawVal) {
            logger.warn "    [obj ${srcObjId}] attr '${attrName}': " +
                "no usable value found in source entry — skipping"
            return null
        }

        // FIX (v40): For Group type attributes (type=4), look up the group in
        // the target Jira instance before sending. This handles:
        //   • Case differences: "org-admins" → "Org-Admins"
        //   • Missing groups: logs a clear warning and skips the value so the
        //     rest of the object (Date, Status, etc.) is still synced correctly
        if (attrType == 4) {
            String resolved = resolveGroupInTarget(
                rawVal, tgtBaseUrl, tgtEmail, tgtToken, groupCache
            )
            if (resolved) {
                if (resolved != rawVal) {
                    logger.info "    [obj ${srcObjId}] attr '${attrName}': " +
                        "group '${rawVal}' → '${resolved}'"
                }
                return [value: resolved] as Map
            }
            // Group not found — skip this value; the retry loop will not be
            // needed since we never send an invalid group name
            return null
        }

        return [value: rawVal] as Map
    }.findAll { it != null } as List<Map>

    return mappedVals
}

// =============================================================================
// STEP 6 — Sync objects (if enabled)
// =============================================================================
// Declared at script scope so Step 7 validation can reference it regardless
// of whether COPY_OBJECTS is true or false.
Map<String, String> objectIdMap = [:]

// Cache for group name lookups: source group name → resolved target name
// (null = group not found in target). Shared across all objects to avoid
// repeated API calls for the same group.
Map<String, String> groupNameCache = [:]

if (COPY_OBJECTS) {
    logger.info '=== STEP 6: Syncing objects ==='

    logger.info '  Pre-loading existing target objects (with attributes) for sync...'

    Map<String, List<Map>> targetObjectQueue = [:]

    int     tgtStartAt = 0
    int     tgtPageNum = 0
    boolean tgtIsLast  = false

    while (!tgtIsLast && tgtPageNum < 2000) {
        String tgtAqlUrl = "${ASSETS_API}/${targetWsId}/v1/object/aql" +
            "?startAt=${tgtStartAt}&maxResults=${OBJECT_PAGE_SIZE}"
        Map tgtAqlResp = assetsPost(
            tgtAqlUrl,
            TARGET_EMAIL, TARGET_API_TOKEN,
            [qlQuery: "\"objectSchemaId\" = \"${targetSchemaId}\"",
             includeAttributes: true]
        )
        List<Map> tgtObjs = (tgtAqlResp.get('values') as List ?: []).collect { it as Map }
        tgtIsLast   = safeBool(tgtAqlResp.get('isLast'), false)
        tgtStartAt += tgtObjs.size()
        tgtPageNum++

        if (tgtObjs.isEmpty()) break

        tgtObjs.each { Map tgtObj ->
            Map    tgtObjType = tgtObj.get('objectType') as Map
            String tgtOtId    = tgtObjType?.get('id') as String
            String tgtLabel   = tgtObj.get('label') as String
            if (tgtOtId && tgtLabel) {
                String qKey = "${tgtOtId}:${tgtLabel}"
                if (!targetObjectQueue.containsKey(qKey)) {
                    targetObjectQueue[qKey] = [] as List<Map>
                }
                (targetObjectQueue[qKey] as List<Map>) << tgtObj
            }
        }

        logger.info "  Target pre-load page ${tgtPageNum}: ${tgtObjs.size()} fetched | " +
            "startAt: ${tgtStartAt} | isLast: ${tgtIsLast}"
    }

    int preloadedCount = targetObjectQueue.values().collect { it.size() }.sum(0) as int
    logger.info "  Pre-loaded ${preloadedCount} target object(s) across " +
        "${targetObjectQueue.size()} distinct label/type combinations"

    int     startAt   = OBJECT_START_AT
    int     pageNum   = 0
    int     created   = 0
    int     updated   = 0
    int     unchanged = 0
    int     skipped   = 0
    boolean batchFull = false
    boolean srcIsLast = false

    while (!srcIsLast && !batchFull && pageNum < 2000) {
        String srcAqlUrl = "${ASSETS_API}/${sourceWsId}/v1/object/aql" +
            "?startAt=${startAt}&maxResults=${OBJECT_PAGE_SIZE}"
        Map aqlResp = assetsPost(
            srcAqlUrl,
            SOURCE_EMAIL, SOURCE_API_TOKEN,
            [qlQuery: "\"objectSchemaId\" = \"${sourceSchemaId}\"",
             includeAttributes: true]
        )

        List<Map> objects = (aqlResp.get('values') as List ?: []).collect { it as Map }
        srcIsLast  = safeBool(aqlResp.get('isLast'), false)
        startAt   += objects.size()
        pageNum++

        if (objects.isEmpty()) break

        objects.each { Map obj ->
            if (batchFull) return

            String srcObjId = obj.get('id') as String
            String label    = obj.get('label') as String

            if (objectIdMap.containsKey(srcObjId)) return

            Map    srcObjType = obj.get('objectType') as Map
            String srcOtId    = srcObjType?.get('id') as String
            String tgtOtId    = objectTypeIdMap.get(srcOtId)

            if (!tgtOtId) {
                logger.warn "  Object ${srcObjId} '${label}': no target type for " +
                    "src type ${srcOtId} — skipping"
                skipped++
                return
            }

            // ── Fetch the full source object individually ─────────────────────
            // FIX (v37): The AQL endpoint with includeAttributes:true silently
            // omits certain attribute types (Date, Group, Status, etc.) from the
            // response — it only reliably returns indexed text/reference attrs.
            // Fetching each source object via GET /v1/object/{id} returns the
            // complete attribute set and is the only reliable way to read all
            // attribute values for migration purposes.
            List<Map> srcAttrs = []
            try {
                Map fullSrcObj = assetsGet(
                    "${ASSETS_API}/${sourceWsId}/v1/object/${srcObjId}",
                    SOURCE_EMAIL, SOURCE_API_TOKEN
                ) as Map
                srcAttrs = (fullSrcObj.get('attributes') as List ?: [])
                    .collect { it as Map }
                logger.info "  [obj ${srcObjId}] '${label}': " +
                    "fetched ${srcAttrs.size()} attribute(s) via individual GET"
                srcAttrs.each { Map a ->
                    Map ota = a.get('objectTypeAttribute') as Map
                    logger.info "    attr '${ota?.get('name')}' (id=${ota?.get('id')}): " +
                        "${(a.get('objectAttributeValues') as List ?: []).size()} value(s)"
                }
            } catch (Throwable fetchEx) {
                logger.warn "  [obj ${srcObjId}] '${label}': individual GET failed " +
                    "(${fetchEx.message}) — falling back to AQL response attributes"
                srcAttrs = (obj.get('attributes') as List ?: []).collect { it as Map }
            }

            // ── Build attribute value payload ─────────────────────────────────
            List<Map> attrValues = []
            int attrValuesSkipped = 0

            srcAttrs.each { Map srcAttr ->
                Map    otAttr    = srcAttr.get('objectTypeAttribute') as Map
                String srcAttrId = otAttr?.get('id') as String
                if (!srcAttrId) return

                String tgtAttrId = attributeIdMap.get(srcAttrId)
                if (!tgtAttrId) {
                    logger.debug "    [obj ${srcObjId}] src attr ${srcAttrId} " +
                        "(${otAttr?.get('name')}) not in attributeIdMap — skipping"
                    return
                }

                List<Map> mappedVals = buildAttrValuePayload(
                    srcAttr, tgtAttrId, objectIdMap, srcObjId, label,
                    TARGET_BASE_URL, TARGET_EMAIL, TARGET_API_TOKEN, groupNameCache
                )

                if (!mappedVals.isEmpty()) {
                    attrValues << [
                        objectTypeAttributeId: toAttrIdInt(tgtAttrId),
                        objectAttributeValues: mappedVals
                    ]
                } else {
                    List<Map> rawVals = (srcAttr.get('objectAttributeValues') as List ?: [])
                        .collect { it as Map }
                    if (!rawVals.isEmpty()) {
                        attrValuesSkipped++
                        logger.info "    [obj ${srcObjId}] attr '${otAttr?.get('name')}' " +
                            "(src=${srcAttrId}→tgt=${tgtAttrId}): " +
                            "${rawVals.size()} source value(s) could not be mapped"
                    }
                }
            }

            // ── Ensure the label attribute is always present ──────────────────
            String labelAttrId = labelAttrIdByTgtOtId.get(tgtOtId)
            if (labelAttrId) {
                int labelAttrIdInt = toAttrIdInt(labelAttrId)
                boolean labelPresent = attrValues.any { Map av ->
                    av.get('objectTypeAttributeId') == labelAttrIdInt
                }
                if (!labelPresent && label) {
                    attrValues << [
                        objectTypeAttributeId: labelAttrIdInt,
                        objectAttributeValues: [[value: label]]
                    ]
                }
            }

            logger.info "  [obj ${srcObjId}] '${label}' (srcOT=${srcOtId}→tgtOT=${tgtOtId}): " +
                "${attrValues.size()} attr(s) to sync, ${attrValuesSkipped} skipped"

            String     queueKey  = "${tgtOtId}:${label}"
            List<Map>  candidates = targetObjectQueue.get(queueKey) as List<Map>
            Map        matchedObj = (candidates != null && !candidates.isEmpty())
                ? candidates.remove(0) as Map
                : null

            if (matchedObj) {
                String tgtObjId = matchedObj.get('id') as String
                objectIdMap[srcObjId] = tgtObjId

                if (UPDATE_EXISTING) {
                    List<Map> tgtAttrs = (matchedObj.get('attributes') as List ?: [])
                        .collect { it as Map }
                    String srcCanonical = canonicalAttrValues(srcAttrs)
                    String tgtCanonical = canonicalAttrValues(tgtAttrs)

                    if (srcCanonical != tgtCanonical) {
                        logger.info "    Updating '${label}' (src=${srcObjId}→tgt=${tgtObjId}): " +
                            "canonical changed"
                        logger.debug "      src: ${srcCanonical}"
                        logger.debug "      tgt: ${tgtCanonical}"

                        // ── Retry loop: remove failing attrs on 400 and retry ─
                        // When one attribute is invalid in the target (e.g. a
                        // Group that doesn't exist), the whole PUT is rejected.
                        // We parse the error, strip the offending attribute(s),
                        // and retry so that valid attrs (Date, Status, etc.)
                        // are still synced.
                        List<Map> retryAttrs = attrValues.collect { it as Map }
                        boolean putOk = false
                        int putRetries = 0
                        while (!putOk && !retryAttrs.isEmpty() && putRetries <= 5) {
                            try {
                                assetsPut(
                                    "${ASSETS_API}/${targetWsId}/v1/object/${tgtObjId}",
                                    TARGET_EMAIL, TARGET_API_TOKEN,
                                    [objectTypeId: Integer.parseInt(tgtOtId),
                                     attributes  : retryAttrs]
                                )
                                putOk = true
                                updated++
                            } catch (AssertionError putErr) {
                                String putErrMsg = putErr.message as String ?: ''
                                Set<Integer> failIds = extractFailingAttrIds(putErrMsg)
                                if (failIds.isEmpty() || !putErrMsg.contains('[400]')) {
                                    logger.warn "  Failed to update object ${srcObjId} " +
                                        "'${label}': ${putErrMsg}"
                                    skipped++
                                    break
                                }
                                failIds.each { int fid ->
                                    logger.warn "  [obj ${srcObjId}] '${label}': " +
                                        "attr id=${fid} rejected by target — " +
                                        "removing and retrying"
                                }
                                retryAttrs = retryAttrs.findAll { Map av ->
                                    !failIds.contains(
                                        av.get('objectTypeAttributeId') as Integer)
                                }
                                putRetries++
                            }
                        }
                        if (!putOk && retryAttrs.isEmpty()) {
                            logger.warn "  [obj ${srcObjId}] '${label}': " +
                                "all attributes rejected — skipping update"
                            skipped++
                        }
                    } else {
                        unchanged++
                        logger.debug "  Unchanged '${label}' (src=${srcObjId} → tgt=${tgtObjId})"
                    }
                } else {
                    unchanged++
                    logger.debug "  Skipped (exists) '${label}' (src=${srcObjId} → tgt=${tgtObjId})"
                }

            } else {
                logger.info "    Creating '${label}' under tgtOT=${tgtOtId} " +
                    "with ${attrValues.size()} attribute(s)"

                // ── Retry loop: remove failing attrs on 400 and retry ─────────
                List<Map> retryAttrs = attrValues.collect { it as Map }
                boolean postOk = false
                int postRetries = 0
                while (!postOk && postRetries <= 5) {
                    try {
                        Map createdObj = assetsPost(
                            "${ASSETS_API}/${targetWsId}/v1/object/create",
                            TARGET_EMAIL, TARGET_API_TOKEN,
                            [objectTypeId: Integer.parseInt(tgtOtId),
                             attributes  : retryAttrs]
                        )
                        String tgtObjId = createdObj.get('id') as String
                        objectIdMap[srcObjId] = tgtObjId
                        created++
                        logger.info "    Created '${label}': src=${srcObjId} → tgt=${tgtObjId}"
                        postOk = true
                    } catch (AssertionError postErr) {
                        String postErrMsg = postErr.message as String ?: ''
                        Set<Integer> failIds = extractFailingAttrIds(postErrMsg)
                        if (failIds.isEmpty() || !postErrMsg.contains('[400]')) {
                            logger.warn "  Failed to create object ${srcObjId} " +
                                "'${label}': ${postErrMsg}"
                            skipped++
                            break
                        }
                        failIds.each { int fid ->
                            logger.warn "  [obj ${srcObjId}] '${label}': " +
                                "attr id=${fid} rejected on create — " +
                                "removing and retrying"
                        }
                        retryAttrs = retryAttrs.findAll { Map av ->
                            !failIds.contains(
                                av.get('objectTypeAttributeId') as Integer)
                        }
                        postRetries++
                        if (retryAttrs.isEmpty()) {
                            logger.warn "  [obj ${srcObjId}] '${label}': " +
                                "all attributes rejected — creating with no attrs"
                            // Still attempt creation with empty attrs so the
                            // object exists and can be updated on a later run
                            try {
                                Map createdObj = assetsPost(
                                    "${ASSETS_API}/${targetWsId}/v1/object/create",
                                    TARGET_EMAIL, TARGET_API_TOKEN,
                                    [objectTypeId: Integer.parseInt(tgtOtId),
                                     attributes  : []]
                                )
                                String tgtObjId = createdObj.get('id') as String
                                objectIdMap[srcObjId] = tgtObjId
                                created++
                                logger.info "    Created '${label}' (no attrs): " +
                                    "src=${srcObjId} → tgt=${tgtObjId}"
                            } catch (AssertionError ignored) {
                                logger.warn "  Could not create '${label}' even with no attrs"
                                skipped++
                            }
                            break
                        }
                    }
                }
            }

            if (OBJECT_BATCH_LIMIT > 0 &&
                (created + updated) >= OBJECT_BATCH_LIMIT) {
                batchFull = true
                logger.info "  Batch limit of ${OBJECT_BATCH_LIMIT} reached — stopping. Re-run to continue."
            }
        }

        logger.info "Page ${pageNum}: ${objects.size()} fetched | startAt: ${startAt} | " +
            "isLast: ${srcIsLast} | created: ${created} | updated: ${updated} | " +
            "unchanged: ${unchanged}"
    }

    // ── Report orphan objects ─────────────────────────────────────────────────
    int orphanObjectCount = 0
    if (REPORT_ORPHANS) {
        logger.info '  --- Orphan objects (in target but not in source) ---'
        targetObjectQueue.each { String key, List<Map> remaining ->
            remaining.each { Map orphan ->
                String orphanId    = orphan.get('id') as String
                String orphanLabel = orphan.get('label') as String
                Map    orphanType  = orphan.get('objectType') as Map
                String orphanTypeName = orphanType?.get('name') as String ?: 'unknown'
                logger.info "  ⚠️  ORPHAN object: '${orphanLabel}' " +
                    "(id=${orphanId}, type='${orphanTypeName}')"
                orphanObjectCount++
            }
        }
        if (orphanObjectCount == 0) {
            logger.info '  ✅ No orphan objects found in target'
        } else {
            logger.info "  ⚠️  ${orphanObjectCount} orphan object(s) found in target " +
                "(present in target, absent from source)"
        }
    }

    logger.info "Object sync complete. Created: ${created}, Updated: ${updated}, " +
        "Unchanged: ${unchanged}, Failed/unmapped: ${skipped}, " +
        "Orphans: ${orphanObjectCount}"

    if (batchFull || !srcIsLast) {
        logger.info "Re-run the script to continue — existing objects will be matched and skipped/updated."
    }
} else {
    logger.info '=== STEP 6: Skipped (COPY_OBJECTS = false) ==='
}

// =============================================================================
// STEP 7 — Validate: confirm source and target schemas are in sync
// =============================================================================
if (VALIDATE) {
    logger.info '=== STEP 7: Validating schema sync ==='

    int          valErrors = 0
    List<String> report    = []

    // ── 7a: Object type structure ─────────────────────────────────────────────
    logger.info '  Checking object type structure...'

    Object valTgtOtRaw = assetsGet(
        "${ASSETS_API}/${targetWsId}/v1/objectschema/${targetSchemaId}/objecttypes/flat",
        TARGET_EMAIL, TARGET_API_TOKEN
    )
    List<Map> valTgtOts = extractList(valTgtOtRaw, 'objectTypes', 'values', 'objecttypes')

    Map<String, Map> valTgtOtById = [:]
    valTgtOts.each { Map ot -> valTgtOtById[ot.get('id') as String] = ot }

    Set<String> srcOtPaths = sourceObjectTypes.collect { Map sot ->
        getOtPath(sot.get('id') as String, srcOtById)
    } as Set<String>
    Set<String> tgtOtPaths = valTgtOts.collect { Map tot ->
        getOtPath(tot.get('id') as String, valTgtOtById)
    } as Set<String>

    if (srcOtPaths.size() == tgtOtPaths.size()) {
        report << "  ✅ Object type count: ${srcOtPaths.size()} (matches)"
    } else {
        report << "  ❌ Object type count: source=${srcOtPaths.size()}, target=${tgtOtPaths.size()}"
        valErrors++
    }

    Set<String> missingOts = srcOtPaths - tgtOtPaths
    if (missingOts.isEmpty()) {
        report << "  ✅ All source object types present in target"
    } else {
        report << "  ❌ Missing object types in target: ${missingOts.sort()}"
        valErrors++
    }

    Set<String> extraOts = tgtOtPaths - srcOtPaths
    if (!extraOts.isEmpty()) {
        report << "  ⚠️  Orphan object types in target (not in source): ${extraOts.sort()}"
    }

    // ── 7b: Attribute completeness per object type ────────────────────────────
    logger.info '  Checking attributes per object type...'

    Map<String, String> valTgtOtPathToId = [:]
    valTgtOts.each { Map ot ->
        String path = getOtPath(ot.get('id') as String, valTgtOtById)
        valTgtOtPathToId[path] = ot.get('id') as String
    }

    int attrMismatches = 0
    sourceObjectTypes.each { Map srcOt ->
        String srcOtId  = srcOt.get('id') as String
        String otName   = srcOt.get('name') as String
        String srcPath  = getOtPath(srcOtId, srcOtById)
        String tgtOtId  = valTgtOtPathToId.get(srcPath)
        if (!tgtOtId) return

        Object srcAttrRaw = assetsGet(
            "${ASSETS_API}/${sourceWsId}/v1/objecttype/${srcOtId}/attributes",
            SOURCE_EMAIL, SOURCE_API_TOKEN
        )
        List<Map> srcAttrs = extractList(srcAttrRaw, 'values', 'objectTypeAttributes')
        Set<String> srcAttrNames = srcAttrs
            .collect { (it as Map).get('name') as String } as Set<String>

        Object tgtAttrRaw = assetsGet(
            "${ASSETS_API}/${targetWsId}/v1/objecttype/${tgtOtId}/attributes",
            TARGET_EMAIL, TARGET_API_TOKEN
        )
        List<Map> tgtAttrs = extractList(tgtAttrRaw, 'values', 'objectTypeAttributes')
        Set<String> tgtAttrNames = tgtAttrs
            .collect { (it as Map).get('name') as String } as Set<String>

        Set<String> missingAttrs = srcAttrNames - tgtAttrNames
        if (!missingAttrs.isEmpty()) {
            List<Map> missingAttrDefs = srcAttrs.findAll { Map a ->
                missingAttrs.contains(a.get('name') as String)
            }
            List<String> crossSchemaRefs = missingAttrDefs
                .findAll { Map a ->
                    if ((a.get('type') as Integer) != 1) return false
                    String refId = a.get('typeValue') as String
                    if (!refId || refId == 'null') {
                        Map rom = a.get('referenceObjectType') as Map
                        refId = rom?.get('id') as String
                    }
                    if (!refId) return false
                    if (objectTypeIdMap.containsKey(refId)) return false
                    String cachedTgtOtId = crossSchemaOtIdMap.get(refId)
                    return cachedTgtOtId == null
                }
                .collect { (it as Map).get('name') as String }

            List<String> fixableAttrs = (missingAttrs - crossSchemaRefs as Set).sort()

            if (fixableAttrs) {
                report << "  ❌ '${otName}': missing attributes: ${fixableAttrs}"
                attrMismatches++
                valErrors++
            }
            if (crossSchemaRefs) {
                report << "  ⚠️  '${otName}': cross-schema refs (schema absent in target): ${crossSchemaRefs.sort()}"
            }
        }

        Set<String> extraAttrs = tgtAttrNames - srcAttrNames
        if (!extraAttrs.isEmpty()) {
            report << "  ⚠️  '${otName}': orphan attributes in target: ${extraAttrs.sort()}"
        }
    }

    if (attrMismatches == 0) {
        report << "  ✅ All source attributes present in all target object types"
    }

    // ── 7c: Object counts per object type ─────────────────────────────────────
    if (COPY_OBJECTS) {
        logger.info '  Counting objects per type in source and target...'

        Map<String, Integer> srcCountByOtId = [:]
        int     srcObjAt     = 0
        boolean srcObjIsLast = false
        while (!srcObjIsLast) {
            String url = "${ASSETS_API}/${sourceWsId}/v1/object/aql" +
                "?startAt=${srcObjAt}&maxResults=${OBJECT_PAGE_SIZE}"
            Map resp = assetsPost(url, SOURCE_EMAIL, SOURCE_API_TOKEN,
                [qlQuery: "\"objectSchemaId\" = \"${sourceSchemaId}\"",
                 includeAttributes: false])
            List<Map> objs = (resp.get('values') as List ?: []).collect { it as Map }
            srcObjIsLast = safeBool(resp.get('isLast'), false)
            srcObjAt    += objs.size()
            if (objs.isEmpty()) break
            objs.each { Map o ->
                String otId = (o.get('objectType') as Map)?.get('id') as String
                if (otId) srcCountByOtId[otId] = (srcCountByOtId.get(otId) ?: 0) + 1
            }
        }

        Map<String, Integer> tgtCountByOtId = [:]
        int     tgtObjAt     = 0
        boolean tgtObjIsLast = false
        while (!tgtObjIsLast) {
            String url = "${ASSETS_API}/${targetWsId}/v1/object/aql" +
                "?startAt=${tgtObjAt}&maxResults=${OBJECT_PAGE_SIZE}"
            Map resp = assetsPost(url, TARGET_EMAIL, TARGET_API_TOKEN,
                [qlQuery: "\"objectSchemaId\" = \"${targetSchemaId}\"",
                 includeAttributes: false])
            List<Map> objs = (resp.get('values') as List ?: []).collect { it as Map }
            tgtObjIsLast = safeBool(resp.get('isLast'), false)
            tgtObjAt    += objs.size()
            if (objs.isEmpty()) break
            objs.each { Map o ->
                String otId = (o.get('objectType') as Map)?.get('id') as String
                if (otId) tgtCountByOtId[otId] = (tgtCountByOtId.get(otId) ?: 0) + 1
            }
        }

        int srcTotalObjs = srcCountByOtId.values().sum(0) as int
        int tgtTotalObjs = tgtCountByOtId.values().sum(0) as int

        if (srcTotalObjs == tgtTotalObjs) {
            report << "  ✅ Total object count: ${srcTotalObjs} (matches)"
        } else {
            report << "  ❌ Total object count: source=${srcTotalObjs}, target=${tgtTotalObjs}" +
                " (${srcTotalObjs - tgtTotalObjs} missing)"
            valErrors++
        }

        int typeMismatches = 0
        sourceObjectTypes.each { Map srcOt ->
            String srcOtId = srcOt.get('id') as String
            String otName  = srcOt.get('name') as String
            String tgtOtId = objectTypeIdMap.get(srcOtId)
            if (!tgtOtId) return

            int srcCount = srcCountByOtId.get(srcOtId) ?: 0
            int tgtCount = tgtCountByOtId.get(tgtOtId) ?: 0

            if (srcCount != tgtCount) {
                int diff = srcCount - tgtCount
                report << "  ❌ '${otName}': source=${srcCount}, target=${tgtCount}" +
                    " (${diff > 0 ? "${diff} missing" : "${-diff} extra"})"
                typeMismatches++
                valErrors++
            }
        }

        if (typeMismatches == 0 && srcTotalObjs == tgtTotalObjs) {
            report << "  ✅ Object counts match for all ${sourceObjectTypes.size()} object types"
        }
    }

    // ── 7d: Object attribute value validation ────────────────────────────────
    // Fetch each source and target object individually and compare attribute
    // values by name. Uses searchValue as fallback (Group/Status store null
    // in 'value' and the human-readable name in 'searchValue').
    // System attributes (Key, Created, Updated) are excluded.
    if (COPY_OBJECTS && !objectIdMap.isEmpty()) {
        logger.info '  Checking object attribute values...'

        int attrValMismatches = 0
        int objsChecked       = 0

        objectIdMap.each { String valSrcObjId, String valTgtObjId ->
            try {
                Map valSrcObj = assetsGet(
                    "${ASSETS_API}/${sourceWsId}/v1/object/${valSrcObjId}",
                    SOURCE_EMAIL, SOURCE_API_TOKEN
                ) as Map
                Map valTgtObj = assetsGet(
                    "${ASSETS_API}/${targetWsId}/v1/object/${valTgtObjId}",
                    TARGET_EMAIL, TARGET_API_TOKEN
                ) as Map

                String objLabel = valSrcObj.get('label') as String ?: valSrcObjId

                // Build attrName → canonical value string (non-system attrs only)
                Closure<Map<String, String>> buildValMap = { Map obj ->
                    Map<String, String> m = [:]
                    List<Map> objAttrs = (obj.get('attributes') as List ?: [])
                        .collect { it as Map }
                    objAttrs.each { Map attr ->
                        Map otAttr = attr.get('objectTypeAttribute') as Map
                        if (!otAttr) return
                        def sf = otAttr.get('system')
                        if (sf instanceof Boolean && (sf as Boolean)) return
                        String aName = otAttr.get('name') as String ?: ''
                        List<Map> vals = (attr.get('objectAttributeValues') as List ?: [])
                            .collect { it as Map }
                        List<String> strs = vals.collect { Map v ->
                            Map ro = v.get('referencedObject') as Map
                            if (ro) return ro.get('label') as String ?: ''
                            String val = v.get('value') as String
                            if (!val) val = v.get('searchValue') as String
                            return val ?: ''
                        }.findAll { it }.sort()
                        if (!strs.isEmpty()) m[aName] = strs.join(',')
                    }
                    return m
                }

                Map<String, String> srcValMap = buildValMap(valSrcObj)
                Map<String, String> tgtValMap = buildValMap(valTgtObj)

                boolean objMatch = true
                srcValMap.each { String aName, String srcVal ->
                    String tgtVal = tgtValMap.get(aName) ?: ''
                    if (srcVal != tgtVal) {
                        report << "  ❌ '${objLabel}' (src=${valSrcObjId}→tgt=${valTgtObjId}): " +
                            "attr '${aName}' — src='${srcVal}' tgt='${tgtVal}'"
                        attrValMismatches++
                        valErrors++
                        objMatch = false
                    }
                }
                if (objMatch) {
                    logger.debug "  ✅ '${objLabel}': all attribute values match"
                }
                objsChecked++

            } catch (Throwable valEx) {
                logger.warn "  Could not validate object ${valSrcObjId}: ${valEx.message}"
            }
        }

        if (attrValMismatches == 0) {
            report << "  ✅ Object attribute values: all ${objsChecked} object(s) fully match"
        } else {
            report << "  ❌ Object attribute values: ${attrValMismatches} mismatch(es) " +
                "across ${objsChecked} object(s) checked"
        }
    }

    // ── 7e: Cross-schema reference report ─────────────────────────────────────
    if (!crossSchemaSchemaInfo.isEmpty()) {
        report << ''
        report << '  ── Cross-schema reference report ──'
        crossSchemaSchemaInfo.each { String schId, Map info ->
            boolean present = info.get('present') as boolean
            String schName  = info.get('name') as String ?: schId
            String tgtSchId = info.get('targetSchemaId') as String ?: 'N/A'

            if (present) {
                report << "  ✅ Referenced schema '${schName}' is PRESENT in target " +
                    "(id=${tgtSchId}) — reference attributes resolved"
            } else {
                report << "  ❌ Referenced schema '${schName}' is ABSENT in target " +
                    "— reference attributes skipped"
                valErrors++
            }
        }

        crossSchemaAttrReport.each { String schName, Map info ->
            boolean present = info.get('present') as boolean
            List<String> attrs = (info.get('attrs') as List ?: []).unique().sort()
            if (!attrs.isEmpty()) {
                String status = present ? 'resolved' : 'skipped (schema absent)'
                report << "    '${schName}' attrs (${status}): ${attrs}"
            }
        }
    }

    // ── 7e: Orphan summary ────────────────────────────────────────────────────
    if (REPORT_ORPHANS) {
        if (!orphanOtNames.isEmpty()) {
            report << "  ⚠️  Orphan object types (in target, not in source): ${orphanOtNames.sort()}"
        }
        if (!orphanAttrReport.isEmpty()) {
            report << "  ⚠️  Orphan attributes (in target, not in source):"
            orphanAttrReport.each { report << "       ${it}" }
        }
    }

    // ── Print report ──────────────────────────────────────────────────────────
    logger.info ''
    logger.info '  ┌─────────────────────────────────────────┐'
    logger.info '  │           SYNC VALIDATION REPORT        │'
    logger.info '  └─────────────────────────────────────────┘'
    report.each { logger.info it }
    logger.info ''
    if (valErrors == 0) {
        logger.info '  ✅ VALIDATION PASSED — source and target schemas are in sync'
    } else {
        logger.info "  ❌ VALIDATION FAILED — ${valErrors} issue(s) found (see above)"
    }
} else {
    logger.info '=== STEP 7: Skipped (VALIDATE = false) ==='
}

// =============================================================================
// SUMMARY
// =============================================================================
logger.info '=== SYNC COMPLETE ==='
logger.info "  Schema        : '${SCHEMA_NAME}'"
logger.info "  Object types  : mapped=${objectTypeIdMap.size()}, " +
    "created=${otCreated}, updated=${otUpdated}, " +
    "orphans=${orphanOtNames.size()}"
logger.info "  Attributes    : mapped=${attributeIdMap.size()}, " +
    "created=${attrCreated}, updated=${attrUpdated}, " +
    "orphans=${orphanAttrReport.size()}"
if (!crossSchemaSchemaInfo.isEmpty()) {
    int presentCount = crossSchemaSchemaInfo.values().count { (it as Map).get('present') } as int
    int absentCount  = crossSchemaSchemaInfo.size() - presentCount
    logger.info "  Cross-schema  : ${crossSchemaSchemaInfo.size()} schema(s) referenced — " +
        "${presentCount} present, ${absentCount} absent"
}

return "Sync complete for '${SCHEMA_NAME}'. " +
    "OTs: created=${otCreated}, updated=${otUpdated}. " +
    "Attrs: created=${attrCreated}, updated=${attrUpdated}."
```

