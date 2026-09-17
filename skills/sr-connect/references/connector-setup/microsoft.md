# Microsoft

Authorized in a browser through OAuth 2.0 against Microsoft Entra ID, with a choice between the platform's own Azure application and one the user registers in their tenant. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app. The connector reaches Microsoft Graph; the Managed API package is `@managed-api/microsoft-graph-v1-sr-connect`, and the event listener type is for Microsoft Teams outgoing webhooks.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the tenant is not recorded, so which tenant a connector reaches is a question for the user.

## Methods the dialog offers

"Choose the instance type that you want to use to connect to Microsoft:", one of:

- "Fully managed Azure application by ScriptRunner Connect", the default. The dialog warns, in an alert shown as soon as it is selected: "The fully managed Azure app by ScriptRunner Connect is only scoped for Microsoft Teams API operations. You should select the self-managed option if you need additional capabilities". So the platform's application covers Teams and nothing else in Graph: no mail, no calendar, no SharePoint, no users beyond what Teams needs. It also needs a tenant administrator to grant consent once, through the "Admin Consent URL" the dialog shows.
- "Self-managed Azure application". The user registers an application in Microsoft Entra, adds the Graph permissions the integration needs, creates a client secret, and gives the dialog "Application (client) ID", "Directory (tenant) ID" and "Client Secret Value".

Default to the platform's application for a Teams integration. Anything else in Graph needs self-managed; say so before the user starts, since the alert is the only place the dialog tells them.

## Steps

Platform application:

1. Open `authorizationUrl`, sign in, first radio, "Next".
2. "Obtain Administrator Consent". The dialog says "You can skip this step if an administrator from your organization has already granted admin consent to ScriptRunner Connect." and otherwise "To authorize our app, an administrator from your organization needs to grant consent to ScriptRunner Connect first. Copy the link below and pass it to them. Once they have granted consent, proceed to the next step." Copy the "Admin Consent URL" and give it to a tenant administrator; they open it, sign in, and accept. This is a one-time step per tenant, not per connector.
3. "Authorize". A consent window opens on Microsoft; sign in as the account the integration should run as, "Accept".

Self-managed, the dialog's steps "Create Application", "Configure Application", "Generate Application Secret", "Configure Permissions", "Obtain Administrator Consent", "Authorize":

1. "Visit the Azure Portal page." https://portal.azure.com/#home. "In the search bar, search for App registrations." "Click on New registration."
2. "Fill in the information below." "Name" `ScriptRunnerConnect`; "Supported account types" as the dialog shows it, "Accounts in any organizational directory (Any Microsoft Entra ID tenant - Multitenant)"; "Redirect URI - Select a platform" "Web"; "Redirect URI" the value the dialog shows with a copy button. "Click on Register."
3. "Configure Application": from the app's Overview copy "Application (client) ID" and "Directory (tenant) ID" into the dialog. Under "Authentication", "Select the Access tokens (used for implicit flows) checkbox." and save.
4. "Generate Application Secret": "Certificates & secrets", "New client secret". "Give the secret a description and choose an expiry date. Note that after this date, all users on this tenant will need to re-authorize their connection." "Copy the secret Value. This will be obfuscated after you navigate away from this section so paste it into the form below." Paste it into "Client Secret Value".
5. "Configure Permissions": "API permissions", "Add a permission", "Microsoft Graph", "Delegated Permissions", tick what the integration needs, then "Grant admin consent" for the tenant. Delegated permissions act as the signed-in user, which is what the connector's OAuth flow authorizes.
6. "Obtain Administrator Consent": for a self-managed application the grant in step 5 is that consent. "Next".
7. "Authorize", then sign in and "Accept" in the consent window.

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Microsoft answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true`; there is no `baseUrl` to check, so ask the user to confirm the tenant.

## Fixed-key alternative through a Generic connector

None fixed. Microsoft Graph accepts bearer tokens only, and every way to one is an OAuth exchange: the delegated flow above, or the client-credentials flow for an application acting as itself. For an integration that should run as an application rather than a user, the self-managed registration with "Application permissions" instead of "Delegated Permissions" and the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the route; the connector's own flow does not do client credentials.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. A self-managed application's client secret has the expiry chosen in step 4 (Microsoft offers 90 days to 24 months); the dialog's own words: "after this date, all users on this tenant will need to re-authorize their connection", and that is after a new secret has been created and pasted into the dialog. Put the date somewhere the team will see it.

## Known differences from the dialog

- The dialog says to visit portal.azure.com; Microsoft now documents app registration in the Entra admin center at https://entra.microsoft.com under "Entra ID", "App registrations". Both reach the same blade.
- The dialog's "Supported account types" value is the old wording; the current dropdown reads "Multiple Entra ID tenants" for the multitenant option, and Microsoft recommends single tenant "for most applications". A single-tenant registration works for a connector used inside that one tenant.
- "Access tokens (used for implicit flows)" is a checkbox Microsoft has moved under "Implicit grant and hybrid flows"; it is still there.

## Verify before trusting

That the tenant administrator has granted consent, on either path, before "Authorize" is clicked; the secret's expiry date; that the permissions added are the Graph permissions the integration's calls need, since a missing one answers 403 with `Authorization_RequestDenied`; and, for Teams, that the account authorizing is a member of the teams the integration will post to.
