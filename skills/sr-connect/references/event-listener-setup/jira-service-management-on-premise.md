# Jira Service Management On-Premise

Jira Service Management Data Center. Listener type JSM_WEBHOOK, 33 event types. The events are Jira's, delivered by the same administration webhooks page as `jira-on-premise.md`, which applies in full; the dialog is the shared Atlassian On-Premise one with the product name swapped in. Snapshot 2026-09-14, cross-checked the same day against https://developer.atlassian.com/server/jira/platform/jira-service-desk-webhooks/ and the Jira Data Center pages named in the sibling. Siblings: `jira-on-premise.md`, `confluence-on-premise.md`.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl`, `setupUrl` and `connectorId`; `connector get <connectorId>` for `baseUrl`. `connectionRequired` is false. The connector is a Jira On-Premise connector; there is no separate one.

## Deep links

- Webhooks: `<baseUrl>/plugins/servlet/webhooks`
- Workflows: `<baseUrl>/secure/admin/workflows/ListWorkflows.jspa`

## What differs from Jira On-Premise

- The steps, the JQL filter and the security are those of `jira-on-premise.md`.
- Jira Service Management Data Center also has its own webhook, the "Webhook" THEN action in a project's legacy automation rules ("Project settings", "Automation"). It posts the issue payload or a custom JSON to a URL that the Jira administrator has allowlisted, filtered by the rule's WHEN and IF conditions, with no secret and no signature. It is a different mechanism from this listener type: point it at a Generic listener if the user wants the rule's shaping and conditions, not at this webhook URL.
- No service-management-specific events exist on the administration webhook; requests, approvals and customer comments arrive as issue and comment events and the script tells them apart by fields.
- The dialog's fallback placeholder reads `[YOUR_JIRA SERVICE MANAGEMENT_INSTANCE]`, with the product's spaces preserved; cosmetic.

## Filter on the app side

JQL on the webhook, `project = SD AND "Customer Request Type" = "Get IT help"` for one request type. In the script, check the project key and the request type field against parameters.

## Secure it

As Jira On-Premise: the secret token and basic authentication of Data Center 11.0 and later go unchecked, because the listener receives the body only and the platform does not check headers for this app. Leave them unset. Hardening through a Generic listener is possible; flag it at the end of the handoff block and build it only when the user asks, see Hardening in `cli-workflow.md`.

## Known differences from the setup dialog

The Jira On-Premise list.

## Verify before trusting

As Jira On-Premise, plus the request type custom field ID on the instance.
