# Confluence On-Premise

Authorized through an application link the user creates in their Confluence Data Center, with a key pair the platform generates. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://confluence.atlassian.com/enterprise/using-personal-access-tokens-1026032365.html. The dialog is the one Jira On-Premise uses with the product name swapped; `jira-on-premise.md` is the full text, and this file lists what differs.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one API connection type and one listener type. Then `authorizationUrl`. `connector get` reports `baseUrl`, the instance, once authorized. A Confluence administrator is needed for the application link.

## The dialog

As Jira On-Premise: "Configure Connector", steps "Add Confluence On-Premise Instance URL", "Create Application Link in Confluence On-Premise", "Enter Details", "Authorize"; one input, the instance URL; "Consumer Key", "Consumer Name" and the public key to copy into Confluence.

## Steps

As Jira On-Premise, in Confluence's administration: the "Application links" page is under General configuration, and the dialog links `<instance>/plugins/servlet/applinks/listApplicationLinks`. "Create link", "Atlassian product", "https://app.scriptrunnerconnect.com" as the "Application URL", "Continue" past the "No response was received from the URL you entered" warning, "ScriptRunnerConnect" as the "Application Name", "Create incoming link", then the public key, "Consumer Key" and "Consumer Name" from the dialog. "Authorize", sign in on the instance, "Allow".

## After the callback

As Jira On-Premise: the consent window closes after 100 seconds; when Confluence answers in time the dialog closes and the connector reads "Authorized"; no site confirmation.

## Fixed-key alternative through a Generic connector

A personal access token, on Confluence 7.9 and later: avatar, "Settings", "Personal Access Tokens", "Create token". Generic connector: base URL the instance, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says. Build `ConfluenceOnPremApi` from `@managed-api/confluence-on-prem-v7-sr-connect` on the Generic connection as `references/scripting.md` shows. Same costs and the same gain as Jira On-Premise: the token acts as its user, and no administrator is needed.

## Expiry and re-authorization

As Jira On-Premise: the public key is valid for 5 years, and re-authorizing regenerates the key pair after the "Regenerate key pair" confirm, which invalidates the application link until the new key is pasted in.

## Known differences from the dialog

Those listed in `jira-on-premise.md`.

## Verify before trusting

As Jira On-Premise.
