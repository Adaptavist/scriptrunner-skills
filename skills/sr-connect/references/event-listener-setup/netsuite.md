# NetSuite

Listener type WEBHOOK, 1 event type: "Generic Event". NetSuite has no webhooks; the web application's setup dialog generates a SuiteScript User Event script that posts to the webhook URL, and the user deploys it. Snapshot 2026-09-14 from that dialog, cross-checked the same day against https://docs.oracle.com/en/cloud/saas/netsuite/ns-online-help/section_1510274245.html (the User Event Script tutorial), section_4489062315.html (creating a script record), section_0706024425.html (deploying) and section_4567628658.html (`https.post`).

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A NetSuite connector records no host, so `connector get` reports no `baseUrl`; the account ID the links below need is the number in the user's NetSuite URL, `https://<accountId>.app.netsuite.com`, with `-sb1` and similar suffixes for sandboxes. `connectionRequired` is false.

The script the dialog generates is only available at `setupUrl`, "Download Script", named `<urlPath>-src-user-event.js`. Hand the user that link for the download; the steps below are the deployment.

## Deep links

Off the account ID:

- Script upload: `https://<accountId>.app.netsuite.com/app/common/scripting/uploadScriptFile.nl`
- Scripts list: "Customization", "Scripting", "Scripts"

## Steps

1. Download the script from the setup dialog. It is a SuiteScript 2.x User Event script whose `afterSubmit` posts the whole `context` as JSON to the webhook URL with `Content-Type: application/json`.
2. Open the script upload page (or "Documents", "Files", "SuiteScripts", "Add File"). "+" beside "SCRIPT FILE", "ATTACH FROM" "Computer", pick the downloaded file. Keep the file name the dialog shows; the setup dialog offers it as a copy field. Choose a folder, "SELECT FILE", leave "CHARACTER ENCODING" UTF-8, "Save".
3. "Create Script Record". "TYPE" reads "User Event". Give the record a name. "Save", then "Save and Deploy", which the older UI called "Deploy Script".
4. On the deployment: "APPLIES TO" is the record type whose creation or update should fire the listener, one deployment per record type. "STATUS" starts at "Testing", which runs the script only for its owner; set "Released" when the integration is ready for everyone. "Save".
5. Create or edit a record of that type; the listener receives the event.

## Filter on the app side

The record type on the deployment, and whatever the script does before posting. The generated script posts on every create and update; to post only on create, or only when a field changed, edit the script before uploading: `if (context.type !== context.UserEventType.CREATE) return;` at the top of `afterSubmit`, or compare `context.newRecord.getValue('status')` with `context.oldRecord`. In the SRC script, check `type` and the record fields the integration cares about against parameters; the event is NetSuite's `context` serialized, `newRecord`, `oldRecord` and `type`.

## Secure it

Nothing built in, and nothing to add for this listener type: a NetSuite listener receives the body only, so a header the SuiteScript sent would not reach the script, and the platform checks none. Deploy the generated script as it is. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: `https.post` takes `headers`, so the SuiteScript would send `headers: { 'X-Webhook-Secret': '<value>' }`, read from a NetSuite secret or script parameter rather than a literal, and the SRC script would compare it against a masked TEXT parameter. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. NetSuite publishes no stable outbound address list.

## Known differences from the setup dialog

- The dialog says "Deploy Script"; the current docs say "Save and Deploy" on the script record and a "Deployments" subtab. Same action.
- The dialog's upload URL, `/app/common/scripting/uploadScriptFile.nl`, is not in Oracle's docs, which route through "Documents", "Files" or "Customization", "Scripting", "Scripts", "New". The URL still works.
- The dialog links two Oracle pages: the first is the User Event Script tutorial, as it says; the second, presented as "More on Workflows", is the SuiteFlow "Creating Your First Workflow" tutorial and does not mention webhooks. The relevant page for a workflow-based alternative is the Custom Action reference, section_N2752089.html, which needs a Workflow Action script rather than a User Event script.
- The dialog's trailing note about Workflow Custom Actions, with its own webhook URL field, is not rendered in the web application; a defect there, and the alternative is real.

## Verify before trusting

The record type name the user wants, the "STATUS" field's effect, and whether the user's account uses the newer scripting UI. SuiteScript 2.1 is current; the generated script is 2.x compatible.
