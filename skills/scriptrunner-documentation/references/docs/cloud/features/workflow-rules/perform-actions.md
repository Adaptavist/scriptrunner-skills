# Perform Actions

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > Workflow Rules
- Doc ID: doc-sr4jc-48a2f7e1-6038-4dca-9a0b-139f4ebf3dc7-e71f5a1f089d71be
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules#perform-actions--en

A Perform actions rule is a workflow function that performs automated actions after a Work item transitions to a new status. ScriptRunner has several built-in Perform actions functions. Each function contains a condition that can be used to dismiss the rest of the script if it returns false. Most functions also include additional code that can execute to modify the function's final action.

There are several ways to enhance your workflow using Perform actions, including:

-   Automatically add or remove a Work item from the active sprint after it is transitioned.
-   Change the assignee of a Work item after it's transitioned.
-   Send a notification when a Work item transitions.

## Create a Perform Actions rule

For help navigating to ScriptRunner workflow functions, follow the steps in the [Example Workflow Extension](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-workflow-rules).

1.  Select the transition you wish to add the Perform actions rule to.
2.  Click Perform actions > Add Perform actions.
3.  Select the ScriptRunner Perform actions option, then Add.
4.  Select a Perform actions rule from the list of available functions. For example, _Add/Remove From Sprint_.
5.  In the Description field, enter a short description.
6.  Select Enable Perform actions to enable it as soon as it is added.

Different options are available depending on the Perform actions rule added. See the examples for each Perform actions in this section for field descriptions along with [Additional Code](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/fields).

## Edit a Perform Actions rule

1.  Navigate to ScriptRunner > Workflows. All existing workflows are displayed as default.
2.  Select Perform actions from the Type drop-down list.
    
    You will now see a refined list displayed.
    
3.  Click the Actions ellipsis for your preferred workflow and select Edit.
4.  Edit the Perform actions fields and click Save.
