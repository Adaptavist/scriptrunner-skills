# Confluence Cloud

Authorized in a browser through OAuth 2.0, with a choice between the platform's own OAuth app and one the user creates. Snapshot 2026-09-15 from the web application's authorization wizard, rechecked 2026-10-07 against the wizard's source, with the scope policy corrected 2026-10-08, and cross-checked on 2026-09-15 against https://developer.atlassian.com/cloud/confluence/oauth-2-3lo-apps/ and https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/. The wizard is Jira Cloud's with a few lines changed; `jira-cloud.md` is the full text, and this file lists what differs. Confluence Cloud has no event listener type; the connector is for API connections only, and events reach the platform through a Generic listener as `references/event-listener-setup/generic.md` describes.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The API connection type carries two Managed API packages, `@managed-api/confluence-cloud-sr-connect` for the v1 REST API and `@managed-api/confluence-cloud-v2-sr-connect` for v2; the connector serves both, and the choice is made on `api-connection create`. Which one to pick, and which v1 calls Atlassian has removed, is in `references/product-gotchas/confluence-cloud.md`. `connector get` reports `baseUrl` with `/wiki` appended once authorized.

## Methods the wizard offers

Account type first; this wizard's sub-heading reads "Choose the default Atlassian account or a service user for security and access control." The rest of the account type screen matches Jira Cloud's, including the note that service users are not Atlassian's service accounts and the alert to be signed in as the service user first. Then "ScriptRunner Connect OAuth 2.0 app" (default, "Less than 1 minute") or "Self-managed OAuth 2.0 app" ("10 minutes +"), whose description ends "Use this option with granular scopes for Confluence Cloud API V2." That line overstates it. The platform's app requests granular scopes for pages, comments, attachments, spaces, tasks, custom content, label reads and content metadata, so v2 works with it for those, and an agent's build read, updated and deleted pages through v2 with it. The policy for this app: the platform's app by default, v1 or v2. Recommend self-managed when the integration needs v2 scopes outside that list, blog posts, whiteboards, databases, folders, writing labels, users and groups among them, or when the user wants only the scopes the integration uses.

## Steps

As Jira Cloud, with the same step numbers, and with these differences. Under "Permissions" the API to add is "Confluence API". Under "Credentials" the wizard asks for the "Confluence Cloud API Authorization URL" from the "Authorization URL generator".

## After the callback

As Jira Cloud: the consent window closes after 100 seconds, and the tab that started the flow opens "Authorize site"; pick the site under "Select site to confirm authorization", "Confirm". The site list shows Confluence sites with `/wiki`. Without this step the connector stays "Incomplete". Recommend the user runs the wizard; if you drive it and fail, hand them `authorizationUrl`.

## Fixed-key alternative through a Generic connector

Basic authentication with the Atlassian account email and an API token from https://id.atlassian.com/manage-profile/security/api-tokens, base URL `https://<site>.atlassian.net/wiki`. Build `ConfluenceCloudApi` from `@managed-api/confluence-cloud-sr-connect` or `@managed-api/confluence-cloud-v2-sr-connect` on the Generic connection as `references/scripting.md` shows; the class name is the same in both packages, so import from the one the integration uses. Same costs as Jira Cloud: the whole account's permissions, a token expiry of at most a year, a connector that reads as Generic.

## Expiry and re-authorization

As Jira Cloud: 88 days of inactivity on the refresh token, then "Reauthorize" at `authorizationUrl`.

## Known differences from the wizard

Those listed in `jira-cloud.md`, plus two in this wizard alone. The self-managed option's text recommends it for the v2 API, though the platform's app covers v2 for pages, comments, attachments, spaces, tasks, custom content, label reads and content metadata; see Methods above.

The other: if the user picks "Service user", types an email, continues, goes back and switches to "My Atlassian account", the wizard keeps the service user's email and saves it on the connector. Jira Cloud's and Jira Service Management Cloud's wizards clear it. The connector still acts as whoever signs in on the consent window, but the web application will show the service user's email for it. When that happens, close the wizard and start it again rather than going back.

## Verify before trusting

As Jira Cloud, plus that the scopes cover the calls: a v2 endpoint outside the platform app's scopes answers 401 with a body naming the missing scope, which is the signal to move to a self-managed app.
