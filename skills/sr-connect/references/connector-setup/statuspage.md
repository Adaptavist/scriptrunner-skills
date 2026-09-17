# Statuspage

Authorized with an API token from the Statuspage account, typed into the dialog. No consent window and no choice of method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://developer.statuspage.io/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the account is not recorded, so ask. The dialog says "You need to be a Statuspage account owner to access API keys."

The token is saved through the web application alone; the public API has no field for it, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way, or the Generic alternative below.

## The dialog

"Configure Connector", a single form: "Authentication in Statuspage is done via an API token.", the input "API token", buttons "Cancel" and "Save".

## Steps

1. Open `authorizationUrl`, sign in.
2. "Log in to your Statuspage account." https://manage.statuspage.io/login, as the account owner.
3. "Click on your avatar in the top right of your screen to access the user menu." Statuspage's current layout has the avatar in the bottom left.
4. "Click API info."
5. "If you already have an API key which you want to use with ScriptRunner Connect, you can paste it into the API token field and skip the rest of the steps by clicking Save."
6. "Otherwise click Create key, type in a name for your token and click Confirm."
7. "Copy the key and paste it to the API token field." "Save".

## Saving

No callback and no window. "Save" stores the token and the connector reads "Authorized". Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account and page with the user.

## Fixed-key alternative through a Generic connector

The same token as a header: Generic connector, base URL `https://api.statuspage.io/v1`, header `Authorization: OAuth <token>`, through `--input` as `generic.md` says; Statuspage's scheme word is `OAuth` even though the value is a fixed key. Build `StatuspageApi` from `@managed-api/statuspage-v1-sr-connect` on the Generic connection as `references/scripting.md` shows. The CLI can create that connector authorized, which the Statuspage connector cannot be. Cost: the connector reads as Generic. Nothing else is lost; a Statuspage event listener does not depend on the connector.

## Expiry and re-authorization

API keys do not expire. The connector stops working when the key is deleted under "API info" or the owner's account is removed; then the dialog again at `authorizationUrl` with a new key.

## Known differences from the dialog

- The dialog puts the avatar "in the top right"; Statuspage's own documentation says "bottom left". Look in both.
- The dialog calls the value "API token"; Statuspage's page calls it an API key. Same value.

## Verify before trusting

That the signed-in user is the account owner, since "API info" is not shown to anyone else; and which account the key belongs to, since one owner can own several.
