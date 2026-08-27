# Available Specs

- `references/specs/assets-cloud-openapi.json`
  - Product: Assets Cloud REST API
  - Common paths: `/rest/assets/1.0/...`
  - Operations: 64
  - Schemas: 52
  - Source: https://dac-static.atlassian.com/cloud/assets/swagger.v3.json
  - Summary: Assets Cloud REST APIs for object schemas, object types, objects, attributes, icons, statuses, and AQL search.

- `references/specs/confluence-cloud-v1-openapi.json`
  - Product: Confluence Cloud REST API v1
  - Common paths: `/wiki/rest/api/...`
  - Operations: 130
  - Schemas: 168
  - Source: https://dac-static.atlassian.com/cloud/confluence/swagger.v3.json
  - Summary: Confluence Cloud REST API v1 for CQL content search, audit, templates, and legacy space or content operations that are not available in v2.

- `references/specs/confluence-cloud-v2-openapi.json`
  - Product: Confluence Cloud REST API v2
  - Common paths: `/wiki/api/v2/...`
  - Operations: 218
  - Schemas: 142
  - Source: https://dac-static.atlassian.com/cloud/confluence/openapi-v2.v3.json
  - Summary: Confluence Cloud REST API v2 for pages, blogposts, spaces, attachments, comments, labels, content properties, tasks, whiteboards, databases, and other current Confluence resources.

- `references/specs/jira-cloud-platform-v3-openapi.json`
  - Product: Jira Cloud platform REST API v3
  - Common paths: `/rest/api/3/...`
  - Operations: 617
  - Schemas: 971
  - Source: https://dac-static.atlassian.com/cloud/jira/platform/swagger-v3.v3.json
  - Summary: Jira Cloud platform REST API v3 for core Jira resources such as issues, projects, users, workflows, fields, permissions, and dashboards.

- `references/specs/jira-service-management-cloud-openapi.json`
  - Product: Jira Service Management Cloud REST API
  - Common paths: `/rest/servicedeskapi/...`
  - Operations: 75
  - Schemas: 117
  - Source: https://dac-static.atlassian.com/cloud/jira/service-desk/swagger.v3.json
  - Summary: Jira Service Management Cloud REST APIs for service desks, requests, queues, approvals, SLAs, and organizations.

- `references/specs/jira-software-cloud-openapi.json`
  - Product: Jira Software Cloud REST API
  - Common paths: `/rest/agile/1.0/...`
  - Operations: 105
  - Schemas: 66
  - Source: https://dac-static.atlassian.com/cloud/jira/software/swagger.v3.json
  - Summary: Jira Software Cloud REST APIs for boards, sprints, epics, backlog, and other software-specific endpoints.

## Lookup pattern

1. Use `rg` to find candidate paths, operationIds, or component names.
2. Use `jq` to inspect the specific path/method or component.
3. Resolve any `$ref` chains before generating code.
4. Cite the spec file plus resolved operation and schema names.

## Ref checklist

- Resolve path-level `parameters`
- Resolve operation-level `parameters`
- Resolve `requestBody`
- Resolve `responses`
- Resolve nested schema `$ref` values
- Inspect `allOf`, `oneOf`, `anyOf`, and array `items`
