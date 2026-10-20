# Zoom

Listener type WEBHOOK, 92 event types. Snapshot 2026-10-16 from the web application's setup dialog, whose steps were checked against the Zoom App Marketplace's Access page and event subscription form on 2026-10-16 after the Features, Add New Event Subscription and Save steps were aligned with them; earlier cross-check 2026-09-14 against https://developers.zoom.us/docs/api/webhooks/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Zoom connector records no host, so `connector get` reports no `baseUrl`; the app's page on the Zoom App Marketplace is where everything happens. `connectionRequired` is false.

The secret token is required before Zoom will validate the endpoint URL, and it can only be entered in the web application's setup dialog at `setupUrl`. The order matters: token first, then the subscription. The CLI cannot store it.

## Deep links

`https://marketplace.zoom.us/user/build` lists the user's apps: "Created apps" in the Developer sidebar, or under "Manage" in the older Marketplace layout. No per-app URL can be built without the app's ID.

## Steps

Part one, the token:

1. Sign in to the Zoom App Marketplace, "Created apps" in the Developer sidebar or under "Manage" in the older layout, open the app the listener is for.
2. "Click on Features, then Access. On older apps the tab is Feature." "Under Token, copy the Secret Token and paste it in the Secret Token field below."
3. Open the setup dialog at `setupUrl`, paste it into "Secret Token", "Save and continue". The platform keeps it; write it nowhere else.

Part two, the subscription:

4. Back on the same Zoom page: "Scroll down to General Features and enable Event Subscription, or Event Subscriptions on older apps." "Click on Add New Event Subscription, or Add Event Subscription on older apps." Up to 20 subscriptions per app.
5. "Enter a meaningful name into the Subscription name field."
6. "Click on Add Events." The "Event Types" picker lists events by description under their product, `meeting.created` is "Meeting has been created" under Meeting. "Select ONLY the following event to listen: <event>, then click Done."
7. "Paste the copied URL into the Event notification endpoint URL field."
8. "Click Save. Zoom validates the URL when you save. On older apps, click Validate next to the URL field first." Zoom posts an `endpoint.url_validation` challenge and the platform answers it with the saved token. Without the token from part one the save fails. Zoom revalidates the endpoint every 72 hours and emails after two failures; nothing to do as long as the listener stays enabled.
9. Adding an event can add a scope to the app, `meeting.created` adds `meeting:read:meeting`. Zoom then delivers nothing for that event, silently, until the user re-authorizes the connector; see `references/connector-setup/zoom.md`.

## Filter on the app side

Only the event selection on the subscription. Zoom sends the event for every user in the account the app can see; narrowing to users or groups is possible through Zoom's webhook subscription API rather than the page, and is usually not worth it. In the script, check `event` (`meeting.started`, `meeting.ended`, `recording.completed`) and `payload.account_id`, and where the integration is about certain hosts, `payload.object.host_id` against a parameter.

## Secure it

Zoom signs every delivery: `x-zm-signature` is `v0=` and the HMAC-SHA256 hex of `v0:<x-zm-request-timestamp>:<body>` keyed with the secret token. The platform verifies it against the token saved in the setup dialog and refuses a delivery without a token, a timestamp or a valid signature, so nothing is needed in code. Zoom explicitly recommends signature verification over an IP allowlist and publishes no stable ranges. Basic authentication, OAuth token and custom header authentication also exist on Zoom's side; they add nothing here.

## Known differences from the setup dialog

- The dialog follows the General app form, naming the older app types' labels in asides. It does not say that on those older apps the fields come in a different order: name, method, endpoint URL, "Validate", authentication header, "Add Events", then Save.

## Verify before trusting

The 20-subscription cap, and the event names in the picker, which Zoom lists by description rather than by `event` value. The validation and signature mechanics are stable and documented at the URL above.
