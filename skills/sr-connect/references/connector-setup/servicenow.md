# ServiceNow

Authorized in a browser through OAuth 2.0 with an OAuth API endpoint for external clients the user creates in their ServiceNow instance. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://www.servicenow.com/docs/bundle/zurich-platform-security/page/administer/security/task/t_CreateEndpointforExternalClients.html.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the instance, once authorized; a sub-production instance carries its suffix in the host (`<name>dev`, `<name>test`), which is how to tell them apart. Creating the endpoint needs the `admin` or `oauth_admin` role.

## The dialog

"Configure Connector", steps "Add ServiceNow Instance URL", "Create Application in ServiceNow", "Enter New Application Details", "Authorize". Inputs: the instance URL, "Client ID", "Client Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect`, the "Redirect URL", "Refresh Token Lifespan" `2000000000`, and a "Logo URL" pointing at the platform's logo.

## Steps

1. Open `authorizationUrl`, sign in. "Enter the ServiceNow URL", `https://` required. "Next".
2. "Create Application in ServiceNow". The dialog says "If you already have an application, skip the steps below and click next".
3. "Visit the ServiceNow OAuth application registry page, click New then select Create an OAuth API endpoint for external clients." The dialog links `<instance>/nav_to.do?uri=%2Foauth_entity_list.do`; ServiceNow's path is All, "System OAuth", "Application Registry", "New".
4. "Copy the values below into the form.": "Name" `ScriptRunnerConnect`; "Redirect URL" the value the dialog shows; "Refresh Token Lifespan" `2000000000`, which is the longest ServiceNow allows and is what keeps the connector authorized without a periodic re-authorization; "Logo URL" as the dialog shows, optional. Leave "Client ID" to ServiceNow, which generates it, and leave "Client Secret" empty for ServiceNow to generate, or set one.
5. "Click Submit."
6. "Enter New Application Details": open the record again, copy "Client ID", then "Click on the lock icon next to the Client Secret and copy the value into the form below." "Next".
7. "Authorize": "To access information in ServiceNow you need to authorize our app to be able to make requests on your behalf." A consent window opens on the instance; sign in as the user the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When ServiceNow answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl` naming the intended instance.

## Fixed-key alternative through a Generic connector

Basic authentication with an instance user, ideally a dedicated integration user with the `web_service_access_only` flag and the roles the tables need. Generic connector: base URL the instance, `--basic-auth-username <user>` with the password in `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD`. Build `ServiceNowApi` from `@managed-api/service-now-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: a password in a connector, the instance's password policy deciding when it stops working, and a connector that reads as Generic. It is the route when nobody with `oauth_admin` will create the endpoint.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. With the lifespan in step 4 the refresh token outlives everything else; the connector stops working when the endpoint record is deactivated, its secret regenerated, or the authorizing user locked out. The instance's "Access Token Lifespan" (default 1800 seconds) is handled by the platform's refresh and needs no change.

## Known differences from the dialog

- The dialog's link uses the old `nav_to.do` frame URL; current instances redirect it to the Application Registry list. The menu path works regardless of version.
- ServiceNow's form has "Client Secret" generated on save when left blank; the dialog's step reads as if the value already exists when the form is filled in. Copy it after "Submit".
- The dialog's "Logo URL" is cosmetic and can be left out.

## Verify before trusting

The instance host against the environment the integration targets, dev, test or production; that the authorizing user in step 7 has the roles the integration's tables need, since ServiceNow answers 403 per table; and the refresh lifespan entered, because the default when the field is left alone is 8,640,000 seconds, 100 days, after which the connector silently needs re-authorizing.
