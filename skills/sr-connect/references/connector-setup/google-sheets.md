# Google Sheets

Authorized in a browser through Google sign-in with the platform's own Google app. No wizard and no choice: one button, "Sign In & authorize with Google". Snapshot 2026-09-15 from the web application's Manage connector dialog and name screen. Google Sheets has no event listener type; changes in a sheet reach the platform from Google Apps Script posting to a Generic listener, as `references/event-listener-setup/generic.md` describes. Google Calendar and Google Drive authorize the same way; `google-calendar.md` is the full text, and this file lists what differs.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. Expect `connector get` to report no `baseUrl` for this app, as `google-calendar.md` says. The Sheets API addresses a spreadsheet by ID, the long segment of its URL; the script reads that from a parameter, and the account authorizing has to have access to that spreadsheet.

## Steps

As Google Calendar: `authorizationUrl`, "Sign In & authorize with Google", pick the account, allow, done. The consent window closes after 100 seconds; no further confirmation.

## Fixed-key alternative through a Generic connector

None fixed, as Google Calendar. A service account with the OAuth recipe in `references/scripting.md` and the spreadsheet shared with its address is the route for an integration that should not act as a person.

## Expiry and re-authorization

As Google Calendar.

## Known differences from the dialog

Those listed in `google-calendar.md`. Unlike Google Drive, no limitation warning is shown for Sheets; the platform app's scope reaches any spreadsheet the account can open.

## Verify before trusting

As Google Calendar, plus that the spreadsheet is shared with the authorizing account, since a 403 from the Sheets API names the file and not the account.
