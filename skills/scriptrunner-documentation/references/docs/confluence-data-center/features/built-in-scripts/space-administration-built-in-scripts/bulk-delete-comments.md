# Bulk Delete Comments

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Space Administration Built-In Scripts
- Doc ID: doc-sr4c-a0022d2d-d76c-476b-b79e-772e73d78a1f-1651a67d5e97b065
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#space-administration-built-in-scripts--en#bulk-delete-comments--en

Using this script, you can automatically delete comments from a space or certain pages.

When you run the script, you can choose to delete all comments (including inline comments) or certain comments based on age.

This script is useful to use when comments become irrelevant because of the age.

Note: If the comment has been modified, the age refers to the modified date not the creation date.

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Bulk Delete Comments.
4.  Enter the space you want to work with in Space.
5.  When Page Tree(s) appears, you can select specific pages within the space to work with, or you can select the entire space.
6.  Select the Comment Age of items to be deleted.
    
    The _Preset Filters_ are:
    
    -   _Older Than 6 Months_
    -   _Older Than 1 Year_
    -   _Older Than 2 Years_
    -   _Created Within Last Month_
    -   _All_
    -   A _Custom Filter_. Your choices are:
        -   _Created within the last_
            
            Created Within the Last appears, where you can enter a number and _Days_, _Weeks_, _Months_, or _Years_ to determine the age of attachments to delete.
            
        -   _Older than_
            
            Older Than appears, where you can enter a number and _Days , Weeks, Months,_ or _Years_ to determine the age of attachments to delete.
            
        -   _Created Between Range_
            
            Created between/range appears where you can select two dates to determine the age of attachments to delete.
            
    
7.  Select whether you want to send Notifications for this update.
    
    If you check the box, updates will go to all users who watch the page.
    
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, a list of the deleted comments appears:

## Examples

You can use the Bulk Delete Comments script in the following situations:

-   When comments become irrelevant due to content changes, delete comments after the date of the last change.
-   When storage space is limited and comments are not being tracked and are irrelevant, delete those older than six months.
-   When a space comment policy is updated, delete recorded comments.
