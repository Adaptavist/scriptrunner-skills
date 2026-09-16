# Features

- Platform: cloud
- Space: SR4JC
- Hierarchy: n/a
- Doc ID: doc-sr4jc-9ef51eba-4fc8-4ad2-9946-2a21cc1b8398-fc04aba8e3321fc9
- Source: https://docs.adaptavist.com/sr4jc/latest/features

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../s/script-runner-migration-to-cloud.md) section. |

## ScriptRunner Enhanced Search

The ScriptRunner Enhanced Search feature provides advanced [JQL function](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) search capabilities, or _queries_, in Jira Cloud, which you can modify or extend. You can use ScriptRunner JQL functions anywhere you are able to use Jira JQL functions.

## Script Console

Use the [Script Console](../../features/script-console.md) to experiment and run scripts on the script editor. You can enter your own scripts, or use one of the many example scripts provided. The Script Console is useful for testing scripts or performing operations that you only want to do once.

## Built-In Scripts

Use [Built-In Scripts](../../features/built-in-scripts.md) to automate manual, complex, and time-consuming tasks. Built-in scripts have been created for some of the most commonly run tasks in ScriptRunner for Jira Cloud. For example, you can use the [Bulk Clone Work Items](https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-clone-work-items) to select Jira work items to clone and move to another space as a set of work items in bulk.

## Scheduled Jobs

Use [Scheduled Jobs](../../features/scheduled-jobs.md) to automate the running of scripts at regular intervals—saving your administrators time, and reducing the risk of human error.

## Script Listeners

Use [Script Listeners](../../features/script-listeners.md) to create automated procedures in ScriptRunner that listen for a specific event to occur in Jira and then carry out an action when it does. Script Listeners sit on your instance and wait for a [webhook event](https://developer.atlassian.com/cloud/jira/platform/webhooks/) to happen before executing the listener script. Webhooks are fired after an action has taken place in Jira, such as when a space is created or if a work item is updated.

## Workflow Rules

Use [Workflows](../../features/workflow-rules.md) to enhance and automate your workflows beyond Jira's native possibilities. ScriptRunner for Jira Cloud extensions to Atlassian's workflows enable you to set up rules relating to the transition of a work item's status within Jira Cloud, giving you increased control over how and when a work item transitions. You can also set up post-transition rules.

## Behaviours

Use [Behaviours](../../features/behaviours.md) to define how fields behave for work items in a given space or work item context. For example, you may want to create a behaviour that hides a field for a specific user group until it's relevant for them to interact with that particular field.

## Escalation Service

The [Escalation Service](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita) allows you to define a process for modifying work items after a certain amount of time has elapsed. This is useful for business procedures that require tasks to be completed within a certain time-frame (service level agreement). Escalation Services can be used if, for example, a task has been opened but not assigned for 7 days. You could automatically move it to a "Prioritize" status, or add a comment, which will cause an email to be sent.

## Script Variables

You can use [Script Variables](../../features/script-variables.md) to specify variables that can be inserted into your scripts ( Script Console, Script Listeners, Workflow Perform Actions, Scheduled Jobbs, Escalation Service. The variables are encrypted and stored within your ScriptRunner for Jira Cloud instance. You can use them to share common variables between your scripts, or to store sensitive data such as passwords that require encryption rather than hard-coding them directly in scripts.

## Script Fragments

Use [UI Fragments](../../features/script-fragments.md) to customize the UI of your Jira instance. For example, you can use this feature to [create a custom link or button](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-item) or [show a custom banner](https://docs.adaptavist.com/sr4js/latest/features/fragments/web-panel) on your Jira instance.

## Scripted Fields

Use [Scripted Fields](../../features/scripted-fields.md) to display information that would otherwise be unavailable for a work item by calculating or combining data from one or more existing fields and displaying the result in as a custom field. The results are updated when viewing a work item and when a work item containing a Scripted Field is updated. You can enter your own script into the script editor, or use one of the many example scripts provided.

## Script Manager

Use [Script Manager](../../features/script-manager.md) to manage saved .groovy and .jel scripts and folders directly from the ScriptRunner front-end. It allows you to easily reuse and organize scripts in any of the Groovy and Jira Expression Language code editors across your instance, making script management more efficient and accessible.

## HAPI

HAPI is an API developed to carry out common tasks in Jira, including managing work items, searching for work items, updating fields and much more! HAPI is a simple alternative to Jira's regular API and can be used in your Groovy scripts. See the [HAPI](../h/hapi.md) page for more details on this feature and to find examples of how to use HAPI.

## Not confident with scripting?

Many ScriptRunner features include built-in scripts that require minimal scripting experience. Our documentation offers practical examples, and you can use example scripts in the code editors of several features or explore more on our [ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira). Check out our [Scripting in ScriptRunner for Jira Cloud](../../get-started/scripting-in-script-runner-for-jira-cloud.md) overview too!
