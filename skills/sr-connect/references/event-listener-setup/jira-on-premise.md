# Jira On-Premise

Jira Data Center. Listener type ADMIN_WEBHOOK, 42 event types. Snapshot 2026-09-14 from the web application's setup dialog, which it shares with Confluence On-Premise and Jira Service Management On-Premise, cross-checked the same day against https://confluence.atlassian.com/adminjiraserver/managing-webhooks-938846912.html (Data Center 11.3) and https://developer.atlassian.com/server/jira/platform/webhooks/. Siblings: `jira-service-management-on-premise.md`, `confluence-on-premise.md`.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`, the instance. `connectionRequired` is false. The instance must be able to reach the webhook URL on the internet; a Data Center behind a firewall needs egress, and the skill's note on inbound traffic to SRC applies.

## Deep links

Off `baseUrl` with the trailing slash removed:

- Webhooks: `<baseUrl>/plugins/servlet/webhooks`. Documented as "Administration", "System", then "WebHooks" under "Advanced", or the quick search for "webhooks".
- Workflows, for Issue Transitioned: `<baseUrl>/secure/admin/workflows/ListWorkflows.jspa`.

Needs Jira administrator rights.

## Steps

1. Open the webhooks page, "Create a webhook".
2. "Name" it. Paste the webhook URL into "URL".
3. Scope: "All issues" or a JQL query; see Filter.
4. Tick only the event the listener was created for. Leave "Exclude body" unticked.
5. Leave authentication unset, on Data Center 11.0 and later where it is offered; see Secure it.
6. "Create".

Issue Transitioned is a post-function delivery, not an event. After step 6 with no event ticked: "Workflows", "Edit", select the transition, "Post functions", "Add post function", "Trigger a Webhook", "Add", select the webhook, "Add", repeat per transition, then "Publish". A webhook that is both ticked for issue events and on a post function fires twice per transition.

Since Data Center 10.0 webhooks are delivered asynchronously only; nothing to configure.

## Filter on the app side

JQL on the webhook. The Data Center docs list no per-event exclusions, unlike Cloud, but sprint and version events carry no issue to filter on, so expect them to fire regardless. In the script, check `issue.fields.project.key` and `webhookEvent` against parameters.

## Secure it

Data Center 11.0 and later offer two methods under "Securing your webhook": a secret token, which makes Jira sign every request with `X-Hub-Signature` as `sha256=` and the hex HMAC-SHA256 of the body, and basic authentication, an `Authorization: Basic` header. Data Center 9.12 and 10.x have neither. Neither header reaches the script, which receives the body only, and the platform does not check them for this app; leave both unset and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`, so a script behind one verifies the signature or the credentials against masked TEXT parameters, or checks the instance's egress address. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

- The dialog says nothing about the JQL scope or about authentication. Both are on the form, authentication on 11.x.
- The dialog spells "Create a WebHook"; the Data Center docs say "Create a webhook".
- The dialog's last step for Issue Transitioned reads "Publish"; the developer docs do not mention publishing at all, and a draft workflow does not run until it is published, so the dialog is right.

## Verify before trusting

The instance's version, which decides whether the authentication methods exist at all; the servlet path, which the docs never print; and whether the instance allows outbound HTTP to the webhook host.
