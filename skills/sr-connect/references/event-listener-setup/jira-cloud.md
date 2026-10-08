# Jira Cloud

Listener type ADMIN_WEBHOOK, 49 event types. Snapshot 2026-09-14 from the web application's setup dialog, rechecked 2026-10-08 against the dialog's source after a change that moved Issue Transitioned to Jira's new workflow editor, and cross-checked on 2026-09-14 against https://developer.atlassian.com/cloud/jira/platform/webhooks/ and https://support.atlassian.com/jira-cloud-administration/docs/manage-webhooks/. Jira Service Management Cloud uses the same webhooks page and has its own file, which differs from this one in two lines.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`, the site, `https://<site>.atlassian.net`. `connectionRequired` is false, but a connector is what gives you the site to link into.

The webhook secret is optional and, if used, can only be saved in the web application's setup dialog at `setupUrl`. The CLI cannot store it.

## Deep links

Off `baseUrl` with the trailing slash removed:

- Webhooks: `<baseUrl>/plugins/servlet/webhooks`. Atlassian documents the menu path only, "Settings", "System", then "WebHooks" under "Advanced"; the servlet URL is what the menu opens.
- Workflows, for Issue Transitioned only: `<baseUrl>/jira/settings/issues/workflows`. The older `<baseUrl>/secure/admin/workflows/ListWorkflows.jspa` redirects there.

Needs the Administer Jira global permission.

## Steps

1. Open the webhooks page, "Create a webhook".
2. "Name" it after the integration.
3. Paste the webhook URL into "URL". HTTPS only, which it is.
4. "Secret": see Secure it. "Generate secret" makes one; the same value goes into the setup dialog.
5. Under "Issue related events" enter the JQL filter; see Filter. The dialog calls this step optional.
6. Tick only the event the listener was created for. Leave "Exclude body" unticked; the script needs the body.
7. "Create".

Issue Transitioned is not a Jira event. The webhook is fired by a workflow rule on the transition, and the SRC event type exists for that delivery. After step 7, with no event ticked in step 6:

8. Open "Workflows", "Edit" next to the workflow.
9. Select the transition, then "Add rule".
10. Under "Perform actions", select "Trigger a webhook".
11. Under "Use this webhook", pick the webhook from the dropdown, "Add". Repeat steps 9 to 11 for every transition that should fire the listener.
12. "Update workflow".

These are the labels of Jira's new workflow editor. The old editor called the same thing a post function: "Post functions" in the properties panel, "Add post function", "Trigger a Webhook", "Add", select the webhook, "Add", then "Publish Draft". If the user sees those labels, follow them; the result is the same.

A webhook that both has issue events ticked and is triggered by a workflow rule fires twice for one transition, once per mechanism. Keep the two on separate webhooks, and so separate listeners.

## Filter on the app side

JQL on the webhook, the "Issue related events" filter: `project = ACME`, `project in (ACME, OPS) AND issuetype = Bug`. Operators are limited to `=`, `!=`, `IN`, `NOT IN`. It applies to issue, comment, worklog, attachment and issue property events, and not to sprint, board or version events, which fire for the whole site whatever the filter says. A webhook triggered by a workflow rule is scoped by the workflow it sits in, and the JQL applies too. In the script, check `issue.fields.project.key` against a parameter and `webhookEvent` against the event you expect; a webhook with several events ticked delivers all of them to one URL.

## Secure it

Set a secret. Jira then signs every delivery: `X-Hub-Signature` is `sha256=` followed by the hex HMAC-SHA256 of the raw body. Paste the same secret into the setup dialog at `setupUrl`, "Secret", "Save changes". The platform checks every delivery against it before the script runs; no further action is needed, and nothing goes in the code.

## Known differences from the setup dialog

- The dialog calls the JQL filter optional. It is the one vendor-side filter Jira offers, so recommend it whenever the integration cares about some projects or issue types and not the whole site.
- For Issue Transitioned the dialog skips the event step without saying to leave the event list empty; ticking issue events on a webhook that a workflow rule triggers doubles the deliveries.
- The dialog spells "Create a WebHook"; Jira's current UI reads "Create a webhook".
- The dialog does not say that the secret is verified; the platform verifies it.

## Verify before trusting

The workflow page path, which Atlassian moved once already, and the workflow editor's labels, which changed with the new editor; the event's label in the checkbox list, which uses Atlassian's names ("Issue" then "created") rather than SRC's; and whether the site's admin has the permission.
