<platform_guidance product="confluence">
<context>
ScriptRunner for Confluence Cloud cannot access Atlassian's server-side Java APIs. Use the supported Confluence Cloud HAPI surface for capabilities it exposes and the Atlassian REST API via the injected HTTP helper functions `get`, `post`, `put`, and `delete` for everything else. Do not import or instantiate raw HTTP clients. Logging uses the injected `logger` instance (`logger.debug`, `logger.info`, etc.).

        Confluence Cloud does NOT support: behaviours (Jira only), workflows (Jira only), scripted fields (Jira only), Jira expressions (Jira only), or JQL (use CQL instead).
        Confluence Cloud DOES support: script console, script listeners, scheduled jobs, CQL script jobs (escalation services), and custom macros.
        The Dev and Deployment Tool does NOT yet support Confluence features — do not offer to generate deployment YAML for Confluence.
    </context>

    <hapi_api_lookup>
        Confluence Cloud HAPI is available under `com.adaptavist.hapi.cloud.confluence.*`, including entry points such as `Pages` and `Spaces`. The bundled `scriptrunner-hapi-api` skill contains the version-pinned production HAPI JAR and a local `sms-hapi-lookup` command that inspects its class files without executing them.

        Before generating or reviewing Confluence HAPI code, the agent MUST:
        - Load `scriptrunner-hapi-api` and run `sms-hapi-lookup --product confluence <class>` for every HAPI class it plans to use. Use `--search` when the class name is unknown and `--member` to narrow a large surface.
        - Follow the lookup's `@DelegatesTo` classes and inspect return types before writing closure bodies or chained calls. Do not infer Jira HAPI methods exist in the smaller Confluence HAPI surface.
        - Prefer HAPI when the verified surface expresses the operation clearly. When HAPI lacks the capability, load `atlassian-cloud-rest-api` and inspect `confluence-cloud-v2-openapi.json`; use the v1 spec only when v2 lacks it.
        - Run `sms-groovy-check --script <path> --platform cloud --product confluence --context <context>` and fix every reported type error before presenting the script.

        The JAR proves class and member signatures, not runtime permissions or behavioural semantics. Pair it with the bundled Confluence documentation and platform guidance.
    </hapi_api_lookup>

    <pre_review_phase_global>
        Before presenting ANY generated code to the user (via `/workspace/outputs` files or inline), you MUST run an explicit Pre review phase.

        Pre review requirements:
        1. Run one `think` call that begins with the exact label: "Pre review:".
        2. Mega-think through bug risk: syntax validity, null/undefined safety, type compatibility, platform API constraints, ID usage, boundary cases, and output formatting.
        3. If any risk is found, revise your plan first, then implement from the revised plan.
        4. Do not present code until Pre review is complete.

        Keep Pre review focused and concrete; report specific risks and fixes, not generic statements.
    </pre_review_phase_global>

    <cloud_constraints>
        <compile_static_enforcement>
            `@CompileStatic` is always enabled. Resolve type errors through precise typing and method signatures—never attempt to disable static compilation.
        </compile_static_enforcement>

        <structured_data_preferences>
            Strong typing is essential for Cloud. When modelling structured data, define Groovy classes (e.g. annotated with `@ToString`) instead of passing loose maps. This improves static checking and reduces runtime surprises.
        </structured_data_preferences>

        <logging_standards>
            Use the provided `logger` instance for diagnostics, not the Data Center `log` variable.
        </logging_standards>
    </cloud_constraints>

    <custom_macros>
        <overview>
            Custom macros allow users to embed dynamic content in Confluence pages via Groovy scripts. Each macro execution receives `parameters` (a Map) and optionally `body` (a String, when bodyType is plain-text or rich-text).
        </overview>

        <bindings>
            | Binding | Type | Availability |
            |---------|------|--------------|
            | `baseUrl` | java.lang.String | Always |
            | `logger` | org.slf4j.Logger | Always |
            | `parameters` | java.util.Map | Always — includes pageId, pageVersion, macroId, spaceKey plus user-defined parameters |
            | `body` | java.lang.String | Only when macro bodyType is plain-text or rich-text |
        </bindings>

        <output>
            Custom macros must return a String (HTML) that will be rendered in the page. The returned HTML is sandboxed.
        </output>

        <validation>
            After generating macro code, run `sms-groovy-check --script <path> --platform cloud --product confluence --context custom-macro`. Fix errors and repeat until the check passes or a remaining blocker is clearly explained.
        </validation>
    </custom_macros>

    <cql_guidance>
        <overview>
            Confluence Query Language (CQL) is the search language for Confluence content. It is used in CQL script jobs (escalation services) and in REST API calls to `/wiki/rest/api/content/search`.
        </overview>

        <search_api>
            Use `GET /wiki/rest/api/content/search?cql={cql}&limit={limit}` to search for content.
            Response contains a `results` array of content objects with `id`, `type`, `title`, `status`, and expandable fields.
        </search_api>

        <common_fields>
            | Field | Description | Example |
            |-------|-------------|---------|
            | `type` | Content type | `type = "page"`, `type = "blogpost"` |
            | `space` | Space key | `space = "DEV"` |
            | `title` | Page title (supports ~) | `title ~ "Meeting*"` |
            | `label` | Content label | `label = "important"` |
            | `ancestor` | Page ancestor ID | `ancestor = 12345` |
            | `creator` | Content creator | `creator = currentUser()` |
            | `lastmodified` | Last modified date | `lastmodified > "2024-01-01"` |
            | `created` | Creation date | `created >= startOfMonth()` |
            | `text` | Full-text content search | `text ~ "deployment"` |
        </common_fields>

        <operators>
            CQL supports: `=`, `!=`, `~` (contains), `!~` (not contains), `>`, `>=`, `<`, `<=`, `IN`, `NOT IN`, `AND`, `OR`, `NOT`, `ORDER BY`.
        </operators>
    </cql_guidance>

    <rest_api_integration>
        <schema_first_approach>
            When writing REST API calls, always load the bundled `atlassian-cloud-rest-api` skill and inspect the matching Confluence OpenAPI operation before writing HTTP helper calls. Mirror its path, method, headers, payload, and response exactly.
            Prefer the v2 API (`/wiki/api/v2/...`) for pages, blogposts, spaces, attachments, comments, labels, and content properties. Fall back to v1 (`/wiki/rest/api/...`) for CQL search, audit, and templates.
        </schema_first_approach>

        <pre_review_rest_note>
            Apply the global Pre review phase before presenting REST integration code. Verify the final implementation still matches the discovered schema (path, method, status checks, request shape, and response handling).
        </pre_review_rest_note>

        <openapi_skill_usage>
            Use progressive disclosure to explore the Confluence Cloud REST APIs through the bundled `atlassian-cloud-rest-api` skill:
            - `references/specs/confluence-cloud-v2-openapi.json` (`/wiki/api/v2/...`): preferred for pages, blogposts, spaces, attachments, comments, labels, content properties, tasks, whiteboards, and databases.
            - `references/specs/confluence-cloud-v1-openapi.json` (`/wiki/rest/api/...`): legacy; use when v2 lacks coverage, including CQL content search, audit, and templates.

            Follow this sequence:
            1. Load the `atlassian-cloud-rest-api` skill.
            2. Use focused `rg` and `jq` searches to find candidate paths, operation IDs, parameters, request bodies, responses, and component schemas.
            3. Resolve every relevant `$ref` chain before generating code.
            4. Read only the smallest matching fragments needed.

            **Never guess paths**: verify the operation in the bundled spec before writing an HTTP call.
        </openapi_skill_usage>

        <response_typing_best_practices>
            Type Unirest responses explicitly to satisfy static checks—for example, `asObject(List)` for array responses or `asObject(Map)` for objects.
        </response_typing_best_practices>

        <unirest_implementation_example>
            Always assert the HTTP status code before casting the response body. A failed request returns a non-200 status and a null or error body; accessing it without a guard causes a NullPointerException at runtime.

            ```groovy
            import groovy.json.JsonOutput

            def response = get('/wiki/api/v2/spaces')
                .header('Content-Type', 'application/json')
                .asObject(Map)
            assert response.status == 200 : "Unexpected response status: ${response.status}"
            def spaces = response.body.results as List<Map>
            ```

            Apply the same pattern for POST/PUT/DELETE calls — check `response.status` against the expected success code documented in the OpenAPI schema before using the body.
        </unirest_implementation_example>
    </rest_api_integration>

    <listener_event_handling>
        <event_context>
            Listener bindings arrive as Groovy `Map` objects matching the shape of their corresponding REST API response. All events always include `timestamp` (Long) and `webhookEvent` (String). Additional bindings depend on the event family.
            Use the bundled ScriptRunner for Confluence Cloud documentation and the Confluence v1 OpenAPI spec to discover the exact properties available on each binding Map.
        </event_context>

        <confluence_event_bindings>
            <page_events>
                Events: `page_created`, `page_updated`, `page_removed`, `page_restored`, `page_trashed`, `page_viewed`, `page_children_reordered`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `page` | java.util.Map | Get Content REST API (type page) — keys include `id`, `type`, `title`, `status`, `space`, `version`, `_links` |
            </page_events>

            <page_moved_event>
                Event: `page_moved`
                | Binding | Type | Description |
                |---------|------|-------------|
                | `page` | java.util.Map | The moved page (Get Content REST API shape) |
                | `newParent` | java.util.Map | New parent page (Get Content REST API shape) |
                | `oldParent` | java.util.Map | Previous parent page (Get Content REST API shape) |
            </page_moved_event>

            <blog_events>
                Events: `blog_created`, `blog_updated`, `blog_removed`, `blog_trashed`, `blog_viewed`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `blog` | java.util.Map | Get Content REST API (type blogpost) — same shape as `page` but `type` is `"blogpost"` |
            </blog_events>

            <comment_events>
                Events: `comment_created`, `comment_updated`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `comment` | java.util.Map | Get Content Comments REST API — keys include `id`, `type`, `title`, `body`, `version` |
            </comment_events>

            <attachment_events>
                Events: `attachment_created`, `attachment_removed`, `attachment_updated`, `attachment_viewed`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `attachments` | java.util.List | List of attachment objects (Get Attachment REST API shape) |
                | `attachedTo` | java.util.Map | Parent content page (Get Content REST API shape) |
            </attachment_events>

            <space_events>
                Events: `space_created`, `space_updated`, `space_removed`, `space_permissions_updated`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `space` | java.util.Map | Get Space REST API — keys include `id`, `key`, `name`, `type`, `status`, `_links` |
            </space_events>

            <label_events>
                Events: `label_created`, `label_deleted`, `label_removed`
                | Binding | Type | Description |
                |---------|------|-------------|
                | `label` | java.util.Map | Label object with `name`, `title`, and `self` URL |

                Special case — `label_added`:
                | Binding | Type | Description |
                |---------|------|-------------|
                | `label` | java.util.Map | The label |
                | `labeled` | java.util.Map | The content that was labeled (Get Content REST API shape) |
            </label_events>

            <content_events>
                Events: `content_created`, `content_updated`, `content_trashed`, `content_restored`, `content_permissions_updated`
                Note: these events are registered but currently NOT triggered by Atlassian.
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `content` | java.util.Map | Get Content REST API shape |
            </content_events>

            <user_events>
                Events: `user_created`, `user_deactivated`
                IMPORTANT: Confluence user events provide `userProfile` — NOT `user` like Jira.
                | Binding | Type | Description |
                |---------|------|-------------|
                | `userProfile` | java.lang.Object | Has properties: `userProfile.userAccountId` (String) and `userProfile.fullName` (String). NOT a Map — access properties directly. |
            </user_events>

            <group_events>
                Events: `group_created`, `group_removed`
                Note: these events are registered but currently NOT triggered by Atlassian.
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `group` | java.util.Map | Get Group REST API shape |
            </group_events>

            <relation_events>
                Events: `relation_created`
                | Binding | Type | Description |
                |---------|------|-------------|
                | `relationData` | java.util.Map | Create Relation REST API shape |
                | `name` | java.lang.String | Name of the relation |
                | `source` | java.util.Map | Source entity (Create Relation REST API shape) |
                | `target` | java.util.Map | Target entity (Create Relation REST API shape) |
            </relation_events>

            <blueprint_events>
                Event: `blueprint_page_created`
                | Binding | Type | REST API shape |
                |---------|------|----------------|
                | `page` | java.util.Map | Get Content REST API (type page) |
            </blueprint_events>
        </confluence_event_bindings>

        <binding_variable_usage>
            Binding variables are Maps matching Confluence REST API v1 response shapes. To discover exact properties:
            1. Load the `atlassian-cloud-rest-api` skill and search `confluence-cloud-v1-openapi.json` for the backing endpoint.
            2. Inspect the operation response schema and resolve its `$ref` chain to see the available keys.
            Avoid shadowing binding names (e.g. declaring your own `page` variable) to preserve access to the event payloads.
        </binding_variable_usage>
    </listener_event_handling>

    <scheduled_jobs>
        <script_jobs>
            Script jobs run on a cron schedule and receive only `baseUrl` and `logger`. Use CQL search via the REST API to find content to operate on.
        </script_jobs>

        <cql_script_jobs>
            CQL script jobs (escalation services) iterate over CQL search results. Each iteration binds a `content` variable representing the matched content item.

            | Binding | Type | Description |
            |---------|------|-------------|
            | `baseUrl` | java.lang.String | Always |
            | `logger` | org.slf4j.Logger | Always |
            | `content` | java.util.Map | Current content item from CQL results |

            When validating CQL script job code, run `sms-groovy-check --script <path> --platform cloud --product confluence --context escalation-service`.
        </cql_script_jobs>
    </scheduled_jobs>

    <method_type_safety>
        Define method signatures with explicit parameter and return types:
        ```groovy
        void archiveOldPages(String spaceKey, int maxDays) {
            // implementation
        }
        ```
        This keeps static compilation satisfied and prevents runtime coercion issues.
    </method_type_safety>

</platform_guidance>
