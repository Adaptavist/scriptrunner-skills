# Bulk Delete Comments

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-55f4188f-e9ff-41cb-90b2-a7aedc2c3c84-5b0acba159e559a7
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#bulk-delete-comments--en

Using this script, you can automatically delete comments from a space or certain pages.

When you run the script, you can choose to delete all comments (including inline comments) or certain comments based on age.

This script is useful to use when comments become irrelevant because of their age.

Note: If the comment has been modified, the age refers to the modified date not the creation date.

To run this script, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Bulk Delete Comments.
3.  Enter the space you want to work with in Space.
4.  When Page Tree(s) appears, you can select specific pages within the space to work with, or you can select the entire space.
5.  Select the Comment Age of items to be deleted.
    
    The Preset Filters are:
    
    -   Older Than Six Months
    -   Older Than One Year
    -   Older Than Two Years
    -   Created Within Last Month
    -   All
    -   A Custom Filter. Your choices are:
        
        -   Created within the last
            
            Created Within the Last appears, where you can enter a number and Days, Weeks, Months, or Years to determine the age of comments to delete.
            
        -   Older than
            
            Older Than appears, where you can enter a number and Days, Weeks, Months, or Years to determine the age of comments to delete.
            
        -   Created Between Range
            
            Created between/range appears, where you can select two dates to determine the age of comments to delete.
            
6.  Select whether you want to send Notifications for this update.
    
    If you check the box, updates will go to all users who watch the page.
    
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, a list of the deleted comments appears:  
  

## Examples

You can use the Bulk Delete Comments script in the following situations:

-   When comments become irrelevant due to content changes, delete comments after the date of the last change.
-   When storage space is limited and comments are not being tracked and are irrelevant, delete older than six months.
-   When a space comment policy is updated, delete recorded comments.
