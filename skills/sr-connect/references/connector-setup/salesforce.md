# Salesforce

Authorized in a browser through OAuth 2.0 with a Connected App the user creates in Salesforce Setup. One method. Snapshot 2026-09-15 from the web application's setup dialog; Salesforce's help pages for connected apps did not render for fetching on the day and are listed under Verify.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the My Domain URL, once authorized, which separates a sandbox (`--<name>.sandbox.my.salesforce.com`) from production. Creating a Connected App needs a Salesforce administrator with "Customize Application" and "Manage Connected Apps".

## The dialog

"Configure Connector", steps "Add Salesforce Instance URL", "Create Connected App in Salesforce", "Enter App's Details", "Authorize". Inputs: the instance URL, "Consumer Key", "Consumer Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Callback URL". The create step's alerts: "If you already have a connected app, skip the steps below and click next." and "Creation of the app might take up to 10 minutes, please make sure to wait before proceeding."

## Steps

1. Open `authorizationUrl`, sign in. "Enter the Salesforce URL"; the dialog says "The Salesforce instance url must match the following format: https://<Your-instance-name>.my.salesforce.com" and refuses anything else. A sandbox's My Domain fits the pattern. "Next".
2. "Visit the Salesforce App Manager page. Lightning view requires third party cookies to be enabled." The dialog links the instance's Lightning setup at `/lightning/setup/NavigationMenus/home`; Salesforce's path is Setup, "Apps", "App Manager".
3. "Click New Connected App button in the top right corner of the page." On orgs where Salesforce has moved to External Client Apps, the button sits under a dropdown ("New Connected App" beside "New External Client App"); a Connected App is what this connector needs.
4. "Copy the name below into Connected App Name and leave API name as suggested." Fill in the contact email Salesforce requires.
5. "In API (Enable OAuth Settings) section check Enable OAuth Settings."
6. "Copy the callback url below into the form." into "Callback URL".
7. "Add the following scopes in Selected OAuth Scopes section: Full access(full), Manage user data via APIs (api), Perform requests at any time (refresh_token, offline_access)." The refresh_token scope is what keeps the connector authorized; without it the connector works for one session and then stops.
8. "Ensure that only the following options are selected: Require Secret for Web Server Flow, Require Secret for Refresh Token Flow, Enable Client Credentials Flow." Untick "Require Proof Key for Code Exchange (PKCE)" if Salesforce ticked it by default; the connector's flow does not send one.
9. "Click Save." Wait; the dialog's alert about 10 minutes is Salesforce's own propagation delay, and authorizing before it has passed fails with an error naming an invalid client.
10. "Enter App's Details": in the app's page, "Manage Consumer Details" (Salesforce asks for a verification code sent by email), copy "Consumer Key" and "Consumer Secret" into the dialog. "Next".
11. "Authorize": "To access information in Salesforce you need to authorize our app to be able to make requests on your behalf." A consent window opens on the instance; sign in as the user the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Salesforce answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl` naming the intended org.

## Fixed-key alternative through a Generic connector

None fixed. Salesforce's REST API takes bearer tokens only, and every way to one is an OAuth grant; the username-password flow that used to stand in for a fixed key is disabled on new orgs. For an integration that should act as an integration user rather than a person, the Connected App's client credentials flow (ticked in step 8) with a run-as user set under "Manage", "Edit Policies", and the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the route; the connector's own flow does not do it.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. The refresh token lives as long as the Connected App's "Refresh Token Policy" allows (the default is "Refresh token is valid until revoked"); an administrator can shorten it or revoke sessions under "Manage", "Edit Policies", and the connector then needs re-authorizing. Rotating the consumer secret means pasting the new one into the dialog and re-authorizing.

## Known differences from the dialog

- The dialog's App Manager link goes through the Lightning navigation setup page rather than App Manager itself; the menu path is Setup, "Apps", "App Manager".
- The dialog lists "Enable Client Credentials Flow" among the options to select; the connector does not use it, and Salesforce will ask for a run-as user when it is ticked. It does no harm and enables the alternative above.
- Salesforce now labels the scope "Manage user data via APIs (api)"; older orgs showed "Access and manage your data (api)". Same scope.
- Salesforce is steering new integrations to External Client Apps; the dialog and this connector want a Connected App.

## Verify before trusting

Salesforce's connected app help pages could not be fetched on 2026-09-15, so the labels in steps 3 to 10 come from the dialog and general knowledge; check them against the org's Setup, where the wording differs between Classic and Lightning. Also verify: the 10-minute wait has passed before step 11; PKCE is not required; `baseUrl` afterwards names the org the user meant, since a sandbox and production look alike in the dialog.
