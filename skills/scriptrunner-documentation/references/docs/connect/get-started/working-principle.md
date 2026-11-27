# Working principle

- Platform: connect
- Space: SRC
- Hierarchy: Get Started
- Doc ID: doc-src-9dc0504d-4b7e-4861-81e8-049fd7d20cd0-76bdfc909b33ccdb
- Source: https://docs.adaptavist.com/src/latest/get-started#working-principle--en

Gain understanding as to how the app works.

ScriptRunner Connect works by having five main constructs that work together:

-   [Workspaces](../uncategorized/w/workspaces.md)
-   [Connectors](../uncategorized/c/connectors.md)
-   [Scripts](../uncategorized/s/scripting.md)
-   [API Connectors](https://docs.adaptavist.com/src/latest/workspaces/api-connections)
-   [Event Listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners)

The following visual details how these pieces work together within the app:

## Process breakdown

1.  The process begins with an external service emitting an event detected by event listeners in ScriptRunner Connect.
2.  Event listeners determine how to process incoming events, sometimes using a connector when necessary. Once that's done, the listeners trigger the associated script.
3.  The scripts execute their code and typically import one or more API connections to communicate with external services.
4.  API connections then process the requests, substitute authentication headers, and call the APIs of the external services. These calls can be returned to the originating service or any other required service(s).

Note: Manual script execution ⚙️

For one-off tasks, you can trigger a script manually. In this use case, the first two steps in the chart are ignored.

## Demo: Working principle

[Media](https://demo.arcade.software/tc0Dnq9AoZ4g8Vhy2YXe?embed&embed_mobile=tab&embed_desktop=inline)
