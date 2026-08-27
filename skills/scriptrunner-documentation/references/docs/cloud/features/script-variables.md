# Script Variables

- Platform: cloud
- Space: SR4JC
- Hierarchy: features
- Doc ID: doc-sr4jc-103678296
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-variables

## Before you start

[![](/sr4jc/files/latest/103678296/230982587/1/1707305609000/learning+icon.jpg)](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables)

Take a look at an example of Script Variables

  

[shortcut Script Variable Example](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables)

  

  

## What are Script Variables?

You can use _Script Variables_ to specify variables that can be inserted into your scripts ([Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console), [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs), [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service)).

## How to use Script Variables

The variables are encrypted and stored within your ScriptRunner for Jira Cloud instance. You can use them to share common variables between your scripts, or to store sensitive data such as passwords that require encryption rather than hard-coding them directly in scripts.

Please remember that a variable has a String value type, even if the value is a number. It is also worth noting that Script Variables are static and can only be set on the Script Variables page, so you cannot dynamically set the values of these via a script.

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

## Create a Script Variable

1.  Navigate to **ScriptRunner > Script Variables**.  
    Depending on whether or not you have already created script variables, you are presented with either a landing screen or a list of previously created script variables.
2.  Click **Create Script Variables** from the initial landing screen if none have been previously created.![](/sr4jc/files/latest/103678296/261686262/1/1717490393000/landing+screen+script+variables.jpeg)  
    _**OR**_  
    Click **Create Script Variables** from the previously created list.  
    ![](/sr4jc/files/latest/103678296/166539092/1/1680619784000/script+variable.jpg)
3.  **(Optional)** Click **[Edit](#id-.ScriptVariablesvCurrent-editscriptvariable)** or **Delete** for your chosen scripted variable via the **Actions** ellipsis on this page to modify or delete as required.
4.  Enter a name in the **Script Variable name** field.  
    ![](/sr4jc/files/latest/103678296/166538342/2/1705493660000/create+script+variable.jpg)
5.  Enter a value in the **Script Variable value** field.
6.  Click **Save** or **Cancel**. Once saved, you will see a confirmation message display and you are automatically redirected to the Script Variables page. You can access saved script variables by clicking the _Script Context_ button in the editors for the [Script Console](https://docs.adaptavist.com/sr4jc/latest/features/script-console), [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners), [Workflow Perform Actions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), [Scheduled Jobs](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs), and [Escalation Service](https://docs.adaptavist.com/sr4jc/latest/features/escalation-service).

Edit a Script Variable  

1.  Navigate to **ScriptRunner > Script Variables**. A list of all script variables is shown.  
    ![](/sr4jc/files/latest/103678296/227344472/1/1705576650000/edit+script+variable.jpg)
    
2.  Click **Edit** on the **Actions** ellipsis of the script variable you wish to edit.
    
3.  Edit the fields as required. When all changes have been made, click **Save**. You can also click **Revert** to undo those changes.
    
4.  Click **Save** after all changes are complete. You can also click the **Delete** button and confirm when prompted.
