# Jira Service Management Cloud

Listener type ADMIN_WEBHOOK, 40 event types. A Jira Service Management Cloud site is a Jira Cloud site: the webhooks page, the fields, the JQL filter, the secret and the workflow rule that fires Issue Transitioned are the same as in `jira-cloud.md`, and everything there applies. Snapshot 2026-09-14 from the web application's setup dialog, rechecked 2026-10-08 against the dialog's source, and cross-checked on 2026-09-14 against https://confluence.atlassian.com/servicedeskcloud/managing-webhooks-1097175852.html and https://developer.atlassian.com/cloud/jira/platform/webhooks/. Sibling: `jira-cloud.md`; a fix there is a fix here.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`, the site. `connectionRequired` is false. The webhook secret, if used, is saved only at `setupUrl`.

## Deep links

- Webhooks: `<baseUrl>/plugins/servlet/webhooks`
- Workflows, for Issue Transitioned: `<baseUrl>/jira/settings/issues/workflows`

## What differs from Jira Cloud

- There are no service-management-specific webhook events. Requests are issues: a request created fires "Issue Created", a request transitioned fires through the workflow rule, an SLA breach fires nothing. Approvals, customer comments and portal actions arrive as issue updates and comment events; the script tells them apart by the fields (`fields.customfield_*` for request type, `comment.jsdPublic` for a customer-visible comment).
- Legacy JSM automation is not offered on sites created on or after 30 August 2021, and Atlassian is retiring it on the older ones. Where it is still present its "Then do this" list has a "Webhook" action that POSTs to a URL. Its successor is Atlassian Automation, whose "Send web request" action does the same with a shaped payload. Both reach a Generic listener and neither is this listener type; check which automation the site actually has before sending anyone to either.
- The dialog's fallback URL placeholder reads `[YOUR_JIRA_SERVICE_MANAGEMENT_CLOUD_INSTANCE]` where Jira Cloud's reads `[YOUR_JIRA_CLOUD_INSTANCE]`. Both dialogs link the same webhooks and workflows paths and give the same steps, numbered alike.

## Filter on the app side

JQL on the webhook: `project = SD AND "Request Type" = "Get IT help"` narrows to one request type; `project = SD` to the service project. Same event restrictions as Jira Cloud. In the script, check `issue.fields.project.key` and the request type field against parameters.

## Secure it

As Jira Cloud: a secret on the webhook, the same value in the setup dialog, `X-Hub-Signature` verified by the platform.

## Known differences from the setup dialog

The Jira Cloud list.

## Verify before trusting

As Jira Cloud, plus the custom field ID for the request type on the user's site, which differs per site.
