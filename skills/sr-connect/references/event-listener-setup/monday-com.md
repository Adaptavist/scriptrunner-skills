# monday.com

Listener type WEBHOOK, 22 event types, all board-level: item created, archived, deleted, moved, name changed, column changed, update created, subitem events. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://developer.monday.com/api-reference/reference/webhooks; monday's support article on the Webhooks integration refused a direct fetch, so its button labels below are the dialog's.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the account's URL, `https://<account>.monday.com`. `connectionRequired` is false.

## Deep links

`<baseUrl>` opens the account; the board is picked there. A board's URL is `<baseUrl>/boards/<boardId>`, and the webhook is added from the board. Without a base URL: sign in at https://monday.com and open the board.

## Steps

1. Open the board the listener is for. Webhooks are per board; another board needs another webhook to the same URL, and the script then checks `event.boardId`.
2. Top right, "Integrate" (the support article calls the button "Integrations"), search for "webhooks", open the Webhooks integration.
3. Pick the recipe whose action matches the SRC event type: "When an item is created, send a webhook", "When a status changes, send a webhook" and so on. Every column-change event type in SRC ("When a status changes", "When a date changes", "When a person changes", "When a column changes") uses the recipe "When a column changes, send a webhook".
4. Paste the webhook URL into "Webhook URL", "Connect". monday posts a JSON body with a `challenge` field to the URL and expects it echoed back; the platform does that, and the recipe shows as connected. A failure here means the URL, not the board.
5. For a column-change recipe, the recipe sentence now has an "a column" dropdown: pick the column the listener is for, or "a column on the board" for any column.
6. "Add to board". Optionally give the recipe a description so it can be told apart from other webhooks later.

## Filter on the app side

The board, the recipe, and for column events the column. Nothing narrower; a webhook on a busy board fires for every item. In the script, check `event.boardId` against a parameter, and for column events `event.columnId`; the payload also carries `event.pulseId` (the item), `event.groupId`, `event.value` and `event.previousValue`. Create the webhook through monday's GraphQL `create_webhook` instead, with a `config` such as `{"columnId": "status", "columnValue": {"index": [1]}}`, when the integration wants one status value only; the Managed API can do that, and the result is the same webhook.

## Secure it

The board integration signs nothing and offers no secret. monday sends a JWT in the `Authorization` header only for webhooks created with a monday app's token through the API; the recipe on the board does not, and a monday.com listener receives the body only, so the header would not reach the script anyway. The script relies on the URL being unguessable and on checking `event.boardId`. Hardening is possible through a Generic listener, which receives headers: register the webhook through the API from an app token and verify the JWT in the script with `jose-browser-runtime`. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. monday publishes no address list. monday retries a delivery that fails or times out once a minute for 30 minutes, but a WEBHOOK listener is asynchronous: the platform acknowledges the delivery before the script runs, so an exception in the script is invisible to monday and the event is not resent. Only a delivery that never reached the platform comes back. Handle a redelivery idempotently and never rely on a throw to get the event again. A synchronous Generic listener is the exception, the script running inside the request.

## Known differences from the setup dialog

- The dialog says "Integrate"; the support article says "Integrations" and a "Create" tab. Same button, and the search box finds "webhooks" either way.
- The dialog does not mention the challenge handshake by name, only that "monday.com will test the connection". It is the challenge, and the platform answers it.
- The dialog says nothing about security. There is nothing to configure on the board; say so, and say what the script checks instead.

## Verify before trusting

The recipe names for the event in question, and whether the column dropdown still appears after "Connect". monday's recipe wording changes; the API reference's event enum does not.
