# Statuspage

Authorized with an API key from the Statuspage account, typed into the dialog. No consent window and no choice of method. Snapshot 2026-10-16 from the web application's setup dialog, whose steps were checked against Statuspage's manage UI and "Create API key" dialog on 2026-10-16 after the dialog's "API token" became "API key"; earlier cross-check 2026-09-15 against https://developer.statuspage.io/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the account is not recorded, so ask. The dialog says "You need to be a Statuspage account owner to access API keys."

The token is saved through the web application alone; the public API has no field for it, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way, or the Generic alternative below.

## The dialog

"Configure Connector", a single form: "Authentication in Statuspage is done via an API key.", the input "API key", buttons "Cancel" and "Save".

## Steps

1. Open `authorizationUrl`, sign in.
2. "Log in to your Statuspage account." https://manage.statuspage.io/login, as the account owner.
3. "Click on your avatar in the top right of your screen to access the user menu."
4. "Click API info."
5. "If you already have an API key which you want to use with ScriptRunner Connect, you can paste it into the API key field and skip the rest of the steps by clicking Save."
6. "Otherwise click Create key, enter a Name, choose an Expiry and click Confirm." The "Create API key" dialog's expiry is "No expiry" or "Expires on" a date at most 365 days out, and defaults to a date a week away.
7. "In the Copy your API token dialog click Copy, paste the key into the API key field below, then click Done." Statuspage shows the key once, masked, and cannot show it again. "Save".

## Saving

No callback and no window. "Save" stores the token and the connector reads "Authorized". Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account and page with the user.

## Fixed-key alternative through a Generic connector

The same token as a header: Generic connector, base URL `https://api.statuspage.io/v1`, header `Authorization: OAuth <token>`, through `--input` as `generic.md` says; Statuspage's scheme word is `OAuth` even though the value is a fixed key. Build `StatuspageApi` from `@managed-api/statuspage-v1-sr-connect` on the Generic connection as `references/scripting.md` shows. The CLI can create that connector authorized, which the Statuspage connector cannot be. Cost: the connector reads as Generic. Nothing else is lost; a Statuspage event listener does not depend on the connector.

## Expiry and re-authorization

A key expires on the date chosen when it was created, or never if "No expiry" was chosen. The connector stops working when the key expires, is deleted under "API info" or the owner's account is removed; then the dialog again at `authorizationUrl` with a new key.

## Known differences from the dialog

None on the snapshot date; every step, label and link matched Statuspage's manage UI. Statuspage itself says "API token" in the title and body of the final "Copy your API token" dialog while labelling the field "API Key"; the dialog follows the field.

## Verify before trusting

That the signed-in user is the account owner, since "API info" is not shown to anyone else; and which account the key belongs to, since one owner can own several.
