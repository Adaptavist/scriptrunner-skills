# Scheduled Jobs

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features
- Doc ID: doc-sr4jc-50a871fc-007f-4348-825e-615e65640e9e-804fcb8aa9d70748
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../uncategorized/s/script-runner-migration-to-cloud.md) section. |

## Before you start

|  |  |
| --- | --- |
|  | Visit ScriptRunner HQ to see example scripts.<br>[ScriptRunner HQ website](https://www.scriptrunnerhq.com/help/example-scripts?ScriptRunner%5BrefinementList%5D%5Bapp%5D%5B0%5D=script-runner-jira&ScriptRunner%5BrefinementList%5D%5Bplatform%5D%5B0%5D=cloud) |
|  | View our training for Scheduled Jobs.<br>[Training videos](../training/course-script-runner-for-jira-cloud-for-beginners/1-2-module-script-runner-for-jira-cloud-automation-capabilities.md) |

## What are Scheduled Jobs?

Scheduled Jobs allow you to automate the running of scripts at regular intervals saving your administrators time, and reducing the risk of human error. You can specify when, and how often, a job should run.

## How to use Scheduled Jobs

You may want to use a Scheduled Job to:

-   Create a work item once per month.
-   Email a report to users on a schedule.
-   Delete inactive users on a monthly basis.
-   Change the status of a work item depending on the time it has been open.
-   Automatically escalate a work item based on the elapsed time using [Escalation Services](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita).

Say, I have a team of consultants who need to fill out expenses at the end of every month. I can create a Scheduled Job to automatically create a task for each user at the end of every month to remind them to complete their expenses.

As a Jira administrator, it's key to keep my instance healthy and reduce costs by removing inactive users. I can set up a job to run a script that deletes inactive users on a monthly basis.

## Create a Scheduled Job

You can use _Scheduled Jobs_ to ensure code runs either at a specified time of day/week/month, or on an interval, to perform an automated task in your Jira instance.

Note: The minimum interval between code executions is 1 hour. The scheduler is triggered every hour and gathers all the tasks to be executed within that hour. The task executions are queued, and workers will consume them in no predefined order. That means the execution time of the task cannot be guaranteed to be the same every hour. For example, if you configure a job to run every hour, it might be executed at 01:02, 02:24, 03:00, and so on, depending on how busy our systems are.

Follow the steps below to use this feature:

1.  Navigate to ScriptRunner > Scheduled Jobs.
    
    Depending on whether or not you have already created scheduled jobs, you are presented with either a landing screen or a list of previously created jobs.
    
2.  Click Create Scheduled Job from the initial landing screen if none have been previously created. If you would rather use our built-in examples, you can click Add Examples to add two scheduled job examples.
    
    OR
    
    Click Create Scheduled Job from the previously created list.
    
3.  Optional: You can modify or delete any of the scheduled jobs listed. Click Edit or Delete via the Actions ellipsis to select the relevant scheduled job and delete, or refer to [Edit a scheduled job](https://docs.adaptavist.com/sr4jc/latest/features/scheduled-jobs#edit-a-scheduled-job--en).
    
    You now see the Create Scheduled Job screen, as shown below:
    
4.  Enter a name in The Scheduled Job called field.
5.  Activate the Enable Scheduled Job toggle. When set to Enabled, the scheduled job is active as soon as it is saved.
6.  Click on the edit pencil within the On this schedule field.
    
    -   The Scheduler dialog lets you choose between running your script on several days during the week (e.g. Monday, Wednesday, Friday), or running your script on particular days of the month (e.g. the last day of the month, the 2nd Tuesday of the month).
    -   You can enable a monthly schedule.
    -   Additionally, you can select an hour interval during which your script will run.
    
7.  Enter the name of the user you wish to run the service for in As this user:.
8.  Write your script in the Code to Run field. You also have the option to click Load and reuse a script you previously saved in Script Manager. Details on how to do this can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#reuse-scripts-in-the-ui--en).
    
    Tip: Reuse a script
    
    Click Load to reuse a previously saved script from [Script Manager](script-manager.md). Further details on how to use these features can be found in [Reuse scripts in the UI](https://docs.adaptavist.com/sr4jc/latest/features/script-manager#reuse-scripts-in-the-ui--en).
    
    OR
    
    Alternatively, you can click the Example scripts button to view a list of example scripts related to this feature.
    
    So, rather than writing your own script, you can reuse one of the many examples provided, as follows:
    
    1.  Choose an example script from the list provided, and the code automatically appears. You also have the option to search for a particular script.
    2.  Click Copy Code and then Close.
    3.  Paste the copied code in the code editor.
    
9.  Optional: Click Script context to view an information modal highlighting parameters/code variables. For further information on referencing Script Context values, refer to [Example Script Variables](https://docs.adaptavist.com/sr4jc/latest/features/script-variables/example-script-variables).
10.  Click Save. You can test your script using the Run Now button, which executes the script and returns the results and logs.
     
     Note: Each Scheduled Job can execute for the same length of time as [Script Listeners](script-listeners.md), [Post Functions](https://docs.adaptavist.com/sr4jc/latest/features/workflow-rules/perform-actions), and in the [Script Console](script-console.md), as documented in the script [limitations](../get-started/limitations.md). See also the [Escalation Service](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/escalation_service.dita), which allows you to configure code to be executed against each work item returned from a JQL search, on a schedule. This is useful for performing automated transitions/releases/updates of work items.
     

## Edit a Scheduled Job

1.  Navigate to ScriptRunner > Scheduled Jobs.
    
    A list of all scheduled jobs is shown.
    
2.  Click Edit on the Actions ellipsis of the scheduled job you wish to edit.
    
3.  Amend the fields previously created for the scheduled job as required. As already noted, you can click the Run Now button to test your script.
4.  Click Save when all changes have been made. You can also click Revert to undo those changes.
