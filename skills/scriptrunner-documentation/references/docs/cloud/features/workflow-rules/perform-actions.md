# Perform Actions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-101629101
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions

A Perform actions rule is a workflow function that performs automated actions after a work item transitions to a new status. ScriptRunner has several built-in perform actions functions. Each function contains a condition that can be used to dismiss the rest of the script if it returns false. Most functions also include additional code that can execute to modify the function's final action.

There are several ways to enhance your workflow using Perform actions, including:

-   Automatically add or remove a work item from the active sprint after it is transitioned.
    
-   Change the assignee of a work item after it’s transitioned.
    
-   Send a notification on the transition of a work item.
    

## Create a Perform actions rule

For help navigating to ScriptRunner workflow functions, follow the steps in the [Example Workflow Extension](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-workflow-rules). 

1.  Select the transition you wish to add the Perform actions rule to.
2.  Click **Perform actions > Add Perform actions**.
3.  Select the **ScriptRunner Perform actions** option, then **Add**.
4.  Select a Perform actions rule from the list of available functions. For example, **Add/Remove From Sprint**.
5.  In the **Description** field, enter a short description.
6.  Select **Enable Perform actions** to enable it as soon as it is added.

Different options are available depending on the Perform actions rule added. See the examples for each Perform actions in this section for field descriptions along with [Additional Code](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields).

## Edit a Perform actions rule

1.  Navigate to **ScriptRunner > Workflows**. All existing workflows are displayed as default.
2.  Select **Perform actions** from the **Type** drop-down list.  
    ![](/sr4jc/files/latest/101629101/524222471/1/1773178615000/select-perform-actions-type.png)   
    You will now see a refined list displayed.
3.  Click the **Actions** ellipsis for your preferred workflow and select **Edit**.
4.  Edit the Perform actions fields and click **Save**.
