# Bitbucket Cloud

Listener type WEBHOOK, 20 event types: repository push, fork, updated, commit comment and build status, issue and pull request events. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://support.atlassian.com/bitbucket-cloud/docs/manage-webhooks/ and https://www.atlassian.com/blog/bitbucket/enhanced-webhook-security.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. A Bitbucket Cloud connector records no host, so `connector get` reports no `baseUrl`; the link below needs the workspace and repository names from the user. `connectionRequired` is false.

## Deep links

`https://bitbucket.org/<workspace>/<repository>/admin/webhooks`. Without the names: the repository, "More actions" (the three dots beside its name), "Settings", then "Webhooks" under "Workflow".

## Steps

1. Open the repository's webhooks page, "Add webhook". Up to 50 per repository.
2. "Title" it after the integration.
3. Paste the webhook URL into "URL".
4. "Secret": "Generate secret" or type one; see Secure it. It is not shown again after saving.
5. Leave "Active" ticked and "Skip certificate verification" unticked.
6. Under "Triggers" tick only the event the listener was created for. The default is "Repository push".
7. "Save".

Workspace-level webhooks, firing for every repository in the workspace, exist but cannot be created in the UI; `POST https://api.bitbucket.org/2.0/workspaces/<workspace>/hooks` through the Bitbucket Cloud API connection does it, with the same fields.

## Filter on the app side

The repository, and the trigger selection. No branch or path filter on a webhook. In the script, check `repository.full_name` against a parameter, and for push events walk `push.changes[].new.name` for the branch. The body's top-level key says which event arrived, `push`, `pullrequest`, `issue` or `commit_status`; the listener receives the body only, so the `X-Event-Key` header Bitbucket also sends is not available.

## Secure it

Bitbucket offers a secret, since October 2023, and signs every delivery with it: `X-Hub-Signature` is `sha256=` and the hex HMAC-SHA256 of the raw body. A Bitbucket Cloud listener receives the body only and the platform does not check the header for this app, so the secret goes unverified; leave the field empty rather than suggest protection that is not there, and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: a script behind one verifies the signature with `crypto.subtle` against a masked TEXT parameter, or checks the sender against Atlassian's ranges at https://ip-ranges.atlassian.com/. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. Delivery history and retries are visible under the webhook's "View requests" once "Enable history" is on.

## Known differences from the setup dialog

- The dialog says "Repository settings"; the current UI is "More actions", "Settings". Same page.
- The dialog does not mention the "Secret" field. It has existed since 2023, and for this listener type it changes nothing.
- The dialog says "Then click Save", which matches.

## Verify before trusting

The workspace and repository names, and whether the user wants one repository or the whole workspace.
