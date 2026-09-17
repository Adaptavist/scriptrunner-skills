# monday.com

Authorized in a browser through OAuth 2.0 with the platform's own monday.com app, which an administrator of the monday.com account installs first. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://developer.monday.com/api-reference/docs/authentication.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. The API connection type carries several Managed API packages, one per monday.com API version, some marked deprecated; pick the current one on `api-connection create` and let the connector serve it. Then `authorizationUrl`. `connector get` reports `baseUrl`, the account URL, once authorized. Installing the app needs a monday.com account administrator; the person authorizing does not need to be one.

## The dialog

"Configure Connector", steps "Add monday.com account URL", "Install Application in monday.com", "Authorize". One input, the account URL. Read-only, with copy buttons: "Installed Apps Link" and "Installation Link". The install step's alerts: "To access information in monday.com, ScriptRunner Connect needs to be installed in the monday.com account." and "To install ScriptRunner Connect in the monday.com account or check if it's already installed, you need administrator privileges. You can give the installation url below to an admin of the account to check and install ScriptRunner Connect for you."

## Steps

1. Open `authorizationUrl`, sign in. Enter the account URL in the field labelled `https://<MONDAY_ACCOUNT>.monday.com`; the dialog refuses one not ending in `monday.com`. "Next".
2. "Give an administrator of the account the Installed Apps Link below so they can check if ScriptRunner Connect is already installed." The link is `<account>/admin/installedApps/manage`.
3. "If ScriptRunner Connect is already installed, click Next."
4. "If ScriptRunner Connect is not installed, copy the Installation Link below and give it to an administrator to paste on their browser and install ScriptRunner Connect." The administrator opens it, picks the account (and, if asked, the workspaces the app may see), and installs. This is once per account, not per connector. If the dialog shows "Install URL not available. Check with ScriptRunner Connect support" instead of a link, the deployment has no installation link configured and support has to supply it.
5. "Click Save." (the dialog's word for the step's Next).
6. "Authorize": "To access information in monday.com you need to authorize our app to be able to make requests on your behalf." A consent window opens on monday.com; sign in as the user the integration should act as, "Authorize".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When monday.com answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl` naming the account.

## Fixed-key alternative through a Generic connector

A personal API token: the profile picture, "Developers", "My access tokens" (monday.com's documentation: "API token", "Show"), copy the token. Generic connector: base URL `https://api.monday.com/v2`, header `Authorization: <token>`, through `--input` as `generic.md` says; monday.com takes the bare token in the header, no `Bearer` prefix, and also wants an `API-Version` header on some versions, which the Managed API sets. Build `MondayApi` from the current monday.com Managed API package `app list` reports on the Generic connection as `references/scripting.md` shows. Costs: the token acts as its user with every board that user can see, it does not expire but is revoked when the user's account is, and the connector reads as Generic. It is the route when no account administrator will install the app.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. monday.com's OAuth tokens do not expire; the connector stops working when the app is uninstalled from the account, when the authorizing user is removed, or when a workspace restriction set at install excludes the boards the integration reads. Uninstalling and reinstalling the app requires every connector on that account to re-authorize.

## Known differences from the dialog

- The dialog's final install step says "Click Save." where the button is the stepper's "Next".
- monday.com's developer settings have moved between "Developers", "My access tokens" and an "API" tab; the dialog does not describe the token page because its flow does not need it.

## Verify before trusting

That the app is installed in the account, which only an administrator can see; that the administrator did not restrict it to workspaces that exclude the integration's boards; and which user authorizes in step 6, since updates carry that user's name.
