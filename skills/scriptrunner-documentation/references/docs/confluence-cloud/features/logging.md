# Logging

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-a2ba73ce-a779-4b53-b730-b6ccc676d514-dc3f0aab1e1699c1
- Source: https://docs.adaptavist.com/sr4cc/latest/features/logging

Learn about script logs and how they are useful.

Logging in scripts is very helpful when debugging. In Cloud scripts, anything printed to `stdout` using `println`, or using a [logger.info](http://logger.info/) ( `'message'`) call will be available in the [Script Logs](logging/script-logs.md) page, and in the execution history of script listeners and script jobs. As noted above, usage of assertions can also help debugging and diagnosing the behaviour of scripts.
