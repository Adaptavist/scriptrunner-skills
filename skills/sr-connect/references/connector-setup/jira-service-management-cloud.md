# Jira Service Management Cloud

Authorized in a browser through OAuth 2.0, with a choice between the platform's own OAuth app and one the user creates. Snapshot 2026-09-15 from the web application's authorization wizard, cross-checked the same day against https://developer.atlassian.com/cloud/jira/platform/oauth-2-3lo-apps/ and https://docs.adaptavist.com/src/latest/connectors/create-a-jsm-cloud-connector. The wizard is Jira Cloud's with a few lines changed; `jira-cloud.md` is the full text, and this file lists what differs.

## Before you hand over

As Jira Cloud: `connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`, then `authorizationUrl`. A Jira Service Management Cloud connector and a Jira Cloud connector are different connector types pointing at the same site; an API connection of one type refuses a connector of the other, and the two are not interchangeable in a picker. A workspace that reads service desk requests and plain issues from one site needs one of each, or one Jira Cloud connector with a Jira Cloud API connection, since the Jira Cloud API reaches service desk issues as issues.

## Methods the wizard offers

Account type ("My Atlassian account" / "Service user"), then "ScriptRunner Connect OAuth 2.0 app" (default, "Less than 1 minute") or "Self-managed OAuth 2.0 app" ("10 minutes +"). Same policy as Jira Cloud: the platform's app unless the user wants only the scopes the integration needs or hits a scope it lacks. This wizard carries no alert about the Jira Software or Compass APIs; a service desk integration rarely needs them.

## Steps

As Jira Cloud, with these differences. In the console, under "Permissions", the API to add is "Jira Service Management API" beside or instead of "Jira API", depending on which endpoints the integration calls. Under "Credentials" the wizard asks for the "JSM Cloud API Authorization URL" from the "Authorization URL generator"; the generator offers one URL per API, and the one pasted must carry the scopes the connector will use.

The public documentation's version of the steps, at the URL above, adds "Select your desired option for the Authorize for site dropdown, review the permissions, then click Accept" for the consent window, and "Reselect the site in the dropdown and confirm" for the step below.

## After the callback

As Jira Cloud: the consent window closes after 100 seconds, and the tab that started the flow opens "Authorize site"; pick the site under "Select site to confirm authorization", "Confirm". Without it the connector stays "Incomplete". Recommend the user runs the wizard; if you drive it and fail, hand them `authorizationUrl`.

## Fixed-key alternative through a Generic connector

As Jira Cloud: basic authentication with the account email and an API token from https://id.atlassian.com/manage-profile/security/api-tokens, base URL `https://<site>.atlassian.net`. The service desk endpoints live under `/rest/servicedeskapi/` on the same host. Build `JiraServiceManagementCloudApi` from `@managed-api/jira-service-management-cloud-sr-connect` on the Generic connection as `references/scripting.md` shows. Same costs: the whole account's permissions, a token expiry of at most a year, and a connector that reads as Generic.

## Expiry and re-authorization

As Jira Cloud: 88 days of inactivity on the refresh token, then "Reauthorize" at `authorizationUrl`.

## Known differences from the wizard

Those listed in `jira-cloud.md`, plus: the public documentation names the methods "the ScriptRunner Connect managed app" and "the self-managed Atlassian Cloud app option", while the wizard's radios read "ScriptRunner Connect OAuth 2.0 app" and "Self-managed OAuth 2.0 app". Same options.

## Verify before trusting

As Jira Cloud, and that the API connection's type matches this connector rather than Jira Cloud's.
