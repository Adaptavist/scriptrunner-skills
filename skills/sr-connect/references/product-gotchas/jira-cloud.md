# Jira Cloud

What a script meets at run time when it calls Jira Cloud or handles its events. Snapshot 2026-10-08, read from `@managed-api/jira-cloud-v3-sr-connect` 3.7.0 and `@sr-connect/jira-cloud` 1.5.0 and from agents' notes on real sites. Load this file only when a script calls Jira Cloud's API or handles its events. Authorizing the connector is `references/connector-setup/jira-cloud.md`; registering the webhook is `references/event-listener-setup/jira-cloud.md`.

## The vendor API

- Search moved. Atlassian removed `GET` and `POST /rest/api/3/search`; both answer 410 "The requested API has been removed. Please migrate to the /rest/api/3/search/jql API". The replacement, `/rest/api/3/search/jql`, pages with `nextPageToken` and `isLast` rather than `startAt` and `total`.
- The user directory, `GET /rest/api/3/users`, has surprises for any question about people:
    - `timeZone` and `emailAddress` are left out of the response entirely when the account's profile visibility hides them, and on a real site most active people hide them. Count the omissions and report them, or the answer silently covers a minority of the directory.
    - `timeZone` is not always an IANA region name. Legacy aliases come back mixed in: `GB`, `GMT`, `Greenwich`, `Universal`, `UTC`, `CET`, `Turkey`, `PST8PDT`, and the `US/*` and `Canada/*` families. Two people on the same clock can carry different strings, so map the aliases before comparing, never compare the strings as they come.
    - `app` and `customer` accounts come back beside `atlassian` ones, and inactive accounts keep their fields. Filter on `accountType` and `active`.
    - There is no total and no `isLast`. A page shorter than `maxResults` is the end.

## The Managed API

`@managed-api/jira-cloud-v3-sr-connect`. Method names do not always follow the vendor path, and some of the obvious ones are dead:

- `GET /rest/api/3/users` is `User.getUsersDefault`. `User.getUsers` is `/rest/api/3/users/search`.
- `Issue.Search.searchByJql` is marked `@deprecated` and calls the removed `/rest/api/3/search`, so every call is the 410 above. Use `Issue.Search.searchByJqlEnhancedSearch`, which posts to `/rest/api/3/search/jql`.
- Create metadata is `Issue.Metadata.getIssueTypesMetadataForCreateIssue` and `Issue.Metadata.getFieldsMetadataForCreateIssue`. The older names beside them, `getCreateIssueTypesMetadata` and `getCreateFieldMetadata`, are deprecated aliases.
- Response types not exported from the package root are deep imports, for example `import { UserAsResponse } from '@managed-api/jira-cloud-v3-core/definitions/UserAsResponse'`. List `definitions/` to find one.
- Every field of a `getIssue` response is optional in the type, `fields` and `fields.reporter` included. Under ts-strict, `issue.fields?.reporter?.displayName`.
- The Atlassian Document Format type is `AtlassianDocumentFormat` from `@sr-connect/jira-cloud/types/adf`, the events library. A workspace with no Jira Cloud listener does not have that library as its own dependency; add it with `package add` before importing the type to build a `description` or a comment body, rather than casting.
- The Jira Software API, boards and sprints, is a second package, `@managed-api/jira-software-cloud-sr-connect`, which a workspace carries beside the main one. The platform's OAuth app does not cover it; see the connector file.

## Event types

`@sr-connect/jira-cloud/events`. The types lag what Jira sends:

- `IssueFields` has no `parent`, though real payloads carry it and the seeded sample does too. It reads through the index signature as `any`; declare a local type for it.
- The event's `Comment` has no `visibility`, which Jira sends on a comment restricted to a role or group. A sync that must not leak restricted comments declares the field locally and checks it.
- `summary`, `project`, `issuetype`, `reporter` and the rest of `IssueFields` are optional. `event.issue.fields.project.key` fails ts-strict; write `event.issue.fields.project?.key`.
- The seeded samples use project `TST`. A script scoped to one project skips them; see Simulation loop in `references/cli-workflow.md`.

## Verify before trusting

- A method name: search the core package's `index.js` for the vendor path, `grep -n "/rest/api/3/users" node_modules/@managed-api/jira-cloud-v3-core/index.js`, and read the `@deprecated` tags in its `index.d.ts`.
- An event field: `node_modules/@sr-connect/jira-cloud/types/issue.d.ts` and `comment.d.ts`, then one real event logged from the listener.
- The vendor behaviour: a probe script reading one page of `/rest/api/3/users` through the connection.
