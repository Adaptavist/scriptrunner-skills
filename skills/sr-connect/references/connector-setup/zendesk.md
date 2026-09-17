# Zendesk

Authorized in a browser through OAuth 2.0 with an OAuth client the user creates in Zendesk Admin Center. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://support.zendesk.com/hc/en-us/articles/4408845965210-Using-OAuth-authentication-with-your-application and https://developer.zendesk.com/api-reference/introduction/security-and-auth/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the subdomain's URL, once authorized. Creating an OAuth client needs a Zendesk administrator.

## The dialog

"Configure Connector", steps "Add ZenDesk Instance URL", "Create Application in ZenDesk", "Enter New Application Details", "Authorize". Inputs: the instance URL, "Unique identifier", "Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Redirect URL".

## Steps

1. Open `authorizationUrl`, sign in. Enter the instance URL in the field labelled `https://<ZENDESK_ACCOUNT>.zendesk.com`; the dialog refuses one that does not start with `https://` and end with `zendesk.com`. A host-mapped Zendesk (the account's own domain) has to be entered as its `zendesk.com` address. "Next".
2. "Create Application in ZenDesk". The dialog says "If you already have an application, skip the steps below and click next".
3. "Visit the ZenDesk OAuth Clients page and click Add OAuth client to add a new connection." The dialog links `<instance>/admin/apps-integrations/apis/zendesk-api/oauth_clients/`; Zendesk's menu path is Admin Center, "Apps and integrations", "APIs", "OAuth clients", "Add OAuth client".
4. "Copy the values below into the form.": "Name" `ScriptRunnerConnect`; the "Identifier" Zendesk fills in from the name can stay; "Redirect URLs" the value the dialog shows.
5. "Set the Client kind to confidential."
6. "Click Save." Zendesk shows the "Secret" once, in full; afterwards only its first characters.
7. "Enter New Application Details": copy Zendesk's "Identifier" into the dialog's "Unique identifier" and the secret into "Secret". "Next".
8. "Authorize": "To access information in ZenDesk you need to authorize our app to be able to make requests on your behalf." A consent window opens on the Zendesk instance; sign in as the agent or admin the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Zendesk answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl`.

## Fixed-key alternative through a Generic connector

An API token: Admin Center, "Apps and integrations", "APIs", "Zendesk API", the "Settings" tab, "Token access" on, "Add API token". Generic connector: base URL `https://<subdomain>.zendesk.com`, basic authentication with the username `<agent email>/token` and the token as the password, `--basic-auth-username "<email>/token"` with the token in `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD`. Build `ZenDeskApi` from `@managed-api/zendesk-v2-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token acts as the agent with all their permissions, Zendesk recommends OAuth over it, and the connector reads as Generic. It is the quick route when no administrator will create an OAuth client.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. Zendesk OAuth access tokens do not expire unless the client's "Expire tokens" option was switched on in step 4; the platform refreshes them when it is. Regenerating the client's secret in Admin Center means pasting the new one into the dialog and re-authorizing.

## Known differences from the dialog

- The dialog spells the product "ZenDesk"; Zendesk spells it "Zendesk". Same product.
- The dialog says "Add OAuth client to add a new connection"; the button is "Add OAuth client", and the form calls the field "Identifier", which the dialog calls "Unique identifier".
- The dialog's "Redirect URL" is one URL; Zendesk's field "Redirect URLs" takes a list, one per line, and one entry is enough.

## Verify before trusting

The subdomain, since a host-mapped account is entered by its `zendesk.com` name; that "Client kind" is confidential, since a public client refuses the secret; and which account signs in at step 8, because every ticket update will carry that agent's name.
