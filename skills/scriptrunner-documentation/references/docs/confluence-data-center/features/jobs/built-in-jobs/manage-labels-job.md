# Manage Labels Job

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Jobs > Built-In Jobs
- Doc ID: doc-sr4c-e8717dd8-31ca-4aae-949e-e44a1cbea3fc-c7de869cf7d19ef8
- Source: https://docs.adaptavist.com/sr4c/latest/features#jobs--en#built-in-jobs--en#manage-labels-job--en

Use the _Manage Labels_ job to schedule routine label management.

You can manage labels on new pages and spaces, which helps your users find relevant content.

Follow these steps to set up a Manage Labels job:

1.  Navigate to General Configuration > ScriptRunner > Jobs.
2.  Select Create Job.
3.  Select Manage Labels Job.
4.  Enter a Name for your reference.
5.  Select the User.
    
    When this job runs, the user is entered as the person who made the change.
    
    Tip: You can create a user to assign for jobs like this. For example, _ScriptRunner Bot User._
    
6.  Enter an Interval/Cron Expression.
    
    Determine how often you want this job to run. You can select Show Examples to use an included expression or enter your own. You have two options for this field:
    
    -   If you want it to run on a schedule, enter the minutes. For example, _30_ for every 30 minutes or _120_ for every two hours.
    -   If you want it to run at a certain time or day, enter a [cron expression](https://www.quartz-scheduler.org/api/1.8.6/org/quartz/CronExpression.html).
    
7.  Choose the type of content that should have labels affected.
    
    Your choices are:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
8.  Choose the Location where you want this job to work.
    
    Your options are:
    
    -   All Spaces
    -   Select Space(s)
        
        If you choose Select Space(s), the Target Space(s) fields appear, where you can select what space and pages you want to work with.
        
    -   Select Page(s) Within a Specific Space
        
        If you choose Selected Space, the Space and Page(s) fields appear, where you can select what space and pages you want to work with.
        
    
    Note: Not available for All Content Types.
    
9.  Once you make your selections, you can choose an Action:
    
    -   Add Label(s)
        1.  Label(s) appears, where you can enter the labels that you want added to the page.
    -   Remove Label(s)
        1.  Label(s) appears, where you can enter the labels that you want removed from the page.
    -   Rename Labels
        1.  Original Name appears, where you enter the old label name that you want to change.
        2.  New Name appears, where you enter the new label name.
    
10.  Select Add.
     

## Example

Add a Label

Using this job, you can review and correct labels based on a parent page on a schedule. For example, you could run a weekly review to ensure that a `benefits` label was added to all pages under the main _Benefits_ page in an _HR_ space.

1.  The Name Benefits label for HR space describes the job.
2.  Enter admin for the User.
3.  Enter 0 0 17 ? \* FRI for the Interval/Cron Expression.
4.  Select Page for Content Type.
5.  For Location, choose Selected Spaces Within a Specifc Page to be able to pick a specific space.
6.  For Space, enter HR.
7.  For Page(s), select Benefits Home to work with all pages updated or created in this section.
8.  For Action, choose Add Label(s).
9.  For Label(s), enter benefits to name the label.
10.  Click Add.
     

Now, at 5:00 PM on Fridays, the job runs, and pages in the _Benefits_ section of the _HR_ space are checked to make sure the `benefits` label is there. If it's not, it will be added.

## Related content

-   [Manage Labels Event Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners/built-in-listeners/manage-labels-listener)
-   [Manage Labels Confluence Administration](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels)
-   [Manage Labels Space Administration](https://docs.adaptavist.com/sr4c/latest/features/built-in-scripts/confluence-administration-built-in-scripts/manage-labels)
