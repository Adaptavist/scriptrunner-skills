# Bulk Delete Attachments

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-3efeefb1-6c30-4941-9660-cba44e8106ac-bf776d3a8447caa0
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#bulk-delete-attachments--en

You can delete all attachments (or all attachments within the selected time range) for a page or multiple pages using _Bulk Delete Attachments_.

This saves time and energy when there are many attachments that need to be removed.

Note: If the attachment has been modified, the age refers to the modified date, not the creation date.

## Run the script

Follow these steps to run the built-in script.

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Bulk Delete Attachments.
3.  Enter the space you want to work with in Space.
4.  When Page Trees(s) appears, you can select specific pages within the space to work with, or you can select the entire space.
5.  Select the Attachment Age of items to be deleted.
    
    The Preset Filters are:
    
    -   Older Than Six Months
    -   Older Than One Year
    -   Older Than Two Years
    -   Created Within Last Month
    -   All
    -   A Custom Filter. Your choices are:
        
        -   Created within the last
            
            Created Within the Last appears, where you can enter a number and Days, Weeks, Months, or Years to determine the age of attachments to delete.
            
        -   Older than
            
            Older Than appears, where you can enter a number and Days, Weeks, Months, or Years to determine the age of attachments to delete.
            
        -   Created Between Range
            
            Created between/range appears, where you can select two dates to determine the age of attachments to delete.
            
6.  Select whether you want to send Notifications for this update.
    
    If you check the box, updates will go to all users who watch the page.
    
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, a list of the deleted attachments appears.
