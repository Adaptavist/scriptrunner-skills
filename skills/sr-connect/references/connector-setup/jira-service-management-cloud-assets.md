# Jira Service Management Cloud Assets

Authorized with basic authentication: an Atlassian account email and an API token typed into the dialog. No consent window and no choice of method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/. Assets has no event listener type; the connector is for API connections only, and it is a separate connector type from Jira Service Management Cloud, whose OAuth connector does not reach the Assets API.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The dialog records no host for this app, so expect `connector get` to report no `baseUrl` even once authorized (not read back from an authorized connector); the site is not entered anywhere in the dialog, since the Assets API is reached through Atlassian's shared API host with a workspace ID the Managed API resolves. Ask which site.

The credentials are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way, or the Generic alternative below.

## The dialog

"Configure Connector", a single form: "Email", "API token", buttons "Cancel" and "Save". The dialog's own steps: "Jira Service Management Cloud Assets REST API supports basic authentication.", "Insert an Atlassian account username to Email field.", "Log in to API tokens page.", "Click Create API token, enter a Label for your token and click Create.", "Click Copy and paste the token to API token field."

## Steps

1. Open `authorizationUrl`, sign in. Enter the Atlassian account email of the user the integration should act as into "Email". A service account with the Assets permissions it needs is the better choice than a person.
2. https://id.atlassian.com/manage-profile/security/api-tokens, signed in as that account. "Create API token", a name, an expiry date, "Create", "Copy to clipboard".
3. Paste into "API token". "Save".

## Saving

No callback and no window. "Save" stores the pair and the connector reads "Authorized". Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the site with the user.

## Fixed-key alternative through a Generic connector

The same pair on a Generic connector, which the CLI can create authorized: base URL `https://api.atlassian.com/jsm/assets/workspace/<workspaceId>/v1`, `--basic-auth-username <email>` with the token in `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD`. The workspace ID comes from `https://<site>.atlassian.net/rest/servicedeskapi/assets/workspace`, one call with the same credentials. Build `JiraServiceManagementCloudAssetsApi` from `@managed-api/jira-service-management-cloud-assets-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the connector reads as Generic, and the workspace ID is baked into the base URL rather than resolved. Nothing else is lost.

## Expiry and re-authorization

Atlassian API tokens expire on the date chosen, 1 to 365 days, default one year, and older tokens created without a date are being expired by Atlassian during 2026. A request with an expired token answers 401 with no warning before. Re-authorizing is the dialog again at `authorizationUrl` with a new token; note the expiry date where the team will see it.

## Known differences from the dialog

- The dialog says "enter a Label for your token"; Atlassian's page asks for a name and, since 2024, an expiry date. The dialog does not mention the expiry.
- The dialog's "Insert an Atlassian account username" means the account's email; Atlassian has no separate username.

## Verify before trusting

The account's Assets permissions in the site, since the token carries exactly that user's access; the token's expiry date; and, for the Generic alternative, the workspace ID and the API path, which come from general knowledge and were not checked against a live connector for this snapshot.
