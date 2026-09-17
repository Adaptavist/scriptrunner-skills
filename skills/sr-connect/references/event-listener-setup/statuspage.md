# Statuspage

Listener type WEBHOOK, 1 event type: "Generic event". Statuspage delivers incident updates, component status changes and scheduled maintenance updates to webhook subscribers of a page. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://support.atlassian.com/statuspage/docs/enable-webhook-notifications/ and https://support.atlassian.com/statuspage/docs/add-single-subscribers/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Statuspage connector records no host, so `connector get` reports no `baseUrl`; pages live at https://manage.statuspage.io/. `connectionRequired` is false.

The subscription can be created through the Statuspage API, so the agent can do it with the Statuspage connector rather than the user; see step 3b.

## Deep links

`https://manage.statuspage.io/`, then the organization and page; "Subscribers" in the left sidebar.

## Steps

1. Enable webhooks on the page: "Subscribers", "Options", "Settings", tick "Webhook" among the delivery types, "Save changes". The page's public subscribe dropdown gains a webhook tab.
2. Subscribing is done from the public status page or through the API, not from the "Add subscriber" dialog, which offers email and SMS only.
3. Either:
    - 3a. On the public page, open the subscribe control, the webhook tab, paste the webhook URL as the endpoint and an email address Statuspage will notify if the endpoint fails; confirm the subscription from the email it sends.
    - 3b. Through the Statuspage API connection: `POST /pages/<pageId>/subscribers` with `subscriber[endpoint]` = the webhook URL, `subscriber[email]` = the user's address, optionally `subscriber[component_ids]` for the components to follow. The confirmation email still goes out for a webhook subscriber unless the API call skips it.
4. Endpoints must answer 2xx within 30 seconds; the platform does.

## Filter on the app side

The page, and the components: enable "Allow users to subscribe to individual components" under the same "Settings", then pick the components on the subscription (through "Manage Subscriptions" on the subscriber, or `component_ids` in the API call). Otherwise every incident, component status change and maintenance update on the page arrives. In the script, check `page.id` and the component IDs against parameters; the payload has a `page` block and either an `incident` or a `component` block.

## Secure it

No secret, no signature and no fixed address range; Atlassian says Statuspage's addresses change. The webhook URL's secrecy is the control; the generated path is already random, so there is nothing to configure, and the script checks `page.id`. The platform verifies nothing here, and there is nothing a Generic listener could verify either.

## Known differences from the setup dialog

- The dialog says "Options", "Add subscriber", "Subscriber type", "Webhook". Atlassian's docs say the "Add subscriber" dialog offers email and SMS only, and that webhook subscribers come from the public page or the API. If the user's manage UI does show a webhook type there, it works the same way and the docs are behind; otherwise step 3 above is the route.
- The dialog does not mention component filtering, the confirmation email or the API route.

## Verify before trusting

Whether "Add subscriber" offers a webhook type on the user's page, and the component subscription setting. Statuspage's admin UI and docs disagreed on the snapshot date.
