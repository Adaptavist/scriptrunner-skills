# Bitbucket Cloud

Authorized in a browser through OAuth 2.0 with an OAuth client the user creates in their Bitbucket workspace. One method. Snapshot 2026-10-12 from the web application's setup dialog, whose Bitbucket labels were checked against a Bitbucket Cloud workspace on 2026-10-09; earlier cross-check 2026-09-15 against https://support.atlassian.com/bitbucket-cloud/docs/use-oauth-on-bitbucket-cloud/ and https://support.atlassian.com/bitbucket-cloud/docs/create-an-api-token/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the workspace entered in the dialog is not read back, so ask which workspace the connector was made for.

Creating an OAuth client needs workspace administrator rights. Find out early who has them.

## The dialog

"Configure Connector", steps "Add Bitbucket Cloud Workspace URL", "Create OAuth Client in Bitbucket Cloud", "Enter New OAuth Client Details", "Authorize". Inputs: the workspace URL, "Client ID", "Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Callback URL".

## Steps

1. Open `authorizationUrl`, sign in. "This connector requires Bitbucket Cloud workspace url." Enter it in the field labelled `https://bitbucket.org/<YOUR_WORKSPACE>`, for example `https://bitbucket.org/acme`; the dialog refuses one that does not start with `https://bitbucket.org/` or that it cannot reach ("Please enter a valid URL, starting with https://bitbucket.org/ or check you have access to the workspace"). The OAuth clients settings URL is accepted too. "Next".
2. "Create OAuth Client". The dialog says "If you already have an application, skip the steps below and click next".
3. "Visit the workspace settings page in Bitbucket and click on Create OAuth client." The dialog links `<workspaceUrl>/workspace/settings/oauth-clients`, Bitbucket's "OAuth clients" page. The form has "Details", "Authorization" and "Scopes" tabs.
4. "Copy the Name below into the Name field on the form."
5. "Click on the Authorization tab of the form, select Authorization code under Supported grant types and copy the Callback URL below into the form." The "Callback URL" field only appears once "Authorization code" is selected.
6. "Click on the Scopes tab of the form and select the required scopes." Tick what the integration needs, by area (repositories, pull requests, issues, webhooks and so on, read or write); there is no all-scopes shortcut, and a call outside the ticked scopes answers 403.
7. "Click Save."
8. "Enter New OAuth Client Details": "A Client ID and Secret will be revealed for the new OAuth client." "Copy the Client ID and Secret into the form below." Bitbucket and the dialog use the same two labels. "Next".
9. "Authorize": "To access information in Bitbucket you need to authorize our app to be able to make requests on your behalf." A consent window opens on Bitbucket; sign in as the account the integration should act as, "Grant access".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Bitbucket answers in time, the dialog closes and the connector reads "Authorized". No further confirmation; no `baseUrl` to check, so confirm the workspace with the user.

## Fixed-key alternative through a Generic connector

An API token with scopes, from the Atlassian account: profile, "Account settings", "Security", "Create and manage API tokens", "Create API token with scopes", a name, an expiry, "Bitbucket" as the app, and the scopes. Generic connector: base URL `https://api.bitbucket.org/2.0`, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says, or basic authentication with the Atlassian account email and the token. Build `BitbucketCloudApi` from `@managed-api/bitbucket-cloud-v2-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token expires on the date chosen and the connector reads as Generic. Atlassian is retiring app passwords in favour of these tokens; an old app password may still work, but do not recommend creating one.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`, the same dialog. The OAuth client's secret can be regenerated in Bitbucket, after which the connector needs the new one and a re-authorization. Bitbucket's OAuth access tokens are short-lived and the platform refreshes them; nothing to do while the OAuth client exists.

## Known differences from the dialog

- None in the labels as of the snapshot; the dialog was aligned with Bitbucket's OAuth clients page on 2026-10-09. Atlassian's documentation may still say "OAuth consumers", "Add consumer", "Key" and "Permissions"; the workspace's own page wins.
- The OAuth client is created per workspace; an OAuth client in one workspace does not reach another.

## Verify before trusting

The scopes ticked in step 6 against the calls the integration makes; which account is signed in on bitbucket.org at step 9; and that the workspace URL entered is the workspace whose repositories the integration reads, since nothing reads it back.
