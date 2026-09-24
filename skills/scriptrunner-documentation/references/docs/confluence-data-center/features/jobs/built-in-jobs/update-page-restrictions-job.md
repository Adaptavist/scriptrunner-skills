# Update Page Restrictions Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-c596b0d2-da1b-43b1-8eb5-e11704f90d5b-08e6a246dbecb7df
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#update-page-restrictions-job--en

Use the _Update Page Restrictions_ built-in job to schedule and manage restrictions to parent and child pages.

You can automatically add or remove restrictions to entire spaces or pages and manage access for newly created spaces.

Follow these steps to create an _Update Page Restrictions_ job:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Update Page Restrictions.
4.  Fill out the Name field.
    
    This is a mandatory field. Enter a name or name that will help you identify this job.
    
5.  Select the User.
    
    When this job runs, this user is entered as who made the change.
    
    Tip: You can create a user to assign for jobs like this. For example, _ScriptRunner Bot User._
    
6.  Enter an Interval/Cron Expression.
    
    Determine how often you want this job to run. You can select Show Examples to use an included expression or enter your own. You have two options for this field:
    
    -   If you want it to run on a schedule, enter the minutes. For example, _30_ for every 30 minutes or _120_ for every two hours.
    -   If you want it to run at a certain time or day, enter a [cron expression](https://www.quartz-scheduler.org/api/1.8.6/org/quartz/CronExpression.html).
    
7.  Select the Space.
    
    You can choose one or multiple spaces here.
    
8.  Select the Page(s).
    
    You can choose the entire space here or select only certain pages.
    
9.  Choose the Restriction Level.
    
    Your choices are:
    
    -   Anyone can view and edit
    -   Anyone can view, only users and groups chosen in this script can edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can edit.
        
    -   Only users and groups chosen in this script can view and edit
        
        When you select this option, two more fields appear: Groups and Users, where you determine which users and groups can view and edit.
        
    
10.  Select Add.
     
     You could also select Run Now to run the job without adding it. When the job is finished, you see a message explaining what the job did.
     

## Examples

You can regularly run this job to ensure any parent and/or child page restrictions are in place and left there. The following examples walk you through creating a job for two different scenarios that keep restrictions in place for different groups.

### Review and correct restrictions for an entire space

1.  Set the Name to Audit Space Restrictions.
2.  Set the User to Admin.
3.  Enter 0 0 0 ? \* 2#2 \* for the Interval/Cron Expression.
    
    Note that `At 12:00 AM, on the first Monday of the month` appears to the right of the field, explaining your cron expression.
    
4.  Enter the space that you want to review.
    
    For this example, Demonstration Space is used.
    
5.  Select the space to review all pages for Page(s).
6.  Select Only users and groups chosen in this script can view and edit for Restriction Level.
7.  Enter the users and groups that you want to restrict for Groups and Users.
    
    For this example, the confluence-users group is used.
    
8.  Select Add.
    

This job will run every month to review restrictions. If any restrictions were changed, they will be corrected.

### Restrict certain groups on certain pages

If you have an instance with different groups like internal employees, external vendors, and customers, you can use this job to keep certain pages within a space locked down for certain groups but the space itself to be accessed by all groups. This job would routinely review the space to ensure restrictions are as they should be.

For this example, you can create a job that runs at the end of every week to ensure customers are the only ones that have access to certain pages in an analytics space.

1.  Set the Name to Restrict pages in analytics space for customers.
2.  Set the User to Admin.
3.  Enter `0 0 22 ? * FRI` for the Interval/Cron Expression.
    
    Note that `At 10:00 PM, only on Friday` appears to the right of the field, explaining your cron expression.
    
4.  Select Analytics for Space.
5.  Select Team Analytics for Page(s).
6.  Select Only users and groups chosen in this script can view and edit for Restriction Level.
7.  Select customers for Groups.
8.  Select Add.
    

This job will run every week to review restrictions. If any restrictions were changed, they will be corrected.
