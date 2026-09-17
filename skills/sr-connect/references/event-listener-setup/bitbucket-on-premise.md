# Bitbucket On-Premise

Bitbucket Data Center. Listener type WEBHOOK, 20 event types: push, modified, forked, commit comments, pull request events, mirror synchronized. Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://confluence.atlassian.com/bitbucketserver/manage-webhooks-938025878.html (Data Center 10.4) and https://confluence.atlassian.com/bitbucketserver/event-payload-938025882.html.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`, the instance. `connectionRequired` is false.

## Deep links

Off `baseUrl` with the trailing slash removed:

- Projects: `<baseUrl>/projects`
- A repository's webhooks: `<baseUrl>/projects/<KEY>/repos/<slug>/settings/hooks`
- A project's webhooks, inherited by every repository in it, since Data Center 8.8: `<baseUrl>/projects/<KEY>/settings/hooks`

## Steps

1. Open "Repository Settings", "Webhook" (or "Project Settings", "Webhook" for the whole project), "Create webhook".
2. "Title" it. Paste the webhook URL into "URL".
3. Authentication: optional, "Secret token" or "Basic authentication"; see Secure it.
4. Leave SSL/TLS certificate verification on.
5. Under "Webhook events" tick only the event the listener was created for.
6. "Test connection" sends a diagnostic request; the listener answers, and the script should ignore it. Its body is `{"test": true}` by third-party reports, not Atlassian's docs.
7. Leave "Active" on. "Create".

## Filter on the app side

The project or repository, and the event selection. No branch filter. Each body carries `eventKey` (`repo:refs_changed`, `pr:opened`, `pr:merged`) at the top level; the script checks it, drops a body with no `eventKey` such as the test request, and checks `repository.project.key` and `repository.slug` against parameters, which matters for a project-level webhook.

## Secure it

Bitbucket offers two methods: "Secret token", which signs every request with `X-Hub-Signature` as `sha256=` and the hex HMAC-SHA256 of the body, and "Basic authentication", an `Authorization: Basic` header. Neither reaches the script, which receives the body only, and the platform does not check headers for this app; leave the method unset and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`, so a script behind one verifies the signature or the credentials against masked TEXT parameters, or checks the instance's egress address. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

- The dialog says "Name"; Bitbucket says "Title".
- The dialog mentions no authentication; the form offers secret token and basic authentication.
- The dialog walks from "Projects" into a repository; a project-level webhook has been available since 8.8 and saves a webhook per repository.
- The dialog says nothing about the test request; a script that treats it as a push will misbehave once.

## Verify before trusting

The instance's version against the 8.8 floor for project webhooks, and the test request's body on a real "Test connection".
