# Generic

Listener type HTTP_ENDPOINT, 2 event types: "Async HTTP Event" and "Sync HTTP Event". Nothing to register on any vendor's side by definition; whatever can send an HTTP request is the sender, and what the block hands the user depends on what that is. Snapshot 2026-09-14 from the web application's setup dialog and https://docs.adaptavist.com/src/latest/workspaces/event-listeners/generic-http-events. The three bridges below were cross-checked the same day against the vendor URLs named in each.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. No connector is involved. The URL path is the one you chose on create, or a generated one, lower-cased, unique across the deployment; a Generic listener's `webhookUrl` is the whole contract.

## Steps

1. Give the sender the webhook URL. The web application's dialog says the same and nothing else: "Copy and use the URL to connect to ScriptRunner Connect."
2. Say which method, content type and body shape the script expects; the script decides, not the platform. JSON content types arrive parsed as `json`, text types as `text`, everything else as `base64`.
3. Async listeners answer at once with the invocation ID and run the script afterwards. Sync listeners run the script inside the request and return its response within 25 seconds; use sync only when the sender needs the answer.

## Filter on the app side

Whatever the sender offers. Nothing on the platform side filters a Generic listener; every request on the path reaches the script. So the script checks first: method, a header or body field that identifies the sender, and the field that scopes the work, all against parameters, returning `401` or `204` early otherwise.

## Secure it

The endpoint is anonymous. Use all three of these where the sender allows:

- A URL path that cannot be guessed: pass `--url-path` with a random suffix on create, or leave it to the generated one.
- A shared secret in a header, compared in the script against a masked TEXT parameter, as `references/scripting.md` shows with `x-shared-secret`. Where the sender signs instead, verify the signature with `crypto.subtle`.
- An allowlist on `event.sourceIp` when the sender publishes its addresses.

The platform verifies nothing on a Generic listener.

## Bridges

Some apps the skill sends through a Generic listener because they have no listener type of their own.

### Trello

Trello registers webhooks only through its REST API, so the agent can do this step with the Trello connector rather than the user. Source: https://developer.atlassian.com/cloud/trello/guides/rest-api/webhooks/.

1. Create the Generic listener, async.
2. Through the Trello Managed API or `fetch` on the Trello API connection: `POST /1/tokens/<token>/webhooks/` (or `POST /1/webhooks` with OAuth) with `callbackURL` = the webhook URL, `idModel` = the ID of the board, list, card or member to watch, `description` for the user. Trello first sends a `HEAD` request to the URL and refuses the registration unless it answers 200. An async Generic listener answers 200 with the invocation ID before the script runs, which is why step 1 picks async; a sync listener answers whatever the script returns, so pick one only when the integration needs a particular status back.
3. Filter: `idModel` is the filter, one webhook per model. In the script check `action.type` (`updateCard`, `createCard`, `commentCard`) and `action.data.board.id`.
4. Secure: every delivery carries `X-Trello-Webhook`, the base64 HMAC-SHA1 of the raw body concatenated with the exact `callbackURL`, keyed with the Trello app's secret. Verify it in the script with `crypto.subtle` against a masked TEXT parameter holding the app secret. Trello's addresses are `104.192.142.240/28` and are listed at https://ip-ranges.atlassian.com/.
5. Trello retries three times at 30, 60 and 120 seconds, disables a webhook after 30 days of consecutive failures, and deletes it on a 410 from the endpoint.

### Confluence Cloud

Confluence Cloud has no admin-configured webhooks and `app list` reports no listener types for it. Two ways to get its events out, both configured in Confluence by the user. Sources: https://docs.adaptavist.com/sr4cc/latest/features/script-listeners and https://support.atlassian.com/cloud-automation/docs/actions-in-confluence-automation/.

- ScriptRunner for Confluence Cloud, "Script Listeners": a listener with the wanted events under "On These Events" (page created, updated, moved, removed; attachment, blog, comment, label, space and user events), running "As This User", with a "Code to Run" that posts the `webhookEvent` to the webhook URL. The listener scripts ship `Unirest` pre-imported for HTTP; `Unirest.post(<webhookUrl>).header('x-shared-secret', <value>).body(webhookEvent).asString()` is the shape, and the docs show Unirest only against Confluence's own API, so test the outbound call once.
- Confluence automation, "Send web request" action: a rule on a page event with the webhook URL, JSON body and custom headers, configured in the space or site automation settings. No code, fewer events than ScriptRunner offers.

Filter: the event selection, and in ScriptRunner a condition in the code on `webhookEvent` (space key, page title). Secure: neither signs; set a shared-secret header in the listener or the web request and check it in the script.

### Google Calendar and Google Sheets

No connector-level events. Google Apps Script bound to the sheet, or a standalone script with a calendar trigger, posts to the webhook URL. Sources: https://developers.google.com/apps-script/guides/triggers/installable and https://developers.google.com/apps-script/reference/url-fetch/url-fetch-app.

1. In the Apps Script editor, "Triggers", "Add Trigger": the function, the event source (the spreadsheet or a calendar), the event type ("On edit", "On change", "On form submit", or the calendar's "Calendar updated"), "Save". Installable triggers run as the user who created them.
2. The function calls `UrlFetchApp.fetch(url, { method: 'post', contentType: 'application/json', headers: { 'x-shared-secret': secret }, payload: JSON.stringify(data) })`. Read the secret from `PropertiesService.getScriptProperties()`, never a literal.
3. Filter: the trigger type, and the function's own check on the sheet name or range before posting. Secure: Apps Script signs nothing; the shared-secret header is the check, compared in the SRC script.
4. Quotas: 20,000 URL fetch calls a day on a consumer account, 100,000 on Google Workspace; 90 minutes a day of trigger runtime on consumer accounts, six hours on Workspace; 20 triggers per user per script. A sheet edited constantly can exhaust these.

## Known differences from the setup dialog

- The dialog's three "Common use cases" are the docs' three: receive events, publish an API, publish a UI. It says nothing about filtering or security, which is right for a Generic listener; the block must, because nothing else will.

## Verify before trusting

The sender's own documentation, every time; this file can only be current about the three bridges above.
