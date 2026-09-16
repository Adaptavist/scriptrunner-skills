# Escalation Services

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4js-da600058-15e3-4f2f-b4f0-22080a7f7511-60d7b6207c8acb47
- Source: https://docs.adaptavist.com/sr4js/latest/features#jobs--en#built-in-jobs--en#escalation-services--en

Automate issue escalation with ScriptRunner _Escalation Services_. Use a JQL query to modify issues based on elapsed time, and enable actions (such as transitions) to occur after a specified time has passed. For example, if a task has been opened but not assigned for seven days, you can set up an escalation service to automatically give the issue a priority status, or send an email to notify the team.

## Adding an escalation service

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name for the job, for example, _Escalate to urgent_.
3.  Under User, enter the user the job will run as.
    
    If the job is set to leave a comment, send an email, or transition an issue, it does so as this user.
    
    Note: This user must have the correct permissions to execute the action (for example, transition the issue). The results of the JQL may differ depending on the permissions of the selected user.
    
    Tip: Create a user called _Automation_ (or similar) and give it administrator rights in every project. Then set _Automation_ as the User when setting up an escalation service.
    
4.  In the Interval/Cron expression field, enter how often the job should run.
    
    The interval can be in minutes, entered as an integer, or a cron expression. The example shown runs every day at 6 am.
    
    Warning: Jobs set to run at intervals run automatically upon start-up of Jira. To avoid this, use non-interval cron expressions specifying the time the job should run (as seen in the example above).
    
    Tip: For more information on cron expressions, see [Constructing Cron Expressions for a Filter Subscription](https://confluence.atlassian.com/jirasoftwareserver/constructing-cron-expressions-for-a-filter-subscription-939938814.html).
    
5.  In JQL Query, enter a query to select the issues you wish to escalate.
    
    For example, issues in a specific project that have the status _To Do_ but have not been updated for over five days.
    
    Tip: Test the query in the Issue Navigator first. For more information on JQL queries, see [Advanced Searching](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html).
    
6.  Select an action in the Action field.
    
    This field is optional if Additional issue actions are specified.
    
7.  Under Transition Options optionally select which options the transition should skip.
    
    -   Skip Permissions: Skip any permissions issues which may stop the issue transitioning.
    -   Skip Validators: Do not validate fields during an issue transition.
    -   Skip Conditions: Ignore all conditions on an issue, allowing transition despite the conditions not being met.
    
8.  Add custom actions into the Additional Issue Actions script field to run additional code as part of the escalation.
    
    For example, add a comment to the issue, or set a custom field.
    
    Tip: Select Example scripts to see examples of commonly used scripts.
    
9.  Select Add to save the escalation service; the script will run on the interval specified.
    
    Optionally, select Run now to run the script and view which issues were affected.
    
    Warning: Selecting Run now does not save the escalation service. Select Add to save.
    

## Escalation service examples

### Close issues waiting for customers

You can use an escalation service to close issues that have been waiting for customers for over a year.

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name, such as _Close issues waiting for customers_.
3.  Select a user to run the script as.
4.  Enter an interval to run as in the Interval/Cron Expression field.
    
    In this example, we want the code to run every 60 minutes.
    
5.  Enter the following JQL query to close issues with the _Waiting for Customers_ status that have been open over a year:
    
    ```
    status = "Waiting for Customers" and updated < -365d
    ```
    
6.  Select Close Issue under Action.
7.  Optionally, select which Transition Options to skip.
8.  Optionally, define a comment to post when the issue is closed.
9.  Select Add to save the escalation service; the script runs on the interval specified.
    

### Automatically approve issues after n days

You can use an escalation service to automatically approve issues after a select amount of days.

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name, such as _Auto Approve Requests After 2 Days_.
3.  Select a user to run the script as.
4.  Enter an interval to run as in the Interval/Cron Expression field.
    
    In this example, we want the code to run every day. For example, enter `0 30 0 ? * *` to run at 12:30am.
    
5.  Enter and appropriate JQL query to close issues that have been waiting for approval.
    
    For example:
    
    ```
    status = "Awaiting Approval" and "My Approved Field" = "No" and updated <-2d
    ```
    
6.  Under Action select the most appropriate option, such as Approved.
7.  Optionally, select which Transition Options to skip.
8.  Optionally, define a comment to post when the issue is approved.
9.  Select Add to save the escalation service; the script runs on the interval specified.
    
    Optionally, select Run now to run the script and view which issues were affected.
    

### Automatically close old support tickets

You can use an escalation service to automatically close issues after a select amount of days.

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name, such as _Close one week old Resolved tickets with no response_.
3.  Select a user to run the script as.
4.  Enter an interval to run as in the Interval/Cron Expression field.
    
    In this example, we want the code to run every day. For example, enter `0 30 0 ? * *` to run at 12:30am.
    
5.  Enter and appropriate JQL query to close old support issues.
    
    For example:
    
    ```
    status = Resolved and updated <-7d
    ```
    
6.  Under Action select the most appropriate option, such as Close Issue.
7.  Optionally, select which Transition Options to skip.
8.  Optionally, define a comment to post when the issue is close.
9.  Select Add to save the escalation service; the script runs on the interval specified.
    
    Optionally, select Run now to run the script and view which issues were affected.
    

### Automatically escalate unassigned issues

You can use an escalation service to automatically escalate an issue that is unassigned for more than a day.

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name, such as _Escalate unassigned issues after a day_.
3.  Select a user to run the script as.
4.  Enter an interval to run as in the Interval/Cron Expression field.
    
    In this example, we want the code to run every day. For example, enter `0 30 0 ? * *` to run at 12:30am.
    
5.  Enter and appropriate JQL query to close old support issues.
    
    For example:
    
    ```
    status = "To Do" and Assignee = "Unassigned" and updated <-1d
    ```
    
6.  Under Action select the most appropriate option, such as Escalated.
    
    You may have to create the Escalated status.
    
7.  Optionally, select which Transition Options to skip.
8.  Optionally, define a comment to post when the issue is close.
9.  Select Add to save the escalation service; the script runs on the interval specified.
    
    Optionally, select Run now to run the script and view which issues were affected.
    

### Automatically mark an issue as inactive

You can use an escalation service to mark issues as inactive when they've been awaiting customer response for a specified duration.

1.  From ScriptRunner, navigate to the Jobs tab and select Create Job > Escalation service.
2.  Enter a Name, such as _Mark issues that are waiting for customers as inactive_.
3.  Select a user to run the script as.
4.  Enter an interval to run as in the Interval/Cron Expression field.
    
    In this example, we want the code to run every day. For example, enter `0 30 0 ? * *` to run at 12:30am.
    
5.  Enter and appropriate JQL query to close old support issues. For example:
    
    ```
    status = "Waiting for Customer" AND updated < -7d
    ```
    
6.  Under Action select the most appropriate option, such as Mark Inactive.
7.  Optionally, select which Transition Options to skip.
8.  Optionally, define a comment to post when the issue is close. For example:
    
    ```
    def comment = """
    This issue has not been updated for five business days.
     
    If you have an update, please use "Add Comments For Atlassian" action to let us know. If you need more time to gather information please let us know and we will 'freeze' this issue. If you have no other questions, please Close this issue.
     
    If no update is received in the next five business days, this issue will be automatically closed.
     
    Thank you,
     
      The Support Team
     
     """
     
      issueInputParameters.setComment(comment)
    ```
    
9.  Select Add to save the escalation service; the script runs on the interval specified. Optionally, select Run now to run the script and view which issues were affected.
