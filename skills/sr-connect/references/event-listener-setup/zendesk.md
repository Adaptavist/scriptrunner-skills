# Zendesk

Listener type "Zendesk", 1 event type: "Generic Event". Zendesk decides what the event carries, through one of two connection methods. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://support.zendesk.com/hc/en-us/articles/4408839108378 ("Creating webhooks to interact with third-party systems"), https://developer.zendesk.com/documentation/webhooks/verifying/ and https://developer.zendesk.com/api-reference/webhooks/event-types/webhook-event-types/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the account, `https://<subdomain>.zendesk.com`. `connectionRequired` is false.

Ask which method the user wants before writing the block. "Zendesk events" is for organization, user, help center, community, agent availability and messaging events. "Trigger or automation" is for ticket activity and gives the user full control of the payload. A webhook uses one method or the other, never both.

## Deep links

Off `baseUrl`:

- Admin Center home: `<baseUrl>/admin/home`; webhooks are under "Apps and integrations", "Webhooks", "Webhooks"
- Triggers: `<baseUrl>/admin/objects-rules/rules/triggers`

## Steps

Common start:

1. Open Admin Center, "Apps and integrations", "Webhooks", "Webhooks", "Create webhook".
2. Choose the method: "Zendesk events" or "Trigger or automation".

Zendesk events:

3. Under "Subscribe to", pick one or more events from the list, "Next".
4. "Name" the webhook. Paste the webhook URL into "Endpoint URL". Request method is POST and format JSON for event webhooks. Authentication: see Secure it. "Create webhook".

Trigger or automation:

3. "Next". "Name" the webhook. Paste the webhook URL into "Endpoint URL". Request method POST, request format JSON. Authentication: see Secure it. "Create webhook".
4. Open "Triggers" ("Objects and rules", "Business rules", "Triggers"). "Create trigger", or edit one.
5. Name and category. Under "Conditions" add at least one condition: a category, an operator and a value. This is the filter.
6. Under "Actions", "Add action", "Notify by", "Active webhook", pick the webhook.
7. Write the JSON body. "View available placeholders" lists them; the SRC script receives exactly this JSON, so put in it what the script needs, `{"ticketId": "{{ticket.id}}", "ticketTitle": "{{ticket.title}}", "status": "{{ticket.status}}"}` for example. "Create".

The webhook's details page has a "Test webhook" panel that sends a sample; use it to see the payload land in `log list-invocation-logs`.

## Filter on the app side

The best of any app here. Event webhooks: the subscription list, one event type or several (`zen:event-type:user.active_changed`, article, community post, organization, agent availability and so on). Trigger webhooks: the trigger's conditions, everything Zendesk can test on a ticket, plus a payload you shaped. Use both layers: a trigger condition on the group or form, and a body that carries only what the script reads. In the SRC script, check the field that scopes the work against a parameter anyway, because triggers are edited by admins.

## Secure it

Zendesk offers two mechanisms: a signing secret on every webhook, behind "Reveal secret" on the details page, sent as `X-Zendesk-Webhook-Signature` with the base64 HMAC-SHA256 of `<timestamp><body>` and `X-Zendesk-Webhook-Signature-Timestamp`; and the "Authentication" field, "API key", "Bearer token" or "Basic authentication", each a header. Neither reaches the script, which receives the body only, and the platform checks no headers for this app; leave "Authentication" at "None required" and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: a script behind one verifies the signature with `crypto.subtle` or compares the authentication header with `===` against a masked TEXT parameter, or checks the sender against `https://<subdomain>.zendesk.com/ips`, consolidated as `216.198.0.0/18`. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

- The dialog names no authentication and no signing secret. The webhook form has an "Authentication" field and every webhook has a secret behind "Reveal secret"; neither changes anything for this listener type.
- The dialog reads "Notify by" then "Active webhook", which matches the docs.
- The dialog's example payload has two fields; the block should list the fields the script actually reads.
- Zendesk retries only on 409, on 429 and 503 with a `retry-after` under a minute, and up to five times on a timeout; a script error does not cause a resend.

## Verify before trusting

The event list for the "Zendesk events" method, which Zendesk extends, and the trigger's conditions with the user. The Admin Center paths above match the current docs.
