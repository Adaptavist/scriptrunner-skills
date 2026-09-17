# Salesforce

Listener type WEBHOOK, 1 event type: "Generic Event". Salesforce delivers through an Outbound Message action fired from a record-triggered flow. Snapshot 2026-09-14 from the web application's setup dialog. Salesforce's help pages would not render to a non-browser fetch that day, so the vendor side below is cross-checked only against https://ip-ranges.salesforce.com/ip-ranges.json and search-index summaries of "Outbound Message Actions" and "Send an Outbound Message from Your Record-Triggered Flow"; treat the step labels as the dialog's and verify them in the org.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the org's My Domain, `https://<org>.my.salesforce.com`. `connectionRequired` is false.

## Deep links

Off `baseUrl`, with `.my.salesforce.com` replaced by `.lightning.force.com` and any trailing slash removed:

- Outbound messages: `<lightning>/lightning/setup/WorkflowOutboundMessaging/home`
- Flows: `<lightning>/lightning/setup/Flows/home`

Without a base URL: "Setup", "Process Automation", "Workflow Actions", "Outbound Messages", and "Setup", "Flows".

## Steps

Part one, the outbound message:

1. Open "Outbound Messages", "New Outbound Message".
2. Select the object whose records should fire the listener, "Next".
3. Name it. Paste the webhook URL into "Endpoint URL". Pick the "User to send as". Leave "Send Session ID" off unless the script needs to call back into Salesforce as that user; the API connection is the better route.
4. Under the fields to send, add every field the script will read. Only these arrive.
5. "Save".

Part two, the flow that sends it:

6. Open "Flows", "New Flow", "Record-Triggered Flow", "Create".
7. Select the same object. Configure the trigger: created, updated, or created or updated, and whether it runs every time or only when conditions are met.
8. "Set Entry Conditions" is the filter; see below.
9. Under "Optimize the Flow for" choose "Actions and Related Records". "Done".
10. "+" under "Run Immediately", "Action", pick "Outbound Message", select the message from part one, give the action a label, "Done".
11. "Save" with a label, then "Activate".

## Filter on the app side

Three layers, all worth using. The object, on both the message and the flow. The trigger, created against updated. The flow's entry conditions, which are the real filter: a record type, a status value, a field change. A flow that fires on every update of a busy object is the usual source of noise. In the script, check the object type and the same field against parameters; the payload is the outbound message's SOAP envelope parsed by the platform, and the fields you chose in step 4 arrive under the notification's `sObject`.

## Secure it

Outbound messages carry no secret and no signature, and a Salesforce listener receives the body only, so there is nothing to check in code; keep the webhook URL private and add nothing. "Send Session ID" is not security; it is a credential handed to the receiver and should stay off. Hardening is possible through a Generic listener, which receives `sourceIp`: a script behind one checks the sender against the ranges Salesforce publishes at https://ip-ranges.salesforce.com/ip-ranges.json. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. Salesforce retries an outbound message that is not acknowledged for up to 24 hours; the platform acknowledges on receipt, so a throwing script does not cause a resend.

## Known differences from the setup dialog

- The dialog's step 13 reads "Set Entry Conditions are optional." They are optional, and they are also the only vendor-side filter worth the name; the block should recommend one.
- The dialog does not mention "User to send as" or "Send Session ID"; both are on the form.
- The dialog names no security measure; there is none on Salesforce's side except the address list, which only a Generic listener could use.
- Salesforce's help pages could not be fetched on the snapshot date, so the field labels above come from the dialog and from search-index text; nothing fetched contradicts them.

## Verify before trusting

Every label in parts one and two against the org, since the Flow Builder UI is revised with each Salesforce release, and the Lightning host substitution for orgs on an unusual domain.
