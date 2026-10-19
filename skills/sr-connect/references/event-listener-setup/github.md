# GitHub

Listener type WEBHOOK, 70 event types. Snapshot 2026-10-14 from the web application's setup dialog, whose labels were checked against GitHub's repository and organization webhook forms, GitHub App settings and Sponsors pages on 2026-10-14 after the dialog's GitHub App and Sponsors steps were aligned with them; earlier cross-check 2026-09-14 against https://docs.github.com/en/webhooks/using-webhooks/creating-webhooks and https://docs.github.com/en/webhooks/webhook-events-and-payloads.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A GitHub connector records no host, so `connector get` reports no `baseUrl` and there is no deep link to build; the links below are GitHub's own pages, and the user picks the repository or organization on them. `connectionRequired` is false: the listener works without a connector.

## Where the webhook goes

The same SRC event type can be registered at up to six places on GitHub, and the payload differs slightly between them. Ask which one the user means before writing the block, or list the ones that apply. The event's own documentation page says which scopes carry it under "Availability".

| Scope        | Where                                                                                    | Direct URL when the name is known                       |
| ------------ | ---------------------------------------------------------------------------------------- | ------------------------------------------------------- |
| Repository   | Repository, "Settings", "Webhooks", "Add webhook"                                        | `https://github.com/<owner>/<repo>/settings/hooks`      |
| Organization | Profile picture, "Your organizations", "Settings", "Webhooks", "Add webhook"             | `https://github.com/organizations/<org>/settings/hooks` |
| Enterprise   | The enterprise, "Settings", "Hooks", "Add webhook" (GitHub Enterprise Cloud only)        | `https://github.com/enterprises/<slug>/settings/hooks`  |
| GitHub App   | Profile picture or organization, "Settings", "Developer settings", "GitHub Apps", "Edit" | `https://github.com/settings/apps/<app>`                |
| Marketplace  | `https://github.com/marketplace/manage`, "Manage listing", "Webhook"                     | one webhook per app                                     |
| Sponsors     | Profile picture, "Sponsors", "Dashboard", "Webhooks", "Add webhook"                      |                                                         |

## Steps

Repository, organization and enterprise:

1. Open the webhooks page for the scope, "Add webhook".
2. Paste the webhook URL into "Payload URL".
3. "Content type": choose `application/json`. The other choice wraps the JSON in a form field called `payload` and the script would have to unwrap it.
4. Leave "Secret" empty; see Secure it below.
5. Under "Which events would you like to trigger this webhook?" pick "Let me select individual events" and tick only the event the listener was created for. The checkbox reads exactly the SRC event name, plurals included ("Pushes", "Issues"); see Event names below for the exceptions.
6. Leave "Active" ticked. "Add webhook".
7. GitHub sends a `ping` at once. The listener receives it; the script must ignore it (see Filter).

GitHub App:

1. Open the app, "Edit". Under "Webhook" tick "Active", paste the webhook URL into "Webhook URL", optionally set "Webhook secret". "Save changes".
2. In the left menu open "Permissions & events". Grant the permission the event needs; the event's documentation page names it. Without the permission the event is not offered.
3. Under "Subscribe to events" tick only the event the listener was created for; this list uses GitHub's short names, see Event names below. `installation`, `installation_repositories`, `github_app_authorization` and `ping` are delivered to every app and cannot be unticked; the script ignores them.
4. "Save changes", or "Create GitHub App" for a new app, which must then be installed on an account or organization before it receives anything.

Marketplace: the form has "Payload URL", "Content type", "Secret" and "Active" and no event picker. It delivers every Marketplace event, so the script keeps only the one it is for. The webhook cannot be deleted, only deactivated by unticking "Active".

Sponsors: "Add webhook", "Payload URL", "Content type" `application/json`, "Active", "Add webhook". No event picker; the script filters on `action`. An account that has not joined GitHub Sponsors shows "Get sponsored" on the Sponsors page instead of "Dashboard", and has no webhooks to configure.

## Event names

On the repository, organization and enterprise forms the checkbox reads exactly the SRC event name, checked label by label on 2026-10-14 (47 of 47 on the repository form, 53 of 54 on the organization form, 10 of 11 on the enterprise form). The one exception is "Team", which the organization and enterprise forms label "Teams"; the dialog shows "Teams" for those two scopes. Three SRC event types, "Projects", "Project cards" and "Project columns", are on no GitHub form any more, since GitHub retired classic projects; the Projects v2 events that replaced them are offered on the organization form and the GitHub App page only. The web application does not offer the three for a new event listener; an existing listener keeps its type but never fires. The GitHub App page's "Subscribe to events" list uses GitHub's machine names, singular ("Push", "Fork", "Label"), and four differ in word as well: "Create" is "Branch or tag creation" (GitHub's `create` event), "Delete" is "Branch or tag deletion" (`delete`), "Gollum" is "Wiki" (`gollum`), "Member" is "Collaborator" (`member`); each has a one-line description under it. The dialog gives the App-page name where it differs. When the name is not on the checkbox list, look it up at https://docs.github.com/en/webhooks/webhook-events-and-payloads and tick the event whose description matches. GitHub puts the event's machine name in the `X-GitHub-Event` header and nowhere in the body, and the listener receives the body only, so the script tells events apart by shape: a `ping` body has `zen` and `hook_id`, an `installation` body has no `repository`, and most others carry `action`.

## Filter on the app side

Only the event selection. GitHub offers no branch, path or repository filter on a webhook; scoping is where you register it, one repository or the whole organization. In the script, return early on a body with `zen` in it, which is the `ping`, and for an organization webhook check `repository.full_name`. Most events also carry `action`, which splits one event into several, `opened` against `closed` on `pull_request` for one; check it when the integration wants only some.

## Secure it

GitHub offers a "Secret" and signs every delivery with it: `X-Hub-Signature-256` is `sha256=` followed by the hex HMAC-SHA256 of the raw body. The header does not reach the script, which receives the body only, and the platform does not check it for this app; leave "Secret" empty rather than suggest protection that is not there, and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: a script behind one checks the sender against the `hooks` ranges at https://api.github.com/meta. It cannot verify the signature, because the Generic listener parses the JSON body, so the signed bytes never reach the script. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

- The dialog never mentions the "Secret" field. GitHub has offered it on every scope for years; for this listener type it changes nothing.
- The dialog names the enterprise menu "Hooks", which matches the docs.
- The dialog says a Marketplace webhook is one per listing; the docs say one per app.

## Verify before trusting

The scope URLs above, the "Content type" wording, the checkbox label for the event in question, and whether the App permission the event needs has changed. GitHub reorganizes settings pages more often than the other apps here.
