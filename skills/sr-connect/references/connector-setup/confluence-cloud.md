# Confluence Cloud

Authorized in a browser through OAuth 2.0, with a choice between the platform's own OAuth app and one the user creates. Snapshot 2026-09-15 from the web application's authorization wizard, cross-checked the same day against https://developer.atlassian.com/cloud/confluence/oauth-2-3lo-apps/ and https://support.atlassian.com/atlassian-account/docs/manage-api-tokens-for-your-atlassian-account/. The wizard is Jira Cloud's with a few lines changed; `jira-cloud.md` is the full text, and this file lists what differs. Confluence Cloud has no event listener type; the connector is for API connections only, and events reach the platform through a Generic listener as `references/event-listener-setup/generic.md` describes.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The API connection type carries two Managed API packages, `@managed-api/confluence-cloud-sr-connect` for the v1 REST API and `@managed-api/confluence-cloud-v2-sr-connect` for v2; the connector serves both, and the choice is made on `api-connection create`. `connector get` reports `baseUrl` with `/wiki` appended once authorized.

## Methods the wizard offers

Account type first; this wizard's sub-heading reads "Choose the default Atlassian account or a service user for security and access control." Then "ScriptRunner Connect OAuth 2.0 app" (default, "Less than 1 minute") or "Self-managed OAuth 2.0 app" ("10 minutes +"), whose description ends "Use this option with granular scopes for Confluence Cloud API V2." That line is the policy for this app: the v2 API and its granular scopes want the self-managed app; the v1 API with classical scopes works with the platform's app. Recommend self-managed whenever the API connection will use the v2 package.

## Steps

As Jira Cloud, with these differences. The wizard's "Create app" section has no "Create dropdown" step; it goes from "Visit the Atlassian Developer Console." to "Specify a name for your app and agree to Atlassian's developer terms." In the console the "Create" dropdown is still where "OAuth 2.0 integration" lives, so the step is missing rather than wrong. Under "Permissions" the API to add is "Confluence API". Under "Credentials" the wizard asks for the "Confluence Cloud API Authorization URL" from the "Authorization URL generator".

## After the callback

As Jira Cloud: the consent window closes after 100 seconds, and the tab that started the flow opens "Authorize site"; pick the site under "Select site to confirm authorization", "Confirm". The site list shows Confluence sites with `/wiki`. Without this step the connector stays "Incomplete". Recommend the user runs the wizard; if you drive it and fail, hand them `authorizationUrl`.

## Fixed-key alternative through a Generic connector

Basic authentication with the Atlassian account email and an API token from https://id.atlassian.com/manage-profile/security/api-tokens, base URL `https://<site>.atlassian.net/wiki`. Build `ConfluenceCloudApi` from `@managed-api/confluence-cloud-sr-connect` or `@managed-api/confluence-cloud-v2-sr-connect` on the Generic connection as `references/scripting.md` shows; the class name is the same in both packages, so import from the one the integration uses. Same costs as Jira Cloud: the whole account's permissions, a token expiry of at most a year, a connector that reads as Generic.

## Expiry and re-authorization

As Jira Cloud: 88 days of inactivity on the refresh token, then "Reauthorize" at `authorizationUrl`.

## Known differences from the wizard

Those listed in `jira-cloud.md`, plus the missing "Create dropdown" step above.

## Verify before trusting

As Jira Cloud, plus that the scopes match the package: v2 endpoints refuse classical scopes with a 401 whose body names the missing scope.
