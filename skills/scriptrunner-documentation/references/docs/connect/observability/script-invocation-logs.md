# Script Invocation Logs

- Platform: connect
- Space: SRC
- Hierarchy: observability
- Doc ID: doc-src-284099551
- Source: https://docs.adaptavist.com/src/latest/observability/script-invocation-logs

To browse historical script invocation logs, click **Reporting** \> **Script Invocation Logs**. You can use various filtering options to specify the logs you're interested in.

**Team-level history 🔻**

Logs are generated at the team level, so you only see invocation logs for the team you select from the main navigation.

For each invocation log, you can view console logs that were emitted during your script invocation. Currently, only logs that were emitted by calling `console.*`  functions are displayed.

To view the logs, click on the number in the _Logs_ column (if greater than zero). You can also view the [HTTP logs](https://docs.adaptavist.com/src/latest/observability/http-logs) by clicking on the number in the _HTTP Logs_ column (if greater than zero).

Use the [replay feature](https://docs.adaptavist.com/src/latest/observability/script-invocation-logs/replay-script-invocations) to replay a (failed) script invocation.

**Retention period ⏰**

ScriptRunner Connect keeps logs for six months, after which they are automatically deleted.

## Execution statuses

Below are the definitions for various execution statuses that you can use to filter script invocations:

-   **Finished**: Invocations that have completed successfully.
-   **Running**: Invocations that are currently in progress.
-   **Denied**: Invocations that have either exceeded their [quota](https://docs.adaptavist.com/src/latest/limits-and-quotas) or are linked to disabled triggers, such as disabled event listeners or scheduled triggers.
-   **Timed out**: Invocations that did not complete within 15 minutes (or 25 seconds for sync HTTP events in generic event listeners).
-   **Aborted**: Invocations that were aborted from the UI.
-   **Function Error**: Invocations that encountered a recoverable business logic error (an uncaught error that the user can address).
-   **Malformed Payload Error**: Invocations that returned unexpected responses. (This status is only used for sync HTTP events in generic event listeners).
-   **Runtime Error**: Invocations that encountered an unrecoverable system-level error.

## Trigger types

Below are the definitions of trigger types you can use to filter script invocations:

-   **Manual**: Invocations that were triggered manually from the UI.
-   **Manual Event Listener**: Invocations that were triggered manually from an event listener using a test event payload via the UI.
-   **External**: Invocations triggered externally (not from the UI) through event listeners.
-   **Chained**: Invocations [triggered programmatically](https://docs.adaptavist.com/src/latest/scripting/triggering-scripts).
-   **Scheduled**: Invocations triggered by a [scheduled trigger](https://docs.adaptavist.com/src/latest/workspaces/scheduled-triggers).
