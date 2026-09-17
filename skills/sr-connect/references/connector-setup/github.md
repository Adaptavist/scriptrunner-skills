# GitHub

Authorized in a browser through the platform's own GitHub app. No wizard and no choice: the user clicks "Authorize" and GitHub asks for consent. Snapshot 2026-09-15 from the web application's Manage connector dialog, cross-checked the same day against https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id> --listener-type-id <id>`, IDs from `app list`; the app has one of each. Then `authorizationUrl`. `connector get` reports no `baseUrl` for this app even once authorized; nothing records which GitHub account or organization the connector acts as, so ask.

## The dialog

The Manage connector dialog itself, with an "Authorize" button and a warning titled "Authorizing your GitHub connector": "Please keep in mind that if you already have an existing GitHub connector, you will be automatically authorized with the account you are currently signed in on GitHub website. If you want to use a different account, before creating a new connector please sign out on https://www.github.com". The same warning appears on the name screen when the connector is created in the web application, and the dialog rates the whole thing "Less than 1 minute".

That warning is the whole setup difficulty. GitHub remembers the consent given to the platform's app, so a second connector is authorized silently as whoever is signed in on github.com in that browser, without a consent screen. When the integration should run as a bot or service account, sign out of github.com first, or use a private window signed in as that account, then open `authorizationUrl`.

## Steps

1. In the browser that will authorize, make sure github.com is signed in as the account the integration should act as. Sign out first if it is not.
2. Open `authorizationUrl`, sign in to the platform, "Authorize".
3. A consent window opens on GitHub. On first consent GitHub lists the app's permissions and organizations; pick the organizations the integration needs access to, and "Authorize". An organization that requires approval for third-party apps shows "Request" instead, and an organization owner has to approve before the connector can reach its repositories.
4. The window closes and the connector reads "Authorized".

## After the callback

The consent window is closed by the web application after 100 seconds and the run is reported as "Authorization cancelled."; start "Authorize" again if it does. No further confirmation. Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the account with the user, or with one call through the API connection to `/user`.

## Fixed-key alternative through a Generic connector

A personal access token: github.com, "Settings", "Developer settings", "Personal access tokens", then "Fine-grained tokens" and "Generate new token" (a name, an expiry, the resource owner, the repositories, and per-permission read or write), or "Tokens (classic)" and "Generate new token (classic)" with scopes such as `repo`. Generic connector: base URL `https://api.github.com`, header `Authorization: Bearer <token>`, through `--input` as `generic.md` says. Build `GithubApi` from `@managed-api/github-sr-connect` on the Generic connection as `references/scripting.md` shows. Costs: the token expires on the date chosen (fine-grained tokens may allow no expiry, but an organization policy can forbid that), GitHub removes a token unused for a year, and the connector reads as Generic. The gain is repository-level and permission-level scoping, which the platform's app does not offer, and an organization that blocks third-party OAuth apps will often allow a fine-grained token.

## Expiry and re-authorization

Re-authorize at `authorizationUrl`. The dialog then warns, under "Reauthorizing your GitHub connector": "You will be automatically authorized with the account you are currently signed in on GitHub website. If you want to use a different account, before reauthorization please sign out on https://www.github.com". Revoking the platform's app under the user's GitHub "Applications" settings is what forces a fresh consent screen.

## Known differences from the dialog

- The dialog links `https://www.github.com`; github.com is where the sign-out happens, and the `www.` redirects there.
- GitHub's consent screen has changed shape more than once (organization access is now a list with "Grant" and "Request" per organization); the dialog does not describe it.

## Verify before trusting

Which account is signed in on github.com before "Authorize", every time; whether the organizations the integration needs have approved the app, since a repository in an unapproved organization answers 404 rather than 403; and, for the Generic alternative, that the fine-grained token names the right resource owner.
