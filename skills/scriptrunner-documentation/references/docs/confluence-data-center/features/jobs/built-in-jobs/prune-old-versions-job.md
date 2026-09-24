# Prune Old Versions Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-c28e0c44-2c41-421e-84fc-622db6d56975-47ac48b83d0fdf51
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#prune-old-versions-job--en

The Prune Old Page Versions built-in job allows you to automatically prune old page versions according to your requirements.

Over time, the number of revisions for each page will grow. Given that Confluence stores the entire content for each revision (rather than deltas), this can dramatically increase your database storage requirements.

For example:

-   Remove versions older than three months on all spaces but always keep the latest three versions
-   On spaces where you may have sensitive content, only keep the latest revision

Warning: Using this built-in job irretrievably removes versions according to your rules. It is not possible to restore the removed versions unless you perform a full space or Confluence restore. Make sure you have tested on your staging instance. At the very least start with a CQL query that selects just test content.

The most recent version will never be deleted. Currently, this built-in job can only be applied to blog posts and pages.

Follow these steps to set up the job:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Prune Old Page Versions.
4.  Enter a Name.
5.  Select a User.
    
    When the job runs, the user is logged as the one who made the change. You should specify a user that has permission to edit the pages you want to prune. Specifying an admin account does not necessarily mean all pages will be pruned. CQL respects permissions even against an admin account.
    
    Tip: You can create a user to assign for jobs like this. For example, _ScriptRunner Bot User_.
    
6.  Enter an Interval/Cron Expression.
    
    Determine how often you want this job to run. You can select Show Examples to use an included expression or enter your own. You have two options for this field:
    
    -   Interval: The easiest way to fill out this field is to enter an interval of minutes. For example, if you want the job to run every 30 minutes, enter 30. If you want it to run every 24 hours, enter 1440.
    -   Cron: If you need the job to run on a more detailed schedule, use a [cron expression](https://www.quartz-scheduler.org/api/1.8.6/org/quartz/CronExpression.html). For example, if you want the job to run at 12:30 AM on Sundays, use the cron _0 30 0 ? \* SUN_. Another example is if you want the job to run every minute, use the cron _0 0/1 \* 1/1 \* ?_.
    
7.  Enter a CQL Query to select pages you want the job to run on.
    
    Tip: CQL tips
    
    -   CQL autocomplete is available for this job. Start typing to see possible CQL statements.
    -   Visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide) for help with CQL.
    
8.  Specify your parameters for which versions to remove. You must enter at least one of the following, but you can provide both:
    
    -   Use Minimum Versions to Keep to select which versions to retain.
        
        Blank retains only the current version.
        
    -   Use the Page Version Age to determine the items to be deleted.
        -   The _Preset Filters_ are:
            -   Older than six months
            -   Older than one year
            -   Older than two years
        -   You also have the option to select a Custom Filter, Older Than . If you select the Older Than value, a screen appears where you choose inputs.
    
9.  Click Add.

Your job now appears on the Jobs page of ScriptRunner. It will run when specified in the script, and you can choose to run it at other times. You can also enable and disable it.

## Example

To remove versions older than 90 days and ensure there are always two historical versions, use this configuration:

1.  For Name, enter Delete old page versions older than 90 days.
2.  Enter the admin User.
3.  For Interval/Cron Expression, enter 0 30 0 ? \* SUN to run at 12:30 on Sundays.
4.  Enter the CQL Query of space=DS and type=page to run on pages in the Demonstration Space.
5.  Enter 3 for Minimum Versions to Keep to make sure there are two historical versions.
6.  For Page Version Age, select Older Than and then enter 90 Days in the fields that appear.
7.  Select Add.
    

## Advanced example idea

It's possible to have a general configuration for all spaces, for example, keep all versions made within the last three months and a minimum of three, but more restrictive settings for certain spaces. You would do this simply by setting up two jobs.
