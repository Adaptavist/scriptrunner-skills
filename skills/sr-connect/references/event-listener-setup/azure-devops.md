# Azure DevOps

Listener type WEBHOOK, 1 event type: "Azure DevOps Event via an Outgoing Webhook". Snapshot 2026-09-14 from the web application's setup dialog, cross-checked the same day against https://learn.microsoft.com/en-us/azure/devops/service-hooks/services/webhooks?view=azure-devops and https://learn.microsoft.com/en-us/azure/devops/service-hooks/events?view=azure-devops.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`. An Azure DevOps connector records no host, so `connector get` reports no `baseUrl`; the link below needs the organization and project names from the user. `connectionRequired` is false.

One SRC event type covers every Azure DevOps event. Which event actually arrives is decided on the Azure DevOps side in step 4, so the block must say which trigger the user should pick, and the script must check `eventType`.

## Deep links

`https://dev.azure.com/<organization>/<project>/_settings/serviceHooks`. Without the names: "Project settings", "Service hooks".

## Steps

1. Open the project's "Service hooks" page.
2. "+" or "Create subscription".
3. On the "Service" screen select "Web Hooks", "Next".
4. On the "Trigger" screen pick the event the integration wants, for example "Code pushed", "Pull request created", "Work item updated" or "Build completed", and set its filters; see Filter. "Next".
5. On the "Action" screen paste the webhook URL into "URL". Leave "Basic authentication credentials" and "HTTP headers" empty; see Secure it. Leave "Resource details to send", "Messages to send" and "Detailed messages to send" at their defaults unless the script needs less; "All" resource details is what the event library's types describe.
6. "Test" sends a sample delivery; check `log list-invocation-logs` for it. "Finish".

## Filter on the app side

Rich, and per trigger. Code pushed: repository, branch, pushed by. Pull request created, updated, merged: repository, branch, created by, reviewers contain, and for updated the change type. Work item created, updated, deleted, restored, commented: area path, work item type, tag; updated adds changed fields and links changed; commented adds a comment pattern. Build completed: build definition name, build status. Release and pipeline events: definition, environment, stage, state. Set every filter the integration allows; one subscription per trigger, so an integration wanting two events registers two subscriptions to the same webhook URL.

In the script, check `eventType` (`git.push`, `git.pullrequest.created`, `workitem.updated`, `build.complete` and so on) and the resource's identity, `resource.repository.name` or `resource.fields["System.AreaPath"]`. The vendor filter is what a project admin can loosen later.

## Secure it

Service hooks sign nothing. The "Action" screen offers "Basic authentication credentials", sent as an `Authorization: Basic` header over HTTPS, and "HTTP headers", one `key:value` per line, readable by anyone who can open the subscription. Neither reaches the script: an Azure DevOps listener receives the body only, and the platform does not check headers for this app. Set nothing there and add no check. Hardening is possible through a Generic listener, which receives headers and `sourceIp`, so a script behind one can compare a header against a masked TEXT parameter or check the sender against the ranges Microsoft publishes at https://learn.microsoft.com/en-us/azure/devops/organizations/security/allow-list-ip-url?view=azure-devops. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

- The dialog says "Organisation Settings", then "projects", then the project, then "service hooks". The current docs go straight to "Project settings", "Service hooks". Both land on the same page.
- The dialog mentions no authentication and no headers. Both are on the "Action" screen.
- The dialog never names the event, since SRC has one event type here; the block must.

## Verify before trusting

The filter names for the trigger the user picks, and the "Action" screen labels. Microsoft renames these fields occasionally; the event list URL above is the authority for `eventType` values and payload shapes.
