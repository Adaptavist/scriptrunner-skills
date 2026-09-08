# Logging

- Platform: data-center
- Space: SR4JS
- Hierarchy: best-practices
- Doc ID: doc-sr4js-101624121
- Source: https://docs.adaptavist.com/sr4js/latest/best-practices/logging

## Logging and Profiling

Each execution of any of your scripts are recorded. We record:

-   any parameters passed to it (the script _binding_), which is known as the _payload_
    
-   the log output including any exception message, if present
    
-   timing information, which is the total elapsed time, and the CPU time used
    

The last 15 executions are displayed where relevant, eg when viewing workflows, script fields, script listeners, and REST endpoints administration.

A summary of recent history is displayed, eg

![](/sr4js/files/latest/101624121/101627970/1/1600701643000/diags-failure-message+%281%29.png)

Clicking through on any of these will give you further information about that particular invocation.

 ![](/sr4js/files/latest/101624121/101627971/1/1600701643000/diags-failure-display+%281%29.png)

![](/sr4js/files/latest/101624121/101627976/1/1600701643000/diags-failure-dialog+%281%29.png)

This is most useful for viewing why your own scripts failed, particularly if it’s an intermittent failure, which may only happen because of certain issue attributes - for instance a field value being unexpectedly null.

Only uncaught exceptions are shown as failures.

On Jira shutdown the last 15 invocations of each _function_ are written to the database so that they persist a restart.

### Known Issues

-   Uncaught exceptions in _conditions_ or _additional code_ are not displayed as errors, but the error will appear in the logs
    
-   When using Jira Data Center, only invocations that executed on that node are shown. If using Data Center, and you suspect issues on just one node, you will need to open the corresponding URL on that DC instance
    
-   Certain categories of scripts are currently excluded from log captures, namely JQL functions and administration scripts (_built-in scripts_)
    
-   On Jira 6.x the persistence functionality may not always work
