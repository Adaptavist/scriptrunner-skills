# Replay Script Invocations

- Platform: connect
- Space: SRC
- Hierarchy: observability > script-invocation-logs
- Doc ID: doc-src-227149270
- Source: https://docs.adaptavist.com/src/latest/observability/script-invocation-logs/replay-script-invocations

On the _Script Invocation Logs_ page, each script invocation that was triggered by an event payload (excluding manually triggered and scheduled scripts) has a **Replay** button, which allows you to re-run the script using the same event payload.

![](/src/files/latest/227149270/227149272/1/1706204545000/replay-invocation-button.png)

When you click **Replay**, you will be redirected to the appropriate workspace and environment where the script invocation was originally triggered. A modal will appear with the event payload that you're about to re-trigger, allowing you to review and modify it before you replay.

![](/src/files/latest/227149270/227149271/1/1706204767000/trigger-invocation.png)

When you're satisfied with the payload, click **Trigger** to kick off a new script invocation with the event payload.

**Limitations 🚨**

-   You cannot replay a script that no longer exists in the target environment.
-   You can replay events with payloads up to 4MB.
-   Invocations that occurred prior to the release of the replay feature, 30 January 2024, cannot be replayed.
