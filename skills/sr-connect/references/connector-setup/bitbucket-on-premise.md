# Bitbucket On-Premise

Authorized in a browser through OAuth 2.0 with an incoming application link the user creates in their Bitbucket Data Center. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html; Atlassian's page for incoming links in Bitbucket Data Center did not answer on the day and is listed under Verify.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports `baseUrl`, the instance, once authorized. Creating an application link needs a Bitbucket administrator.

## The dialog

"Configure Connector", steps "Add Bitbucket On-Premise Instance URL", "Create Application Link in Bitbucket On-Premise", "Enter New Application Link Details", "Authorize". Inputs: the instance URL, "Client ID", "Client Secret". Read-only, with copy buttons: "Name" `ScriptRunnerConnect` and the "Redirect URL".

## Steps

1. Open `authorizationUrl`, sign in. "Enter the Bitbucket On-Premise URL", `https://` required; the dialog tests the URL and warns when it redirects. A 408 or 502 means the platform cannot reach the instance; the dialog's message names the platform's public IP to allow through the firewall, and links https://docs.adaptavist.com/src/latest/get-started/connect-to-services-behind-the-firewall. "Next".
2. "Create Application Link". The dialog says "If you already have an application link, skip the steps below and click next."
3. "Visit the Bitbucket On-Premise OAuth application links page page, click Create link then check Application type: External application, Direction: Incoming." The dialog links `<instance>/plugins/servlet/applinks/listApplicationLinks`; the menu path is Administration, "Application links".
4. "Click Continue."
5. "Copy the values below into the form.": "Name" `ScriptRunnerConnect` and the "Redirect URL" the dialog shows.
6. "Select Write under System Admin and ignore other permissions." Bitbucket's incoming link form lists "Application permissions" as one radio row per area; the dialog asks for the highest one because the Managed API covers administration endpoints. A narrower choice works for an integration that stays within it, and a call outside it answers 403.
7. "Click Save." Bitbucket shows "Client ID" and "Client secret".
8. "Enter New Application Link Details". The dialog adds "If you already have an application link, go to Application links page, click options (...) to the right of your app link and click View credentials." Copy both values into the dialog. "Next".
9. "Authorize": "To access information in Bitbucket On-Premise you need to authorize our app to be able to make requests on your behalf." A consent window opens on the instance; sign in as the account the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Bitbucket answers in time, the dialog closes and the connector reads "Authorized". No further confirmation. Read `connector get` back for `authorized: true` and `baseUrl` naming the instance.

## Fixed-key alternative through a Generic connector

A personal access token, on Bitbucket Data Center 5.5 and later: the user's avatar, "Manage account", "HTTP access tokens" (older versions: "Personal access tokens"), "Create token", a name, project and repository permissions, an expiry. Generic connector: base URL the instance, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says. Build `BitbucketOnPremiseApi` from `@managed-api/bitbucket-on-premise-v1-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token acts as its user with the permissions chosen, it may expire, and the connector reads as Generic. The gain is that no administrator is needed and the permissions can be narrower than "System Admin".

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. The application link's client secret can be regenerated in Bitbucket ("View credentials"), after which the connector needs the new one. Nothing else expires on this path.

## Known differences from the dialog

- The dialog's step 3 repeats the word "page" ("application links page page"); a typo, not two pages.
- The dialog names the permission "Write under System Admin"; Bitbucket's form shows "System admin" as the row and "Write" as the level.
- The dialog uses "Client Secret" with a capital S; Bitbucket shows "Client secret".

## Verify before trusting

The Bitbucket version, since incoming OAuth 2.0 application links arrived in Data Center 7.20 (https://confluence.atlassian.com/bitbucketserver/bitbucket-data-center-and-server-7-20-release-notes-1101934428.html) and anything earlier offers only OAuth 1.0a, which this connector does not do; the permission level in step 6 against what the integration calls; and `connector get`'s `baseUrl` afterwards. Atlassian's page for configuring an incoming link in Bitbucket Data Center could not be fetched on 2026-09-15 and the field labels above come from the dialog and general knowledge.
