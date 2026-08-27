# Working Principle

- Platform: connect
- Space: SRC
- Hierarchy: get-started
- Doc ID: doc-src-194512646
- Source: https://docs.adaptavist.com/src/latest/get-started/working-principle

ScriptRunner Connect works by having five main constructs that work together:

-   [Workspaces](https://docs.adaptavist.com/src/latest/workspaces)
-   [Connectors](https://docs.adaptavist.com/src/latest/connectors)
-   [Scripts](https://docs.adaptavist.com/src/latest/scripting)
-   [API Connectors](https://docs.adaptavist.com/src/latest/workspaces/api-connections)
-   [Event Listeners](https://docs.adaptavist.com/src/latest/workspaces/event-listeners)

The following visual details how these pieces work together within the app:

![Diagram showing interaction between Jira and Slack via ScriptRunner Connect. Arrows illustrate the flow from event listening in Jira to API connection in Slack.](/src/files/latest/194512646/350603197/1/1743087011000/SRC+Working+Princible.jpg)

## Process breakdown

1.  The process begins with an external service emitting an event detected by event listeners in ScriptRunner Connect.
2.  Event listeners determine how to process incoming events, sometimes using a connector when necessary.   
    Once that's done, the listeners trigger the associated script.
3.  The scripts execute their code and typically import one or more API connections to communicate with external services.
4.  API connections then process the requests, substitute authentication headers, and call the APIs of the external services.  
    These calls can be returned to the originating service or any other required service(s).

**Manual script execution ⚙️**

For one-off tasks, you can trigger a script manually. In this use case, the first two steps in the chart are ignored.

## Demo
