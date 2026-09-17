# GitLab

Listener type WEBHOOK, 13 event types. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://docs.gitlab.com/user/project/integrations/webhooks/ and https://docs.gitlab.com/user/project/integrations/webhook_events/.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the GitLab instance the connector was authorized against, `https://gitlab.com` or a self-managed host. `connectionRequired` is false.

## Deep links

Off `baseUrl` with the trailing slash removed:

- A project's webhooks: `<baseUrl>/<group>/<project>/-/hooks`
- A group's webhooks: `<baseUrl>/groups/<group>/-/hooks`, on the Premium and Ultimate tiers

Without a base URL: "Settings", "Webhooks" in the project's or group's left sidebar.

## Steps

1. Open the project or group. Group webhooks fire for every project in the group and its subgroups; a project webhook for that project alone. Maintainer or Owner on a project, Owner on a group.
2. Left sidebar, "Settings", "Webhooks", "Add new webhook".
3. Paste the webhook URL into "URL". A "Name" and "Description" are optional and worth filling.
4. Leave "Signing token" and "Secret token" empty; see Secure it.
5. Under "Trigger" tick only the event the listener was created for. For "Push events" a branch filter appears; see Filter.
6. Leave "Enable SSL verification" ticked. "Add webhook".
7. The new row offers a "Test" dropdown, one entry per event type, which sends a sample delivery; push needs at least one commit in the project. Use it to see the payload land in `log list-invocation-logs`.

## Filter on the app side

Scope by registering on one project rather than the group. Push events take a branch filter: "All branches", "Wildcard pattern" (`*-stable`, `production/*`) or "Regular expression" (RE2). No other event has a branch filter. Every body carries `object_kind` (`push`, `merge_request`, `note`, `issue`, `pipeline`, `tag_push`) and `project.path_with_namespace`; the script checks those, and `object_attributes.action` where the integration wants one transition of a merge request or issue. The `X-Gitlab-Event` header GitLab also sends does not reach the script.

## Secure it

Two mechanisms, and both can be on at once.

- "Signing token", the one GitLab recommends since 19.1: "Generate signing token", shown once. GitLab then sends `webhook-id`, `webhook-timestamp` and `webhook-signature` headers following the Standard Webhooks specification; the signature is `v1,<base64>` of the HMAC-SHA256 over `<webhook-id>.<webhook-timestamp>.<body>` keyed with the token after its `whsec_` prefix is base64-decoded.
- "Secret token", marked "(not recommended)": a value you type, sent back verbatim in `X-Gitlab-Token` on every delivery.

Neither header reaches the script, which receives the body only, and the platform does not check them for this app; leave both empty and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: a script behind one compares the secret token with `===` against a masked TEXT parameter, or verifies the signing token's HMAC with `crypto.subtle`. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. A self-managed GitLab older than 19.1 offers the secret token only.

## Known differences from the setup dialog

- The dialog mentions no secret token, no signing token and no branch filter. All three exist; the two tokens change nothing for this listener type.
- The dialog says the URL field is "URL" and the button "Add new webhook", which match the docs; it says "click Add webhook" to save, also correct.
- The dialog's fallback link is `https://www.gitlab.com`; the sign-in host is `https://gitlab.com`. Either resolves.

## Verify before trusting

The tier of the user's plan for group webhooks, the branch filter's three modes, and whether the instance is recent enough for the signing token. GitLab moves settings between releases; the sidebar path above is the one the current docs print.
