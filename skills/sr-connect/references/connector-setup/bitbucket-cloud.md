# Bitbucket Cloud

Authorized in a browser through OAuth 2.0 with an OAuth consumer the user creates in their Bitbucket workspace. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://support.atlassian.com/bitbucket-cloud/docs/use-oauth-on-bitbucket-cloud/ and https://support.atlassian.com/bitbucket-cloud/docs/create-an-api-token/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the workspace entered in the dialog is not read back, so ask which workspace the connector was made for.

Creating an OAuth consumer needs workspace administrator rights. Find out early who has them.

## The dialog

"Configure Connector", steps "Add Bitbucket Cloud Workspace URL", "Create OAuth Client in Bitbucket Cloud", "Enter New OAuth Client Details", "Authorize". Inputs: the workspace URL, "Client ID", "Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Callback URL".

## Steps

1. Open `authorizationUrl`, sign in. Enter the workspace URL in the field labelled `https://bitbucket.org/<YOUR_WORKSPACE>`; the dialog refuses one that does not start with `https://bitbucket.org/` or that it cannot reach ("check you have access to the workspace"). "Next".
2. "Create OAuth Client". The dialog says "If you already have an application, skip the steps below and click next".
3. "Visit the workspace settings page in Bitbucket and click on Create OAuth client." The dialog links `<workspaceUrl>/workspace/settings/oauth-clients`; Bitbucket's menu path is the workspace, "Settings", "Workspace settings", "OAuth consumers" under "Apps and features", "Add consumer".
4. "Copy the Name below into the Name field on the form."
5. "Click on the Authorization tab of the form and copy the Callback URL below into the form." In Bitbucket's current form the "Callback URL" field sits on the same page rather than a tab. Leave "This is a private consumer" ticked.
6. "Click on the Scopes tab of the form and select the required scopes." Bitbucket's form lists "Permissions" as checkboxes by area (Repositories, Pull requests, Issues, Webhooks and so on, each with Read or Write). Tick what the integration needs; there is no all-scopes shortcut, and a call outside the ticked scopes answers 403.
7. "Click Save." Bitbucket shows the consumer; expand it to see "Key" and "Secret".
8. "Enter New OAuth Client Details": "A Client ID and Secret will be revealed for the new OAuth client." Copy Bitbucket's "Key" into the dialog's "Client ID" and "Secret" into "Secret". "Next".
9. "Authorize": "To access information in Bitbucket you need to authorize our app to be able to make requests on your behalf." A consent window opens on Bitbucket; sign in as the account the integration should act as, "Grant access".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Bitbucket answers in time, the dialog closes and the connector reads "Authorized". No further confirmation; no `baseUrl` to check, so confirm the workspace with the user.

## Fixed-key alternative through a Generic connector

An API token with scopes, from the Atlassian account: profile, "Account settings", "Security", "Create and manage API tokens", "Create API token with scopes", a name, an expiry, "Bitbucket" as the app, and the scopes. Generic connector: base URL `https://api.bitbucket.org/2.0`, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says, or basic authentication with the Atlassian account email and the token. Build `BitbucketCloudApi` from `@managed-api/bitbucket-cloud-v2-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token expires on the date chosen and the connector reads as Generic. Atlassian is retiring app passwords in favour of these tokens; an old app password may still work, but do not recommend creating one.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`, the same dialog. The consumer's secret can be regenerated in Bitbucket, after which the connector needs the new one and a re-authorization. Bitbucket's OAuth access tokens are short-lived and the platform refreshes them; nothing to do while the consumer exists.

## Known differences from the dialog

- The dialog says "Create OAuth client" and speaks of an "Authorization tab" and a "Scopes tab"; Bitbucket's current settings page is "OAuth consumers", the button "Add consumer", and the fields are on one form with "Permissions" checkboxes.
- The dialog calls the credentials "Client ID" and "Secret"; Bitbucket shows them as "Key" and "Secret".
- The dialog's consumer is created per workspace; Atlassian's documentation says the same, and a consumer in one workspace does not reach another.

## Verify before trusting

The permissions ticked in step 6 against the calls the integration makes; which account is signed in on bitbucket.org at step 9; and that the workspace URL entered is the workspace whose repositories the integration reads, since nothing reads it back.
