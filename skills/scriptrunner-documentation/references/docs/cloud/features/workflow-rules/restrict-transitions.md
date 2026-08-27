# Restrict Transitions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-101629020
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions

A Restrict transitions rule is a workflow condition that extends the functionality of a basic Jira workflow condition. A restricted transition checks to ensure a requirement is met before a transition is made available to users. If the script returns `false`, the transition button is not available for a work item until the condition is met.

There are several ways to enhance your workflow using Restrict transitions, as shown in [Example Restrictions and Validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators), including:

-   Allow a transition only if the summary starts with specified characters.
    
-   Restrict transitions if certain fields are not populated.
    
-   Enforce that the work item must have at least one PDF file attachment to transition.
    
-   Allow only certain users to transition a work item.
    

ScriptRunner for Jira Cloud provides workflow Restrict transitions using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/platform/jira-expressions). It is not possible to use the REST API.

Navigate to [Context Variables](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#context-variables) to see the variables provided by this framework that can be used to create expressions. Click the [variables](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference/#issue) to view the properties that can be called.

## Create a Restrict transition rule

1.  Navigate to the _Workflows_ menu from within Jira's settings. You will see _Active_ and _Inactive_ workflows displayed.
2.  Click **Edit** from the **Actions** ellipsis for your chosen workflow, and the workflow opens. You can choose to view the workflow as a diagram or text; we will use the former for this example.
3.  Select a transition from within the workflow diagram. A list of associated workflow functions, including **Restrict c****onditions**, **Validate details**, **Perform action**, **Triggers**, and **Properties,** is displayed for the selected transition.
4.  Click **Restrict transition****,** and the workflow's transition options appear.  
    ![](/sr4jc/files/latest/101629020/524222475/1/1773168797000/restrict-transition-workflow.png)
5.  Click **Add restrict transition rule**. You will see the list of conditions that can be added to the chosen transition**.**   
    ![](/sr4jc/files/latest/101629020/524222474/1/1773168898000/select-restrict-transition.png)
6.  Select the **ScriptRunner: Restrict transition using a Jira Expression** option and click **Select**.
7.  Enter a **Name** for the ScriptRunner Restrict transition rule.  
    In the **ScriptRunner Script Restrict transition** field, enter the script condition expression. This script condition must be written as a [Jira expression](https://developer.atlassian.com/cloud/jira/platform/jira-expressions).

## Edit a Restrict transition rule

1.  Navigate to **ScriptRunner → Workflows**. All existing workflows are displayed as the default.
2.  Select **Restrict transition** from the **Type** drop-down list. You will now see a refined list displayed.
3.  Click the **Actions** ellipsis for your preferred workflow and select **Edit**.  
    ![](/sr4jc/files/latest/101629020/524222473/1/1773169067000/edit-restrict-transition.png)
4.  Edit the Restrict transition fields and click **Save**.
