# Confluence Cloud

What a script meets at run time when it calls Confluence Cloud. Snapshot 2026-10-08, read from `@managed-api/confluence-cloud-sr-connect` 3.2.0 and `@managed-api/confluence-cloud-v2-sr-connect` 2.4.0 and from agents' notes on a real site. Load this file only when a script calls Confluence Cloud's API. Authorizing the connector is `references/connector-setup/confluence-cloud.md`; Confluence has no listener type, and events reach a Generic listener as `references/event-listener-setup/generic.md` describes.

## The vendor API

- Atlassian is removing the v1 REST API piece by piece. Removed endpoints answer 410 "This deprecated endpoint has been removed". Seen gone: `GET /wiki/rest/api/content` and the v1 content property endpoints. The v1 CQL search, `GET /wiki/rest/api/search`, still works.
- A v2 page update, `PUT /wiki/api/v2/pages/{id}`, needs `version.number` set to the current number plus one. A concurrent edit answers 409; read the page again and retry.
- The Page Properties macro is a `bodiedExtension` node with `extensionKey: details` in Atlassian Document Format, and a table inside it. The label cell is `tableHeader` on some pages and `tableCell` on others built from the same template, `<th>` and `<td>` in storage format, so take a row's first cell whatever its type. A match on `<th>` alone silently skipped most pages for one agent.
- Content properties do not hold the Page Properties macro's data, only keys the editor keeps for itself such as `content-appearance-*`. The macro table in the page body is the only place the API exposes it.

## The Managed API

A v1 and a v2 package, and the connector serves both; the choice is made on `api-connection create`:

- `@managed-api/confluence-cloud-sr-connect`, the v1 REST API. Many of its methods are marked `@deprecated`, `Content.getContent` among them; treat each as removed until a probe shows otherwise, since the removed endpoints answer 410 through them. `getContentProperties` exists only at the root, as a deprecated alias of `Content.Property.getProperties`; inside the group the method is `getProperties`, and both reach the removed endpoint. `Search.searchContent` works and takes `expand` as an array, `expand: ['content.body.atlas_doc_format']`, which is the shortest way to a page's ADF without v2.
- `@managed-api/confluence-cloud-v2-sr-connect`, the v2 REST API. It also carries the surviving v1 calls under `V1`, so `V1.Search.searchContent` is the same CQL search. Page content properties are `Content.Property.Page.*`.

Prefer v2 for anything it covers. The platform's OAuth app requests v2 scopes for pages, comments, attachments, spaces, tasks, custom content, label reads and content metadata; the connector file says which uses need the self-managed app.

Results are loosely typed; expect optional chaining on most fields.

## Event types

None. Confluence Cloud has no listener type and no events library. When Atlassian Automation sends the events, load `atlassian-automation.md` beside this file.

## Verify before trusting

- A method: read its `@deprecated` tag in `node_modules/@managed-api/confluence-cloud-core/index.d.ts` or `confluence-cloud-v2-core/index.d.ts`, and search the core package's `index.js` for the vendor path to find the method behind it.
- A removed endpoint: one probe call through the connection's managed `fetch`; a 410 settles it.
- The Page Properties shape: log one page's body with `body-format=atlas_doc_format` before writing the parser.
