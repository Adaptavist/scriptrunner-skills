# Atlassian Automation

What a script meets when an Atlassian Automation rule, in Confluence Cloud or Jira Cloud, is the sender: a rule whose "Send web request" action posts to a Generic listener's `webhookUrl`. Atlassian Automation is not an app in `app list`; it is the bridge that gives Confluence Cloud an event feed, as the Confluence Cloud bridge in `references/event-listener-setup/generic.md` describes. Load this file only when an Automation rule is part of the integration. Snapshot 2026-10-08, from one agent's build against Confluence automation; every item below was seen once and is worth a logged event before relying on it.

## The vendor API

What "Send web request" delivers, as seen from Confluence automation:

- A custom `Content-Type` header on the action is ignored; the request keeps `application/json`. Send a JSON body. A bare non-JSON body arrives anyway, with `bodyType` `'base64'` rather than `'text'`, so a script reading it needs `isBase64` and `convertBase64ToText` from `@sr-connect/convert`.
- `{{page.id}}` placed in the URL arrived in the query string with a trailing comma, `123456,`. Take the first run of digits; do not require an exact match.
- `{{comment.body}}` arrived as plain text with no markup. Atlassian's smart-value reference does not say which format it renders.
- Automation signs nothing. Put a shared secret in a custom header on the action and check it in the script against a masked TEXT parameter, with a case-insensitive header lookup as `references/scripting.md` shows.

## The Managed API

None. Writing back to Confluence or Jira goes through that app's API connection; load its own product file.

## Event types

The script receives the Generic listener's `HttpEventRequest` from `@sr-connect/generic-app/events/http`, and the body is whatever the rule built from smart values. Type it yourself from one logged request.

## Verify before trusting

Fire the rule once with the script logging `event.headers`, `event.queryStringParams`, `event.bodyType` and `event.body`, and read `log list-console-logs` before writing the parser. https://support.atlassian.com/cloud-automation/docs/actions-in-confluence-automation/ for the action's options.
