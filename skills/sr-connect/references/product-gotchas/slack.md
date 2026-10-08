# Slack

What a script meets at run time when it calls Slack or handles its events. Snapshot 2026-10-08, read from `@managed-api/slack-core` 2.4.0. Load this file only when a script calls Slack's API or handles its events. Authorizing the connector is `references/connector-setup/slack.md`; registering the events is `references/event-listener-setup/slack.md`.

## The vendor API

Slack reports most failures in the body of a 200: `{ "ok": false, "error": "channel_not_found" }`. A status check alone passes them; read `ok`.

## The Managed API

`@managed-api/slack-sr-connect`. Because of the 200-with-an-error shape, the package adds its own error beside the common ones: `SlackError`, from `@managed-api/slack-core/common`, carrying `response` with that body. Catch it with `instanceof SlackError`, or handle it in `errorStrategy` with `handleSlackError`, which sits beside the `handleHttp*` members. Block Kit builders ship in the core package, `createSectionBlock`, `createActionsBlock` and the rest from `@managed-api/slack-core/blockKit`; `slack-block-builder` on the verified list in `references/scripting.md` is the alternative.

## Event types

None known. Which event types the listener offers, interactive Block Actions and View Submission among them, is in `references/event-listener-setup/slack.md`.

## Verify before trusting

`node_modules/@managed-api/slack-core/common.d.ts` for `SlackError` and `errorStrategy.d.ts` for the handler name.
