# monday.com

What a script meets at run time when it calls monday.com or handles its events. Snapshot 2026-10-08, read from `@managed-api/monday-v2025-07-core` 1.0.0. Load this file only when a script calls monday.com's API or handles its events. Authorizing the connector is `references/connector-setup/monday-com.md`; registering the webhook is `references/event-listener-setup/monday-com.md`.

## The vendor API

GraphQL only. The version is in the package name, `v2025-07`; a newer API version is a different package, not an upgrade of this one.

## The Managed API

`@managed-api/monday-v2025-07-sr-connect` is GraphQL-shaped. The options carry `args` for query arguments and `fields` for the selection: `true` for a leaf, `{ fields: {...} }` for a nested object, which may take its own `args`. The response type is inferred from `fields`, so you can read only what you asked for. Results are under `response.data`. For hand-written GraphQL use the connection's managed `fetch` or `gql-query-builder` from the verified list in `references/scripting.md`.

```ts
const response = await Monday.Board.getBoards({
	args: { ids: [123] },
	fields: { name: true, items_page: { fields: { items: { fields: { id: true, name: true } } } } },
})
```

Source: https://docs.adaptavist.com/src/latest/managed-apis/managed-api-for-monday.com

## Event types

None known.

## Verify before trusting

`node_modules/@managed-api/monday-v2025-07-core/index.d.ts` for the method list and the request types under `types/`.
