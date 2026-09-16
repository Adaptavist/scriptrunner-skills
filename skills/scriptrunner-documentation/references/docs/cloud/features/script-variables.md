# Script Variables

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features
- Doc ID: doc-sr4jc-54479bea-2f64-4784-a0a5-9f38ad8e1269-967fa38c1107727c
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-variables

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../uncategorized/s/script-runner-migration-to-cloud.md) section. |

## Before you start

|  |  |
| --- | --- |
|  | Take a look at an example of Script Variables.<br>[Example Script Variable](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables) |

## What are Script Variables?

You can use _Script Variables_ to specify variables that can be inserted into your scripts ( [Script Console](script-console.md), [Script Listeners](script-listeners.md), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](scheduled-jobs.md), [Escalation Service](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita)).

## How to use Script Variables

The variables are encrypted and stored within your ScriptRunner for Jira Cloud instance. You can use them to share common variables between your scripts, or to store sensitive data such as passwords that require encryption rather than hard-coding them directly in scripts.

Note: Please remember that a variable has a String value type, even if the value is a number. It is also worth noting that Script Variables are static and can only be set on the Script Variables page, so you cannot dynamically set the values of these via a script.

### Naming convention

Variable names must follow these rules:

-   start with a letter
-   only capital letters are allowed
-   only digits and underscore character (\_) are allowed

### Limitations

Length limits for variables include:

-   name is 32 characters
-   value is 3000 characters

Note that clicking the show password icon of script variables that are >50 characters opens a popup screen for easy viewing.

### Create a Script Variable

1.  Navigate to ScriptRunner > Script Variables.
    
    Depending on whether or not you have already created script variables, you are presented with either a landing screen or a list of previously created script variables.
    
2.  Click Create Script Variables from the initial landing screen if none have been previously created.
    
    _OR_
    
    Click Create Script Variables from the previously created list.
    
3.  Optional: Click [Edit](https://docs.adaptavist.com/sr4jc/latest/features/script-variables#edit-a-script-variable--en) or Delete for your chosen scripted variable via the Actions ellipsis on this page to modify or delete as required.
4.  Enter a name in the Script Variable name field.
    
5.  Enter a password in the Script Variable value field.
6.  Click Save or Cancel. Once saved, you will see a confirmation message display and you are automatically redirected to the Script Variables page. You can access saved script variables by clicking the Script Context button in the editors for the [Script Console](script-console.md), [Script Listeners](script-listeners.md), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](scheduled-jobs.md), and [Escalation Service](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita).

### Edit a Script Variable

1.  Navigate to ScriptRunner > Script Variables.
    
    A list of all script variables is shown.
    
2.  Click Edit on the Actions ellipsis of the script variable you wish to edit.
3.  Edit the fields as required.
    
    When all changes have been made, click Save. You can also click Revert to undo those changes.
    
4.  Click Save after all changes are complete.
    
    You can also click the Delete button and confirm when prompted.
