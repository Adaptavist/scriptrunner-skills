# Bulk Delete Attachments Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-e5e5474b-a594-4d8e-87b7-ab5ed6d13a67-f8a441574e49de34
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#bulk-delete-attachments-job--en

Using the _Bulk Delete Attachments_ job, you can schedule attachments to be deleted based on selected criteria.

An example is available at the bottom of the page.

## Create a Bulk Delete Attachments job

Follow these steps to create a job:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Bulk Delete Attachments Job.
4.  Enter a Name to help you identify the job.
5.  Enter the User that the job runs as.
    
    Tip: You can create a user specifically for the automated jobs. For example, _automation user._
    
6.  Enter the Space you would like the job to operate within.
7.  Select the page tree and/or pages on which you want the attachments to be evaluated for Page Tree(s).
8.  Select the Attachment Age to choose the age of attachments that will be deleted.
    
    Your choices are
    
    -   Preset Filters
        -   _Older than six months_
        -   _Older than one year_
        -   _Older than two years_
        -   _Created within the last month_
        -   _All_
    -   Custom Filters
        -   Created with the last
            
            If you choose this, Created Within the Last appears, where you can select your numerical value and _Days_, _Weeks_, _Months_, or _Years_.
            
        -   Older than
            
            If you choose this, Older Than appears, where you can select your numerical value and _Days_, _Weeks_, _Months_, or _Years_.
            
    
9.  Select the checkbox for Notifications if you want to send notifications for the update.
10.  Select Add.
     
     You can also select Run Now to run the job immediately.
     

## Examples

Delete all attachments older than three years in a space

If you want to maintain a _Demonstration Space_ by deleting all attachments older than three years, every year, follow these steps:

1.  Enter Delete attachments older than 3 years old every January 1 for Name.
2.  Enter admin for User.
3.  Enter 0 0 0 1 1 ? for Interval/Cron Expression.
4.  Select Demonstration Space for Space.
5.  Select all the page trees for Page Tree(s).
6.  Select Older Than for Attachments Age.
7.  Enter 3 and select Years for Older Than.
8.  Leave the Notifications checkbox blank.
9.  Select Add.
    

That job is now saved to the main _Jobs_ page, and it will run every January 1 at 12 AM.
