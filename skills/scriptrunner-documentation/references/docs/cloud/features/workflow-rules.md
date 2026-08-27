# Workflow Rules

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-101629502
- Source: https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules

![](/sr4jc/files/latest/101629502/403866185/1/1751970649000/sr-migrate+%281%29.png)

**Migrating from ScriptRunner for Jira Server/DC to Cloud?** **Learn more in our** **[Feature Parity](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#workflow-conditions)** **overview.**

## Before you start

[![](/sr4jc/files/latest/101629502/230982582/1/1707305062000/training+icon.jpg)](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-3-module-scripted-workflow-extensions)

View our training module on Scripted Workflow Rules.

  

[shortcut Training Modules](https://docs.adaptavist.com/sr4jc/latest/training/course-scriptrunner-for-jira-cloud-for-beginners/1-3-module-scripted-workflow-extensions)

  

## What are workflow rules?

Workflow rules in ScriptRunner for Jira Cloud allow you to extend and automate Jira's native workflows by adding conditional logic, custom validators, and post-transition rules. They enable you to create rules for transitioning a work item's status in Jira Cloud, giving you greater control over when and how it transitions.

## How to use workflow rules

ScriptRunner for Jira Cloud provides built-in and custom workflow functions. You can use these workflows to change or transition a work item through a set of logical steps. 

Workflows typically represent a process and contain a set of statuses and transitions. You can extend Jira's native workflows by adding:

-   [Restrict Transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions) \- check to make sure that a requirement is met before the transition option is available.
    
-   [Validate Details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details) \- check to make sure that a requirement is met when a user tries to transition a work item.
    
-   [Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions) \- perform automated actions after a work item transitions to a new status.

You can **only** view Workflows in ScriptRunner for Jira Cloud if you have already created a restriction, validator, or workflow action from the Workflows within the Jira administration menus. Once added in Jira, the workflow appears in the Workflows section of ScriptRunner for Jira Cloud, where you can edit or disable it.

ScriptRunner for Jira Cloud provides workflow restrictions and validators using the [Jira Expression Framework](https://developer.atlassian.com/cloud/jira/platform/jira-expressions). It is not possible to use the REST API.

It's worth noting from the outset that although you may be familiar with extensions to workflows in the [Jira Server](https://docs.adaptavist.com/sr4js/latest/features/workflows) version of ScriptRunner, the Cloud infrastructure differs. You can follow our step-by-step [example](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/example-workflow-rules) to learn how to extend workflows.

Reuse a script

Click **Load** to reuse a previously saved script from [Script Manager](https://docs.adaptavist.com/sr4jc/latest/features/script-manager).  
Further details on how to use this feature can be found in the [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#id-.ScriptManagervDraft-ReusescriptsintheUIReusescriptsintheUI) section of the documentation.

## What is the Workflow page?

The ScriptRunner for Jira cloud Workflows page lets you quickly view and manage information about existing workflows, without navigating through the Jira administration menus. In other words, this is where you can edit a Scriptrunner workflow rule after it's been created on a workflow transition. 

## How to use the Workflow page

You simply navigate to **ScriptRunner → Workflows** and a list of all existing workflows displays.

You can view all workflow rules, or you can refine the list displayed by:

-   **Type** - choose the type of workflow rules to display. These include [Perform actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Restrict transitions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/restrict-transitions), and [Validate details](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/validate-details).
-   **Workflow Status** - choose whether to display **Active** or **Inactive** workflows. Both are activated by default.

The History column displays any errors that may have occurred with the 10 most recent script executions. More details, such as logs or payload, can be accessed by clicking the red icon for a given error.

If you wish to edit or disable a particular workflow rule, click the **Actions** ellipsis for your preferred workflow and select either **Edit** or **Disable**.  
![](/sr4jc/files/latest/101629502/585007618/2/1785520306000/edit-or-disable-workflow+%281%29.png)

-   If you choose to disable the chosen workflow, you simply confirm this via a confirmation message once prompted.
-   If you choose to edit the chosen workflow, you will see the workflow details screen displayed from where you can make the required edits and click **Save**. For example:

![](/sr4jc/files/latest/101629502/585007617/1/1785520382000/edit-perform-actions-rule+%281%29.png)
