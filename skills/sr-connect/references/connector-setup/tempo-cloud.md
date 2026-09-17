# Tempo Cloud

Authorized in a browser through OAuth 2.0 with an application the user registers in Tempo's settings inside their Jira Cloud site. One method. Snapshot 2026-09-15 from the web application's setup dialog; Tempo's API documentation at https://apidocs.tempo.io/ did not render for fetching on the day and is listed under Verify. Tempo Cloud has no event listener type; the connector is for API connections only.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. Tempo Cloud is a separate connector type from Jira Cloud even though it is configured inside Jira; an integration that reads worklogs from Tempo and issues from Jira needs both connectors. Registering the application needs Tempo administrator rights in the site.

## The dialog

"Configure Connector", steps "Add Jira Cloud Instance URL", "Create Application in Jira Cloud", "Enter New Application Details", "Authorize". Inputs: the Jira Cloud instance URL, "Client ID", "Client Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect`, the "Redirect URL", "Client type" `Public`, "Authorization grant type" `Authorization code`.

## Steps

1. Open `authorizationUrl`, sign in. "Enter the Jira Cloud instance URL", `https://<site>.atlassian.net`. "Next".
2. "Create Application in Jira Cloud". The dialog says "If you already have an application, skip the steps below and click next".
3. "Visit the Tempo settings page in Jira and click New Application." The dialog links the Tempo app's configuration page inside the site (`/plugins/servlet/ac/io.tempo.jira/tempo-app#!/configuration/identity-service`); Tempo's menu path is the Tempo app, "Settings", "API integration" (older Tempo: "OAuth 2.0 Applications"), "New Application".
4. "Copy the values below into the form.": "Name" `ScriptRunnerConnect`, "Redirect URL" the value the dialog shows, "Client type" `Public`, "Authorization grant type" `Authorization code`.
5. "Click Submit." Tempo shows the application's "Client ID" and "Client secret".
6. "Enter New Application Details": "Copy the Client ID and Client secret into the form below. NOTE: These credentials will be stored securely in our platform." "Next".
7. "Authorize": "To access information in Jira you need to authorize ScriptRunner Connect to be able to make requests on your behalf." A consent window opens; sign in to Atlassian as the user the integration should act as, and approve Tempo's consent screen.

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Tempo answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true`; check `baseUrl` if it is reported, since the account has not been measured for this app.

## Fixed-key alternative through a Generic connector

A Tempo API token: the Tempo app, "Settings", "API integration", "New Token", a name, an expiry, and the permissions. Generic connector: base URL `https://api.tempo.io/4`, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says. Build `TempoCloudApi` from `@managed-api/tempo-cloud-v4-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token acts as its creator with the permissions chosen, expires on the date chosen, and the connector reads as Generic. It is the route when no Tempo administrator will register an application.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. The application's secret can be regenerated in Tempo, after which the connector needs the new one. Tempo refreshes access tokens through the platform; nothing to do while the application exists.

## Known differences from the dialog

- The dialog calls the settings page "Tempo settings page in Jira" and links its old configuration route; Tempo's current UI puts applications under "API integration".
- The dialog's "Client type" `Public` is Tempo's label; the flow still sends the secret. Follow the dialog.

## Verify before trusting

Tempo's documentation could not be fetched on 2026-09-15, so the menu labels in steps 3 to 5 come from the dialog and general knowledge; check them in the site's Tempo settings. Also verify that the site entered in step 1 is the one whose Tempo data the integration reads, since Tempo data is per site.
