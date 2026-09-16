# Replay Script Invocations

- Platform: connect
- Space: SRC
- Hierarchy: Observability > Script Invocation Logs
- Doc ID: doc-src-137cd030-6540-4c91-932c-27c1323669d8-15f3ce8af78cbb76
- Source: https://docs.adaptavist.com/src/latest/observability/script-invocation-logs#replay-script-invocations--en

Learn about the Replay button, allowing you to re-run a desired script.

On the _Script Invocation Logs_ page, each script invocation that was triggered by an event payload (excluding manually triggered and scheduled scripts) has a Replay button, which allows you to re-run the script using the same event payload.

1.  When you click Replay, you will be redirected to the appropriate workspace and environment where the script invocation was originally triggered.
    
    A modal will appear with the event payload that you're about to re-trigger, allowing you to review and modify it before you replay.
    
2.  When you're satisfied with the payload, click Trigger to kick off a new script invocation with the event payload.

Warning: Limitations 🚨

-   You cannot replay a script that no longer exists in the target environment.
-   You can replay events with payloads up to 4MB.
-   Invocations that occurred prior to the release of the replay feature, 30 January 2024, cannot be replayed.
