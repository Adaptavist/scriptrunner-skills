# Zoom

Authorized in a browser through OAuth 2.0 with a General app the user creates in the Zoom App Marketplace. One method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://developers.zoom.us/docs/integrations/create/.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; the Zoom account is not recorded, so ask. The event listener for Zoom needs a secret token entered at the listener's `setupUrl`, which `references/event-listener-setup/zoom.md` covers; the connector is the outbound half only.

## The dialog

"Configure Connector", steps "Create Application in Zoom", "Enter New Application Details", "Add Required Scopes", "Authorize". Inputs: "Client ID", "Client Secret". Read-only, with a copy button: the "Redirect URL". The dialog warns "You must be logged into Zoom to create an application."

## Steps

1. Open `authorizationUrl`, sign in. "Create Application in Zoom". The dialog says "If you already have an application, skip the steps below and click next".
2. "Visit the Zoom Apps Marketplace page. You will need to sign in if you're not already signed in." https://marketplace.zoom.us/user/build
3. "Hover over the Develop dropdown in the top navigation bar, then select Build app." Zoom's current page reads "Develop", then "Build an app".
4. "Select the General app type." and "Create".
5. "Enter New Application Details": rename the app to `ScriptRunnerConnect` (or the integration's name; Zoom shows the name on the consent screen). "Select User-managed app option for Select how the app is managed." Copy "Client ID" and "Client Secret" from the app's Basic Information into the dialog. "Copy the Redirect URL into the OAuth Redirect URL field." Zoom also wants the same URL in "OAuth allow lists".
6. "Add Required Scopes": "You will need to select the necessary permissions to give ScriptRunner Connect." "In the left-hand navigation panel, select Scopes.", "Select Add Scopes.", "Select the appropriate scopes from the list." Zoom's scopes are granular (`meeting:read:meeting`, `user:read:user` and so on); tick what the integration's calls need. A missing scope answers 400 with code 4711 naming it. "Next".
7. "Authorize": "To access information in Zoom you need to authorize our app to be able to make requests on your behalf." A consent window opens on Zoom; sign in as the account the integration should act as, "Allow".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. When Zoom answers in time, the dialog closes and the connector reads "Authorized". No further confirmation; no `baseUrl` to check, so confirm the account with the user.

## Fixed-key alternative through a Generic connector

None fixed. Zoom retired JWT apps, and every remaining route is an OAuth exchange: the user-level flow above, or a Server-to-Server OAuth app, which trades an account ID, client ID and secret for a short-lived token per request. For an integration that should act as the account rather than a user, a Server-to-Server OAuth app and the OAuth recipe in `references/scripting.md` under "OAuth without a bespoke connector" is the route; the connector's own flow does not do it.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. Zoom's refresh tokens are long-lived and rotated by the platform; a connector stops working when the app's secret is regenerated in the Marketplace, when the app is deleted, or when the authorizing user's account is deactivated. A user-managed app that has not been published works only for users in the developer's own account; publishing it is a Marketplace review, which is why the dialog steers to user-managed.

## Known differences from the dialog

- The dialog says "Build app"; Zoom's menu reads "Build an app".
- The dialog does not mention "OAuth allow lists", which Zoom now requires alongside the redirect URL.
- Zoom generates separate development and production credentials; the dialog wants the ones matching where the app is activated, which for an unpublished app is development.

## Verify before trusting

The scopes against the integration's calls; which credential set (development or production) was copied; and that the authorizing user is in the same Zoom account as the app, since an unpublished app refuses everyone else.
