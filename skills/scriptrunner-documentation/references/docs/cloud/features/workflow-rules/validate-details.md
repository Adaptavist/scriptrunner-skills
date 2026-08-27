# Validate Details

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-104373072
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details

A validate details rule is a powered-up version of a standard Jira validator. Instead of using one of the basic validators that you find in Jira, you can run a script to validate your work item. If the script returns `false`, it does not transition until all errors are resolved, for example, when all required fields are complete. Validate details rules enable administrators to specify the error message displayed to the user.

Remember, a validate details rule checks to see if the user can transition an work item. They don't prevent the next transition button from appearing. A [Restrict transition](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) gives you more options to control the workflow.

ScriptRunner for Jira Cloud provides workflow Validate details rules using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/platform/jira-expressions). It is not possible to use the REST API.

There are several ways to enhance your workflow using the validate details option, as shown in [Example Restrictions and Validators](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators), including:

-   Require a **Fix Version** if the resolution value is set to _Fixed_.
    
-   Require a comment when the resolution is _Won't Fix_.
    
-   Ensure that at least one sub-task is _In Progress_ if the resolution of the parent work item changes to _In Progress_.
    

Navigate to [Context Variables](https://developer.atlassian.com/cloud/jira/platform/jira-expressions/#context-variables) to see the variables provided by this framework that can be used to create expressions. Click the [variables](https://developer.atlassian.com/cloud/jira/platform/jira-expressions-type-reference/#issue) to view the properties that can be called.

## Add a Validate details rule

1.  Navigate to the _Workflows_ menu from within Jira's settings. You will see _Active_ and _Inactive_ workflows displayed.
2.  Click **Edit** from the **Actions** ellipsis for your chosen workflow, and the workflow opens. You can choose to view the workflow as a diagram or text; we will use the former for this example.
3.  Select a transition from within the workflow diagram.  
    A list of associated workflow functions, including **Restrict transition**, **Validate details**, **Perform action**, **Triggers**, and **Properties,** is displayed for the selected transition.  
    ![](/sr4jc/files/latest/104373072/524222479/1/1773167935000/workflow-diagram.png)
4.  Click **Validate details > Add validate details rule**.
5.  Select the **ScriptRunner Validate details using a Jira Expression** option, then click **S****elect**.  
    ![](/sr4jc/files/latest/104373072/524222480/1/1773167825000/select-scriptrunner-validate-details.png)
    
6.  Enter the **Name of ScriptRunner Script validate details rule**.
    
7.  Enter the script expression in the **ScriptRunner Script Validate details** field. This script validate details rule must be written as a [Jira expression](https://developer.atlassian.com/cloud/jira/platform/jira-expressions).
    
8.  Type an error message to show when the validation fails in **Message to Show when Validation Fails**.
    

## Edit a Validate details rule

1.  Navigate to **ScriptRunner > Workflows**. All existing workflows are displayed as the default.
2.  Select **Validate details** from the **Type** drop-down list. You will now see a refined list displayed.
3.  Click the **Actions** ellipsis for your preferred workflow and select **Edit**.  
    ![](/sr4jc/files/latest/104373072/524222478/1/1773168139000/edit-validate-details.png)
4.  Edit the Validate details fields and click **Save**.
