# Jira Cloud

Authorized in a browser through OAuth 2.0, with a choice between the platform's own OAuth app and one the user creates. Snapshot 2026-09-15 from the web application's authorization wizard, cross-checked the same day against https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps/ and https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/. Jira Service Management Cloud and Confluence Cloud use the same wizard and have their own files, which differ from this one in a few lines.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`. The app ID and both type IDs come from `app list`; the app has one API connection type and one event listener type, and a connector created without the API connection type is refused when it is attached to an API connection. The response is `authorized: false` and `authorizationUrl`, which opens the connector in the web application with the wizard on top. `connector get` reports the same URL later, which is also where an expired authorization is renewed, and `baseUrl`, the site, once the wizard has finished. Nothing in the API says which method a connector was authorized with; the web application shows it under "Authorization method", so when it matters, ask.

## Methods the wizard offers

The wizard is titled "Authorize connector". It asks about the account and the method before any credential.

Account type: "My Atlassian account" or "Service user". A service user takes a "Service user email"; the wizard's help says "Service users distinguish authorised connectors from those using personal accounts." Recommend a service user for anything that will run in production, so the integration does not stop when a person leaves.

A service user here is an ordinary Jira Cloud user account that belongs to no particular person and outlives whoever set it up. It is **not** Atlassian's "service accounts" feature, which is a different thing managed in Atlassian Administration and cannot run this wizard; that one has its own route through a Generic connector, below. The wizard authorizes a service user exactly as it authorizes a personal account — somebody signs in as it.

Authorization method, one of:

- "ScriptRunner Connect OAuth 2.0 app", the default, rated "Less than 1 minute". The platform's own OAuth app with pre-approved scopes. The wizard says it "may lack certain permissions" and, in an alert, "To use the Jira Software API or Compass GraphQL API, please select the Self-managed option". Which further scopes it lacks is not readable from the CLI or the wizard; a vendor 401 or 403 on a call the account can make in Jira is how you find out, and the answer then is a self-managed connector.
- "Self-managed OAuth 2.0 app", rated "10 minutes +". The user creates an OAuth 2.0 integration in the Atlassian Developer Console, picks the scopes the integration needs, and gives the wizard the app's "Authorization URL", "Client ID" and "Secret". The wizard reads the scopes off the authorization URL and refuses one with none: "No scope specified in the authorization url. Please ensure you have configured some scopes." It also refuses a client ID that does not match the URL.

Default to the platform's app when the user accepts its scopes. Recommend self-managed when they want only the scopes the integration needs, or when the integration touches the Jira Software API (boards, sprints) or Compass. The `@managed-api/jira-software-cloud-sr-connect` package on the API connection is the tell: that work needs the self-managed app.

No API token option, for either account type. When the user wants one — a personal token, or one belonging to an Atlassian service account — see the Generic section below.

## Steps

Both methods start the same way: open `authorizationUrl`, sign in, and the wizard is already open on the connector. Pick the account type, then the method.

Platform app: "Authorize app". A consent window opens on Atlassian; sign in if asked, check the site list, "Accept". Then the step under After the callback.

Self-managed, when the user has no app yet. The wizard's sections are collapsible and open by default; the numbering below is the wizard's.

"Create app":

1. "Visit the Atlassian Developer Console." https://developer.atlassian.com/console/myapps/
2. "Click on the Create dropdown and select OAuth 2.0 integration."
3. "Specify a name for your app and agree to Atlassian's developer terms."
4. "Click Create."

"Distribution", for an app other people in the site will authorize through:

5. Open "Distribution" in the app's left menu, "Edit".
6. Under "Distribution Status" select "Sharing".
7. "Complete the form and click Save changes."

"Permissions":

8. Open "Permissions", "Add" next to "Jira API" (and any other API the integration needs).
9. "Add necessary scopes (max 41 scopes, avoid mixing classical and granular scopes)."

"Authorization":

10. Open "Authorization".
11. "Click Add next to the OAuth 2.0 (3LO) authorization type."
12. Paste the wizard's "Callback URL" into the console's "Callback URL" field and "Save changes". The value is shown in the wizard with a copy button; never type it from memory.

"Credentials":

13. Still under "Authorization", find the "Authorization URL generator" and copy the "Jira Cloud API Authorization URL" into the wizard's "Authorization URL".
14. Open "Settings", copy "Client ID" and "Secret" into the wizard.
15. "Authorize app".

When the user already has an app, the wizard's "My apps" variant skips steps 1 to 4: "Select your chosen app from the list in My apps.", then Permissions, Authorization, Credentials as above.

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start again from "Authorize app". When Atlassian answers in time, the tab that started the flow opens "Authorize site": "Select site to confirm authorization", pick the site, "Confirm". Nothing else finishes the connector. Without this step it stays "Incomplete", and `connector get` reports `authorized: false` with no `baseUrl`. The account may see several sites in the list; the one picked is the one every request goes to, so read `baseUrl` back and check it names the site the user meant.

Recommend the user runs this wizard. If you drive it and the window closes, or the "Authorize site" dialog never appears because the tab that started the flow is gone, hand them `authorizationUrl` and ask them to finish; do not retry silently.

## Fixed-key alternative through a Generic connector

Basic authentication with the Atlassian account email and an API token from https://id.atlassian.com/manage-profile/security/api-tokens ("Create API token", a name, an expiry, "Create", "Copy to clipboard"). Generic connector: base URL `https://<site>.atlassian.net`, `--basic-auth-username <email>` with the token in `SR_CONNECT_CLI_BASIC_AUTH_PASSWORD`, or the user configures it in the web application. Build the client on it as `references/scripting.md` shows under "A Managed API on a Generic connector", with `JiraCloudApi` from `@managed-api/jira-cloud-v3-sr-connect`.

An Atlassian **service account** is the same route with a different account and one changed base URL, and it is the better answer when the organization has the feature. An organization admin creates it in Atlassian Administration, gives it the project roles the integration needs, and creates a token for it with scopes (`read:jira-work`, `write:jira-work`, and so on); the scopes are fixed at creation, so a different set means a new token, and the expiry is 1 to 365 days as it is for a personal one. What differs for the connector: a service-account token is **refused on `https://<site>.atlassian.net`** and only works through Atlassian's platform gateway, so the Generic connector's base URL is `https://api.atlassian.com/ex/jira/<cloudId>`, the cloud ID being what `https://<site>.atlassian.net/_edge/tenant_info` answers. Basic authentication with the service account's email and the token as the password works there as it does on the site URL. Verify the first call through a Managed API built on that connector before building on it: the paths it sends (`/rest/api/3/...`) append to the gateway base URL, but nothing on the platform side states that it has been tried.

Costs to name: a personal token carries the whole account's permissions rather than scopes; Atlassian gives it an expiry of 1 to 365 days, default one year, and a request with an expired token answers 401 with no warning before; the connector reads as Generic everywhere, so `baseUrl` is the only thing naming the site; and Atlassian's own wizard text calls token authentication "Not recommended by Atlassian". It is still the right answer when the user will not run OAuth and the integration is fine with one account's permissions.

## Expiry and re-authorization

The platform keeps the OAuth refresh token for 88 days of inactivity and Atlassian rotates it on every use, so a connector that is used at least every few weeks stays authorized; one that sits idle needs re-authorizing. Re-authorize at `authorizationUrl`, the same wizard with "Reauthorize" as its button. A self-managed app's secret can be rotated in the Developer Console; after that every connector using the app has to be re-authorized with the new secret.

## Known differences from the wizard

- The wizard's "Authorization" section says "Click Add next to the OAuth 2.0 (3LO) authorization type"; Atlassian's current console labels the button "Configure" once a callback exists. Same place either way.
- The wizard says "Distribution Status" then "Sharing"; Atlassian's documentation describes an "Enable sharing" toggle. Follow the console.
- Atlassian documents the refresh token's inactivity expiry as 90 days; the platform re-authorizes a little earlier, at 88.
- The wizard's own timing chips, "Less than 1 minute" and "10 minutes +", are estimates; the self-managed path took longer than that in every review where someone had to create the app and wait for it.

## Verify before trusting

The console's menu labels, which Atlassian renames; the scope names, classical against granular, and that the app does not mix the two; that the account is an admin of the site for a self-managed app that other users will authorize through; and, after the wizard, `connector get`'s `baseUrl` naming the intended site.
