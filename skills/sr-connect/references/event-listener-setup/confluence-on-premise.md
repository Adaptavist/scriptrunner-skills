# Confluence On-Premise

Confluence Data Center. Listener type WEBHOOK, 43 event types: attachment, blog, comment, label, page, space and user events. Snapshot 2026-09-14 from the web application's setup dialog, the shared Atlassian On-Premise one, cross-checked the same day against https://confluence.atlassian.com/doc/managing-webhooks-1021225606.html (Data Center 10.2) and the Confluence 7.7 release notes. Siblings: `jira-on-premise.md`, `jira-service-management-on-premise.md`.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`, the instance. `connectionRequired` is false. Webhooks exist since Confluence 7.7 (August 2020); an older instance has none.

## Deep links

`<baseUrl>/plugins/servlet/webhooks`, with the trailing slash removed from the base. Documented as "Administration", "General Configuration", "Webhooks". Needs Confluence Administrator or System Administrator.

## Steps

1. Open the webhooks page, "Create a webhook".
2. Enter a "title".
3. Paste the webhook URL into "URL".
4. Leave "secret" empty; see Secure it.
5. "Test connection" sends a request to the URL; the listener answers.
6. Tick only the event the listener was created for.
7. Tick "Active". "Create".

## Filter on the app side

Event selection only. No space or CQL scoping exists; a `page_updated` webhook fires for every page on the instance. The payload is deliberately minimal, IDs rather than names or titles, so the script fetches what it needs through the Confluence On-Premise API connection and then checks the space key against a parameter before doing anything else. The vendor side offers nothing narrower.

## Secure it

Confluence offers a secret and signs every request with it, `X-Hub-Signature` as `sha256=` and the hex HMAC-SHA256 of the body, since the feature's first release. The header does not reach the script, which receives the body only, and the platform does not check it for this app; leave the field empty and add no check. The listener is therefore unauthenticated: its URL's secrecy is the only control, and anyone who learns the URL can post a body carrying the fields the script reads and trigger whatever it does. Say that in the handoff block and let the user decide whether it is acceptable for this integration. Hardening is possible through a Generic listener, which receives headers and `sourceIp`, so a script behind one verifies the signature with `crypto.subtle` against a masked TEXT parameter. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. After five consecutive delivery failures Confluence pauses the webhook, for ten seconds at first and up to ten hours; that counts deliveries the platform never answered, not script outcomes, since the listener acknowledges before the script runs and an exception in it is invisible to Confluence. Confluence documents no shape for the "Test connection" request and the listener hands the script the body alone, so do not try to recognise the test request itself: narrow on the fields the integration needs and return early when they are absent, which covers the test request and anything else unexpected.

## Known differences from the setup dialog

- The dialog says "Name"; Confluence says "title".
- The dialog does not mention the secret, "Test connection" or "Active". All three are on the form; the secret has been there since 7.7 and changes nothing for this listener type.
- The dialog's "Issue Transitioned" branch belongs to Jira and cannot appear for Confluence.

## Verify before trusting

The instance's version against the 7.7 floor, and whether the instance can reach the webhook host.
