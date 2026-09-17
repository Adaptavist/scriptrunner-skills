# Google Calendar

Authorized in a browser through Google sign-in with the platform's own Google app. No wizard and no choice: one button, "Sign In & authorize with Google". Snapshot 2026-09-15 from the web application's Manage connector dialog and name screen, cross-checked the same day against https://docs.adaptavist.com/src/latest/connectors/create-a-google-calendar-connector. Google Calendar has no event listener type; events reach the platform from Google Apps Script posting to a Generic listener, as `references/event-listener-setup/generic.md` describes. Google Sheets and Google Drive authorize the same way and have their own files.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The flow records no host for this app, so expect `connector get` to report no `baseUrl` even once authorized (not read back from an authorized connector); the Google account is not recorded, so ask.

## The dialog

None. In the web application the connector's name screen replaces "Continue" with "Sign In & authorize with Google", and the Manage connector dialog's authorize button reads the same, "Sign In & re-authorize with Google" once authorized. The dialog rates it "Less than 1 minute". The scopes are the platform app's and cannot be changed.

## Steps

1. Open `authorizationUrl`, sign in. "Sign In & authorize with Google".
2. A Google consent window opens. Pick the Google account the integration should act as, review the calendar permissions, "Continue" or "Allow". A Google Workspace account whose administrator restricts third-party apps shows a block or a request-access page instead; the administrator has to allow the app in the Workspace admin console first.
3. The window closes and the connector reads "Authorized".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; click the button again if it does. No further confirmation. Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account with the user, or with one call through the API connection to the primary calendar.

## Fixed-key alternative through a Generic connector

None fixed. Google APIs take OAuth bearer tokens only. For an integration that should act as an application rather than a user, a Google Cloud service account with a private key and the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the route, signing the JWT assertion with `jose-browser-runtime`; the calendar then has to be shared with the service account's address. The connector's own flow does not do it.

## Expiry and re-authorization

Google refresh tokens last until revoked, with one exception the connector cannot avoid: an account under a Workspace policy that limits token lifetime, or a consumer account that has not used the app in six months, has its token expire and the connector needs re-authorizing at `authorizationUrl`. Revoking the app under the Google account's "Third-party apps & services" does the same.

## Known differences from the dialog

- The public documentation's button label is "Sign In & Authorize With Google" in title case; the web application reads "Sign In & authorize with Google".
- Neither says which scopes the platform app requests; Google's consent screen is where the user sees them.

## Verify before trusting

Which Google account is picked in the consent window, since a browser signed in to several will offer them all; whether a Workspace administrator has to allow the app; and that the calendars the integration reads are visible to that account.
