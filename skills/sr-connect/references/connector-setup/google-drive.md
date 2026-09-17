# Google Drive

Authorized in a browser through Google sign-in with the platform's own Google app. No wizard and no choice: one button, "Sign In & authorize with Google". Snapshot 2026-09-15 from the web application's Manage connector dialog and name screen. Google Drive has no event listener type; the connector is for API connections only. Google Calendar and Google Sheets authorize the same way; `google-calendar.md` is the full text, and this file lists what differs.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. Expect `connector get` to report no `baseUrl` for this app, as `google-calendar.md` says.

Say this before anyone builds on it. The web application shows a warning titled "Limitations of the Google Drive connector" on both the name screen and the Manage connector dialog: "Please note that the Google Drive connector currently supports only files and folders created using ScriptRunner Connect." The platform's app asks Google for the scope that reaches files the app itself created, not the whole drive, so an integration that should read files a person uploaded cannot use this connector. The alternatives are a Generic connector with the OAuth recipe — either a service account the folders are shared with, or an application the user authorizes themselves — or Google Apps Script running inside the drive and posting to a Generic listener.

## Steps

As Google Calendar: `authorizationUrl`, "Sign In & authorize with Google", pick the account, allow, done. The consent window closes after 100 seconds; no further confirmation.

## Fixed-key alternative through a Generic connector

None fixed, as Google Calendar. For files a person created, the OAuth recipe in `references/scripting.md` on a Generic connector, two ways: a service account with the folders shared with it, or an application the user authorizes once in a browser, the script storing and refreshing the tokens. The service account needs nobody to re-consent and reaches only what is shared with it; the user-authorized application reaches whatever that user can see and stops when its refresh token is revoked.

## Expiry and re-authorization

As Google Calendar.

## Known differences from the dialog

The public documentation has no page for the Google Drive connector; the limitation above is stated only in the web application.

## Verify before trusting

Whether the files the integration needs were created through the platform, before anything else; then as Google Calendar.
