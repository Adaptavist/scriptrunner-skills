# GitLab

Authorized in a browser through OAuth 2.0, with a choice between the platform's own GitLab application on gitlab.com and an application the user registers on their own instance. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://docs.gitlab.com/integration/oauth_provider/ and https://docs.gitlab.com/user/profile/personal_access_tokens/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the instance, once authorized: `https://gitlab.com` for the platform's app, the customer's host for a self-managed one, which is what tells a production instance from a test one.

## Methods the dialog offers

"Choose the Instance type that you want to connect to:", one of:

- "Fully managed GitLab application by ScriptRunner Connect", the default, for gitlab.com. No application to register; the dialog goes straight to "Authorize". The application is registered with the `api` scope, which is GitLab's full read and write scope, so there is no narrower option on this path.
- "Self-managed GitLab application", for a GitLab instance the user runs, or for gitlab.com when the user wants their own application. The user registers an application with the `api` scope and gives the dialog its "Application ID" and "Secret".

Default to the platform's application on gitlab.com. Self-managed is the only option for an instance the user hosts, and the one to recommend when the user wants the application under their own administration; scopes are the same either way, since the dialog asks for `api` on both.

## Steps

Platform application: open `authorizationUrl`, sign in, pick the first radio, "Next", "Authorize". The dialog's text: "To access information in GitLab you need to authorize our app to be able to make requests on your behalf." A consent window opens on gitlab.com; "Authorize" there. The account it authorizes as is whoever is signed in on gitlab.com in that browser, see the warning under Expiry.

Self-managed:

1. Pick the second radio, "Next". Enter the instance URL in the field labelled `https://gitlab.<INSTANCE_NAME>.com`; the dialog says "The connector requires your GitLab instance url." and refuses one that does not start `https://gitlab.` or that it cannot reach. The prefix is a literal check on the string, so an instance whose host does not begin `gitlab.` — `https://git.example.com`, `https://code.example.com` — cannot be entered here at all and the Generic connector below is the route to it. A host that does satisfy the prefix but is not publicly reachable needs the platform's public IP allowed through; the dialog's own error names it.
2. "Create Application". The dialog says "If you already have an application link to ScriptRunner Connect, skip the steps below and click next" and "To setup an application link you need administrator privileges for your GitLab Instance." A user-owned application does not need an administrator; a group-owned or instance-wide one does.
3. "Visit the Applications page in your GitLab Instance." The dialog links `<instance>/-/profile/applications`; GitLab's menu path is the avatar, "Edit profile", "Access", "Applications".
4. "Under Add new application insert the following details:" "Name" `ScriptRunnerConnect`, and the "Redirect URI" the dialog shows with a copy button. Leave "Confidential" checked.
5. "Under Scopes select the api checkbox."
6. "Scroll down and click Save application." GitLab shows "Application ID" and "Secret" once; copy both into the dialog's "Application ID" and "Secret". "Next".
7. "Authorize", then "Authorize" again in the consent window on the instance.

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When GitLab answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl`.

## Fixed-key alternative through a Generic connector

A personal access token: avatar, "Edit profile", "Access", "Personal access tokens", "Add new token", a name, an expiry, the `api` scope (or `read_api` for a read-only integration, which is narrower than either OAuth path offers). Generic connector: base URL `https://gitlab.com/api/v4` or `<instance>/api/v4`, header `PRIVATE-TOKEN: <token>`, through `--input` as `generic.md` says. Build `GitlabApi` from `@managed-api/gitlab-v4-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token expires (GitLab sets 365 days when no date is given and caps it there by default) and every request answers 401 the day after; the connector reads as Generic. The gain is `read_api`, the one way to a read-only GitLab connector.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. On a connector authorized through the platform's application the dialog warns: "You will be automatically authorized with the account you are currently signed in on GitLab website. If you want to use a different account, before reauthorization please sign out on https://gitlab.com". The same is true at first authorization, so when the integration should run as a service account, sign in to gitlab.com as that account before opening `authorizationUrl`. A self-managed application's secret can be renewed in GitLab; the connector then needs re-authorizing with the new one.

## Known differences from the dialog

- The dialog's alert says an application link needs "administrator privileges for your GitLab Instance"; a user-owned application under "Edit profile" needs none. Only a group or instance application does.
- The dialog spells the field "Redirect URI" as GitLab does; GitLab's current form also shows a "Confidential" checkbox the dialog does not mention. Leave it checked.
- GitLab's documentation labels the token creation "Add new token"; older versions and the dialog's era said "Add a personal access token". Same form.

## Verify before trusting

Which account is signed in on gitlab.com before authorizing through the platform's application; the instance URL's host, since the dialog insists on `gitlab.` as a prefix and an instance at another host has to be reached another way; and the token's expiry on the Generic alternative.
