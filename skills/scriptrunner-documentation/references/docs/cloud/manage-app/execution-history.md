# Execution History

- Platform: cloud
- Space: SR4JC
- Hierarchy: Manage App
- Doc ID: doc-sr4jc-ebb46473-5be8-4b7c-911e-ca59f7ea92e8-8d327c6e1afd722c
- Source: https://docs.adaptavist.com/sr4jc/latest/manage-app/execution-history

Use the Execution History page to analyse the effects of ScriptRunner scripts on your Jira instance. You can use _Execution History_ to view execution times and failure rates for [Script Listeners](../features/script-listeners.md), [Scheduled Jobs](../features/scheduled-jobs.md), [Escalation Services](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita) and [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) scripts in your instance, allowing a long-term view of script performance.

The Execution History page allows you to view an analysis of all your script executions for Script Listeners, Scheduled Jobs, Escalation Services and Perform Actions in a single page.

Click the Execution History option from the ScriptRunner menu and select the time frame you are interested in by choosing one of the options from the Interval drop down list that includes:

-   24 hours
-   48 hours
-   72 hours

Once loaded, you can use the Success/failure or Breakdown buttons to check results at a glance and you can view the script executions that have occurred in the chosen time frame as either a graph or a table, as shown below.

You can toggle between the Graph and Data results for each of the script executions. You should note that:

-   The graph view shows whether or not a script executed successfully.
-   Hovering over each bar in the graph view displays the time run and a description of the script.
-   A more detailed analysis of the execution history of each script is provided in the table view, as shown below.

Note: An Execution History table can include:

-   date of execution
-   execution status
-   name
-   correlation id
-   time to execute
-   work item
-   executor name
-   execution event
-   workflow name
-   initial workflow state
-   transition type
-   number of work items run against

## Related Content:

-   [Scripting in ScriptRunner for Jira Cloud](../get-started/scripting-in-script-runner-for-jira-cloud.md)
-   [Review Logs](review-logs.md)
-   [Features](../uncategorized/f/features.md)
