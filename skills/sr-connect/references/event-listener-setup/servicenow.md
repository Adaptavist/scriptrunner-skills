# ServiceNow

Listener type WEBHOOK, 1 event type: "Generic Event". ServiceNow has no webhooks; the web application's setup dialog generates a server script that creates a REST Message and a Business Rule in the instance, and the Business Rule posts to the webhook URL. Snapshot 2026-09-14 from that dialog, cross-checked the same day against https://www.servicenow.com/docs/bundle/yokohama-api-reference/page/integrate/outbound-rest/task/t_ConfiguringARESTMessage.html, the RESTMessageV2 reference and the Business Rules concept page in the same docs bundle.

## Before you hand over

`event-listener get -e <env> <listenerId>` for `webhookUrl` and `setupUrl`; `connector get <connectorId>` for `baseUrl`, the instance, `https://<instance>.service-now.com`. `connectionRequired` is false.

The generator is only at `setupUrl`: it takes the table, the operations and the payload properties and produces the script. Hand the user that link for the generation; the steps below are what to choose in it and how to run the result.

## Deep links

Off `baseUrl`:

- Scripts - Background: `<baseUrl>/sys.scripts.modern.do` (older UI: `/sys.scripts.do`)
- REST Messages: `<baseUrl>/sys_rest_message_list.do`, or "All", "System Web Services", "REST Message"
- Business Rules: `<baseUrl>/sys_script_list.do`, or "All", "System Definition", "Business Rules"

## Steps

In the setup dialog:

1. "Table": the table whose records fire the listener, `incident` by default. Any table name works.
2. Operations: "Insert" is pre-ticked; add "Update", "Delete" or "Query" as the integration needs. Query is almost never wanted; it fires on every read.
3. "Parameters": the properties the payload will carry. The defaults are a title, the acting user's sys_id, the record's display value and its sys_id; "Add custom parameters" adds a property whose value is a server-side expression such as `current.short_description`. Add every field the SRC script will need.
4. "Generate script", copy the script.

In ServiceNow:

5. Open Scripts - Background. Paste the script, scope "global", "Run Script". It creates one REST Message with a POST method whose endpoint is the webhook URL and variable substitutions for the parameters, and one Business Rule on the table, running after the chosen operations, that fills the substitutions and calls `executeAsync()`.
6. Change a record of the table; the listener receives the event. The payload is the parameters as JSON plus `eventType: "generic_triggered"`.

Later changes: the REST Message's endpoint, headers and substitutions under "System Web Services", "REST Message", the POST method's "HTTP Request" tab and "Variable Substitutions"; the Business Rule's table, operations and conditions under "System Definition", "Business Rules", the "When to run" and "Advanced" tabs.

## Filter on the app side

The table and the operations are the coarse filter. The fine one is the Business Rule's own condition: open the rule, "When to run", add filter conditions on the table's fields, or tick "Advanced" and write a condition such as `current.priority == 1 && current.assignment_group.name == 'Service Desk'`. The generated rule has no condition, so it fires on every insert of the table; recommend adding one. In the SRC script, check the parameters that identify the record type and the field the integration hinges on against parameters; the platform's event is the JSON the rule posted.

## Secure it

Nothing in the generated script, and nothing to add for this listener type: a ServiceNow listener receives the body only, so a header on the REST Message would not reach the script, and the platform checks none. Run the generated script as it is. Hardening is possible through a Generic listener, which receives headers and `sourceIp`: the REST Message takes HTTP headers that apply to all its methods, so one such as `X-Webhook-Secret`, its value kept in a ServiceNow credential or system property, would be compared in the SRC script against a masked TEXT parameter. Flag that at the end of the handoff block and build it only when the user asks; see Hardening in `cli-workflow.md`. ServiceNow's outbound address ranges are published only behind the Now Support login.

## Known differences from the setup dialog

- The dialog's navigation path "System Web Services > Outbound > REST Message" has an "Outbound" level the current docs do not show; the list URL and the search box find it either way.
- `sys.scripts.modern.do` is the new Scripts - Background UI and is not in the docs, which name the module only; `sys.scripts.do` still opens the older one.
- The dialog describes the Business Rule's condition only under "How to update Business Rule (Advanced)"; it is the filter and belongs in the block.
- The dialog adds no header; the REST Message supports one, which matters only behind a Generic listener.

## Verify before trusting

The table name and its fields with the user, the REST Message list path in their release, and that the instance allows outbound REST to the webhook host; some instances restrict outbound calls by allowlist.
