# Bulk Purge Trash Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-a1f5ea51-6f29-4552-befe-89939864fc89-4489cfd1cab78ecf
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#bulk-purge-trash-job--en

You can use _Bulk Purge Trash_ to create a job that runs on a set schedule to purge trash from all the specified spaces.

When you delete a Confluence page, it is moved to the space's trash. Deleted pages can be restored from the space's trash, but they also continue to take up database storage space. It is good housekeeping practice to regularly clear a space's trash to minimize database storage requirements.

Follow these steps to set up the script:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Bulk Purge Trash.
4.  Enter a Name for your job.
5.  Select the User.
    
    When this job runs, the user is entered as the person who made the change. If you are purging from multiple spaces, ensure that the user account specified has the appropriate permissions on all spaces.
    
    Tip: You can create a user to assign for jobs like this—for example, _Automated Purge Trash_ _._
    
6.  Enter an Interval/Cron Expression.
    
    Determine how often you want this job to run. You can select Show Examples to use an included expression or enter your own. You have two options for this field:
    
    -   If you want it to run on a schedule, enter the minutes. For example, _30_ for every 30 minutes or _120_ for every two hours.
    -   If you want it to run at a certain time or day, enter a [cron expression](https://www.quartz-scheduler.org/api/1.8.6/org/quartz/CronExpression.html).
    
7.  Choose the Location where you want this job to work.
    
    Your options are:
    
    -   All Spaces
    -   Selected Space
        
        If you choose Selected Space, the Space field appears, where you can select the space you want to work with.
        
    
8.  Select Add.
    

Note: You can also click the Run Now button, which displays a results table showing whether the job was completed successfully and the log for the job execution.
