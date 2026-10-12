# Salesforce

Authorized in a browser through OAuth 2.0 with a Connected App the user creates in Salesforce Setup, or an External Client App where the org no longer allows new Connected Apps (step 3). One method. Snapshot 2026-10-12 from the web application's setup dialog and the connector's OAuth service; Salesforce's help pages for connected apps did not render for fetching on the day and are listed under Verify.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the My Domain URL, once authorized, which separates a sandbox (`--<name>.sandbox.my.salesforce.com`) from production. Creating a Connected App needs a Salesforce administrator with "Customize Application" and "Manage Connected Apps".

## The dialog

"Configure Connector", steps "Add Salesforce Instance URL", "Create Connected App in Salesforce", "Enter App's Details", "Authorize". Inputs: the instance URL, "Consumer Key", "Consumer Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Callback URL". The create step's alerts: "If you already have a connected app, skip the steps below and click next." and "Creation of the app might take up to 10 minutes, please make sure to wait before proceeding."

## Steps

1. Open `authorizationUrl`, sign in. "Enter the Salesforce URL"; the dialog says "The Salesforce instance url must match the following format: https://<Your-instance-name>.my.salesforce.com". It first checks the URL answers ("Please enter a valid URL starting with \"https://\""), then the format ("Please enter a valid URL that match the following format: https://<Your-instance-name>.my.salesforce.com"); "Next" stays disabled after a refusal until the URL is edited. A sandbox's My Domain fits the pattern. "Next".
2. "Visit the Salesforce App Manager page. Lightning view requires third party cookies to be enabled." The dialog links the instance's Lightning setup at `/lightning/setup/NavigationMenus/home`; Salesforce's path is Setup, "Apps", "App Manager".
3. "Click New Connected App button in the top right corner of the page." Since Spring '26 Salesforce blocks creating new Connected Apps by default; existing ones and ones installed from a package keep working, and Salesforce Support can enable creation for an org. Where the button sits under a dropdown ("New Connected App" beside "New External Client App") or is refused, an External Client App is Salesforce's recommended replacement. The connector uses only the standard web server flow (consumer key and secret, an S256 code challenge, the `/services/oauth2/authorize`, `token` and `introspect` endpoints), which External Client Apps also support, so one set up with the same callback URL, scopes and secret settings as steps 5 to 8 should work. The dialog does not mention it and this snapshot did not test it; say so to the user. Support is needed only when the org must have a new Connected App.
4. "Copy the name below into Connected App Name and leave API name as suggested." Fill in the contact email Salesforce requires.
5. "In API (Enable OAuth Settings) section check Enable OAuth Settings."
6. "Copy the callback url below into the form." into "Callback URL".
7. "Add the following scopes in Selected OAuth Scopes section: Full access(full), Manage user data via APIs (api), Perform requests at any time (refresh_token, offline_access)." The connector asks for `refresh_token full api`. Without the refresh_token scope Salesforce returns no refresh token and the authorization fails at the callback.
8. "Ensure that only the following options are selected: Require Secret for Web Server Flow, Require Secret for Refresh Token Flow, Enable Client Credentials Flow." Two exceptions to "only": leave "Require Proof Key for Code Exchange (PKCE) Extension for Supported Authorization Flows" as Salesforce set it, since the connector sends an S256 code challenge on every authorization and Salesforce accepts it whether or not PKCE is required; and "Enable Refresh Token Rotation" may stay on, since the connector stores each rotated refresh token.
9. "Click Save." Wait; the dialog's alert about 10 minutes is Salesforce's own propagation delay, and authorizing before it has passed fails with an error naming an invalid client.
10. "Enter App's Details": "In API (Enable OAuth Settings) section click Manage Consumer Details." "You're sometimes prompted to verify your identity before you can view the consumer key."; Salesforce sends a verification code by email. "Copy the Consumer key into the form below." and "Copy the Consumer secret into the form below.", into the dialog's "Consumer Key" and "Consumer Secret". "Next".
11. "Authorize": "To access information in Salesforce you need to authorize our app to be able to make requests on your behalf." A consent window opens on the instance; sign in as the user the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Salesforce answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl` naming the intended org.

## Fixed-key alternative through a Generic connector

None fixed. Salesforce's REST API takes bearer tokens only, and every way to one is an OAuth grant; the username-password flow that used to stand in for a fixed key is disabled on new orgs. For an integration that should act as an integration user rather than a person, the Connected App's client credentials flow (ticked in step 8) with a run-as user set under "Manage", "Edit Policies", and the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the route; the connector's own flow does not do it.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. The refresh token lives as long as the Connected App's "Refresh Token Policy" allows (the default is "Refresh token is valid until revoked"); an administrator can shorten it or revoke sessions under "Manage", "Edit Policies". Once Salesforce refuses the refresh token, every call through the connector fails with "It appears that the authentication token has expired or been revoked by Salesforce, please re-authorize the Connector." and the connector needs re-authorizing. Refresh Token Rotation does not cause that; the connector saves the new refresh token on each refresh. Rotating the consumer secret means pasting the new one into the dialog and re-authorizing.

## Known differences from the dialog

- The dialog's App Manager link goes through the Lightning navigation setup page rather than App Manager itself; the menu path is Setup, "Apps", "App Manager".
- The dialog's "only the following options" list predates PKCE support and leaves out PKCE and Refresh Token Rotation; both work, as step 8 says.
- The dialog lists "Enable Client Credentials Flow" among the options to select; the connector does not use it, and Salesforce will ask for a run-as user when it is ticked. It does no harm and enables the alternative above.
- Salesforce now labels the scope "Manage user data via APIs (api)"; older orgs showed "Access and manage your data (api)". Same scope.
- The dialog only describes a Connected App. Salesforce blocks creating new ones by default since Spring '26 and recommends External Client Apps; step 3 covers both.

## Verify before trusting

Salesforce's connected app help pages could not be fetched on 2026-09-15, so the labels in steps 3 to 10 come from the dialog and general knowledge; check them against the org's Setup, where the wording differs between Classic and Lightning. If the user went with an External Client App, its labels differ from the dialog's, and a failure at the callback or on the first token refresh is the first thing to check. Also verify: the 10-minute wait has passed before step 11; the refresh_token scope is selected; `baseUrl` afterwards names the org the user meant, since a sandbox and production look alike in the dialog.
