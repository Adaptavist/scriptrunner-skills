# Logging

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features
- Doc ID: doc-sr4cc-c61aee81-95c2-48ab-9b98-d8f187781b15-dc3f0aab1e1699c1
- Source: https://docs.adaptavist.com/sr4cc/latest/features/logging

Learn about script logs and how they are useful.

Logging in scripts is very helpful when debugging. In Cloud scripts, anything printed to `stdout` using `println`, or using a [logger.info](http://logger.info/) ( `'message'`) call will be available in the [Script Logs](logging/script-logs.md) page, and in the execution history of script listeners and script jobs. As noted above, the usage of assertions can also help debug and diagnose the behaviour of scripts.
