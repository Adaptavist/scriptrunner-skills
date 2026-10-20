# Statuspage

Listener type WEBHOOK, 1 event type: "Generic event". Statuspage delivers incident updates, component status changes and scheduled maintenance updates to webhook subscribers of a page. Snapshot 2026-10-16 from the web application's setup dialog, whose steps were checked against Statuspage's Subscribers page, its "Subscriber notification settings" modal and its "Add subscriber" dialog on 2026-10-16 after the dialog gained the "Save changes" step; earlier cross-check 2026-09-14 against https://support.atlassian.com/statuspage/docs/enable-webhook-notifications/ and https://support.atlassian.com/statuspage/docs/add-single-subscribers/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Statuspage connector records no host, so `connector get` reports no `baseUrl`; pages live at https://manage.statuspage.io/. `connectionRequired` is false.

The subscription can also be created through the Statuspage API, so the agent can do it with the Statuspage connector rather than the user; see step 4b.

## Deep links

`https://manage.statuspage.io/`, then the page from the picker at the top of the left sidebar; "Subscribers" below it.

## Steps

1. "Log into your Statuspage instance", https://manage.statuspage.io/. "On the left side menu, make sure that you have selected the organization and page which you want to subscribe to." The picker at the top of the sidebar lists pages.
2. "Click Subscribers."
3. "Make sure that you have webhooks enabled. To do that click on Options to the right of the search box, select Settings and on the appearing modal, make sure that you have the Webhook option checked, then click Save changes." The modal is "Subscriber notification settings" and "Webhook" sits under "Delivery types". Until it is saved, "Add subscriber" offers "Email" only and says that webhook notifications are disabled.
4. Either:
    - 4a. In the manage UI: "To create a new webhook, click Options again and select Add subscriber." "Under Subscriber type select Webhook." "Paste the copied URL into the Endpoint URL field." "Enter any email into the Email address field. This is where Statuspage will send notifications should the endpoint fail." "Click Add subscriber."
    - 4b. Through the Statuspage API connection: `POST /pages/<pageId>/subscribers` with `subscriber[endpoint]` = the webhook URL, `subscriber[email]` = the user's address, optionally `subscriber[component_ids]` for the components to follow. The confirmation email still goes out for a webhook subscriber unless the API call skips it.
5. Endpoints must answer 2xx within 30 seconds; the platform does.

## Filter on the app side

The page, and the components: enable "Allow users to subscribe to individual components" under the same "Settings", then pick the components on the subscription (through "Manage Subscriptions" on the subscriber, or `component_ids` in the API call). Otherwise every incident, component status change and maintenance update on the page arrives. In the script, check `page.id` and the component IDs against parameters; the payload has a `page` block and either an `incident` or a `component` block.

## Secure it

No secret, no signature and no fixed address range; Atlassian says Statuspage's addresses change. The webhook URL's secrecy is the control; the generated path is already random, so there is nothing to configure, and the script checks `page.id`. The platform verifies nothing here, and there is nothing a Generic listener could verify either.

## Known differences from the setup dialog

- Every step and label matched Statuspage's manage UI on the snapshot date. The dialog covers only the manual route, steps 1 to 4a; component filtering, the confirmation email and the API route are in this file alone.

## Verify before trusting

Whether a webhook subscriber added from "Add subscriber" lands under "Unconfirmed" and needs the confirmation email before deliveries start; the Subscribers page counts "Active", "Quarantined" and "Unconfirmed", and the manage-UI route was checked on the snapshot date without adding one.
