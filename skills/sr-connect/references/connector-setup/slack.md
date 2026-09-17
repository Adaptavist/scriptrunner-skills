# Slack

Authorized with a Slack app the user creates: its App ID, its signing secret and a bot token, typed into the dialog. No consent window and no choice of method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://docs.slack.dev/authentication/installing-with-oauth.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl` as the app's configuration page on api.slack.com once authorized, which names the app and not the workspace; ask which workspace the app is installed in. The connector's signing secret is also what verifies every Slack event listener in the workspace, so a listener on an unauthorized Slack connector receives nothing; `references/event-listener-setup/slack.md` has that side.

The credentials are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way.

## The dialog

"Configure Connector", steps "Input App Details", "Add Scopes", "Install App", "Input Token". Inputs: "App ID", "Signing Secret", "Bot User OAuth Access Token". Read-only, for copying into Slack: the bot token scopes `team:read`, `chat:write`, `commands`. The dialog notes "These credentials will be stored securely in our platform."

## Steps

1. Open `authorizationUrl`, sign in. "Input App Details". The dialog says "If you already have an application, skip the steps below and paste the App ID and Signing Secret which can be found in the App Credentials section".
2. "Visit the Slack API site and click Create an App. Select the From scratch option to configure your app." https://api.slack.com/apps; Slack's button reads "Create New App".
3. "Choose a name for your app and the Workspace that the app belongs to, then click Create App."
4. "You should be redirected to the Basic Information page for your app, scroll down to the App Credentials section." Copy "App ID" and "Signing Secret" ("Show" first) into the dialog. "Next".
5. "Add Scopes": "You now need to add some permission scopes so your Slack App can work properly." "Visit the Slack API OAuth & Permissions page." (the dialog links it for the App ID entered), "Scroll down to Scopes then Bot Token Scopes", "Click Add an OAuth Scope", "Find and add the following scopes": `team:read`, `chat:write`, `commands`. Add whatever else the integration's calls need (`channels:read`, `users:read`, `files:write` and so on); Slack answers `missing_scope` naming the one that is not there. "Next".
6. "Install App": "You now need to install the Slack app in the Workspace you created it in:" "Visit the Slack API Install App page.", "Click on Install to Workspace." Slack shows the permissions and asks to allow; a workspace that requires admin approval for apps shows "Request to Install" instead, and an admin has to approve before the token exists. "Next".
7. "Input Token": "Now copy and paste the Bot User OAuth Access Token in to the box below." It starts `xoxb-` and sits on the "OAuth & Permissions" page after installation. "Done".

## Saving

No callback and no window. "Done" saves the credentials and the connector reads "Authorized". Read `connector get` back for `authorized: true` and `baseUrl` naming the app.

## Fixed-key alternative through a Generic connector

The same bot token as a header: Generic connector, base URL `https://slack.com/api`, header `Authorization: Bearer xoxb-...`, through `--input` as `generic.md` says. Build `SlackApi` from `@managed-api/slack-sr-connect` on the Generic connection as `references/scripting.md` shows. The CLI can create that connector authorized, which the Slack connector cannot be. Costs: the Generic connector holds no signing secret, so it cannot back a Slack event listener, and the connector reads as Generic. Never choose it for a workspace that has, or will have, a Slack listener; for an outbound-only integration it is a fair trade when the user wants no web application step.

## Expiry and re-authorization

Slack bot tokens do not expire unless the app has token rotation switched on, which the connector does not support; leave rotation off. The connector stops working when the app is uninstalled from the workspace or when the token is revoked; either means the dialog again at `authorizationUrl` with the new values. Regenerating the signing secret is narrower: the bot token is untouched and outbound API calls carry on, and what breaks is the platform's verification of inbound Slack requests, so a Slack event listener on this connector receives nothing until the new secret is in the dialog. Reinstalling the app after adding scopes issues a new token; paste it in.

## Known differences from the dialog

- The dialog says "Create an App" and "Create App"; Slack's buttons read "Create New App" and "Create App".
- The dialog's "Bot User OAuth Access Token" is Slack's older label; the page now reads "Bot User OAuth Token". Same `xoxb-` value.
- The dialog lists the minimum scopes; a real integration adds more, and the dialog does not say where the `missing_scope` error will point.

## Verify before trusting

That the app is installed in the workspace the integration targets and not the developer's test workspace; that the scopes cover the integration's calls; and that the signing secret pasted is the current one, since regenerating it in Slack breaks every listener on the connector until it is pasted again.
