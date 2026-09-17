# Opsgenie

Authorized with an API key from an API integration the user creates in Opsgenie, typed into the dialog. No consent window and no choice of method beyond the region. Snapshot 2026-09-15 from the web application's setup dialog; Atlassian's Opsgenie integration pages did not answer for fetching on the day and are listed under Verify.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the Opsgenie instance URL entered, once authorized. Creating an API integration needs Opsgenie admin or owner rights.

The key is saved through the web application alone; the public API has no field for it, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way, or the Generic alternative below.

## The dialog

"Configure Connector", steps "Add Opsgenie instance region", "Add Opsgenie instance url", "Create API Integration in Opsgenie", "Enter API Key". Inputs: region radios "EU" / "US" ("Choose the region of your Opsgenie instance"), the instance URL, "API Key". The dialog notes "These credentials will be stored securely in our platform."

## Steps

1. Open `authorizationUrl`, sign in. Pick the region. EU accounts live on `app.eu.opsgenie.com` and their API on `api.eu.opsgenie.com`; a US key against the EU host, or the reverse, answers 401 with nothing more helpful, so get this right first. "Next".
2. "Enter the Opsgenie URL", `https://` required: `https://<account>.app.opsgenie.com` or `https://<account>.app.eu.opsgenie.com`. "Next".
3. "Create API Integration in Opsgenie". The dialog says "If you already have an API Integration, skip the steps below and click next".
4. "Visit the Create new API integration page in Opsgenie and copy API Key." The dialog links `<instance>/settings/integration/add/API/`; Opsgenie's path is Settings, "Integrations", "Add integration", "API".
5. "Give your integration a meaningful name."
6. "Make sure that Read Access, Create and Update Access, Delete Access and Enabled settings are checked." Opsgenie treats those as separate rights, so tick what the integration calls and no more: "Read Access" and "Enabled" for one that only reads, "Create and Update Access" or "Delete Access" when it writes or deletes, and configuration access only when it touches configuration domains. A call outside the set answers 403.
7. "Click Save Integration." Copy the "API Key" shown on the integration.
8. "Enter API Key": "Paste previously copied API Key into the form below." "Done".

## Saving

No callback and no window. "Done" saves the key and the connector reads "Authorized". Read `connector get` back for `authorized: true` and `baseUrl`.

## Fixed-key alternative through a Generic connector

The same key as a header: Generic connector, base URL `https://api.opsgenie.com` or `https://api.eu.opsgenie.com`, header `Authorization: GenieKey <key>`, through `--input` as `generic.md` says. Build `OpsgenieApi` from `@managed-api/opsgenie-sr-connect` on the Generic connection as `references/scripting.md` shows. The CLI can create that connector authorized, which the Opsgenie connector cannot be. Cost: the connector reads as Generic, with `baseUrl` naming the API host rather than the account. Since an Opsgenie event listener does not depend on the connector's key, nothing else is lost.

## Expiry and re-authorization

API integration keys do not expire. The connector stops working when the integration is disabled or deleted in Opsgenie, or when its key is regenerated; then the dialog again at `authorizationUrl` with the new key. Opsgenie itself is being folded into Jira Service Management; an account that has migrated has no API integrations page and this connector cannot be set up for it.

## Known differences from the dialog

- The dialog's link `/settings/integration/add/API/` is Opsgenie's older route; current accounts land on the integrations list, and "Add integration", then "API", reaches the form.
- The dialog asks for "Enabled" among the checkboxes; Opsgenie shows it as a toggle at the top of the integration, on by default.

## Verify before trusting

Atlassian's Opsgenie integration documentation could not be fetched on 2026-09-15, so the labels in steps 4 to 7 come from the dialog and general knowledge; check them in the account. Also verify the region against the account URL, the access levels against the integration's calls, and whether the account has migrated to Jira Service Management, in which case a Jira Service Management Cloud connector is the answer.
