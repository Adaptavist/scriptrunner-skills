# Zoom

Listener type WEBHOOK, 92 event types. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://developers.zoom.us/docs/api/webhooks/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Zoom connector records no host, so `connector get` reports no `baseUrl`; the app's page on the Zoom App Marketplace is where everything happens. `connectionRequired` is false.

The secret token is required before Zoom will validate the endpoint URL, and it can only be entered in the web application's setup dialog at `setupUrl`. The order matters: token first, then the subscription. The CLI cannot store it.

## Deep links

`https://marketplace.zoom.us/user/build` lists the user's apps ("Manage", "Created Apps"). No per-app URL can be built without the app's ID.

## Steps

Part one, the token:

1. Sign in to the Zoom App Marketplace, "Manage", "Created Apps", open the app the listener is for.
2. Open "Features", then "Access"; the older UI called the tab "Feature". Copy the "Secret Token".
3. Open the setup dialog at `setupUrl`, paste it into "Secret Token", "Save and continue". The platform keeps it; write it nowhere else.

Part two, the subscription:

4. Back on the same Zoom page, under "General Features" enable "Event Subscriptions", then "Add New Event Subscription". Up to 20 subscriptions per app.
5. Paste the webhook URL into "Event notification endpoint URL".
6. "Validate". Zoom posts an `endpoint.url_validation` challenge and the platform answers it with the saved token; the page shows the URL as validated. Without the token from part one this step fails.
7. Open the event picker ("Add Events" in the dialog, "Event Types" in the current docs), tick only the event the listener was created for, "Done".
8. "Save". Zoom revalidates the endpoint every 72 hours and emails after two failures; nothing to do as long as the listener stays enabled.

## Filter on the app side

Only the event selection on the subscription. Zoom sends the event for every user in the account the app can see; narrowing to users or groups is possible through Zoom's webhook subscription API rather than the page, and is usually not worth it. In the script, check `event` (`meeting.started`, `meeting.ended`, `recording.completed`) and `payload.account_id`, and where the integration is about certain hosts, `payload.object.host_id` against a parameter.

## Secure it

Zoom signs every delivery: `x-zm-signature` is `v0=` and the HMAC-SHA256 hex of `v0:<x-zm-request-timestamp>:<body>` keyed with the secret token. The platform verifies it against the token saved in the setup dialog and refuses a delivery without a token, a timestamp or a valid signature, so nothing is needed in code. Zoom explicitly recommends signature verification over an IP allowlist and publishes no stable ranges. Basic authentication, OAuth token and custom header authentication also exist on Zoom's side; they add nothing here.

## Known differences from the setup dialog

- The dialog says "Click on Feature"; the current Marketplace UI reads "Features", then "Access", and Zoom's own docs use both spellings on one page.
- The dialog's labels "Subscription name", "Add Events" and "Add Event Subscription" are the older page's; the current docs say "Add New Event Subscription", "Event Types" and "Done". The dialog's fallback link `marketplace.zoom.us/user/build` is not in the docs, which say "Manage", "Created Apps"; it resolves to the same list.
- The dialog does not say the signature is verified after validation; the platform does both.

## Verify before trusting

The tab names on the app page, which Zoom has renamed at least once, and the 20-subscription cap. The validation and signature mechanics are stable and documented at the URL above.
