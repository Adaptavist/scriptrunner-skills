<platform*guidance>
<context>
ScriptRunner for Jira Cloud cannot access Atlassian's Java APIs. All automation must rely on HAPI and the Atlassian REST API via the injected HTTP helper functions `get`, `post`, `put`, and `delete`. Logging uses the injected `logger` instance (`logger.debug`, `logger.info`, etc.).
</context>
<migrated_config_identity>
When producing ScriptRunner Cloud Dev and Deployment Tool (D+D) YAML for existing Data Center configuration, treat UUID-bearing fields as stable identity, not throwaway placeholders. Never try to \_choose* identity for a workflow rule.

- **Workflow rules (conditions, validators, post functions): do not set identity at all.** `parameters.id` and `config.uuid` are assigned by the server when the descriptor is saved, deterministically from the configuration. Put any value in those fields; it will be replaced and you will be told what it was replaced with. Do not run `uuidgen`, do not copy a UUID from the source, and above all never copy a UUID from a _different_ rule to satisfy a "copy the UUID" instruction.
  Why: Data Center function ids are not unique. Copying a workflow or importing workflow XML clones `FIELD_FUNCTION_ID`, so one id legitimately appears in many workflows. The server retains a canonical UUID or a 40-character hex Script Registry id as `parameters.id`; other shapes are replaced with a derived UUID. Duplicate `parameters.id` values are reported on export but do not block the download. Fix them in the downloaded project (`uuidgen` or remove a duplicate) before deploy. `config.uuid` is always derived because those ids are global. The original Data Center function id remains the configuration's source id in the migration tooling.
- **Other features (scripted fields, listeners, jobs, behaviours): copy the Data Center UUID 1:1** into the entry's `uuid`, and behaviour `fieldUuid` values likewise. These are genuine stable identity and are not cloned the way workflow function ids are.
  If a Data Center uuid for one of these is not a canonical UUID (8-4-4-4-12 hex), say so explicitly instead of inventing one: the deploy tool will reject it and the configuration needs re-analysis.
- Only generate a new UUID when creating a genuinely new entry for one of those features, and only with `uuidgen`.
- When finishing a descriptor converted from Data Center configuration, tell the user which identity was retained and which was server-assigned. If the corresponding configuration was already deployed via JCMA, retained UUIDs mean deployment writes to that existing Cloud configuration rather than a different one.
  </migrated_config_identity>
  <cloud_identifier_placeholders>
  When producing output for the Dev and Deployment Tool (D+D) or a portable migration project, a Data Center identifier cannot be written into a persisted script, expression, Behaviour TypeScript file, or descriptor as a literal, because the target Cloud value is environment-specific even when the exact source id is known. Emit a `%placeholder%` marker instead; the export generates the mapping file from your markers and the customer supplies the Cloud values via the deploy tool's `pullMappings` task. A standalone script written directly for one known Cloud site keeps the source's literal ids, keys and names, or may use that site's concrete Cloud ids.

- Form: `%<prefix><exactDataCenterValue>%`, e.g. prefix `user-` plus value `JIRAUSER85335` gives `%user-JIRAUSER85335%`. The prefix selects the entity type, so naming the marker correctly is all the registration required. Do not record placeholders anywhere else.
- Prefixes (the complete list; nothing else is resolvable): `user-`, `group-`, `customField-`, `customFieldOption-`, `customFieldConfigScheme-`, `appCustomField-`, `project-`, `projectCategory-`, `projectRole-`, `status-`, `issueType-`, `issueLinkType-`, `issueLink-`, `issue-`, `issueSecurityLevel-`, `priority-`, `resolution-`, `component-`, `version-`, `sprint-`, `rapidView-`, `filter-`, `screen-`, `workflowRule-`, `comment-`, `workLog-`, `fileAttachment-`, `requestType-`, `portalPage-`, `customerOrganization-`.
- Never invent a prefix. `%transitionId-51%` or `%actionId-…%` cannot be entered in the mapping file, so the save is rejected. An identifier that no prefix covers (workflow transition and action ids, for example) keeps its literal Data Center value and is reported as a manual verification step.
- Examples: `%user-JIRAUSER85335%`, `%group-jira-administrators%`, `%customField-customfield_11402%`, `%projectRole-10900%`.
- Reuse one marker for one identifier everywhere it appears. Two markers for the same Data Center key under one entity type is a mapping-file error.
- Only `%…%` is substituted. A free-form marker such as `<accountId-for-JIRAUSER123>`, `ACCOUNT_ID_FOR_JIRAUSER123`, `REPORTER_ACCOUNT_ID`, or `customfield_XXXXX` is never resolved. It ships as literal text, and the rule then silently never matches for anyone.
- Do not invent identifiers. In Dev and Deployment Tool output, use the exact Data Center id/key inside the marker even when it is concrete. Use a verified target-site Cloud value directly only in a standalone script. Never guess a plausible-looking Cloud value.
- Replacement is textual and adds no quotes. Put markers in the syntax required by the mapped Cloud value, normally quoted in Groovy, TypeScript, Jira Expressions, JQL, and YAML. When a HAPI overload requires a numeric custom-field id, do not splice a placeholder into a number or parse the mapped `customfield_N`; use Jira REST with the string custom-field placeholder in `fields` instead.
- A Data Center user key is never a valid Cloud `accountId`. Writing `JIRAUSER85335` where an `accountId` is expected produces a comparison that is always false, so user keys always become `%user-…%` markers in Dev and Deployment Tool output.
  </cloud_identifier_placeholders>
  <pre_review_phase_global>
  Before presenting any generated code to the user (as a file or inline), you must run an explicit pre-review phase and check the following.

Pre-review requirements:

1. Check for bug risk: syntax validity, null/undefined safety, type compatibility, platform API constraints, ID usage, boundary cases and output formatting.
2. When the task is a Data Center → Cloud migration of any non-trivial script (nested conditionals, loops inside guards, multi-branch accumulators, link traversals or conditional early returns), explicitly trace the DC control flow branch by branch and confirm the Cloud version produces the same outcome on every branch. Follow the `control_flow_fidelity_caveat` rules below.
3. If you find any risk, revise your plan first, then implement from the revised plan.
4. Do not present code until the pre-review is complete.

Keep the pre-review focused and concrete: report specific risks and fixes, not generic statements.
</pre_review_phase_global>
<absolute_binding_must_not_fail_rules>
For comment listeners (`comment_created`, `comment_updated`, `comment_deleted`), do not reference a top-level `user` variable. ScriptRunner Cloud comment events have no such binding. Code containing `user as Map`, `user['accountId']`, `user.accountId` or `def userMap = user` in a comment listener is invalid. Rewrite it to use `((comment as Map).author as Map).accountId`, or `comment.updateAuthor.accountId` if the DC source specifically means the updater. A comment listener is not an issue event just because it has an `issue` binding.
In a comment-triggered listener, DC `jiraAuthenticationContext.loggedInUser` is the user whose comment caused the synchronous event. On Cloud that actor is `comment.author` (or `comment.updateAuthor` for an update), not `/myself`. `/myself` is the app execution identity and silently fails actor/role gates.

Do not assume any listener or workflow post-function has a top-level `user` binding. Use a user supplied by the event's documented bindings when the Data Center source means that event user. When it means the authenticated execution user, resolve `GET /rest/api/3/myself` and use its `accountId`. A bare reference to `user` is invalid unless the event's documented bindings confirm it for that exact script type and event (for example via the ScriptRunner MCP `get_jira_cloud_event_bindings` tool).
When the Data Center source contains an ApplicationLink, remote-service base URL or any absolute `http://` / `https://` literal, keep the Cloud request URL absolute and external. Source configuration literals override documentation examples and inferred same-site proxy paths. For every relative resource passed to an ApplicationLink request factory, mechanically join the source's named remote base constant with that resource and use the resulting absolute URL in the injected HTTP helper. Never strip the scheme/host into a relative Jira path or replace the source host with Jira's `baseUrl`. A final helper call beginning with `/wiki` or another relative path is invalid whenever the source supplies a distinct remote host. Before final output, compare every translated external call with the source and confirm the URL keeps its remote scheme and host.
An ApplicationLink supplies authentication outside the source script. If the source contains no credentials, do not invent credential placeholders, placeholder assertions or a hard-failing "configure credentials" guard in the executable Cloud path. Preserve the external request and its source-visible headers using the platform's configured outbound authentication, and describe administrator setup separately from the code. A migration that always aborts before the request is not a faithful authentication substitute.

For scripted fields, the declared scripted-field type is a hard runtime contract. Before final output, inspect every reachable return expression against that type.

- `TEXT_FIELD`: return only a `String` or `null`. Convert a Data Center collection result with `.toString()` unless the source explicitly formats it another way. Never return a raw `List`, `Map`, Jira object or ADF document.
- If that collection held DC Jira Issue objects, collect Cloud issue `key` strings before `.toString()`. Stringifying raw REST issue maps is not equivalent to DC `Issue.toString()`.
- Any reachable `TEXT_FIELD` return containing an ADF marker such as `type: 'doc'`, `version: 1`, `paragraph` or `bulletList` is an automatic rejection. Rewrite it to the source's plain text result.
- Unused HTML/markup imports, an unused base URL or the possibility of prettier links do not authorize upgrading a source collection/string into rich text.
- `NUMBER_FIELD`: return only a numeric value or `null`.
- `RICH_TEXT_FIELD`: may return ADF when formatting is required.
- Compilation success does not prove the return shape matches the declared field type.

Cloud HAPI `Project` objects and project references are sparse. Do not read `project.roles`, `projectObject.roles` or an equivalent HAPI property for project-role resolution. Fetch `GET /rest/api/3/project/{projectKeyOrId}/role`, then fetch the selected role detail URL/id.
Project-picker values and project references are also sparse. Normalise the raw issue field as a map and take its `key` or `id`. Then hydrate `GET /rest/api/3/project/{keyOrId}` before reading lead data such as `lead.accountId` or `lead.displayName`. Project search results and HAPI picker/project objects are not a reliable source of expanded lead data.
For Data Center logic that aggregates or copies select, multi-select, checkbox, radio or cascading-select values between issues, do not cast HAPI `getCustomFieldValue(...)` results to `Map`/`List<Map>`, read `.id` from them or forward them into REST writes. Their runtime representation is not a stable Jira REST option reference. Fetch each source field by id through issue REST, normalise the returned raw option map/list, and write only minimal non-null `id` or `value` references.
Jira option IDs belong to a specific custom field and context. When source and target option field IDs differ, do not reuse the source option's `id` in the target field, even if both display the same choices. Preserve the source option's human-readable `value` in a target `[value: ...]` reference, or resolve that value against the target field's applicable context and use the target option ID. Direct ID copying is valid only when source and target are the same field/context.
When migrating legacy parent/Epic-Link traversal, never preserve a fixed number of parent hops. Starting with the current issue, inspect its issue type and repeatedly follow the unified REST `fields.parent` relationship until the semantic target type is reached or the chain ends, with a small cycle/safety bound. A Story may already have an Epic as its immediate parent, while a subtask may need another hop. Do not use HAPI `getEpic()`: it can return null for subtasks and hides the unified parent chain.
Jira Cloud webhook identifiers, including project ids and version ids, are string-shaped. Do not cast them through `Number`, `Long` or `Integer` to perform a REST lookup or build a URL. Convert only at the boundary of an API verified to require a numeric JSON value.
Do not add speculative feature/configuration probes that the source's durable behaviour does not need. A DC global-manager capability guard with no supported Cloud equivalent should not become a call to a guessed configuration endpoint that can fail before the actual migration logic.
Raw Jira Cloud issue create/update payloads must use ADF for `description` and textarea/rich-text custom fields. Never send a plain description string to `POST /rest/api/3/issue`.
HAPI's String-valued setters differ from the raw REST path: `setDescription(String)` and `setCustomFieldValue(name, String)` on a `textarea` custom field both run the wiki-to-ADF converter internally. Handing HAPI a plain String is therefore correct for genuinely plain prose, but not safe for every wiki construct. Live probes of the pinned converter (adf-builder-java-wiki 1.3.3) show:

- Inline marks, headings, tables, code blocks, quotes and bulleted/numbered lists all convert and are accepted by Jira.
- Macros do not convert. `{info}`, `{warning}`, `{note}`, `{tip}` and `{status}` survive as literal text, a `{color}` wrapper around a block silently drops the colour, and a `{panel}` containing a table becomes an empty panel with the table escaped out beside it.
- Mentions are worse than lossy. The converter renders `[~accountid:<id>]` as a mention node whose `id` keeps the `accountid:` prefix. Jira normalises that to `id: "unknown"`, so the text renders `@unknown` and notifies nobody.

When the source text carries a wiki macro or a user mention, do not round-trip it through the String setter. Build the ADF document explicitly and give any mention node the bare `accountId` as `attrs.id`.
Any value you build yourself (a raw REST body, or a Map passed to HAPI and written as ADF) must be a complete, valid ADF document with `type: 'doc'`, `version: 1` and well-formed nodes. A partial or malformed document is rejected and fails the entire update, so one invalid ADF map silently costs every other field in the same write.
When copying multiline content into ADF, preserve each newline structurally with `hardBreak` nodes or equivalent paragraph boundaries. A newline embedded inside one ADF text node is not rendered as a line break. Apply this even when the source REST read already returns an ADF map: recursively split newline-containing text nodes into text/hardBreak/text nodes before writing.
When cloning an issue, never forward a hydrated `fields=*all` map (or a broad read-response field map with a few exclusions) into `POST /rest/api/3/issue`. Read responses contain output-only fields and read shapes that are not valid create shapes. Build an explicit create-field allowlist from fields the source actually copies, reconstruct minimal writable references, omit null/non-createable fields, normalise ADF, and serialise dates such as `duedate` to Jira's writable `yyyy-MM-dd` string. Before presenting code, enumerate the create payload's fields and reject any field whose write shape was merely inherited from a read response.
Create metadata does not authorize forwarding a read value unchanged. Broad clone helpers must still exclude output/relationship collections such as `issuelinks`, attachments, comments, worklogs, changelog, status, transitions and derived time-tracking data, unless the DC source explicitly recreates that feature through its dedicated write API. Copy only the durable source fields the clone needs and rebuild each write shape.

Field names inside an event binding are as load-bearing as the binding name, and a wrong one fails silently. Reading a property that does not exist on a binding map yields `null` rather than raising, so an invented field name usually turns the script into a no-op that neither logs nor throws and looks like "the listener never fired". Never infer a binding's field name from the Data Center accessor it replaces or from what reads naturally. Confirm the exact field with the event's documented bindings for that specific event (for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool). Where a DC accessor returns an object, the Cloud binding commonly carries an identifier instead, usually an id rather than a key. Use the field the documentation lists, then hydrate it with a REST call if you need the whole entity.

Project-role actors are not expanded on Cloud, which silently changes which branch of an actor-resolution chain fires. `GET /rest/api/3/project/{keyOrId}/role/{id}` returns an `actors` array (live-probed):

- A group actor is `type: "atlassian-group-role-actor"` carrying only `actorGroup: [name, groupId, displayName]`. The group's members are not included.
- A user actor is `type: "atlassian-user-role-actor"` carrying only `actorUser: [accountId]`.

Data Center's `ProjectRoleActors.getApplicationUsers()` returns the union of the role's direct user actors and the members of its group actors. To port it faithfully, collect each `actorUser.accountId` and also expand every group actor through `GET /rest/api/3/group/member` before taking the union. Data Center's `getRoleActorsByType('atlassian-group-role-actor')` with `getParameter()` is different: it yields group names only, which maps to reading `actorGroup.name`. When a source distinguishes these two reads, keep them distinct. Treating the group list as the user list, or skipping the group expansion, produces a plausible non-empty result that sends an ordered fallback down the wrong branch.

Jira Cloud has no usernames. When the Data Center source identifies or compares a user by `getName()`, `getKey()` or a username literal, re-key the comparison to `accountId`. Resolve the username through the source's own username-to-user mapping table when it supplies one, or otherwise through a user search, and compare `accountId` to `accountId`. Never compare users by `displayName`. Display names are user-editable, not unique on a site and not guaranteed to be populated on every event payload, so a display-name comparison can silently never match and turn an actor guard into dead code.
</absolute_binding_must_not_fail_rules>
<behaviours_support>
<overview>
Cloud Behaviours scripts use TypeScript, not Groovy. The behaviours context provides a rich TypeScript API for controlling field visibility, validation, and behaviour on Jira issue screens.
</overview>
<documentation_first>
Use the bundled `scriptrunner-documentation` and `scriptrunner-example-scripts` skills for Behaviours when API details are uncertain, the task is novel, or you need to confirm a specific capability or limitation.
For straightforward field-level conversions (visibility, required, readOnly, value, options) where this guidance and the prompt context already give the required APIs, skip documentation fetches to reduce latency and token cost.
</documentation_first>
<async_operations_critical>
Behaviours scripts must explicitly await all async operations before returning. Scripts using `.then()` chains may terminate early.

- Use async/await syntax, not `.then()`/`.catch()` chains.
- Await `makeRequest()` calls.
- Mark behaviour functions as `async` if they contain `await`.
- For parallel operations, use `await Promise.all([...])`.
- Use try/catch for error handling.
  </async_operations_critical>
  <behaviours_api_contract>
  Use these API contracts when writing Cloud Behaviours TypeScript:
- getChangeField(): Field | undefined
- Field API uses methods (getId(), getValue(), setVisible(), setRequired(), setReadOnly(), setValue())
- setVisible/setRequired/setReadOnly/setValue return void (do not chain setter calls)
- makeRequest(url: string, fetchOptions?: RequestInit) returns Promise<{ status: number; body: any }>
- makeRequest result has no response.json() method; parse from response.body directly
  </behaviours_api_contract>
  <field_references>
  <system_fields>
  System fields can be referenced by their field names (e.g., 'assignee', 'priority', 'summary', 'description', 'labels', 'components', 'fixVersions', 'issuetype', etc.). Use getFieldById() to access them.
  </system_fields>

<custom_fields>
Custom fields MUST be referenced by their field ID (e.g., 'customfield_10001'), never by display name. When writing Behaviours scripts that use custom fields:

1. For output produced for the Dev and Deployment Tool / a portable migration project, ALWAYS persist the exact source id as `%customField-customfield_10001%`, even when the concrete Data Center id is available.
2. For a standalone script targeting one known Cloud site, use the supplied concrete Cloud id.
3. Never substitute a display name or invented id. In Dev and Deployment Tool output, reuse the same placeholder everywhere in TypeScript and descriptor YAML.
   </custom_fields>
   </field_references>
   <lifecycle_semantics>
   Behaviours script output is top-level TypeScript executed by the Behaviours runtime. Do not wrap the entire script in a custom function.

When and for which field each platform runs a script:

- DC INITIALISER: runs once when the form loads. Port it as an On load script and do not depend on getChangeField().
- DC FIELD (server-side) script: attached to one field, the "Behaviour field". DC runs it when the form loads AND whenever that attached field changes, and never when any other field changes. Inside it, getFieldChanged() is always the attached field's id, on load as well, so `getFieldById(getFieldChanged())` simply means "the attached field".
- Cloud getChangeField() is not getFieldChanged(). It returns the field the user just edited, which can be any field on the form when the script runs On change, and it is undefined On load. Never use it (or `getChangeField() ?? ...`) as a stand-in for the attached field: read the attached field explicitly with getFieldById("<attached field id>").
- A Cloud On change script runs after every field edit, not only the attached field's, whereas DC leaves everything a field script set in place until the attached field changes again. To reproduce DC exactly, wrap the body of a ported FIELD script so it acts only on load or when the attached field changed: `const changed = getChangeField(); if (!changed || changed.getId() === "<attached field id>") { ... }`. Without this guard, editing any other field reruns the script, which overwrites changes the user has made since (for example a value the script set and the user then changed) and repeats anything that is not idempotent.
- Use the On load / On change configuration stated in the prompt.
- The runtime runs the script inside an async function and applies the changes queued when it finishes. Await asynchronous work at the top level (`const context = await getContext()`); an async function or `.then()` chain that is called but not awaited loses every change it makes. Do not add `import` or `export` statements: the script is not a module, and an `export {}` makes it fail before it changes anything.
  </lifecycle_semantics>
  <dc_value_semantics>
  Port what the DC script actually does on a DC form, including behaviour its author did not intend. A faithful port reproduces DC's observable result for every input, so work out DC's real value shapes before translating:
- Reproduce the result, not DC's wire format. A date written as a DC date-picker string (for example `d/MMM/yy`), a user written as a user name, or an option written as a label means that date, user or option; send it in the form Cloud accepts.
- getValue() on a single select or radio field returns the option label as a String. Priority and resolution return objects (.name, .id), components and versions return lists of objects, number fields return a Double, date fields a Date, and user pickers the user name.
- Checkboxes and labels: DC's form joins the selected values and getValue() only splits them when there are two or more. Two or more give a List of labels; exactly one gives a plain String; none gives null (checkboxes) or "" (labels). Groovy `as List`, `.each`, `for (x in value)`, `.collect` and `.contains` on a String work on its characters or substrings, so for a single ticked box `(value as List).contains("Label")` is false and `value.contains("sec")` matches part of a lone label. A single select's value is always a String, so `.each` over it always walks characters. A multi-select is different: it is a plain list box, so getValue() is always a List of labels ([null] when None is selected). Reproduce DC's result for each case: Cloud getValue() returns an array of option objects (or label strings for labels).
- setFormValue() writes through: a later getValue() in the same DC run sees the new value. Cloud getters return what the form held before the script ran, so keep a value you set in a variable if the DC script reads it back.
- setFormValue() and setFieldOptions() accept option names or ids on DC; Cloud setValue() and setOptionsVisibility() need ids.
- setHelpText(text) has no Cloud counterpart; use setDescription(text).
- DC clears a user field with setFormValue(""). In Cloud, clear a user field (assignee, user picker) with setValue(null): an empty string is not a valid account id and makes Jira discard every change the script made in that run.
- Clear a Cloud field with the empty value of its type: null for single-value fields (user pickers, single selects and radios, dates and date-times, numbers, cascading selects, project and parent pickers), "" for text and URL fields, and [] for list fields (labels, components, versions, multi-selects, checkboxes, multi-user pickers, People). setValue(null) on a text, URL or list field makes Jira discard every change the script made in that run.
- Cloud de-duplicates labels passed to setValue().
- Jira keeps a field its own configuration requires (summary, reporter, and any field the field configuration marks required) required whatever a script says. On the create and transition screens, setRequired(false) on such a field makes Jira discard every change the script made in that run, so never send it: when a DC script toggles such a field with setRequired(condition), leave that call out of the port (setRequired(true) on it is harmless). Fields the configuration leaves optional can be made required and optional again freely.
- Date fields (due date, date pickers) take setValue("YYYY-MM-DD"). Date-time fields take the time to the minute with an explicit offset, for example setValue("2026-12-01T10:30+01:00"); Jira refuses seconds, milliseconds, a trailing Z or a missing offset, so Date.toISOString() is refused as it stands (`date.toISOString().slice(0, 16) + "+00:00"` gives the same instant in an accepted form). getValue() on a date-time returns it in the user's time zone with that zone's offset. A refused value makes Jira discard every change the script made in that run.
  </dc_value_semantics>
  <affected_field_detection>
  ScriptRunner Cloud decides which fields a script may change by static analysis of the saved script. A change is applied only to a field reached through getFieldById with a string literal id (directly, or through a const holding that call) on which a setter is called. Field ids taken from a loop, an array, a parameter or a computed string are not detected: the field is not registered and Jira silently drops every change to it. Write one getFieldById("literal id") per field you change and unroll loops over fields.
  An invalid value for any field, or a setter the view does not support for that field, makes Jira discard every change the script made in that run.
  The editor type-checks against the browser DOM library and refuses to save a script whose top-level const or let redeclares a browser global (TS2451), for example status, name, event, parent, location, history, top, self, origin, length, open, close, print or focus. Use descriptive names.
  </affected_field_detection>
  <context_shape_compact>
  Use the getContext() extension shape (IDs are strings):
- GIC: {type:'jira:uiModifications', project:{id,key,type}, issueType:{id,name}, viewType:'GIC'}
- IssueView: {type:'jira:uiModifications', project:{id,key,type}, issueType:{id,name}, issue:{id,key}, viewType:'IssueView'}
- IssueTransition: {type:'jira:uiModifications', project:{id,key,type}, issueType:{id,name}, issue:{id,key}, issueTransition:{id}, viewType:'IssueTransition'}

Compare IDs as strings (e.g. transitionId === '31').
</context_shape_compact>
<dc_to_cloud_mapping_rules>
Apply these mappings when converting Data Center Behaviours patterns:

- setHidden(true) -> setVisible(false)
- setHidden(false) -> setVisible(true)
- setFormValue(...) -> setValue(...)
- setFieldOptions([...labels...]) -> setOptionsVisibility([...optionIds...], true)
- getIssueContext().getIssueType().name -> (await getContext()).extension.issueType.name

Preserve the identity of any IDs supplied in prompt comments or context exactly. In output produced for the Dev and Deployment Tool or a portable migration project, encode environment-specific ids with the matching `%alias%` marker. Use the source's literal ids directly only in an ordinary non-migration standalone script targeting one known Cloud site.
</dc_to_cloud_mapping_rules>
<mandatory_validation>
Type-check every Behaviours TypeScript script before presenting it, using a Behaviours type checker when one is available. This applies to every Behaviours script, whether or not it touches custom fields.

General rules for every Behaviours script:

1. If the checker returns errors, revise and re-check until it passes.
2. Treat top-level script errors (for example "return statement can only be used within a function body") as hard failures and fix them.
3. Do not finalise while checker errors remain, even if the runtime logic looks correct.

When checking a script that touches custom fields:

1. ALWAYS provide a custom-field mapping from custom field id to custom field type, for example `{ "customfield_10001": "com.atlassian.jira.plugin.system.customfieldtypes:select", "customfield_10002": "com.atlassian.jira.plugin.system.customfieldtypes:textfield" }`. Take the types from source metadata, never from a guess. The mapping is CRITICAL for TypeScript to type-check field `getValue()` and `setValue()` calls. Omit it only when the script touches no custom fields.
2. For output produced for the Dev and Deployment Tool / a portable migration project, keep the final TypeScript portable with its `%customField-customfield_N%` placeholders. Check a throwaway copy in which each placeholder is replaced by its original source (Data Center) `customfield_N`, and never save that concrete-id copy as the output. For standalone scripts, check the concrete script directly.
   </mandatory_validation>
   <pre_review_behaviours_note>
   Immediately before presenting Behaviours code, run the general pre-presentation checks in this guidance (bug risk, null safety, type compatibility, platform API constraints, ID usage and boundary cases) and additionally confirm: no top-level `return`, async operations are awaited, field and option identity aligns with the source, and output produced for the Dev and Deployment Tool uses consistent `%alias%` placeholders in both the TypeScript and the descriptor YAML. Type-check Behaviours TypeScript before presenting it when a checker is available.
   </pre_review_behaviours_note>
   <typescript_patterns>
   Common patterns in Behaviours scripts:

- Use getFieldById() to access fields with full type safety.
- Field values are typed by field type (for example, select fields return OptionReference | null).
- Use logger for debugging (logger.info(), logger.debug(), etc.).
- Use makeRequest() for REST API calls when needed.
- Use async/await for asynchronous operations (NEVER use .then() chains).
- Type-check Behaviours TypeScript before presenting it when a checker is available.
  </typescript_patterns>
  <rich_text_field_handling>
  For Behaviours field API typing:
- `description.getValue()` and `textarea.getValue()` may be `string | ADF`.
- Treat description and textarea values as rich text.

Narrow safely before reading ADF content:

- `if (typeof value === "string") { ... }`
- `else if (value && Array.isArray(value.content)) { ... }`

Do not access `value.content` without narrowing when `value` may be a string.
`setValue` must match the type `getValue` returns. With the default rich-text renderer, `description` and textarea fields hold an ADF document, so write ADF. A plain string is only valid for a field using the plain-text renderer, and never on the issue view; on a rich-text field it is not applied, and on the issue view Jira reports an error applying UI modifications. Wiki markup left inside an ADF text node is stored as literal text, so it renders as the raw characters.
If needed, use a structural ADF type to keep type checking clean: `{ version: 1; type: "doc"; content: unknown[] }`

Checker-safe examples:

1. Description empty check + ADF writeback:

```typescript
const field = getFieldById('description')
if (field) {
	const value = field.getValue()
	const isEmpty =
		value == null ||
		(typeof value === 'string' && value.trim() === '') ||
		(typeof value === 'object' &&
			value !== null &&
			Array.isArray((value as { content?: unknown[] }).content) &&
			((value as { content?: unknown[] }).content ?? []).length === 0)
	if (isEmpty) {
		const adf = {
			version: 1 as const,
			type: 'doc' as const,
			content: [] as unknown[],
		}
		field.setValue(adf)
	}
}
```

2. Textarea custom field, `hasContent` variant:

```typescript
const notes = getFieldById('customfield_12345')
if (notes) {
	const value = notes.getValue()
	const hasContent =
		typeof value === 'string'
			? value.trim().length > 0
			: !!(
					value &&
					typeof value === 'object' &&
					Array.isArray((value as { content?: unknown[] }).content) &&
					((value as { content?: unknown[] }).content ?? []).length >
						0
				)
	if (!hasContent)
		notes.setValue({
			version: 1 as const,
			type: 'doc' as const,
			content: [] as unknown[],
		})
}
```

</rich_text_field_handling>
<wiki_markup_to_adf>
Data Center description and textarea values are wiki-markup strings. Cloud stores them as ADF. Do not pass the wiki string to setValue, and do not wrap it in a single text node: both render the markup characters literally.

Translate each construct into nodes:

- \*bold\* → strong; \_italic\_ → em; +underline+ → underline; -strike- → strike; {{mono}} → code
- h1. through h6. → heading (attrs.level); a leading "\* " or "# " line → bulletList or orderedList of listItem; ||header|| and |cell| rows → table; ---- → rule; {code} → codeBlock; [text|url] → link mark; !file.png! → media
- {panel}, {info}, {warning}, {note}, {tip}, {status}, {color}, and [~user] mentions do not convert faithfully. Record a manual step. A mention needs the bare Cloud accountId as attrs.id; do not guess one from a Data Center username.

Shape the document in the ADF Playground (https://developer.atlassian.com/cloud/jira/platform/apis/document/playground/) and pass that object to setValue: `{ version: 1, type: "doc", content: [ /* nodes */ ] }`.
</wiki_markup_to_adf>
<common_typecheck_failure_prevention>
Prevent frequent TypeScript failures by applying these rules before final output:

- Do not use top-level return statements in script output; use if-guards instead.
- Do not use non-existent field properties (e.g., fieldId); use getId().
- Do not chain field setters; call each setter on its own line.
- getChangeField() is undefined On load; guard for undefined before access.
- For ID comparisons from context, compare strings to strings (IDs are string-shaped).
  </common_typecheck_failure_prevention>
  <option_id_lookup>
  Select-type custom fields (select, multi-select, checkboxes, radio buttons) require option IDs (not display values) in setValue():
- Single select/radio: field.setValue("10021")
- Multi-select/checkboxes: field.setValue(["10021", "10022"])

Use the option IDs given in the prompt. If none are given, ask the user for them. Do not look them up at runtime: the field context option endpoints need the Administer Jira permission, which the person filling in the form rarely has.
</option_id_lookup>
<rest_calls_run_as_the_user>
A behaviours script runs as whoever opens the form, usually a user with no administration permissions, and makeRequest() calls Jira as that user. Only call REST endpoints an ordinary user may call; an endpoint that needs Administer Jira or Administer projects (field contexts and options, project roles and role actors, workflows and workflow schemes, screens, permission schemes) fails for them and the script silently does nothing useful.

- The current user and their groups: GET /rest/api/3/myself?expand=groups.
- The current user's permissions: GET /rest/api/3/mypermissions?permissions=...
- The current user's project roles: POST /rest/api/3/expression/evaluate with the Jira expression user.getProjectRoles(project) and the project in the context; GET /project/{key}/roledetails and /project/{key}/role need project administration.
- Issues, projects, versions, components, priorities and issue types can be read with Browse projects.
  </rest_calls_run_as_the_user>
  <options_visibility_semantics>
  setOptionsVisibility(optionIds, isVisible) semantics:

- isVisible = true: only listed option IDs are shown
- isVisible = false: listed option IDs are hidden
  Use this explicitly when translating DC option restriction logic to avoid inverted behaviour.
  </options_visibility_semantics>
  </behaviours_support>
  <cloud_constraints>
  <compile_static_enforcement>
  `@CompileStatic` is always enabled. Resolve type errors through precise typing and method signatures; do not disable static compilation.
  </compile_static_enforcement>

<structured_data_preferences>
Strong typing is essential for Cloud. When modelling structured data, define Groovy classes (for example annotated with `@ToString`) instead of passing loose maps. This improves static checking and reduces runtime surprises.
</structured_data_preferences>

<logging_standards>
Use the provided `logger` instance for diagnostics, not the Data Center `log` variable.
</logging_standards>
<library_availability>
Do not import Data Center/server-side convenience libraries just because the source did. In particular, avoid `org.apache.commons.lang3.StringUtils` in Cloud Groovy output; use native Groovy/JDK string operations such as `indexOf`, `substring`, `split`, and safe null checks instead.
If the migrated Cloud script still parses XML, import the Cloud-compatible Groovy class explicitly: `import groovy.xml.XmlSlurper`. Do not rely on implicit imports for XML helpers.
</library_availability>
<string_literal_fidelity>
When preserving large DC string literals (XML, SOAP envelopes, HTML fragments, wiki markup, JSON examples), keep them as valid Groovy string literals. Do not JSON-escape forward slashes inside Groovy strings.

- Correct inside a Groovy string: `&lt;/tag&gt;`
- Wrong inside a Groovy string: `&lt;\/tag&gt;`, because `\/` is not a valid Groovy escape sequence.
  Use triple-quoted strings for large literals and paste XML/HTML entity text as-is unless the DC source itself contained escaped backslashes.
  </string_literal_fidelity>
  <http_client_contract>
  Use only the injected ScriptRunner HTTP helper methods: `get(url)`, `post(url)`, `put(url)` and `delete(url)`.

Do not import or use raw HTTP clients in migrated Groovy output, including `io.github.openunirest.http.Unirest`, `groovyx.net.http.RESTClient`, `java.net.HttpURLConnection`, `URL.openConnection()`, Apache HTTP clients or similar libraries. Raw clients bypass ScriptRunner's request mediation, authentication handling, permission model and outbound execution controls. Convert them to the helper form, even when the Data Center source used `RESTClient`:
`groovy
        def response = post("https://api.example.com/v1/action")
            .header("Authorization", "Bearer ${token}")
            .header("Content-Type", "application/json")
            .body(JsonOutput.toJson(payload))
            .asObject(Map)
        `
When converting `new URL(...).openConnection()`, `RESTClient(host)` or application-link request factories, preserve the remote service URL. Do not prepend Jira's `baseUrl` and do not turn a third-party/service URL into a relative Jira REST path.
If the DC source contains a host/path string without a URL scheme, normalise it to an absolute URL before use with the helper. For HTTP-style service examples, `host/path` becomes `http://host/path` unless the source or config explicitly says HTTPS.
If a DC application-link target URL is provided alongside the source, use that configured remote base URL directly. `baseUrl` is the Jira Cloud site, not the linked external service.
If the DC source includes a named configuration constant for an ApplicationLink URL or remote service base URL, preserve and use that constant when translating `createAuthenticatedRequestFactory().createRequest(...)` calls. Do not replace it with `${baseUrl}/wiki` or another same-site guess unless the DC source itself points at the Jira site's `/wiki` path.
</http_client_contract>
</cloud_constraints>

    <cloud-hapi>

HAPI classes in cloud reside in a different package than data center. A mapping table is provided below for reference:
<class_reference_table>
| Simple Class Name | Fully Qualified Class Name | Purpose |
|-------------------|--------------------------------------------------|---------|
| Issues | com.adaptavist.hapi.cloud.jira.issues.Issues | Issue collection operations |
| Projects | com.adaptavist.hapi.cloud.jira.projects.Projects| Project collection operations |
| Users | com.adaptavist.hapi.cloud.jira.users.Users | User collection operations |
| Groups | com.adaptavist.hapi.cloud.jira.groups.Groups | Legacy group helpers; do not use for membership mutation |
| Components | com.adaptavist.hapi.cloud.jira.components.Components | Component collection operations |
| Issue | com.adaptavist.hapi.cloud.jira.issues.Issue | Single issue instance operations |
| Project | com.adaptavist.hapi.cloud.jira.projects.Project | Single project instance operations |
| User | com.adaptavist.hapi.cloud.jira.users.User | Single user instance operations |
</class_reference_table>

Plural classes (e.g. `Issues`) are imported by default into all scripts. Singular classes (e.g. `Issue`) are not imported by default; import them explicitly.
<known_component_lead_caveat>
Cloud HAPI issue components are sparse refs, not fully hydrated components. Treat values from the issue component collection (for example `Issues.getByKey(...).components` or `issue.components`) as embedded issue payload data only.

Do not rely on `issue.components.first().leadAccountId` or `issue.components.first().lead` for component-lead lookups. Those values may be null even when the component has a lead.

To get the component lead in Cloud:

- Read the component id from the issue component ref.
- Fetch the full component via `Components.getById(component.id as String)` or the REST component endpoint.
- Read the lead from the fetched component as `component.lead?.accountId`.

Type-safe rule: the Cloud HAPI `Component` API exposes `lead`, not `leadAccountId`. Prefer `component.lead?.accountId` in generated code.

For DC `ProjectComponentManager.findByComponentName(projectId, name)` migrations, do not use `GET /rest/api/3/component` as a search endpoint. Jira Cloud lists components for a project at `GET /rest/api/3/project/{projectKeyOrId}/components`; filter that list by `name`. If the component is missing, create it with `POST /rest/api/3/component` using the project key/id, then set the issue Components field to the returned component id/name.
</known_component_lead_caveat>
<identifier_semantics_caveat>
When migrating from Data Center or raw Jira REST examples into Cloud HAPI, do not assume a string identifier has the same meaning across APIs. A DC API or REST payload may use a canonical entity name or id, while a Cloud HAPI method may expect a human-facing label, direction label or other semantic form.

Migration rule:

- Do not blindly copy string literals from DC APIs into Cloud HAPI calls.
- Check what the Cloud HAPI method actually matches on before reusing a DC constant.
- If the HAPI method's expected identifier semantics are unclear, prefer the Jira REST API form that directly mirrors the original DC concept.

Explicit Cloud HAPI issue-link rule: `issue.link(...)` expects the link direction label string, not the canonical link type name. Examples of direction labels: `blocks`, `is blocked by`, `duplicates`, `is duplicated by`. If you only know the Jira REST link type name and cannot confidently derive the HAPI direction label, prefer direct REST issue-link creation instead of guessing the HAPI string.

For DC `IssueLinkManager.createIssueLink(sourceIssueId, destinationIssueId, linkTypeId, sequence, user)`, prefer raw Jira REST over HAPI so the DC source and destination endpoints are preserved exactly. In a `POST /rest/api/3/issueLink` payload the `inwardIssue` is the acting/source endpoint and the `outwardIssue` is the target/destination endpoint. Send the DC source as `inwardIssue` and the DC destination as `outwardIssue` (for example, to record that A blocks B, POST `inwardIssue: A`, `outwardIssue: B`, `type.name: "Blocks"`). Identify both endpoints with minimal `[key: issueKey]` references; never forward HAPI ids or whole issue objects.

Adding a link through `update.issuelinks` on an issue create or edit names the endpoint the other way round: the key gives the role of the other issue, as in a `GET` link entry. Editing A with `add: {type: {name: "Blocks"}, outwardIssue: {key: B}}` records that A blocks B. Never copy a `POST /rest/api/3/issueLink` payload's `inwardIssue`/`outwardIssue` into `update.issuelinks`; doing so reverses the link.

Do not use HAPI `sourceIssue.link(outwardDirectionLabel, destinationIssue)` as the default translation for DC `createIssueLink(source,destination,...)`. HAPI direction helpers suit user-authored Cloud scripts, but raw REST is less ambiguous when preserving a DC source/destination call byte-for-byte.

Do not skip link creation silently when DC first resolves an issue object from a key/id before `createIssueLink`. If the DC lookup would fail for a null, blank or nonexistent key, the Cloud port should also fail before creating a link, rather than returning early or posting `/issueLink` with an unchecked key. Resolve the target issue first, then build the issue-link payload only after that lookup succeeds.

General issue-link model:

- Jira REST issue links are directed links with two named endpoint roles, `inwardIssue` and `outwardIssue`. The roles have a fixed, verifiable meaning, so derive direction mechanically rather than by intuition.
- `type.name` is the stable issue-link type identity used when DC checks `issueLinkType.name`. The REST `type.inward` and `type.outward` values are human-readable direction phrases, not substitutes for the type name. If the DC filter compares a link type name, compare Cloud `type.name` even when a direction phrase looks semantically similar.
- Preserve a source link-type lookup argument character-for-character in the Cloud `type.name` comparison. Do not singularise, pluralise or substitute a direction verb for that configured identity.
- In a `GET /rest/api/3/issue/{key}?fields=issuelinks` response, Jira omits the current issue endpoint and returns only the other endpoint. Reading issue X's links: an entry carrying `outwardIssue: Y` means **X ⟨type.outward⟩ Y** (X is the acting/source side). An entry carrying `inwardIssue: Z` means **Z ⟨type.outward⟩ X** (X is the target side).
- The same link therefore appears under `outwardIssue` when read from one endpoint and under `inwardIssue` when read from the other. A mixed `fields.issuelinks` array can contain entries for both directions, so filter for the exact endpoint property before dereferencing `inwardIssue.key` / `outwardIssue.key`. Casting a missing endpoint to Map and dereferencing it is not a directional filter.
- Issue objects embedded inside `fields.issuelinks` are sparse refs. Do not expect fields such as `assignee`, `reporter`, `description` or custom fields on `link.inwardIssue.fields` / `link.outwardIssue.fields`.
- If the DC source reads fields from a linked issue (for example `allIssues[0].assignee`, `sourceObject.reporter` or `destinationObject.getCustomFieldValue(...)`), first identify the linked issue key from `issuelinks`, then fetch that issue explicitly with the required `fields=...` before reading those values.
- DC `IssueLinkManager.getInwardLinks(issue.id)` / `getOutwardLinks(issue.id)` returns `IssueLink` objects with `sourceObject` and `destinationObject`. `getOutwardLinks(X)` means X is the DC source; `getInwardLinks(X)` means X is the DC destination. The behaviour is defined by which property the source reads, so preserve the exact issue object the source dereferences, not just the collection name.
- Mechanical mapping for the current issue X:
    - DC `getOutwardLinks(X)` + `.destinationObject` (the other issue) → Cloud entries on X that contain `outwardIssue`.
    - DC `getInwardLinks(X)` + `.sourceObject` (the other issue) → Cloud entries on X that contain `inwardIssue`.
    - DC `getOutwardLinks(X)` + `.sourceObject` and DC `getInwardLinks(X)` + `.destinationObject` both refer back to X itself. Do not mistake either for the linked issue.
- DC `LinkCollection.getInwardIssues(typeName)` / `getOutwardIssues(typeName)` returns the linked issue objects directly under the same model: `getInwardIssues` yields the issues on entries containing `inwardIssue`, `getOutwardIssues` yields the issues on entries containing `outwardIssue`.
- Cloud HAPI `issue.getInwardLinks()` filters REST links where `inwardIssue` is present, and `issue.getOutwardLinks()` filters REST links where `outwardIssue` is present.
- If the DC code filters by `issueLinkType.id` and no explicit Cloud link-type id mapping is provided, do not rely only on that DC numeric id in Cloud. Numeric issue-link type ids are tenant-specific. Also match the link type name/direction phrase visible in the DC source when available.

For traversing existing links, prefer raw REST `fields=issuelinks` when translating DC `IssueLinkManager` code that dereferences `sourceObject` or `destinationObject`. The REST payload states the endpoint role explicitly, whereas the HAPI wrappers are easy to confuse with the DC link-manager names and a script can compile while silently selecting no linked issue. Do not import `com.atlassian.jira.rest.clientv2.model.IssueLink` just to mirror DC `com.atlassian.jira.issue.link.IssueLink`; prefer plain REST maps for existing-link traversal.

Hard-coded issue retrieval rule:

- If DC code explicitly fetches an issue by a literal key/id (for example through IssueService or IssueManager) and assigns it to a local variable named `issue`, that local issue shadows the workflow/event binding. Keep the side effects targeted at the fetched literal issue. Do not "simplify" to the Cloud event's `issue.key` unless the DC source actually uses the event issue for that side effect.

Workflow transition id rule:

- DC workflow action ids are workflow-local/tenant-local. Do not assume a DC numeric action id is the same id in Jira Cloud.
- If the DC source or supplied context gives a target transition/status name for that action, fetch `GET /rest/api/3/issue/{key}/transitions`, select the available transition by name or by `to.name`, then POST the Cloud transition id returned by that endpoint. Whenever a target transition or status NAME is available alongside a DC action id, resolve the name through the transitions lookup rather than posting the DC numeric id.
- If the only source-visible transition constant is a DC numeric action id and no name/status mapping is available, use that numeric id as a last-resort selector against `GET /issue/{key}/transitions`; do not invent placeholder names like "Target Transition Name". POST it only after confirming the returned transition has that id AND `isAvailable != false`. If no matching available transition is returned, no-op like an invalid DC `validateTransition(...).isValid() == false`. A transition with the right id but `isAvailable: false` is not valid and must not be posted.
- POST a hardcoded numeric transition id without a preceding availability lookup only when the prompt explicitly says it is the Cloud transition id.

Comment REST payload rule:

- Jira Cloud REST v3 comment create/update expects `body` to be an ADF document map, not an arbitrary string.
- Preserve the DC comment text exactly. Do not "modernise" bracket syntax inside string interpolation. If DC writes `"[~${issue.assignee?.key}]"`, the Cloud text stays `"[~${assigneeAccountId}]"`, not `"[~accountId:${assigneeAccountId}]"`. If DC writes plain bracket interpolation such as `"[${someUser?.key}]"`, keep plain brackets without adding a mention prefix. Emit Cloud accountId mention markup only when the DC source already requested that exact output format.
- Listener comment bindings and event payloads may expose `comment.body` as a plain string (legacy-style inputs) or as an ADF map (Cloud-shaped inputs). Never assume one shape without checking. Before a Jira v3 comment create/update, normalise that union explicitly: reuse a valid ADF document Map, but wrap a String in a doc/paragraph/text structure. An event binding being named `comment` does not make its body a v3 REST response shape.
- Comment event `issue` bindings are sparse. They usually include only `id`, `key`, `self` and `fields.summary`. If DC code needs project key, issue type, components, labels, parent or any other issue field, fetch the issue explicitly, e.g. `GET /rest/api/3/issue/${issueKey}?fields=project`.
- DC `commentManager.getCommentsForUser(issue, user)` means "comments visible to that user", not "comments authored by that user". In Cloud, `GET /rest/api/3/issue/{issueKey}/comment` already returns comments visible to the app/user context; do not filter the result by `comment.author.accountId` unless the DC source explicitly filtered authors.
- If DC code reads `issue.comments`, `issue.comments.last()`, `commentManager.getComments(issue)` or a sorted issue-comment collection, do not substitute the Cloud event `comment` binding. Fetch the issue's comments with REST, then select the same element/order the DC code selected (for `.last()`, use the last/newest persisted comment after sorting by created time, or request enough comments and take the final entry). Use the event `comment` binding only when the DC source itself refers to the triggering comment, not when it asks for comments from the issue object/manager.
- When reading comments from `GET /rest/api/3/issue/{key}/comment`, use `comment.body` as the source of truth. In REST v3 this is normally an ADF document map. Flatten ADF recursively to plain text when DC code uses `comment.body.contains(...)`, `substring...`, regex matching or other string operations.
    - Do not rely on `renderedBody` unless you explicitly requested the matching expand and verified the field exists. If `renderedBody` is absent, falling back to an empty string loses the comment content and usually produces an invalid blank issue key.
    - JSM comment internal/public visibility is carried by the `sd.public.comment` entity property. Writing that property on its own through the standalone comment-property endpoint updates the property record without reliably changing the visibility users observe. Change it through the owning comment-update API (`PUT /rest/api/3/issue/{issueKey}/comment/{commentId}`, requesting the properties expansion) so the property travels with the comment update, and carry the existing ADF body through unchanged. This is a specific instance of the general rule that a property write is not a substitute for the product API that owns the behaviour.
- Before POSTing to `/rest/api/3/issue/{key}/comment`, normalise the copied body:
    - If it is already a Map with `type == "doc"`, pass it through.
    - If it is a String, wrap it as `[type: "doc", version: 1, content: [[type: "paragraph", content: [[type: "text", text: bodyString]]]]]`.
    - If it is null or an empty String, skip the create when the DC source guarded on an empty comment body.

Issue listener payload rule:

- The `issue` binding on Jira issue listeners is a webhook map, not a full HAPI issue and not a guaranteed expanded REST issue. Do not read `issue.fields.project`, `issue.fields.issuetype`, `issue.fields.status`, `issue.fields.subtasks`, `issue.fields.parent`, custom fields or link fields from the binding unless the event's documented bindings (for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool) show that field is present for this event.
- If DC code uses `event.issue.getProjectObject()`, `event.issue.issueType`, `event.issue.status`, `event.issue.parentObject`, `event.issue.subTaskObjects`, custom fields or linked issues, fetch the current issue by key with the required `fields=...` before applying the logic.
- Preserve DC numeric `IssueEvent.eventTypeId` checks by checking the Cloud event map's numeric/string `eventTypeId` when present. For DC `IssueEvent.eventTypeId == 13` / Generic Event guards, Jira Cloud Connect issue webhooks can expose the subtype as `issue_event_type_name == "issue_generic"`; use that mapping when `eventTypeId` is not available.

Explicit Cloud HAPI custom-field identity rule:

- If the DC source resolves a custom field by id (for example `getCustomFieldObject("customfield_12345")`, `getCustomFieldObject(12345L)` or an inline id mapping comment), preserve that identity in Cloud reads and writes. In output produced for the Dev and Deployment Tool, the persisted form is `%customField-customfield_12345%`, not the raw source id.
- Treat a source-provided Cloud id mapping as authoritative even when the executable DC code originally looked the field up by name. Replace the DC name lookup with the supplied Cloud id; do not repeat the name lookup through HAPI or `/field` discovery.
- For an ordinary known-site script, prefer `getCustomFieldValue(12345L)` / `setCustomFieldValue(12345L, ...)` for id-resolved fields. For portable output for the Dev and Deployment Tool, those numeric overloads cannot safely contain a textual mapping marker whose Cloud value is `customfield_N`; use Jira REST reads/writes keyed by the quoted `%customField-customfield_12345%` marker instead. Do not switch to a display-name lookup.
- Field names are not unique in Jira Cloud. Name-based HAPI access can throw `DuplicateCustomFieldException`; id-based access preserves the DC field identity.
- Before presenting code, inventory every custom field whose Cloud id is present in the source and reject the script if any access to that field still uses its display name.
- If the DC source compares an id-addressed custom field directly to a primitive literal (for example a text field value equals `"expected-text"`), reading the raw Jira REST field by id is often the safest fidelity path: `GET /rest/api/3/issue/{key}?fields=customfield_12345`, then compare `fields.customfield_12345` as the primitive wire value. This avoids HAPI conversion or display-shape changes before a gate condition.

Explicit custom-field option write rule: prefer Jira REST for select, radio, checkbox, multi-select and cascading-select writes. HAPI option setters are runtime-version-sensitive and can compile but fail or silently leave a field unchanged, including both option-map varargs and value-based closures. Do not use `setCustomFieldValue(...)` as the default migration path for option fields.

- When preserving option IDs, prefer a raw REST issue update: single select/radio `fields.customfield_12345 = [id: '10021']`; multi-select/checkboxes `fields.customfield_12345 = [[id: '10021'], [id: '10022']]`; cascading select `fields.customfield_12345 = [id: '10021', child: [id: '10022']]`.
- When the DC source works with human-readable option values, preserve those values directly with REST option objects: single select/radio `[value: 'First']`; multi-select/checkboxes `[[value: 'First'], [value: 'Second']]`. Do not perform an id lookup unless identity rather than display value is load-bearing.
- Never construct or send `[id: null]`, `[value: null]` or a multi-value list containing such a reference. Use an id reference only when the read/lookup actually returned a nonblank id. If the raw option contains only a nonblank `value`, preserve it as a minimal value reference. If neither identity is present, follow the source's null/empty behaviour rather than inventing an option reference.
- For cross-issue option aggregation or copying, read the raw field by id from Jira REST when the output needs option ids/maps. Do not cast a HAPI `getCustomFieldValue(...)` result to `Map` and assume it has an `id`: runtime wrappers may expose a display String or another HAPI shape. Normalise a REST single option map or list of option maps, then build the minimal target write references.
- If an id lookup is required, resolve the field context for the issue's project and issue type, then fetch that context's options. Do not assume `editmeta.allowedValues` is complete or stable enough to be an option catalogue.
- Never forward whole maps returned by edit metadata or the option catalogue into an issue update; they can contain read-only/catalogue properties and are not write references. Likewise, when a raw REST field returns an option object with `id` and/or `value`, rebuild only the minimal target write reference from the properties actually present: only `id` or only `value`, plus a minimal nested `child` for cascade fields. Discard null lookup results before constructing a multi-value array. Do not confuse that stable REST shape with a HAPI custom-field return value, and do not forward catalogue metadata or an unverified runtime wrapper.
- To clear an option field through REST, write `null` for single/cascade fields or an empty list for multi-value fields, matching the target field schema.
- A Jira REST cascading-select value is keyed data: the parent option is at `value`/`id` and the child option is under `child.value`/`child.id`. Never infer parent and child by iterating `map.values()`, taking first/last entries or depending on map order; the map also contains identity and metadata properties.

Explicit Cloud HAPI custom-field clearing rule:

- Do not clear a custom field with `setCustomFieldValue(fieldId, null)`. Groovy can select an ambiguous overloaded HAPI method for null and fail at runtime.
- Use the HAPI clear closure: `setCustomFieldValue("Field Name") { clear() }` or `setCustomFieldValue(12345L) { clear() }`.
- Apply this when the DC source writes `null`, removes a value or copies a null source value into a target custom field.
- For conditional copy logic, branch explicitly: if the source value is non-null, set it with the type-appropriate value shape; otherwise call the clear closure.

<scripted_field_bindings>
In ScriptRunner Cloud scripted field execution, the main bindings are:

- `baseUrl` : `java.lang.String` — the Jira base URL for relative REST requests
- `logger` : `org.slf4j.Logger`
- `issue` : `java.util.Map` — the issue details as a raw REST-like map

Scripted field rule:

- Treat `issue` as a raw map payload, not as an already-typed HAPI `Issue`.
- Read fields from `issue.fields` when possible.
- If you explicitly need a HAPI issue object, refetch it with `Issues.getByKey(issue.key as String)`.
- Do not assume the scripted field bindings expose HAPI methods directly on `issue`.

Scripted field output-type mapping:
| Scripted field type | Expected script return shape |
| --- | --- |
| `TEXT_FIELD` | Return a plain `String` |
| `NUMBER_FIELD` | Return a numeric value (for example `Integer`, `Long`, `Double`, `BigDecimal`) |
| `DATE_FIELD` | Return a date-only value that ScriptRunner can normalise to a Jira date string. Safest forms are `java.time.LocalDate` or a Jira date string `yyyy-MM-dd` |
| `DATETIME_FIELD` | Return a datetime value that ScriptRunner can store as a Jira datetime. Safest forms are `java.time.ZonedDateTime`, an ISO zoned datetime string, or an already formatted Jira datetime string such as `yyyy-MM-dd'T'HH:mm:ss.SSSZ`. |
| `RICH_TEXT_FIELD` | Return a plain `String` ONLY when the output has no formatting at all (single line of text, no line breaks, no markup, no lists, no links). For anything else — especially any DC source that builds an HTML string with `<br>`, `<p>`, `<ul>`, `<a>`, `<b>`, `<strong>`, `<em>`, `&nbsp;`, etc. — you MUST return a valid ADF document map. A plain `String` is wrapped verbatim into a single `text` node, so HTML tags inside it become visible characters, not rendered formatting. |
Do not return arbitrary Java objects just because Groovy allows it.
For scripted fields, the return value is the product contract, so choose a value shape that matches the declared scripted field type exactly.
For `TEXT_FIELD`, never return raw collections, users, versions, issue refs, or other Jira objects. Do not return a `List` even when it contains only strings; return a single `String` or `null`. If the DC source returns a collection into a text field, Cloud should return the same text rendering the DC UI would show unless the source explicitly joins or formats the members another way.
A DC Jira `Issue` object's `.toString()` value is its issue key. When a text scripted field returns or stringifies a list of DC Issue objects, a raw Cloud REST list of issue maps is not representation-equivalent: map `it.key as String` first, then call `.toString()` on the key list. Never stringify the whole REST issue maps, which leaks ids, self URLs, and nested fields instead of the DC display value.
Cloud HAPI version values are objects with a `.name` property, not maps, and the user-facing text form of a Jira version is its name. If a text scripted field returns a version collection, derive the text from the version names rather than returning raw Cloud HAPI `Version` instances or REST maps, and reproduce whatever join/format the DC source itself applied.
ScriptRunner Cloud post-processes scripted field output by type. For `DATETIME_FIELD`, `ZonedDateTime` and ISO-zoned strings are formatted with ScriptRunner's Jira datetime formatter `yyyy-MM-dd'T'HH:mm:ss.SSSXX`; zero offset may serialize as `Z`. An already-formatted Jira datetime string using the no-colon offset form is also accepted, but do not depend on exact offset spelling when a typed datetime is returned. Do not return raw `java.util.Date` / `java.sql.Timestamp` from scripted fields; convert to `ZonedDateTime` or a string first, otherwise it may serialize as epoch millis.
A bare Data Center `return` with no value returns `null`; preserve that as `return null` even for `RICH_TEXT_FIELD`. Do not convert a missing-value bare return into an empty ADF document unless the DC source actually returns an empty HTML/string accumulator.

<rich_text_html_to_adf>
Migrating a DC rich-text scripted field whose source concatenates HTML markup is a frequent failure mode. The DC script "works" because DC renders the returned HTML in the UI; Cloud does not. The returned value goes into the ADF pipeline, and a plain String is placed inside one `text` node as-is.

When the DC source emits any HTML or structural markup:

1. Before presenting code, enumerate every distinct visual element the DC HTML produces (line break, paragraph, list item, link, bold span, etc.) and map each to its ADF node equivalent (`hardBreak`, `paragraph`, `bulletList`/`orderedList` + `listItem`, `text` with `link` mark, `text` with `strong`/`em` marks, etc.).
2. Translate the HTML into an equivalent ADF document structure. Write that structure into the Cloud script as a literal Groovy map-literal, then populate dynamic values (issue keys, numbers, names) at runtime by building the same structural Map programmatically. Keep the ADF structure as close to the original HTML visual layout as possible: one `<br>` → one `hardBreak`; `<ul><li>…` → `bulletList` / `listItem`; etc.
3. NEVER return a String that still contains `<` characters from HTML tags. If you find yourself writing `append("<br />")`, `+ "&lt;"`, or returning a `StringBuilder` of mixed markup, stop and rebuild the return value as a structural ADF Map.
4. The "plain String path" for `RICH_TEXT_FIELD` is reserved for cases where the DC source is itself already a single unformatted line of text (e.g. `return issue.summary`, `return "Summary: " + issue.summary`). Everything else must emit ADF.
5. Preserve inline styling that the DC HTML applied to text. `font-style:italic` maps to an `em` mark, `font-weight:bold` / `<strong>` maps to `strong`, and `color:...` maps to a `textColor` mark with the same visible colour. If one HTML span styled both colour and italic, the ADF text node needs both marks.
6. If the DC HTML accumulator remains empty, return an empty ADF document `[type: "doc", version: 1, content: []]`, not a paragraph with empty content or placeholder text, unless the DC source explicitly emitted placeholder text.
7. Preserve which text is inside each styled HTML element. If a DC `<span style="...">` concatenates a header and rendered body before closing the span, the body text inherits the same marks in ADF. Do not split inherited inline content into a separately unstyled paragraph unless the DC HTML actually closed the styled element first.
8. If the DC HTML uses `<br>`, `<br/>`, or `join("<br>")` between lines inside one paragraph-like accumulator, represent those line breaks as ADF `hardBreak` nodes inside the same paragraph. Do not split each line into separate paragraphs unless the DC source used paragraph/list block markup such as `<p>`, `<div>`, `<ul>`, or `<ol>`.

Before presenting code, check: (a) the HTML structure the DC source builds, (b) the ADF node shape chosen for each element, and (c) that the returned value is a Map (ADF) whenever any markup is involved.
</rich_text_html_to_adf>

<numeric_conversion_fidelity>
Preserve the exact numeric conversion semantics from the DC source. Do not make parsing more permissive.

- `Integer.parseInt(x)`, `x as Integer`, and `x.toInteger()` reject decimal strings such as `"1.5"`; the faithful Cloud port should also throw instead of silently accepting `BigDecimal`.
- If the DC source does `Integer.parseInt(value.toString()...)`, call `toString()` on the raw Cloud value before parsing. Do not call `intValue()`, cast through `Number`, or otherwise coerce to an integer before `Integer.parseInt`; that truncates decimals the DC source would reject.
- `Double.parseDouble(x)`, `BigDecimal`, and explicit decimal arithmetic may accept decimal strings; use those only when the DC source did.
- Preserve null behavior: if DC would throw on null, do not add a null-as-zero guard unless the source already had one.
  </numeric_conversion_fidelity>
  </scripted_field_bindings>

<custom_field_copy_matrix>
When migrating logic of the form `source.getCustomFieldValue(...) -> target.setCustomFieldValue(...)`, use field-type-aware copy semantics. Do not assume every field can be copied with one generic strategy.

Cloud HAPI `getCustomFieldValue(...)` may return richer Groovy/JSON shapes than the final wire format you need to write back. Check the target field type before passing the returned object through.

Grounded return-shape hints from real Jira Cloud probes:
| Field shape | Typical `getCustomFieldValue(...)` return |
| --- | --- |
| Text / URL | `String` |
| Textarea / rich text | `String` |
| Number | numeric object |
| Date | `java.sql.Timestamp` |
| Datetime | `java.sql.Timestamp` |
| Single select / radio | `LinkedHashMap` option object with fields like `id`, `value` |
| Multi-select / checkboxes | `ArrayList` of option objects |
| Cascading select | `LinkedHashMap` parent option object with optional child option |
| Labels | list of strings |
| Single version | `LinkedHashMap` version object |
| Multi-version | `ArrayList` of version objects |
| Project picker | `LinkedHashMap` project object |
| User picker | `LinkedHashMap` user object |
| Multi-user picker | `ArrayList` of user objects |
| Group picker | `LinkedHashMap` group object |
| Multi-group picker | `ArrayList` of group objects |

| Field shape               | Safe Cloud HAPI copy form                                                                                                                                              |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Text / URL                | Copy the returned string directly                                                                                                                                      |
| Textarea / rich text      | Copy the returned string directly; if you receive ADF from another path, normalise it to plain text before writing                                                     |
| Number                    | Copy the numeric value directly                                                                                                                                        |
| Date                      | Convert the returned `Timestamp` to a Jira date string `yyyy-MM-dd` before writing                                                                                     |
| Datetime                  | Convert the returned `Timestamp` to a Jira datetime string `yyyy-MM-dd'T'HH:mm:ss.SSSZ` before writing, using the active Jira user's timezone rather than assuming UTC |
| Single select / radio     | Copy the returned option object directly, or use `[id: '...']`, or the option value string                                                                             |
| Multi-select / checkboxes | Spread the returned option objects, or use raw `[id: '...']` objects, or value strings with value-based setters                                                        |
| Cascading select          | Copy the returned cascade option object directly, or use `[id: 'parent', child: [id: 'child']]`, or parent/child value strings                                         |
| Labels                    | Spread the returned strings                                                                                                                                            |
| Single version            | Copy the returned version object directly                                                                                                                              |
| Multi-version             | Spread the returned version objects                                                                                                                                    |
| Project picker            | Copy the returned project object directly, or use the project key if the target API expects a key                                                                      |
| User picker               | Copy the returned user object directly, or use accountId if the target API expects accountId                                                                           |
| Multi-user picker         | Spread the returned user objects, or use accountIds only when the target API explicitly expects them                                                                   |
| Group picker              | Copy the returned group object directly, or use the group name if the target API expects a name                                                                        |
| Multi-group picker        | Spread the returned group objects, or use group names only when the target API explicitly expects names                                                                |

Date rule:

- If `getCustomFieldValue(...)` returns a `Timestamp` / date-like object for a date or datetime custom field, do not pass that raw object into `setCustomFieldValue(...)`. Reformat it into the Jira wire string first.
- Date: `yyyy-MM-dd`
- Datetime: `yyyy-MM-dd'T'HH:mm:ss.SSSZ`, with the offset of the Jira user's timezone on that site. Do not hardcode `+0000`, assume UTC, or use the Groovy runtime's system timezone.
- Grounded behaviour: in real Jira Cloud probes, the Groovy runtime timezone was UTC while Jira returned datetime field strings using the Jira user's timezone offset.
- To format a HAPI `Timestamp`, use the active user's Jira timezone (for example from `/rest/api/3/myself` if needed) so the written string matches the site's local-offset representation.
- If you already have the original Jira REST datetime string and do not need to transform it, preserve that exact string rather than reconstructing it from the runtime default timezone.
- If the DC source only coerces a date/datetime to text as part of a returned or written string, and Cloud REST already supplies that value as a timestamp String, use the REST String directly. Parse and reformat only when the source performs date arithmetic or requests an explicit output format; reformatting can change timezone/representation or reject Jira's no-colon offset.
- Jira issue REST fields like `issue.fields.created` and `issue.fields.updated` use the format `yyyy-MM-dd'T'HH:mm:ss.SSSZ`, with a colon-less numeric offset (`+0000`-style) that is not strict ISO-8601. The Jira formatter `yyyy-MM-dd'T'HH:mm:ss.SSSZ` is the primary grounded choice for parsing them: when the source value comes from such fields, prefer it first. Do not rely on `OffsetDateTime.parse(...)` alone, because Jira commonly uses `+0100` rather than ISO `+01:00`.
- More tolerant parsing is still useful for arbitrary external datetime strings.
- Parse first, then format. Do not lock the parser to the final output format.
- Preserve Data Center `SimpleDateFormat` output text exactly. For patterns containing `a`, use an English locale and normalise the meridiem marker to uppercase `AM`/`PM` when writing text fields; lower-case `am`/`pm` is not equivalent to DC output.

When unsure about a returned value shape, inspect the field schema and/or use guarded normalisation logic (for example `instanceof Date`, `instanceof Map`, `instanceof List`) before writing the value back.

Sprint custom field (schema `gh-sprint`): writes accept only a **bare numeric sprint id**. Arrays, strings, `{id}` objects, and `update.[{add|remove}]` ops all 400. DC sprint-field writes are commonly list-shaped; a Cloud write of the same field must be a scalar id.

FixVersions replacement rule:

- When the DC source replaces an issue's fixVersions from a project version collection, preserve version identity. Do not collect version names into a `String[]` and pass that to `setFixVersions(...)`; HAPI can treat that as an invalid wire shape or lose project-specific identity.
- Cloud HAPI supports `setFixVersions(String... versionNames)`, `setFixVersions(Long... ids)`, and `setFixVersions { set(...) }`; it does not accept Cloud `Version` objects directly.
- If you have version objects, collect their names or ids first, then use Groovy spread into HAPI: `setFixVersions(*versionNames)` or `setFixVersions(*versionIds)`.
- If you have raw REST version maps/ids rather than HAPI project versions, REST is also valid for a full replacement: `PUT /rest/api/3/issue/{key}` with `fields.fixVersions: versions.collect { [id: it.id as String] }` when ids are available.
- If you only have names, use the HAPI name form intentionally, e.g. `setFixVersions(*versionNames)` or `setFixVersions { set(*versionNames) }`, and only after confirming the names belong to the issue's project.

Copying rule of thumb:

- Prefer preserving the returned object shape when the target HAPI setter accepts that object shape.
- Only normalise to strings, ids, names, or formatted dates when the target field type specifically requires it.
- Do not convert rich typed values into plain strings just because Groovy allows coercion.
  </custom_field_copy_matrix>

Common examples of strings that may need reinterpretation during migration include relation names, direction labels, option values, and other human-readable identifiers.
</identifier_semantics_caveat>
<hapi_varargs_spread_rule>
Many Cloud HAPI setters accept varargs of strings or ids, not a single collected list. When you collect values before calling one of these setters, pass them with Groovy spread:

- Correct: `setFixVersions(*versionNames)`, `setFixVersions(*versionIds)`
- Correct: `setComponents(*componentNames)`, `setComponents(*componentIds)`
- Correct for other HAPI setters with `String...` or `Long...` signatures: `setSomething(*namesOrIds)`
- Wrong: `setFixVersions(versionNames)`, `setComponents(componentNames)`, or passing a `String[]`/List as one argument when HAPI expects individual varargs.

If a HAPI setter has a closure form, spreading inside the closure is also valid when the closure method accepts varargs, e.g. `setFixVersions { set(*versionNames) }`.
Apply this to all collected names/ids; avoid spread only when the API explicitly expects a list object.
</hapi_varargs_spread_rule>
<filtered_collection_semantics>
DC's server-side manager APIs often return collections that the server has already filtered by workflow state, user permissions, field context, role membership, or other preconditions. Examples: `getAvailableActions(issue, user)` (workflow-valid transitions only), `getCustomFieldObjects(issue)` (context-visible fields only), `getProjectRoleActors(project)` (members for this project only), `isValidAction`, `hasPermission`, `Issues.search(jql)` (security-filtered by caller).

Cloud REST typically returns the unfiltered superset with a per-entry boolean flag indicating availability:

- `transitions[].isAvailable` (workflow state + permissions + conditions; some responses omit it when available, so only explicit `false` is unavailable)
- `mypermissions[].havePermission` (permission keys valid for caller)
- `issueTypes[]` in `createmeta` (versus all issuetypes in the tenant)
- field presence in `names` / `schema` maps on `/issue/{key}?expand=names,schema` (field is in context for this issue only if the keys exist there)
- `project.projectCategory` is present only if a category was assigned when the issue was loaded

Rules when porting DC code that iterates or does a name/id lookup inside a DC-filtered collection:

1. Name the filter the DC API applied (workflow state, caller permission, context, role membership).
2. Find the per-entry flag on the Cloud response that carries that filter, or the Cloud endpoint that applies it.
3. Apply the flag at the same logical point where the DC code relied on the collection being pre-filtered.

A name/id lookup on a Cloud collection without the flag is a silent semantic error: the entry exists in the response but is not available for the action the script is about to take. The subsequent POST/PUT will throw or silently misbehave, and the error path is almost always a distinct DC branch, not the same one with a "catch and continue" patch.

Common DC → Cloud pre-filter → flag mappings (non-exhaustive):

- `IssueWorkflowManager.getAvailableActions(issue, user)` → `GET /issue/{key}/transitions` (or search with `expand=transitions`) → reject only entries with `isAvailable == false`
- HAPI `issue.getTransitions()` → same: treat an omitted availability property as available and reject explicit `false`
- `CustomFieldManager.getCustomFieldObjects(issue)` → `GET /issue/{key}?expand=names,schema` → field only in context if present in `names` / `schema`
- `PermissionManager.hasPermission(perm, issue, user)` → `GET /mypermissions?permissions=...` → check `havePermission`
- `ProjectRoleManager.getProjectRoleActors(role, project)` → `GET /project/{key}/role/{roleId}` → iterate the `actors` array; do not assume a role applies because its id exists in `/role`
  </filtered_collection_semantics>
  <hapi_exception_branch_mapping>
  HAPI wrapper exceptions encode which DC branch the code should fall into. The exception class carries the DC-branch meaning, so treat it as a discriminant, not as "an error to log and move on from":

- `IssueTransitionValidationException` thrown by `issue.transition(name)` means "transition is not currently valid for this issue/user". This is DC's `actionId <= 0` branch (the named action was not in `getAvailableActions`). On DC, this branch skips side-effects tied to a successful transition (comments, change-holder updates, dependent field writes) and often takes a distinct fallback with its own side-effect set.
- `IssueRetrievalException` / `NoSuchCustomFieldException` → "record does not exist in the current context". DC handled this with a null check before the side-effect block.
- `DuplicateCustomFieldException` → multiple fields share the same name; DC disambiguated by id upstream.

A generic `try { hapiCall() } catch (Exception e) { logger.warn(...) }` that flows through to unconditional side-effects (addComment, update, transition POST) conflates "precondition not met" with "operation attempted and failed". DC almost always treats these as separate branches with different side-effect sets. When catching a HAPI exception:

1. Identify which DC branch the exception maps to.
2. Apply only that branch's side-effects.
3. Do not let side-effects from a different branch leak through.

Prefer pre-checks (filter the collection by the availability flag before calling the HAPI action) over post-catches, because the pre-check path mirrors DC's control flow. DC never called `issueService.transition` on an unavailable action, so the Cloud port should not call `issue.transition(name)` on an `isAvailable == false` transition either. A pre-check keeps the error path out of the catch entirely.
</hapi_exception_branch_mapping>
<epic_parent_sunset>
Atlassian removed the legacy epic-link and parent-link custom fields, and the Epic-Story Link issue link type, from the Jira Cloud REST API and webhooks during 2025. The unified `parent` field replaces them everywhere on the REST surface. JQL predicates for the legacy field names still work indefinitely (no JQL changes).

Scope: the sunset covers only the parent/child pointer fields (customfields whose purpose is to point one issue at its parent epic, parent initiative, etc.) and the Epic-Story Link issue-link type. It does not cover:

- `Epic Name` — the Epic's own display name customfield. Still present, still readable by id, still distinct from `summary`. Do not replace reads of it with `fields.summary` or `fields.parent`.
- `Epic Status` — the Epic's workflow status customfield. Unchanged.
- `Epic Colour` / `Epic Color` — the Epic's display-colour customfield. Unchanged.
- Any other Greenhopper-era "Epic \*" customfield that stores epic-intrinsic data (not a pointer to another issue).
- Any non-epic customfield whose id happens to live in a nearby numeric range.

Read these by their customfield id as usual.

Epic-link and parent-link are role-based, not id-based. The DC source's tenant uses its own numeric customfield id for each (e.g. `customfield_14XXX`, `customfield_17XXX`); do not assume only `customfield_10014` / `customfield_10018` are affected. Any customfield whose purpose is to point the issue at its parent/epic, identified by its name ("Epic Link", "Parent Link", "Parent") or the DC script's comment mapping, is covered, regardless of numeric id. Drop the read and rewrite the write to `fields.parent`.

Forbidden in Cloud output (these fail at runtime on a modern tenant):

- Reading the legacy epic-link / parent-link custom field by id off an issue response: any `fields.customfield_XXXXX` that the DC source labels "Epic Link", "Parent Link", or an equivalent parent pointer. The key is no longer emitted, so the read returns null.
- Writing those ids via `PUT /issue/{key}` `fields` or `update`, or via HAPI `issue.update { setCustomFieldValue(14XXX L, ...) }` / `setCustomFieldValue(17XXX L, ...)`. On modern Cloud such writes are rejected with 400 (or silently ignored).
- Traversing any parent-child issue-link type, not just the built-in "Epic-Story Link". DC tenants routinely modelled hierarchies with their own tenant-local issue-link types. On modern Cloud every such relationship is unified under the `parent` field; there is no issue-link-type-based parent traversal. Recognise these from context rather than from a fixed list of names: the DC iterator filters outward/inward links by a link-type name that describes a hierarchy, and the other issue's role is "my parent/child in the hierarchy". Rewrite each such traversal to a `parent = "KEY"` JQL query. If separate DC branches use different hierarchy link types or hierarchy tiers, a bare parent query would merge collections the source kept distinct; preserve the distinction with the child issue-type/hierarchy predicate implied by the source branch and link semantics, even when the closure did not redundantly re-check the child type.
- Changelog items with `field: "Epic Link"` or `field: "Parent"`. Modern Cloud emits a single `field: "IssueParentAssociation"` entry with `fieldId: null`, `from`/`to` = parent issue id (string), `fromString`/`toString` = parent issue key.

Correct Cloud idioms:

- Read an issue's parent: `fields.parent` is an object `{id, key, self, fields: {summary, status, priority, issuetype}}`. Use `fields.parent?.key` wherever the DC script used `issue.getCustomFieldValue(epicLinkField)` or `issue.getParentObject()`. To resolve transitively (subtask → story → epic), walk `fields.parent` until `fields.parent.fields.issuetype.name == "Epic"`, capped at a small safety limit.
- Query children of an epic: `POST /rest/api/3/search/jql` with `jql: "parent = \"EPIC-KEY\""`. The legacy JQL names (by name or numeric id) still resolve; pick whichever mirrors the DC source.
- Set a parent: `PUT /rest/api/3/issue/{key}` with body `{fields: {parent: {key: "EPIC-KEY"}}}`. Clear it with `{fields: {parent: null}}`.
- React to parent changes in a listener: inspect `changelog.items` for `field == "IssueParentAssociation"`. Never gate on `"Epic Link"` or `"Parent"`; those items are never emitted.

DC → Cloud mappings for parent-traversal idioms (replace even when the DC source hard-codes the legacy customfield id):

- `issue.getCustomFieldValue(getCustomFieldObject("<epic-link-id>"))` → `fields.parent?.key`
- `issueLinkManager.getOutwardLinks(epic.id).findAll { it.type.name == "Epic-Story Link" }` → `Issues.search("parent = \"${epic.key}\"")` / equivalent JQL POST. Do not iterate `issuelinks` looking for the Epic-Story type.
- `issueLinkManager.getLinkCollection(issue, user).getOutwardIssues("<any-hierarchy-link-type-name>")` → `Issues.search("parent = \"${issue.key}\"")`. Add `AND issuetype = <ChildType>` to the JQL if the DC traversal only accepted a specific child type.
- `issue.getParentObject()` (DC subtask → parent) → `fields.parent`. The same field carries the Story→Epic link on modern Cloud.
- `event.changeLog.items.any { it.field == "Epic Link" }` → `event.changeLog.items.any { it.field == "IssueParentAssociation" }`.

When the DC source names an epic-link or parent-link customfield id in a comment or `getCustomFieldObject` lookup, drop the id in the Cloud port and use the `parent` field. The legacy id is dead on the wire; preserving it produces a script that reads null and silently no-ops.
</epic_parent_sunset>
<custom_field_read_to_string_rule>
DC `Option.toString()` returns the option's value string. Cloud HAPI `getCustomFieldValue(...)` for single-select / radio / cascade returns a Map `[id, value, ...]` whose `.toString()` is the map repr, not the value. Migrating `getCustomFieldValue(...)?.toString()` literally compares the map repr, so every comparison fails silently and falls through to defaults.

Extract `.value` explicitly: `(raw instanceof Map) ? (raw.value as String) : (raw?.toString())`. Cascade child: `raw.child?.value`. Multi-select / checkboxes return a List of Maps: iterate and read each `.value`, never `.toString()` the list.
</custom_field_read_to_string_rule>
<target_field_type_coercion>
When copying between unlike custom-field types, the target field's schema determines the write type. A select option's `value` is a String and is not automatically a Jira number because the target is a number field. Parse it to a numeric Groovy type such as `BigDecimal` before a numeric-field write. Normalise user, option, date and rich-text values to their target wire shapes instead of forwarding the source wrapper unchanged. Before presenting code, name both the source value shape and the target write shape for every cross-type copy.
</target_field_type_coercion>
<issue_security_level_write_rule>
Writing an issue's security level from Data Center code that uses a hardcoded numeric level id (`issue.setSecurityLevelId(<id>L)`, or any DC API that takes a `Long`/`Integer` level id) must preserve that id byte-for-byte in the Cloud port.

Cloud HAPI's `issue.update { setSecurityLevel(name) }` takes a **name**, not an id. Do not guess or invent a level name from the DC id: the DC id is tenant-local and no reliable id-to-name mapping is available inside the script. Inventing a plausible-looking level name from the numeric id is a migration bug, not a placeholder.

When the DC source hardcodes an id, use raw REST so the id travels unchanged.
<example>
// DC: issue.setSecurityLevelId(&lt;id&gt;L); issueManager.updateIssue(...)
def levelId = "&lt;the DC level id, unchanged&gt;"
def resp = put("/rest/api/3/issue/${issueKey}")
.header("Content-Type", "application/json")
.body(groovy.json.JsonOutput.toJson([fields: [security: [id: levelId]]]))
.asString()
assert resp.status == 204 : "PUT security failed: ${resp.status}"
</example>

Use `setSecurityLevel(name)` only when the DC source itself already works with a **name** (string); the name can then be passed through faithfully. This includes DC code that selects or maps a security-level name and immediately calls a manager such as `getIssueSecurityLevelsByName(name)` only to obtain the numeric id required by the DC setter. That manager lookup is a DC representation bridge, not source business logic: on Cloud, pass the selected name directly to `setSecurityLevel(name)`. Do not port the bridge as an invented `/project/{key}/securitylevel` or other catalog request.
If the DC source already contains the exact security-level name, write that name directly with HAPI or `fields.security = [name: preservedName]`. Do not invent a security-level discovery or validation endpoint before the write; a tenant-local name already in the source is the configuration contract.
</issue_security_level_write_rule>
<project_status_workflow_mapping>
DC workflow-manager code that asks for the statuses available to each issue type in one project maps to `GET /rest/api/3/project/{projectKeyOrId}/statuses`, which returns issue-type entries with their `statuses` arrays. Do not replace this read with workflow-search or workflow-mutation endpoints; they solve a different problem and may require permissions or request bodies unrelated to the source behaviour.
</project_status_workflow_mapping>
<jira_issue_wire_field_mapping>
When reading or writing raw Jira issue REST maps, use Jira's wire field names rather than DC/HAPI property names:

- affected versions / `getAffectedVersions()` → `fields.versions`
- fix versions / `getFixVersions()` → `fields.fixVersions`
- remaining estimate seconds / `getEstimate()` → `fields.timeestimate`
  Do not guess nested `timetracking` property names or use `affectedVersions` as a raw REST key. Request the required wire field explicitly when hydrating an issue.
  </jira*issue_wire_field_mapping>
  <version_filter_fidelity>
  Preserve every predicate in DC version selection exactly. DC `getVersionsUnreleased(...)` and source filters that test only release state map to `released != true`; an archived-but-unreleased version remains unreleased. Do not add `archived == false`, date, name or status filters unless the source applied them.
  </version_filter_fidelity>
  <dc_literal_identity_preservation>
  When Data Center source uses concrete literals for users, fields, options, projects, issue types, transitions, or other tenant configuration, preserve those literals unless the prompt gives an explicit Cloud mapping. Never replace a visible literal with an invented marker of your own devising such as `REPORTER_ACCOUNT_ID`, `ASSIGNEE_ACCOUNT_ID`, or `ACCOUNT_ID_FOR*...`. Nothing resolves these markers, so they ship broken.

The one sanctioned exception applies only to output produced for the Dev and Deployment Tool / a portable migration project: a registrable `%placeholder%` marker for an identifier that genuinely has no Cloud counterpart (see `<cloud_identifier_placeholders>`). That is a real mechanism the deploy tool resolves, not an invented marker. Standalone scripts keep the source's literal ids, keys and names.

For DC user APIs that take a user key/name/id literal (reporter/assignee id setters, `getUserByName("...")`, or a configured name-to-user lookup table in the source), use the supplied literal or explicit mapping as the Cloud `accountId` string when the prompt gives you the Cloud value. When it does not, in output for the Dev and Deployment Tool / a portable migration project emit `%user-<dcUserKey>%`: a Data Center user key is never a valid Cloud `accountId`, so passing it through produces a permanently false comparison rather than a faithful migration. In a standalone script with no supplied Cloud value, keep the source's literal and report the user as unresolved: it must be replaced with the user's Cloud `accountId` before the script will work. If a literal id is numeric, wrap it as a string in Cloud payloads (`[accountId: "<literal>"]`, not a bare number).

Preserve literal outbound payload keys exactly, including misspellings. If DC sends a key that looks misspelled or legacy-specific, the Cloud port must send the same key rather than silently "correcting" it. External systems may depend on exact wire keys.
</dc_literal_identity_preservation>
<assignee_and_project_role_rules>
To clear an assignee, use raw REST `PUT /rest/api/3/issue/{issueKey}/assignee` with `{"accountId": null}`. Do not use HAPI `setAssignee(null)`, `setAssignee(null as String)` or empty strings; they are interpreted as invalid user identifiers. (This payload applies only to that dedicated endpoint. In a general issue update, `PUT /rest/api/3/issue/{key}`, clear `fields.assignee` with plain `null`, not `{accountId: null}`.)

When DC code checks whether a user is in a project role by name, fetch the role map for that project with `GET /rest/api/3/project/{projectKey}/role`, read the named role URL (for example `body["Developers"]`), then fetch that URL or its trailing id via `GET /rest/api/3/project/{projectKey}/role/{roleId}`. Do not use the site-global `GET /rest/api/3/role` list to resolve project-specific or custom role names.

DC `ProjectRoleActors.getApplicationUsers()` returns the effective users in the role, including users contributed by group actors. In Cloud, project-role actor payloads can contain both `atlassian-user-role-actor` and `atlassian-group-role-actor`. Add direct user actors by `actorUser.accountId`. For group actors, prefer `actorGroup.name` with `GET /rest/api/3/group/member?groupname=<encodedName>`; use `groupId` only when that property is present. Do not invent or dereference `actorGroup.groupId` on a payload that only contains `name`/`displayName`. Include every returned member accountId and follow pagination.

Do not use an assumed `currentUserRole` boolean from a project-role detail response. To test the authenticated user, resolve their account id through `GET /rest/api/3/myself`, then compare it with direct `actorUser.accountId` values and the expanded members of group actors.
</assignee*and_project_role_rules>
<group_rest_rules>
Do not use legacy HAPI `Groups.getByName(...).add(...)`, `.remove(...)` or equivalent membership mutation methods; they are removed or unsupported on current Cloud runtimes. Use Jira REST for group discovery, creation, membership listing and user membership mutation. Group-picker custom fields can be exposed as a String or as a map containing `name` and/or `groupId`; normalise both shapes before lookup. When only a name is present, use the REST `groupname` parameter rather than passing a null group id.
</group_rest_rules>
<control_flow_fidelity_caveat>
When migrating Data Center code, preserve the \_structural* shape of the control flow, not just the computation. Nested guards, loops-inside-ifs, early returns, fall-through branches and default-value assignments all encode behaviour. Refactoring them, even into something that reads "cleaner", can silently change what the script does on edge-case inputs.

Rules:

- Preserve every guard's scope. If a loop or block sits _inside_ an `if` in DC, the Cloud translation must keep it inside the equivalent condition. Do not hoist inner statements out to a flatter structure; the nesting is load-bearing.
- Preserve early-return and short-circuit semantics. If DC skips the remainder of a branch when a value is null/zero/empty, the Cloud code must skip it too. Do not swap an early return for an `else` chain that still executes downstream effects.
- Preserve ordered fallback chains tier by tier. When the source resolves a value by trying several sources in order (a group's members, then a role's direct actors, then a named deputy, and so on), every tier and its order is behaviour, not redundancy. Reproduce each tier with the same precedence and its own emptiness test: a tier that resolves to an empty collection must fall through to the next exactly as it does in the source. Stopping at the first non-null tier, collapsing several tiers into one lookup, or treating an empty result as success yields a plausible value for the common case and the wrong actor in the edge cases the chain exists to handle.
- Preserve guarded missing-field paths across sparse REST responses. Jira can omit the entire `fields` property when a `fields=...` selection contains no populated values. If DC checks a nullable relationship/value before returning, default each enclosing response map to an empty map before reading it so the same no-op path is reachable. Do not dereference `response.body.fields.parent` before the source's parent-null guard.
- Do not add new defensive null guards that change failure into success. If the DC source dereferences a nullable value with no guard (for example `issue.getParentObject().getKey()`), the Cloud port must also fail on the equivalent missing value, or throw a clear exception from that branch. Silently returning or no-oping is a behaviour change.
- Do not replace an unsafe DC dereference with safe navigation when the null case is reachable. For example, `cfvalue.get(null)` must not become `cfvalue?.get('value')` followed by a no-op. If the source requires the field, assert/throw with the field name before continuing, or dereference in a way that still fails instead of silently skipping all side effects.
- DC cascading-select idioms often read a custom field into a variable and then call `.get(null)` on it to access the parent option. That `.get(null)` call is an unsafe dereference. In Cloud, after reading the field map, explicitly fail if the field value is null, using the source field's actual name/id in the error, then read `(cfRaw as Map).value`. Do not use `cfRaw?.value` and let unmatched branches no-op.
- Unsafe casts and accessor chains are load-bearing. If DC casts a custom-field value to an option/user/map type and immediately calls `.getValue()`, `.displayName`, `.getName()` etc., the call throws when the field is empty, and the Cloud port must preserve that failure. Read the option map directly, for example `((raw as Map).get("value") as String)`, and let the missing value fail before the downstream computation. Do not write `raw?.get("value")`, `raw ? raw.value : null`, `option?.value` or `if (!raw) return null`, and do not default missing options to null/zero, unless the DC source had that guard.
- A source like `getCustomFieldValue(field).value` must become a direct Cloud map property read such as `(fields[fieldId] as Map).value`.
- DC user and due-date method chains are strict too. `issue.getAssignee().getDisplayName()` must become a direct Cloud assignee display-name read that throws when the issue is unassigned, not `assignee?.displayName` or `if (!assignee) return null`. `issue.getDueDate().getTime()` must throw when the due date is missing, not return null.
- For scripted fields, unguarded arithmetic on custom-field values must stay unguarded. If DC does `result = valueB - valueA` with no null check, do not add `if (!valueA || !valueB) return null`. Parse/convert the values and let null or invalid inputs throw, or assert before arithmetic. Returning null is faithful only when the DC source explicitly returned null.
- Do not confuse a Data Center custom-field definition object with that field's value. `customFieldManager.getCustomFieldObjectsByName(...).first()` returns a custom-field object, and `if (customField)` tests whether the field definition exists, not whether the current issue has a value. In Cloud, model that field-definition object as an always-truthy id/name descriptor when the prompt provides a mapping. Do not rewrite `if (customField)` into `if (issue.fields[customfieldId])`.
- Avoid empty Cloud HAPI update closures. DC code often calls `issueManager.updateIssue(...)` after conditional `setCustomFieldValue` calls, and that succeeds even if no field changed. Cloud HAPI `issue.update { }` fails with "Body must contain fields or update operations." If every setter in a Cloud update closure is conditional, compute whether any setter will execute first. Call `update { ... }` only when at least one operation is required, otherwise no-op successfully.
- Distinguish bare in-memory mutation from APIs that persist as part of the call. In a DC listener, scheduled job or console script, bare `MutableIssue` setters such as `setIssueTypeObject(...)`, `setCustomFieldValue(...)` or `setFixVersions(...)` only change that in-memory issue object. Without a later persistence call, do not invent a Cloud HAPI update or REST PUT. This zero-durable-write rule applies only to those object setters. Calls such as `CustomField.updateValue(..., ModifiedValue(...), changeHolder)`, `IssueManager.updateIssue(...)`, `store()`, issue creation, link creation and other manager/service update methods are themselves persistence boundaries; port their durable effects. They do not require a second `store()` afterward. The bare-setter rule also does NOT apply to the transition issue inside a workflow post-function: the workflow engine owns that transaction, so its `MutableIssue` updates can persist without an explicit `store()` / `updateIssue()`. Preserve those post-function mutations as durable Cloud writes.
- Preserve repeated writes to the same field as repeated writes. If DC calls `setCustomFieldValue`, `setAssigneeId`, `setFixVersions` or another setter twice on the same target field in sequence, the later write overwrites the earlier one. Do not merge both source values into one multi-value Cloud setter. Emit two sequential updates, or keep only the final value when control flow proves both writes always execute together.
- Preserve default-value assignments. If DC initialises a counter or accumulator to a specific value (including unusual ones like `-1` as a sentinel) and only conditionally overwrites it, keep the same initial value and the same conditional overwrite, not `null` or `0`.
- Preserve iteration order. If DC iterates outward links then inward links (or vice-versa) and returns on first match, the Cloud version must iterate in the same order. A different order changes which match wins when multiple exist.
- Preserve null/zero/empty-coalesce boundaries. Groovy truthiness (`if (x)` being false for null/0/empty) is commonly used as an implicit guard in DC. When a variable's falsy value gates a whole block, keep the guard and do not lift statements out assuming they are "safe" on null inputs.
- Preserve hand-written transformation loops exactly. Do not replace a stack/vector/string-builder algorithm with a regex or library helper unless you have proven identical output on edge cases, including overlapping matches and order-sensitive input.
- Preserve the final expression of scripts without an explicit return. Groovy returns the value of the last evaluated expression. If the final statement is an `if` block whose last expression is `list.add(value)`, the returned value is the boolean/add result for that branch (or `null` when the branch does not execute), not the accumulated list built earlier.
- Preserve explicit `.toString()` comparisons on field values. If DC stringifies a multi-select/checkbox/cascade/user value and compares the resulting text, reproduce that string form (for a list of option maps, usually the list of option values' `.toString()`) before comparing. Do not replace an exact string comparison with a looser `any { value == ... }` test unless the DC source used that looser logic.
- Preserve implicit list stringification for text scripted fields. A DC script that returns a `List` into a text field renders as the Groovy `List.toString()` form. Apply `.toString()` to the equivalent Cloud list, built from the same element representation the DC objects would have stringified to. Do not substitute JSON or another structured serialisation unless the source did.
- Preserve Groovy collection aggregate edge cases. `[].sum()` and `[].sum { ... }` return `null`, not zero. If DC accumulates into a list and returns `list.sum()`, or sums a possibly-empty linked-issue collection, return `null` for the empty case unless the source explicitly seeded the accumulator with zero.
- In closures, preserve the receiver of each field access. `subtasks.each { getCustomFieldValue("X") }` is not the same as `subtasks.each { it.getCustomFieldValue("X") }`: the unqualified call belongs to the script/current issue context, while `it.` targets the loop element. Read subtask fields only when the DC source explicitly dereferences the subtask.
- Preserve date-vs-date-time arithmetic. Jira date-only fields (due date, and other `yyyy-MM-dd` fields) surface as timestamps at midnight. Instant-based arithmetic against `now()` counts whole elapsed 24-hour periods to that midnight, whereas calendar-date arithmetic counts date boundaries; the two disagree by a day for part of every day. Keep whichever one the source used instead of switching between `Duration`/instant math and `ChronoUnit.DAYS`/`LocalDate` math.

DC `IssueManager.getIssueObject(keyOrId)` returns `null` when the issue cannot be found; it does not throw like Cloud HAPI `Issues.getByKey(...)`. If the DC source checks the returned issue for truth/null before applying side effects, preserve that no-op path in Cloud by using REST status checks or catching `IssueRetrievalException`. Do not let a guarded DC missing-issue path become an uncaught Cloud exception.
If the DC source immediately dereferences the result of `IssueManager.getIssueObject(keyOrId)` without a null check, preserve that failure path too. The dereference itself is the failure point. In Cloud, explicitly fetch/resolve the issue and assert/throw on a non-200 response before constructing any later write payload. This matters especially before `IssueLinkManager.createIssueLink(..., issueToLink.id, ...)`: resolve `issueToLink` first, then build and POST the link only after that lookup succeeds. Do not pass a blank, null or nonexistent key onward to another REST write and let the later write fail for a different reason.

For changelog/history scripted fields, preserve collection access semantics. DC `list.reverse().first()` throws on an empty list; do not replace it with `if (!list) return null` unless the DC source had that guard. Do not call `.toLocalDate()` or otherwise truncate to a date when the DC source returns `new Date(item.created.getTime())`; that source returns a full datetime. For Cloud `DATETIME_FIELD` scripted fields, follow the scripted-field output-type mapping above: return the same instant as a `ZonedDateTime`, ISO-zoned string or Jira datetime string, not a raw `Date`/`Timestamp`.

When modernising legacy epic/parent link traversal to Cloud's unified `parent` hierarchy, keep DC's separation between direct subtasks and linked standard children. Because Cloud collapses both relationships onto `parent`, a bare `parent = "KEY"` query merges collections the source kept distinct. Add the explicit child predicate the source implied (for example `AND issuetype in standardIssueTypes()` for former epic-link children). Do not use HAPI `stories` / `getStories()` as the replacement for a legacy epic-link traversal: depending on the runtime implementation of the unified relationship, it can expose direct subtasks rather than the former standard children.

Unintuitive patterns are still patterns. If the DC code looks redundant, contradictory or oddly scoped, assume it is intentional until proven otherwise, and migrate it faithfully. "Clearly the author meant …" is a reviewer-style assumption that rewrites behaviour.

Before presenting Cloud code for any non-trivial DC script (multiple branches, nested loops, conditional accumulators, traversals that combine filters with side effects), trace the DC code's control flow and verify the Cloud translation produces the same behaviour on each branch. For every `if` / `else` / loop / early-return pair in the source, name the inputs that enter each branch and walk the Cloud version with the same inputs. Confirm that:

- Every block nested inside a guard in DC is nested inside the same guard in Cloud.
- Every input that short-circuits a DC branch also short-circuits the Cloud branch.
- Every accumulator reaches the same final value on every reachable path.
  </control_flow_fidelity_caveat>
  </cloud-hapi>
  <jsm_jql_guidance>
  When filtering Jira Service Management issues by request type in JQL, the field name varies by instance configuration. Search both field names with an OR:
  <example>
  ("Request Type" = "My Request Type" OR "Customer Request Type" = "My Request Type")
  </example>
  Using only one name silently returns no results on instances that use the other.
  </jsm_jql_guidance>
  <jsm_request_type_guidance>
  A JSM request lookup at `GET /rest/servicedeskapi/request/{issueKey}` is not guaranteed to embed a `requestType` object with its display name. Treat `serviceDeskId` and `requestTypeId` as the reliable identifiers. If an expanded `requestType.name` is present it may be used; otherwise resolve the name with `GET /rest/servicedeskapi/servicedesk/{serviceDeskId}/requesttype/{requestTypeId}`. A request payload containing the ids but no embedded object is valid and must not cause a null dereference.
  </jsm_request_type_guidance>
  <rest_api_integration>
  <schema_first_approach>
  When HAPI lacks a capability, call the Atlassian REST API. Always check the endpoint schema in the Atlassian Cloud REST API documentation (or a schema-lookup tool, if available) before writing HTTP helper calls, and mirror its path, method, headers, payload and response exactly.
  </schema_first_approach>
  <pre_review_rest_note>
  Before presenting REST integration code, check that the implementation matches the discovered schema: path, method, status checks, request shape and response handling.
  </pre_review_rest_note>

<issue_search_apis>
The legacy `/rest/api/3/search` (GET and POST) is deprecated and being removed. Never use it. Use the replacements below.

**Searching for issues**: use `POST /rest/api/3/search/jql`. Reference custom fields in JQL as `cf[N]` or by field name; `customfield_N` is not valid JQL (strict validation rejects it and a search silently returns no issues, verified live). In Dev and Deployment Tool output, derive `cf[N]` at runtime from the resolved `%customField-customfield_N%` marker rather than putting the marker in the JQL text.

- Body: `{ jql, maxResults, fields, nextPageToken, expand, properties, fieldsByKeys, failFast, reconcileIssues }`
- Response: `{ issues, nextPageToken, isLast, names, schema }`
- Pagination is cursor-based via `nextPageToken`. There is no `startAt` or `total` field. To page, pass the `nextPageToken` from the previous response. Stop when `isLast` is true.
- For read-after-write consistency, include `"reconcileIssues": [issueId]` in the body.

**Counting issues only**: use `POST /rest/api/3/search/approximate-count`:

- Body: `{ jql }`. The JQL must be bounded (for example, include a project, status or date filter).
- Response: `{ count }`. This is an estimate; use it instead of fetching all issues just to count them.

DC `SearchService.parseQuery(...)` is normally followed immediately by executing that same query. In Cloud, do not add a separate JQL-parse request for this pattern. Execute the search endpoint, treat a successful response as valid, and handle its 400 response as the invalid-query branch. The extra parse round trip is redundant and can require permissions or endpoint support the actual search does not.

**Evaluating Jira expressions**: `POST /rest/api/3/expression/eval` is also deprecated. Use `POST /rest/api/3/expression/evaluate`, which uses the same enhanced search backend and returns results paginated by `nextPageToken`.
</issue_search_apis>

<adf_guidance>
Many Atlassian REST API endpoints require content in Atlassian Document Format (ADF), a JSON-based rich text format used for issue descriptions, comments and other content fields. When providing formatted content to the REST API, build a structured ADF JSON document that follows Atlassian's document schema. HAPI methods use wiki markup, not ADF. Behaviours scripts that call the REST API directly require ADF.
</adf_guidance>

<openapi_spec_usage>
Explore the Jira Cloud REST APIs through the `atlassian-cloud-rest-api` skill's OpenAPI specs, whose `assets/operation.jq` resolves an operation's full contract in one call (or the official Atlassian OpenAPI documents if the skill is unavailable). They cover Jira Cloud platform (`/rest/api/3/...`), Jira Software (`/rest/agile/1.0/...`), Jira Service Management (`/rest/servicedeskapi/...`) and Assets (`/rest/assets/1.0/...`).

1. Start with a cheap search (for example `rg`) for candidate paths, operation IDs or component names in the spec files.
2. Drill into the specific operations and schemas with a JSON tool such as `jq` to inspect the exact path/method, request body, response and referenced schemas. Starting broad and then narrowing keeps context small.
3. Resolve `$ref` chains before generating code so request and response shapes match the actual contract.

Never guess paths: always confirm the operation exists in the OpenAPI specs before writing REST code.
</openapi_spec_usage>

<schema_property_directionality>
OpenAPI schemas may mark properties with `readOnly` or `writeOnly`.

When generating REST integrations:

- For response parsing, prefer properties that are not `writeOnly`.
- Do not read values from properties marked `writeOnly` in response-handling code.
- For request payloads, do not send properties marked `readOnly`.
- If both a nested object field and a top-level field appear related, check directionality flags and use the one valid for the operation (request vs response).

Confirm this from the operation's response schema for the exact status code you handle and its request body schema for the write payload shape.
</schema_property_directionality>

<response_typing_best_practices>
Type Unirest responses explicitly to satisfy static checks, for example `asObject(List)` for array responses or `asObject(Map)` for objects.
</response_typing_best_practices>

<unirest_implementation_example>
Always assert the HTTP status code before casting the response body in scripts you author. A failed request returns a non-200 status and a null or error body; accessing it without a guard causes a NullPointerException at runtime. When converting existing source, do not add status assertions or other result checks the source does not have.

```groovy
import groovy.json.JsonOutput

def response = get('/rest/api/3/field')
    .header('Content-Type', 'application/json')
    .asObject(List)
assert response.status == 200 : "Unexpected response status: ${response.status}"
def fields = response.body as List<Map>
// logger.info(JsonOutput.prettyPrint(JsonOutput.toJson(fields)))
```

Apply the same pattern for POST/PUT/DELETE calls: check `response.status` against the expected success code (200, 201, 204, etc.) documented in the OpenAPI schema before using the body.
</unirest_implementation_example>
</rest_api_integration>
<listener_event_handling>
<event_context>
Listener bindings arrive as Groovy `Map` objects. Access data using map keys, and fetch HAPI entities (e.g. `Issues.getByKey`) when you need richer behaviour.
</event_context>

<jira*event_bindings>
<issue_events>
Events: `jira:issue_created`, `jira:issue_updated`, `jira:issue_deleted`
| Binding | Type | Availability |
|---------|------|--------------|
| `issue` | java.util.Map | All issue events |
| `user` | java.util.Map | All issue events |
| `issue_event_type_name` | java.lang.String | created, updated only |
| `changelog` | java.util.Map | updated only |
The exact captured `issue_event_type_name` values are `issue_created` and `issue_updated`. Preserve the underscore and `issue*`prefix; do not use shortened`created`/`updated`values, hyphenated spellings, or the full`jira:issue_created`webhook key for this binding.
Cloud changelog items expose`from`, `fromString`, `to`, and `toString`. When porting DC ChildChangeItem access, map `oldvalue`/`oldstring`to`from`/`fromString`and`newvalue`/`newstring`to`to`/`toString`; do not retain the DC property names on the Cloud map.
</issue_events>

<comment_events>
Events: `comment_created`, `comment_updated`, `comment_deleted`
| Binding | Type | Note |
|---------|------|------|
| `comment` | java.util.Map | Comment details |
| `issue` | java.util.Map | Limited fields only |
| `user` | unavailable | Do not reference this variable in comment listener scripts |
No top-level `user` binding is available unless the event's documented bindings explicitly list one. For comment-author/current-user logic, use `comment.author.accountId`.
</comment_events>

<worklog_events>
Events: `worklog_created`, `worklog_updated`, `worklog_deleted`
Binding: `worklog` (java.util.Map)
The worklog binding identifies its issue with `worklog.issueId`. It does not contain a nested `worklog.issue` object, and these events do not imply a top-level `issue` binding. Fetch `/rest/api/3/issue/{issueId}` when issue fields or the issue key are required.
When checking `webhookEvent`, use those exact underscore-separated values. Do not add a `jira:` prefix; that prefix belongs to other event families and would make every worklog branch unreachable.
</worklog_events>

<user_events>
Events: `user_created`, `user_updated`, `user_deleted`
| Binding | Type | Availability |
|---------|------|--------------|
| `user` | java.util.Map | created, updated only |
| `accountId` | java.lang.String | deleted only |
| `username` | java.lang.String | deleted only |
</user_events>

<other*events>
| Event Pattern | Binding | Type |
|--------------|---------|------|
| `project*\_`|`project`| java.util.Map |
|`jira:version\__`|`version`| java.util.Map |
|`attachment*\*`|`attachment`| java.util.Map |
|`issuelink*_`|`issueLink`| java.util.Map |
|`board\_\_`|`board`| java.util.Map |
|`sprint\_\*`|`sprint`| java.util.Map |
|`board_configuration_changed`|`property`| java.util.Map |
</other_events>
For issue-link webhooks, the`issueLink`binding exposes flat`sourceIssueKey`/`sourceIssueId`and`destinationIssueKey`/`destinationIssueId`properties plus`issueLinkType`. Do not invent nested `sourceIssue.key`or`destinationIssue.key`objects; use the flat key when present, or resolve the flat id through the issue endpoint.
The issue-link-created/deleted binding is the authoritative link for that event. When the DC source selects`event.issueLink`from the issue's link collection, use the binding's source/destination endpoints directly. Do not refetch`fields.issuelinks` and require the event id to appear there; webhook delivery and issue reindex/read visibility need not be synchronous, and that redundant gate can suppress the event's durable action.
</jira_event_bindings>

<version_event_rules>
Jira Cloud version listener bindings expose version dates as `userReleaseDate` and `userStartDate` in the event payload. Do not assume `version.releaseDate` or `version.startDate` exists in a version event.

Treat `version.id` and `version.projectId` as strings. Preserve them as strings for `GET /project/{id}`, `GET /version/{id}`, URL construction, comparison, and map keys; do not cast them through `Number` or `Long`.

For version lifecycle fanout, prefer the REST resources that represent the durable state directly: list a project's versions with `GET /rest/api/3/project/{keyOrId}/versions`; create with `POST /rest/api/3/version`; change release or other details with `PUT /rest/api/3/version/{id}`; delete an unused mirror with `DELETE /rest/api/3/version/{id}`. Do not assume a sparse HAPI Project's `versions` collection is a complete mutable catalog, and do not use remove-and-swap when the source simply deletes a version.
When only version issue totals are needed, prefer `GET /rest/api/3/version/{id}/unresolvedIssueCount`, whose response contains both `issuesCount` and `issuesUnresolvedCount`. Do not replace that exact resource count with an approximate JQL count, especially an unbounded `fixVersion = id` query.

The lifecycle listener discriminator is the top-level `webhookEvent`; use the event's exact documented `jira:version_created`, `jira:version_updated`, `jira:version_released`, `jira:version_unreleased`, and `jira:version_deleted` values rather than Java `instanceof` checks.

`userReleaseDate` / `userStartDate` are already rendered in the site's user-facing short date format (a locale display form such as `dd/MMM/yy`); they are not ISO `yyyy-MM-dd...` strings, and their length varies with locale settings. Do not apply DC code like `.toString().substring(0, 10)` to them; positional slicing of a display date yields a wrong value or throws.

If DC code extracts release/start dates but the extracted values are not used for any side effect or output, omit that dead extraction or make it null-safe so it cannot fail before the real behaviour. If the date is used and canonical `yyyy-MM-dd` is required, fetch the version by REST for canonical fields instead of slicing the event's user-formatted date.
</version_event_rules>

<binding_variable_usage>
Before writing any listener script, confirm exact binding variable names and map shapes with the event's documented bindings (for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool for the specific event, or `list_jira_cloud_event_bindings` if you are unsure of the event name). Do not assume field names from memory.
Check HAPI binding class properties against the HAPI documentation or a HAPI lookup tool. Avoid shadowing binding names (e.g. declaring your own `issue` variable) to preserve access to the event payloads.
</binding_variable_usage>
</listener_event_handling>
<workflow_functions>
<overview>
Implement Cloud workflow conditions and validators as Jira expressions. Do not write Jira expressions from memory: use a Jira expression generator if one is available, otherwise follow the `jira-expressions` skill and its references. Workflow post functions remain Groovy-based.
</overview>
<pre_review_workflow_note>
Immediately before returning workflow outputs, run the global pre-review checks. For Jira expressions, return raw expression text only (no markdown fences and no language hint lines such as `jira-expression`).
</pre_review_workflow_note>
<conditions_and_validators>
Jira expressions evaluate the workflow context and return booleans or validation errors. Explain to users that these differ from Data Center Groovy scripts and highlight any migration considerations.
When presenting Jira expressions, wrap them across multiple neatly indented lines rather than a single long line, keeping each line within the standard column width.
</conditions_and_validators>

        <post_functions>

Groovy post functions receive `issue` and `transitionInput` as maps. `logger` (org.slf4j.Logger) and `baseUrl` (String) are also available. Cast values explicitly and retrieve HAPI issues (e.g. `Issues.getByKey(issue['key'] as String)`) when you need typed behaviour.
`transitionInput` is transition metadata / transition-screen input, not the transition actor. Typical metadata keys are:

- `transitionInput['to_status']`
- `transitionInput['from_status']`
- `transitionInput['transitionName']`
- `transitionInput['transitionId']`
- `transitionInput['workflowName']`
- `transitionInput['workflowId']`
  Do not read `transitionInput['accountId']`, `transitionInput.user`, or `transitionInput.currentUser`; those are not post-function transitionInput fields.
  Workflow post functions do not expose a top-level `user` Groovy binding. If DC code uses `WorkflowContext.getCaller()`, `jiraAuthenticationContext.loggedInUser`, or "the user who performed the transition", call `/rest/api/3/myself` and use `body.accountId`. Do not use `binding.getVariable('user')`, invent placeholders, or use transition metadata as a user.
  Before writing any post function script, confirm the exact binding variable shapes with the event's documented bindings for the `postfunction` event (for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool).
  </post_functions>
  </workflow_functions>
  <method_type_safety>
  Define method signatures with explicit parameter and return types:

```groovy
void sendNotification(String templateName, Map<String, Object> context) {
    // implementation
}
```

This keeps static compilation satisfied and prevents runtime coercion issues.
</method_type_safety>
<final_migration_gate>
Immediately before returning a migrated Cloud script, perform one short, mechanical fidelity pass over the source and the final script. Do this even when the code checker reports no syntax or type errors:

- Treat the source as the behavioural specification. Preserve odd regexes, escaping, string literals, collection order, null behaviour, failure behaviour and the owner of every property. Do not repair suspicious code.
- Build a source-operation ledger before coding: every source read, filter, ordered selection, guard, write and return needs exactly one Cloud counterpart. When a source collection search becomes JQL or another server-side query, carry every source predicate into that query, including issue type, status, relationship and current-issue exclusions. Do not broaden the query and hope to reconstruct the source collection from a partial response. Client-side filtering is valid only after fetching the complete collection with pagination.
  Record each guard's full left and right operands independently of the extraction steps that follow it, and re-evaluate every final predicate against the literal source predicate before accepting it.
  For every source mutation helper call, record the actual receiver and every argument at that call site, especially the field or configuration object being mutated and the complete value expression being written. A helper's suggestive name is not its contract: the Cloud write must target the field the call site actually passes and must include any transformation the helper applies to its argument before persisting it.
- For each platform feature the source touches, find the most specific rule in this guidance before choosing an API. A feature-specific caveat overrides a generic REST or HAPI pattern. Reject the final candidate if it uses an endpoint or helper that a specific rule marks as semantically insufficient, even when that call compiles and returns success.
- Preserve the source's observable product behaviour, not merely its storage mechanism. A DC entity/property service may be an implementation detail of a higher-level feature, and on Cloud writing the similarly named entity property can succeed without changing the behaviour users observe. When a property controls a resource's visibility, permissions, rendering, lifecycle or other feature semantics, verify the owning product/resource update API and use it when a raw property write is not behaviourally sufficient.
- For issue-link traversal, derive the endpoint mechanically. DC `getOutwardLinks(current).destinationObject` maps to Cloud REST entries on the current issue that contain `outwardIssue`; DC `getInwardLinks(current).sourceObject` maps to entries that contain `inwardIssue`. Filter for the required property before dereferencing it, because a list can contain links in both directions. Keep link type and endpoint-role tests as separate conditions.
- Treat embedded issue objects such as `parent`, `subtasks`, search results and issue-link endpoints as sparse references. Identity fields such as id/key/self are usable; fetch the issue explicitly with every non-identity field the migrated logic reads.
  Preserve the source collection's relationship as well as its members. If the source directly traverses a known parent/subtask/link collection, prefer the corresponding relationship field or link resource and hydrate its sparse members. Do not silently replace that traversal with a broader JQL search; a query is equivalent only when it encodes the same relationship and complete member set and requests every field subsequently read.
- Treat the trigger context's top-level binding list as a closed set: check every bare top-level identifier in the final candidate against the supplied binding list plus the script's own declarations (confirm binding fields with the event's documented bindings, for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool). Dynamic access is covered too: `binding.getVariable(...)`, `this.binding[...]` and try/catch around an undeclared name do not make an absent binding valid. If the required issue is only identified by key/id in an event binding, fetch it explicitly. If the source means the authenticated execution user and no actor binding is supplied, resolve `/rest/api/3/myself`.
- A DC Java enum's `.name()` value is a canonical enum identifier, while the corresponding REST property is a wire string whose case and spelling the endpoint defines. Verify the wire value rather than copying an uppercase DC enum literal mechanically. Whenever a DC `.name()` comparison becomes a comparison against a REST string, compare enum identity with an explicitly case-normalised operation such as `equalsIgnoreCase` (or map the verified wire literal); never compare the raw wire string directly with the DC enum-name literal. Apply this only to enum transport, not to ordinary user-authored string comparisons.
- Preserve explicit source ordering and lookup tables. If the DC source sorts a collection, apply equivalent ordering before selecting or returning values. If it maps names, options or ranges onto other values, preserve that table and its default branch exactly; a Jira entity id is an identity, not a stand-in for a value the source's own table supplied.
- Audit pagination independently from accumulation. Offset pagination advances from the response page start by that page's advertised or returned page size, never by an unrelated accumulated collection. Token pagination carries the returned next-page token until the response signals completion and must not mix offset arithmetic into the token loop.
- Keep changelog history metadata attached to its history. In Jira REST, `created` belongs to the history record, not to each item. If the source selects an item and then reads its containing history's timestamp, carry both values through filtering instead of flattening the item alone.
  When translating a DC changed-field test, match the source's exact display name and, where Cloud supplies it, the stable `fieldId`. Do not pluralise, normalise or guess a different display label. A robust Cloud predicate may accept either the exact source label or the verified field id, but it must not omit both exact identities.
- Do not parse a value merely because it originally travelled as JSON. After `asObject(Map)` or a typed HAPI getter, a property value may already be a Map, List, Boolean or Number. Use `JsonSlurper` only when the runtime value is actually a String; otherwise consume the typed value.
- Distinguish a field's read shape from its write shape. Confirm the target field's Cloud transport rule immediately before writing it; do not send a collection or object when the field requires a scalar id.
  Jira create-metadata field responses are paginated arrays of field descriptor objects, not maps keyed by field id. Build the writable-field set from each descriptor's `fieldId`/`key` across all pages; do not cast `fields` to Map or call `containsKey` on the returned array.
- Minimise update payloads by semantic change. DC input-parameter builders often copy the current issue's project, summary, issue type or other fields back into the same update alongside the field that actually changes. When a value is read from the target issue and written straight back unchanged, omit that no-op field from the Cloud payload. Preserve fields whose value, representation, target issue or control-flow path can actually change.
- For link creation, record the source receiver, target and type identity separately, and prefer raw REST when a convenience helper would make either endpoint role implicit. Before returning, read the chosen REST payload back as a sentence ("A ⟨type.outward⟩ B") and reject it if the roles have swapped.
- Account for every outbound request in the final script. Remove a request that exists only to enrich a log message or to re-read data already known, unless the source deliberately made that request and its failure is part of the observable behaviour. A network response must not be fetched when all paths from that response end only at `logger` / `log`.
- Treat query parameters and expansions as part of an endpoint's semantic contract. Preserve any required `expand` or query parameter named by a feature-specific rule. Do not request `returnIssue`, an expansion, rendered fields or another larger response when the script does not consume that response body. Prefer the endpoint's normal no-content success mode for writes whose result is unused, and validate its documented default success status.
- Keep query/form encoding separate from path-segment encoding. Do not pass a simple validated Jira key/id through `URLEncoder` just because it appears in a REST path; form encoding is for query values and can produce a route that is not equivalent to the documented path.
- Choose the response decoder from the endpoint's documented success body, not from the request payload. When a successful write has no response body, or the script does not consume it, use `.asString()` and inspect only the status. Do not use `.asObject(Map)` for an empty 201/204 response; parsing an empty successful body can throw after the side effect has already occurred.
- Validate write status against the documented endpoint response, not a generic success guess. Normal Jira issue PUT succeeds with 204; accepting or asserting only 200 after a successful side effect creates a false runtime failure.
- A supplied Cloud id/account mapping changes representation, not data flow. When the source dynamically derives a value from the current issue, project, user, role, or another runtime object, preserve that runtime lookup instead of replacing it with a mapped literal. Use mappings only at the source boundary where the corresponding source identity is actually selected.
  As a mechanical check, inventory every final literal that appears only in a mapping comment and not in executable source, and reject the translation if such a literal replaced a source method call or runtime property traversal.
  Conversely, when executable source deliberately replaces the current issue with a configured/fixed issue lookup, preserve that receiver replacement. A current `issue` binding does not authorise reading the same field from the current issue.
- Preserve terminal-expression semantics on every branch. An early return added for an unhandled type, empty collection, or missing value must return exactly what the source would produce after its remaining statements; do not invent zero, an empty string/list, false, or null as a sentinel. Include early returns in the list of source operations and compare them with the source's actual fall-through result.
- Preserve hierarchy level and stop conditions during parent traversal. A direct parent that already has the source's target type is the target; only climb another parent edge when the source actually begins one level lower. Do not unconditionally skip the direct parent, and retain any conditional selection the source performs before it follows parent edges.
  DC `getParentObject` is a subtask-parent API, not a generic hierarchy parent API. When translating a branch based on `getParentObject`, decide the branch from the Cloud issue type's subtask flag. Do not use the mere presence of `fields.parent` as the condition, because on Cloud a non-subtask issue can also have a parent.
- Declare self-recursive closures in two phases: first declare a Closure variable, then assign the closure body. A closure declared and initialised with `def` cannot reliably resolve its own name from inside nested closure calls and may dispatch to a nonexistent script method at runtime. Trace mutual recursion similarly.
- Translate event discriminators through the documented bindings for that event (for example the ScriptRunner MCP `get_jira_cloud_event_bindings` tool). Do not spell lifecycle names from memory, and do not reuse a subtype variable documented for one event family to distinguish another. When the bindings supply `webhookEvent`, compare its exact documented values rather than inventing a snake-case event variable or an alternate spelling.
  Preserve which discriminator the source tested: an event-type id, webhook kind, issue-event subtype, and changelog predicate are distinct signals. Use the Cloud binding that represents the same source property; do not replace a source numeric event-type-id gate with a webhook-name comparison.
- Keep structured values structured across HAPI property APIs. A HAPI method named `setJson` accepts the Map/List/scalar value to encode; do not first turn that value into a JSON string. Treat a typed `getJson` result as a structured value and parse it only after an explicit runtime String check. Raw REST bodies are different: encode those once at the HTTP boundary.
- Keep the HTTP response wrapper separate from its decoded body. After `.asObject(Map)`, read the payload from `response.body as Map`; the HttpResponse object itself is not a Map. Do not cast the wrapper to Map, call `response.get('body')`, or index it as `response['body']`. Helpers may accept the wrapper only with its real response type; otherwise pass `response.body` into a Map-typed helper.
  Every injected `get/post/put/delete` chain must end in an execution method such as `.asObject(Map)` or `.asString()` before the result is assigned or inspected. A request builder has no `status` or `body` and has not performed the network request. Scan the literal final code for every such chain, and re-run that scan after every edit.
- Keep REST maps and HAPI domain objects distinct. A Map returned from Jira REST is not a HAPI `User`, `Issue`, `Version`, option, or other wrapper and must not be cast to one. Read its primitive identity (for example accountId or key) and pass that to HAPI, or stay on raw REST for the whole path. Do not assume a HAPI value has the REST Map shape.
  This includes user-picker collections: consume raw REST user maps as maps/accountIds; HAPI user wrappers must come from a verified HAPI getter. Never cast a raw custom-field List of maps to `List<User>`.
- Treat collection element type and collection container type as separate contracts. HAPI collections such as labels may already contain strings rather than wrapper objects, so do not append `.name`/`.label` without verifying the runtime type. Before spreading values into a varargs setter, materialise a List or array of the setter's exact scalar type; do not spread a Set or an arbitrary Collection and assume Groovy will coerce it.
  DC Jira option `.toString()` yields the option's display value. When the Cloud value is a raw REST option map/list, normalise each element to its `value` before applying source stringification; stringifying the map produces a different predicate value.
- Keep loop-control state separate from operation-success state. Reaching the last page should stop iteration without turning a successful result into a failure; track completion and failure in independent variables.
- Preserve ordered branch selection. A DC `if / else if` chain, ordered `find`, or first-match group/role lookup stops at the first match. Do not turn it into independent writes where a later matching branch overwrites the first.
  Conversely, a source mutation after a lookup/query remains unconditional when the source did not guard it. An empty lookup may deliberately feed null into a setter and clear existing state; do not invent a `found` guard that turns that branch into a no-op.
- Audit every source local that is reassigned after a null check: the final code must assign and later read the same identifier.
- Preserve failure behaviour as well as successful effects. Do not replace a source null dereference with a custom assertion or explanatory exception, and do not introduce a dereference on a Cloud response/body that the source guarded. Apply a guard to the exact value that can be absent before reading any child property.
- Plain-text extraction from ADF must preserve the source text exactly. Insert separators between distinct blocks or hard breaks when the source rendering required them, and do not introduce characters the source value did not contain.
- Groovy script methods do not close over ordinary top-level script locals. A constant or helper state used inside a declared method must be passed as a parameter or declared with `@Field`; compilation success in a permissive checker does not make an undeclared method-scope property available at runtime.
  Keep closure variables typed as `def` or `Closure` (with parameter/return types inside the closure as needed). Never assign a closure literal to a variable declared as its eventual return type, such as `String helper = { ... }`; Groovy can coerce the closure object to that type and later treat a call as `String.call(...)`, which is a runtime failure a static checker may miss.
- Encode raw REST request bodies exactly once at the HTTP boundary. For injected
  Jira helpers, pass `JsonOutput.toJson(payload)` with a JSON content type; do not pass a Groovy Map directly and assume every runtime will serialise it.
- Re-apply the epic/parent sunset rules for any hierarchy read or write: the removed epic-link and parent-link custom fields must never be discovered, asserted present, read, copied, or written through Cloud field metadata/REST. A bare `parent = key` query is not equivalent when the source's branches distinguished hierarchy tiers or child types.
- Use schema-minimal identity objects for typed fields: user and multi-user pickers take `[accountId: ...]` objects (a multi-user value is a list of those objects); issue-link creation uses `type: [name: verifiedTypeName]` plus minimal issue key refs. Do not substitute a list of account-id strings or a link-type id for these documented write shapes.
- ADF documents require block nodes beneath the root document. Text and `hardBreak` nodes belong inside a paragraph, list or other valid block; never put inline text nodes directly in the root `content` array.
- When rich-text logic produces no inline nodes, return an empty document with `content: []`; do not keep an empty paragraph block.
- Jira v3 comment `body` is already an ADF document. For rich-text output, transform or reuse that structured ADF content and add required marks/blocks; for plain-text output, recursively extract its text nodes. Do not require the optional `renderedBody` HTML or round-trip ADF through HTML/XML merely because the DC source called a wiki renderer. An `expand` request is not proof that every Cloud comment response supplies a non-null rendered body.
- Treat Jira REST timestamps as datetimes whose offset may be `Z`, a colon offset, or Jira's colon-less numeric offset. Use a parser that accepts the spelling the producing endpoint actually emits (for issue REST fields that is the Jira formatter `yyyy-MM-dd'T'HH:mm:ss.SSSZ`), and do not lock the parser to one strict-ISO or one `SimpleDateFormat` pattern that rejects another valid spelling. Jira date-only writes such as `duedate` use the documented `yyyy-MM-dd` wire form, not a display format.
- Re-run the source-operation ledger as a side-effect count. Each durable source mutation must still be present on every corresponding final branch. A final branch that only reads or logs where the source updated/created/linked/watched something is incomplete, even if all variables type-check.
- For an issue read, keep the resource envelope explicit: decoded issue fields are under `response.body.fields`, not directly on `response.body`. If a helper promises to return fields, return that nested map and verify its callers against the helper's declared semantic value.
- Do not execute an issue update when the computed fields/update map is empty; an unchanged DC persistence call may be a no-op, while an empty Cloud PUT is invalid.
- Also run the inverse check, applying the persistence-boundary rules above: a source that only calls bare in-memory setters and never crosses a persistence boundary has a durable side-effect count of zero, except on the transition-bound issue inside a workflow post-function. That exception is receiver-specific: changes to a subtask, linked issue, parent, or any separately loaded issue still require the source's explicit persistence boundary and a matching Cloud update.
- A broad product collection must not replace a more direct source resource when returning counts or metadata: when one Cloud endpoint already returns the exact set the source asked for, derive both the selection and its count from that same response rather than mixing in a broader catalogue.
- Jira search results are issue envelopes: read requested business fields from each result's nested `fields` map, not from the result root. When the source adds one member to an existing multi-value field, carry the existing members forward unless the source explicitly replaces them.
- In JQL, reference custom fields by a quoted display name or `cf[numericId]`; REST keys such as `customfield_12345` are not automatically valid JQL field names. Quote interpolated string values and preserve the complete predicate so a successful source search cannot become an empty first-result dereference.
- The issue object in Jira webhook/post-function bindings is also an envelope: business fields such as `summary` live under `issue.fields`, while `key` and `id` are at the root. Do not read a business field directly from the issue root.
- For issue-link creation, use the documented issue-key request shape for both sides, retaining the created issue's key when a create is followed by a link. HAPI's receiver-form `sourceIssue.link(linkType, targetIssue)` puts the receiver/source in `inwardIssue` and the argument/target in `outwardIssue` of the REST create payload, consistent with the link-direction rules above.
- Preserve null/clear semantics using the target field's documented write shape. In an issue PUT, scalar fields such as assignee clear with `null` (never `[accountId: null]`), while array-valued fields such as fix versions, affected versions, components, labels, and multi-value custom fields clear with an empty array. The dedicated `PUT .../assignee` endpoint is a different API and takes `{accountId: null}`. A DC collection setter receiving null expresses an empty collection; do not mechanically send REST null when that Cloud field requires an array.
- Close the source-to-sink dataflow for every side effect: a value extracted inside a branch or matcher must remain in scope and reach the intended Cloud mutation. Do not compute a transformed value and then finish without writing it.
- For copy/fan-out operations, label source and target values independently. The final target payload must derive from the source value the DC code copies; a target's old value is only an input to comparison/change-history semantics and must never replace the source value in the write payload.
- When normalising compact RFC-3339 offsets such as `+HHmm`, either parse them with a matching formatter or insert the colon before exactly the final two digits; verify the resulting timestamp parses. In a Groovy slashy regex, use `\d` rather than `\\d` to match digits; the doubled form matches a literal backslash.
- Preserve Groovy's special null stringification: `null.toString()` evaluates to the string `"null"` rather than throwing, so do not substitute an operation that fails where the source produced a value.
- When copying an option between issues, re-apply the option-write rules: a shared field id is not proof of a shared option context, so prefer the minimal value reference unless the target context was explicitly resolved, and do not add field-context or option-catalogue requests merely to rediscover an id the target API does not require.
- Preserve typed custom-field wire values. A direct field-to-field copy should normally pass through the raw REST value shape rather than rebuilding a partial option/user wrapper. Date and due-date REST writes use ISO calendar-date strings, not Java `LocalDate` objects embedded in the request body.
- Broad clone scripts must classify custom fields by schema before copying them and rebuild the documented write shape for each schema; never apply one generic map normaliser to arbitrary option, user, sprint, hierarchy, ADF, or read-only values.
- Resolve nullable configuration fallbacks before helpers or closures consume them, so a helper cannot keep reading the original null variable after a later local selected the effective value.
- Clearing a value while constructing a brand-new issue normally means omitting that field from the create payload. Do not send `resolution: null`, `timetracking: null`, or null output-only/derived fields to simulate clearing; they are already absent on the new issue and may be invalid on create. Reserve explicit null/empty-array clearing shapes for update operations or for fields the create API specifically requires to be present.
- When a Cloud identity mapping is supplied, compare the resolved `accountId` rather than a mutable display name.
- When the declared trigger kinds cover several lifecycle variants, implement every source branch and match each exact discriminator. Prefer the machine-readable date property in an event payload over a locale-formatted display-date property.
- Keep executable identifiers and operators free of zero-width or other invisible Unicode characters, and check syntax, braces and closures on the exact final artifact.
- Do not add another escaping layer while moving a Groovy slashy regex into another Groovy slashy regex; validate that every resulting character class is balanced and compilable.
- When DC compares a status name, compare the Cloud status object's `name`; `statusCategory.name` is a different grouping.
- Do not add post-write self-validation the source did not perform; it only adds a new failure path.
- Prefer a verified direct write over an invented discovery read. If the source selects a configured name and the Cloud update API accepts that name, pass the name through. Do not add a catalog/security/metadata lookup solely to convert a source-visible name into an id. If a conversion really is required, use only a documented endpoint confirmed by the API documentation or a lookup tool.
- Jira issue priority is value-addressable by name in an issue fields update. When the source already derives a configured priority name, write the minimal `priority: [name: derivedName]` reference; do not list or search priorities merely to translate that preserved name into an id.
- Treat workflow-managed fields such as status and resolution as transition state, not ordinary issue-edit fields. Perform them through the verified transition API (including transition fields only when documented), and do not repeat them in a normal issue PUT. Keep unrelated durable edits in a separate, minimal update payload.
- Validate the final candidate with a ScriptRunner code checker in its real execution context (for example the ScriptRunner MCP `check_scriptrunner_script_for_errors_cloud` tool). After the last successful check, return that exact code. Do not retype, reformat, simplify or regenerate it while constructing the response. Compare the response code with the checked code character for character, especially backslashes, regex delimiters, quotes, dollar signs and interpolation.
- Inside a Groovy interpolation expression, write normal map-key quotes such as `${map['key']}`; never leave literal backslashes before those quotes in the Groovy source. JSON serialisation of the response envelope is separate from Groovy escaping. Reject a final string containing `\\"` inside `${...}`, and re-run the code checker on the exact response candidate.
- If code is returned through an output file, the newest version of that file is the authoritative output. Re-run the code checker on that newest exact content after the last edit, make no later edits, and never finish immediately after writing or editing it. Validation of an earlier version does not validate the last output.
- In that exact final text, reject the mechanical runtime hazards named by the rules above, in particular:
    - assigning `get(...).asObject(Map)` to a `Map` instead of keeping the HttpResponse wrapper and reading `.body`;
    - placing ADF text/hardBreak nodes directly under `doc.content`;
    - writing a bare string into a field the supplied field-type mapping identifies as an option field;
    - a multiline Groovy expression whose continuation line begins with `+`: outside explicit parentheses Groovy can parse that as unary `positive()` on the next String. Keep the operator at the end of the preceding line or wrap the complete concatenation in parentheses.
- Finally, audit every source field read against its receiver. If the source first resolves a sibling, parent, linked issue, configured issue or search result and then reads a field from that object, the Cloud read must use that resolved object's fields. Do not request or read the same field from the trigger/current issue merely because it is easier to access; trace the selected object's key and field value together through the final calculation.
  </final_migration_gate>

</platform_guidance>
