# Opsgenie

Listener type WEBHOOK, 18 event types, one per alert action: created, acknowledged, unacknowledged, snoozed, escalated, closed, assigned, tagged, noted and the rest. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://support.atlassian.com/opsgenie/docs/integrate-opsgenie-with-webhook/ and https://support.atlassian.com/opsgenie/docs/use-advanced-integration-settings/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, `https://app.opsgenie.com` or `https://app.eu.opsgenie.com` for the European region. `connectionRequired` is false.

## Deep links

Off `baseUrl` with the trailing slash removed: `<baseUrl>/settings/integration/add/Webhook/` opens the new Webhook integration form. Documented as "Settings", "Integrations", "Add integration", search "Webhook".

## Steps

1. Open the Webhook integration form. Name it after the integration; optionally pick an "Assignee team", which limits the webhook to that team's alerts.
2. "Continue" saves it. "Turn on integration", which the dialog calls "Enabled".
3. Under "Post to Webhook URL for Opsgenie alerts", keep only the mapping for the action the listener was created for and remove the others; Opsgenie seeds several. One Opsgenie action may map to one URL only, except tag-added and custom actions.
4. Paste the webhook URL into "Webhook URL".
5. For a created or custom action, tick alert description and alert details if the script needs them; both are cut at 1,000 characters.
6. Leave custom headers empty; see Secure it. "Save Integration".

## Filter on the app side

The action mappings are the first filter, the assignee team the second. On Standard and Enterprise plans every action also has a filter section under the advanced settings, "Match all alerts", "Match one or more conditions below" or "Match all conditions below", on alert fields, tags and priority, up to 50 rules. Use it for a priority or a tag. In the script, check `action` and `alert.teams` or `alert.tags` against parameters; the payload is the alert with the action name.

## Secure it

No secret and no signature. The integration form takes custom headers, but an Opsgenie listener receives the body only and the platform checks no headers for this app, so a header would go unread; set none and add no check. Hardening is possible through a Generic listener, which receives headers: a custom header such as `X-Webhook-Secret` with a shared value, compared in the script against a masked TEXT parameter. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. Opsgenie publishes no address list for outgoing webhooks that this snapshot could find.

## Known differences from the setup dialog

- The dialog says "Enabled"; the form says "Turn on integration".
- The dialog names the section "For Opsgenie alerts"; the docs call it "Post to Webhook URL for Opsgenie alerts".
- The dialog says nothing about custom headers or the per-action filter; both exist, the filter on paid plans.
- The dialog's fallback placeholder is `[YOUR_INSTANCE]`; the two real hosts are the US and EU ones above.

## Verify before trusting

The user's plan for the advanced filter, the region host, and whether the seeded mappings still appear on a new integration.
