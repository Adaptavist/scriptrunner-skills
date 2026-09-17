# Trello

Authorized with an API key from a Trello Power-Up the user creates, and a token generated for that key, both typed into the dialog. No consent window of the platform's own and no choice of method. Snapshot 2026-09-15 from the web application's setup dialog, cross-checked the same day against https://developer.atlassian.com/cloud/trello/guides/rest-api/api-introduction/. Trello has no event listener type; events reach the platform through a webhook registered with Trello's API and pointed at a Generic listener, as `references/event-listener-setup/generic.md` describes.

## Before you hand over

`connector create --team <teamId> --app-id <id> --name <name> --api-connection-type-id <id>`, IDs from `app list`; no listener type exists to pass. Then `authorizationUrl`. The dialog records no host for this app, so expect `connector get` to report no `baseUrl` even once authorized (not read back from an authorized connector); the Trello workspace is not recorded, so ask. Creating a Power-Up needs a Trello workspace admin.

The key and token are saved through the web application alone; the public API has no field for them, so the CLI cannot finish this connector. The dialog at `authorizationUrl` is the only way.

## The dialog

"Configure Connector", steps "Create Power-Up in Trello", "Enter API Key", "Enter Token". Inputs: "API Key", "Token". Read-only, with a copy button: "New Power-Up or Integration" `ScriptRunner Connect`. The dialog notes "These credentials will be stored securely in our platform."

## Steps

1. Open `authorizationUrl`, sign in. "Create Power-Up in Trello". The dialog says "If you already have a Power-Up assigned to your workspace, skip the steps below and click next".
2. "Visit the Power-Ups page in Trello and click New." https://trello.com/power-ups/admin
3. "Copy the value below into the form.": the Power-Up's name, `ScriptRunner Connect`.
4. "Fill the rest of the form (Iframe connector URL is not necessary)." Trello asks for the workspace, an email, a support contact and an author; the iframe connector URL can stay empty.
5. "Click Create." "Next".
6. "Enter API Key": "If you don't have an API Key, generate one in the Power-Up API Key section." In the Power-Up's page that is the "API key" tab, "Generate a new API key". "Copy the API Key into the form below." "Next".
7. "Enter Token": "Generate a Token". The dialog links Trello's authorize URL for the key entered, with `expiration=never` and `scope=read,write,account`; Trello shows a consent page, "Allow", then the token. Sign in to Trello as the account the integration should act as before clicking. "Copy the Token into the form below." "Done".

## Saving

No callback and no window of the platform's. "Done" saves both values and the connector reads "Authorized". Read `connector get` back for `authorized: true`; there is no `baseUrl`, so confirm the workspace with the user.

## Fixed-key alternative through a Generic connector

None that fits for a Managed API. Trello's REST API takes the key and token as `key` and `token` query parameters on every request; a Generic connector adds headers and a base URL, not query parameters, so the Managed API on a Generic connection would have to carry both per call.

What does work without the dialog is the global `fetch` against `https://api.trello.com/1/...` with the key and token held as environment parameters — the token one a PASSWORD parameter — and appended per request:

```ts
const url = `https://api.trello.com/1/boards/${boardId}/cards?key=${EV.TRELLO_KEY}&token=${EV.TRELLO_TOKEN}`
const response = await fetch(url)
```

That gives up what a connector is for: no Managed API types, no shared authorization, and the credentials live in each environment's parameters instead of the connector. Take it when the user cannot create a Power-Up or wants the credentials per environment; otherwise the dialog is the way, and it is short.

## Expiry and re-authorization

The token generated through the dialog's link never expires (`expiration=never`). The connector stops working when the token is revoked under the Trello account's "Applications" settings, when the Power-Up is deleted, or when the key is regenerated; then the dialog again at `authorizationUrl` with new values.

## Known differences from the dialog

- The dialog says "generate one in the Power-Up API Key section"; Trello's current Power-Up admin has an "API key" tab with "Generate a new API key". Atlassian's documentation also describes a "Trello Auth" tab in some layouts.
- The dialog's token link names the application "Stitch It" in Trello's consent screen (`name=Stitch%20It`), the platform's former name. Same platform; the name is cosmetic.
- The dialog offers `read,write,account` scopes with no narrower choice; Trello's authorize URL accepts a subset, and a read-only integration could use `read` by editing the link, which the dialog does not suggest.

## Verify before trusting

Which Trello account is signed in at step 7, since every card change will carry that member's name; that the Power-Up belongs to the workspace whose boards the integration reads; and that the token was generated for the same key that was pasted.
