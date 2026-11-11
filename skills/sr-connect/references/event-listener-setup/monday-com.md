# monday.com

Listener type WEBHOOK, 24 event types, all board-level: item created, archived, deleted, restored, moved to any group or to one group, status changed to one value, name changed, column changed, update posted, edited and deleted, subitem events, column created. Snapshot 2026-10-29 from the web application's setup dialog, walked the same day on a monday.com board and cross-checked against https://developer.monday.com/api-reference/reference/webhooks.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the account's URL, `https://<account>.monday.com`. `connectionRequired` is false.

## Deep links

`<baseUrl>` opens the account; the board is picked there. A board's URL is `<baseUrl>/boards/<boardId>`, and the webhook is added from the board. Without a base URL: sign in at https://monday.com and open the board.

## Steps

1. Open the board the listener is for. Webhooks are per board; another board needs another webhook to the same URL, and the script then checks `event.event.boardId`. For subitem events `event.event.boardId` is the board's subitems board, not the board the webhook is on, and a moved subitem sends no `boardId` at all; the parent board is in a field that differs by event, so check that event's payload before filtering.
2. Top right of the board, "Integrate". It opens a panel titled "Automations <board>" with "Create" and "Manage" tabs. Type "webhooks" in the search box and open the "webhooks" tile under "Integrations".
3. Find the recipe card whose sentence matches the SRC event type, "When an item is created, send a webhook", "When an item is archived, send a webhook" and so on, and click "Use template". The SRC event types "When a person changes", "When a date changes", "When a status changes" and "When a column changes" all use the one card "When a column changes, send a webhook"; "When any column changes" has its own card. Two SRC event types are worded differently from their card: "When a new update is posted" is the card "When a new update posted, send a webhook", and "When a subitem is archived" is "When subitem is archived, send a webhook". "When a status changes to something" and "When an item moves to group" have their own cards and fire for one status value or one group only; they send the same payload as "When a status changes" and "When an item is moved to any group".
4. "Connect your webhook URL": paste `webhookUrl` into "Webhook URL", "Connect". monday.com posts a JSON body with a `challenge` field to the URL and expects it echoed back; the platform does that, and the page moves on. A failure here means the URL, not the board. On a board where a webhook URL was connected before, this page is replaced by "Choose an account connection": the existing URL as a card, and "Use another account" to paste a different one.
5. The page now shows the recipe sentence. For the column-change card it reads "When a column changes, send a webhook" with "a column" underlined: click it, and "Select a column" lists the board's columns by their titles, "Owner", "Status", "Due date" and so on, plus "Add a new column". Select the column the listener is for by its name on the board; the dialog's person, date and status are column types, not titles. There is no option for every column, that is the "When any column changes" card. The "When a status changes to something" and "When an item moves to group" cards have their own dropdowns in the sentence: "a status" lists the board's status columns and "something" their values, with "Anything" first; "group" lists "Top group" and the board's groups by name.
6. "Create automation". The webhook then appears under the panel's "Manage" tab, where a description can be added to tell it apart from other webhooks later.

## Filter on the app side

The board, the recipe, and for column events the column. Nothing narrower on the board except the one-value and one-group cards in step 3; a webhook on a busy board fires for every item. In the script, check `event.event.boardId` against a parameter (for subitem events, see step 1), and for column events `event.event.columnId`; the payload also carries event-specific fields, such as `event.event.pulseId` (the item), `event.event.groupId`, `event.event.value` and `event.event.previousValue`. Not every event type sends every field, so check that a field exists before the script reads it. Create the webhook through monday's GraphQL `create_webhook` instead, with a `config` such as `{"columnId": "status", "columnValue": {"index": [1]}}`, when the integration wants one status value only; the Managed API can do that, and the result is the same webhook.

## The payload

The script receives monday.com's body unchanged, an object with one key, `event`, so every field is read as `event.event.<field>`. A "When an item is created" payload carries `app`, `type` (`create_pulse`), `triggerTime`, `subscriptionId`, `userId`, `originalTriggerUuid`, `boardId`, `pulseId`, `pulseName`, `groupId`, `groupName`, `groupColor`, `isTopGroup`, `columnValues` and `triggerUuid`.

## Secure it

The board integration signs nothing and offers no secret. monday sends a JWT in the `Authorization` header only for webhooks created with a monday app's token through the API; the recipe on the board does not, and a monday.com listener receives the body only, so the header would not reach the script anyway. The script relies on the URL being unguessable and on checking `event.event.boardId`. Hardening is possible through a Generic listener, which receives headers: register the webhook through the API from an app token and verify the JWT in the script with `jose-browser-runtime`. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. monday publishes no address list. monday retries a delivery that fails or times out once a minute for 30 minutes, but a WEBHOOK listener is asynchronous: the platform acknowledges the delivery before the script runs, so an exception in the script is invisible to monday and the event is not resent. Only a delivery that never reached the platform comes back. Handle a redelivery idempotently and never rely on a throw to get the event again. A synchronous Generic listener is the exception, the script running inside the request.

## Known differences from the setup dialog

None at the snapshot date.

## Verify before trusting

The recipe names for the event in question, and whether the column dropdown still appears after "Connect". monday's recipe wording changes; the API reference's event enum does not.
