# Example Workflow Rules

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > workflow-rules
- Doc ID: doc-sr4jc-107999441
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-workflow-rules

Atlassian's [new transition experience](https://community.atlassian.com/forums/Jira-articles/Now-GA-try-the-new-issue-transition-experience-in-Jira/ba-p/2734436) in Jira is being permanently rolled out in **April 2025**. As a consequence, how your Jira expressions ([Restrict transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) and [Validate details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details)) work will change.  
Check out our [Breaking Changes](https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/compatibility-of-atlassian-s-new-transition-experience-with-jira-expressions) section for more information.

ScriptRunner for Jira Cloud provides several [built-in workflow actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/built-in-workflow-actions) to help you get started with Workflows, and you can refer to our [example custom scripts](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions/example-custom-scripts). You can also use one of the many [Jira expression examples](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-restrictions-and-validators), which can be applied to **either** [Restrict transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) or [Validate details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) and on **all transitions** unless noted otherwise. 

## Example: Add a Perform actions workflow rule 

By way of an example, if you would like to add a Perform actions rule to an existing Jira workflow, follow the steps below:

1.  Navigate to the _Workflows_ menu from within Jira's settings. You will see _Active_ and _Inactive_ workflows displayed.
2.  Click **Edit** from the **Actions** ellipsis for your chosen workflow, and the workflow opens. You can choose to view the workflow as a diagram or text; we will use the former for this example.
3.  Select a transition from within the workflow diagram. A list of associated workflow functions, including **Restrict transitions**, **Validate details**, **Perform actions**, **Triggers**, and **Properties,** is displayed for the selected transition.  
    ![](/sr4jc/files/latest/107999441/524222489/1/1773172814000/select-workflow-diagram.png)
4.  Click **Perform actions,** and the workflow's transition options appear.  
    
5.  Click **Add perform actions rule.**  
    ![](/sr4jc/files/latest/107999441/524222488/1/1773172919000/add-perform-actions-rule.png)
6.  Select the **ScriptRunner: Perform actions using a script** option and click **Select**.  
    ![](/sr4jc/files/latest/107999441/524222487/1/1773173724000/select-perform-actions.png)  
    The _Add ScriptRunner Perform Actions Rule_ screen appears.
7.  Select a Perform actions rule from the list of available functions. For example, choose **Add/remove from sprint**.   
    ![](/sr4jc/files/latest/107999441/524222486/1/1773173829000/perform-actions-list.png)  
    You will now see the _Configuration_ screen.
8.  In the **Description** field, enter a short description.
9.  Select **Enable Perform actions** to enable it as soon as it is added.
10.  Select an **Example** script from the provided list of examples. These can help you get started writing your script in the console.  
     
11.  Choose from the **Action** drop-down whether to add to a sprint or remove from a sprint.
12.  Choose from the **Board Name** drop-down whether to assign the workflow action to a particular board.
13.  Choose whether to run the script as an **Initiating** **User** or **ScriptRunner Add-On User** in the _Run As_ dropdown.
14.  Click **Add,** and you are returned to the workflow transition, where you will see the newly added Perform actions rule appear.

### Edit a Perform Actions rule

You can edit the script for the Perform actions rule directly in the workflow, or quickly access it at any time via the _Workflows_ tab in ScriptRunner for Jira Cloud.

Remember, you can only view Workflows in ScriptRunner for Jira Cloud if you have already created a Restrict transition, Validate details or Perform actions rule from the Workflows within the Jira Administration menus. Once added within Jira, the workflow then appears in the Workflows section of ScriptRunner for Jira Cloud, where you can edit or disable it.

1.  Navigate to **ScriptRunner > Workflows**.  
    All existing workflows are displayed. You can refine your search by selecting the transition type from the **Type** drop-down list (Restrict transition, Validate details, or Perform actions) or the **Workflow Status** (active or inactive).  
    You will now see a refined list displayed.
2.  Click the **Actions** ellipsis for your preferred workflow and select either **Edit** or **Disable**.  
    ![](/sr4jc/files/latest/107999441/524222485/1/1773174130000/edit-or-disable-workflow.png)

-   If you choose to disable the chosen workflow, you can confirm this via a confirmation message once prompted.
-   If you choose to edit the chosen workflow, you will see the workflow details screen displayed, from where you can make the required edits to an existing workflow.  
    For example:  
    ![](/sr4jc/files/latest/107999441/524222483/1/1773178993000/edit-perform-actions-rule.png)

1.  1.  Write your script in the code editor.  
        
        Reuse a script
        
        Click **Load** to reuse a previously saved script from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager).  
        Further details on how to use this feature can be found in the [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervDraft-ReusescriptsintheUIReusescriptsintheUI) section of the documentation.
        
        This code is executed when the Condition is **true**.   
        OR  
        Alternatively, click **Example scripts** to view a list of example scripts related to this feature.  
        ![](/sr4jc/files/latest/107999441/524222490/1/1773167511000/example-scripts.png)  
        So, rather than writing your own script, you can reuse one of the many examples provided, as follows:  
        \- Choose an example script from the list provided, and the code automatically appears. You can also search for a particular script.  
        \- Click **Copy Code** and then **Close**.\- Paste the copied code in the code editor.
2.  Click **Save**.
3.  **(Optional)** Click **[Script context](https://docs.adaptavist.com/sr4jc/current/features/workflow-rules/perform-actions/fields#script-context)** to view an information modal highlighting parameters/code variables.  
    For further information on referencing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).
