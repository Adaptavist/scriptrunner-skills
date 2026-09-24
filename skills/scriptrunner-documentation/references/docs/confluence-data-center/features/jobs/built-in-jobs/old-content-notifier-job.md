# Old Content Notifier Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-b06c3803-52bf-42a2-b9f7-b95f94353930-528452b88c2afe4d
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#old-content-notifier-job--en

This script will check the pages and their descendants returned from the CQL clause provided to determine if there are any inactive pages.

If any inactive pages are found, a short report will be generated and emailed to all the users in the specified group.

An inactive page is defined as a page of a specified age where all descendants are also the same age or older. Adding a comment to a page will flag it as active.

The job will allow you to automatically notify content managers about inactive pages, for example:

-   In a specified space, find all the inactive pages older than two years with inactive descendants without the label 'ignore\_inactive'. The CQL clause would look like this: space = SPACEKEY and type = page and lastModified < now('-104w') and label not in (ignore\_inactive)

Warning: The job could potentially take a while to complete if casting a large net with your CQL clause.

This job will only operate on pages.

Follow these steps to set up the job:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Old Content Notifier.
4.  Enter a Name.
5.  Select a User.
    
    When the job runs, the user is logged as the one who made the change.
    
    Tip: You can create a user to assign for jobs like this. For example, _ScriptRunner Bot User_.
    
6.  Enter an Interval/Cron Expression.
    
    Determine how often you want this job to run. You can select Show Examples to use an included expression or enter your own. You have two options for this field:
    
    -   Interval: The easiest way to fill out this field is to enter an interval of minutes. For example, if you want the job to run every 30 minutes, enter 30. If you want it to run every 24 hours, enter 1440.
    -   Cron: If you need the job to run on a more detailed schedule, use a [cron expression](https://www.quartz-scheduler.org/api/1.8.6/org/quartz/CronExpression.html). For example, if you want it the job to run at 12:30 AM on Sundays, use the cron _0 30 0 ? \* SUN_. Another example is if you want the job to run every minute, use the cron _0 0/1 \* 1/1 \* ?_.
    
7.  Enter a CQL Query to select pages you want the job to run on.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available for this job. Start typing to see possible CQL statements.
    -   Visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    
8.  Select the Group you want to notify.
9.  Use the Content Age field to determine what items will be deleted.
    
    -   The _Preset Filters_ are:
        -   Older than six months
        -   Older than one year
        -   Older than two years
    -   You also have the option to select a Custom Filter, Older Than. If you select the Older Than value, a screen appears where you choose inputs.
    
    Warning: The Older Than field must contain a value (which specifies a specific date) equal or greater than the date specified in the CQL 'lastModified' clause.
    
10.  Click Add.

Your job now appears on the Jobs page of ScriptRunner. It will run when specified in the script, and you can choose to run it at other times. You can also enable and disable it.

## Example

The following example configuration shows an old content notifier job which will run as the Admin user each Sunday morning just after midnight.

1.  For Name, enter Timed archival job 1 space a.
2.  Enter the admin User.
3.  For Interval/Cron Expression, enter 0 30 0 ? \* SUN to run at 12:30 AM on Sundays.
4.  Enter the CQL Query of space = TS1 and type = page and lastModified <now("104") to run on all pages in a space with the space key _TS1_ which were modified over two years ago.
5.  Enter content-management for Group.
6.  For Content Age, select Older Than and then enter 104 Weeks in the fields that appear.
7.  Select Add.
