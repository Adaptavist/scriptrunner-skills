# Bulk Delete Attachment Versions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-a2d61646-b7fb-439b-a99b-d447c3286809-e7dd5703aabb18a4
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#bulk-delete-attachment-versions--en

Use this script to delete old attachment versions throughout your instance.

Since old versions are kept each time a new version is saved, this can free up a lot of space in your instance.

## Run this script

To use this script, follow these steps:

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Bulk Delete Attachment Versions.
3.  In CQL Query, enter a query to select attachments.
    
    Tip: CQL tips
    
    -   This field has CQL autocomplete. Start typing to see suggestions.
    -   You can select Show Examples to see and use example queries.
    -   For help with CQL, visit the [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).
    
4.  Specify the minimum age of attachment versions you want to delete in Attachment Version Age.
5.  Specify the minimum number to keep regardless of the age selected in Minimum Versions to Keep. Leave the field blank if you only want to retain the latest version.
    
    CAUTION:
    
    Important information about the Attachment Version Age and Minimum Versions to Keep fields:
    
    -   Keeping the Minimum Versions to Keep field blank retains only the current version.
    -   The Minimum Versions to Keep field takes precedence over the Attachment Version Age field if there is an overlap between the values.
        
        Example: There are 10 attachment versions, all older than one year. If the script is configured to delete attachments older than six months and keep three at a minimum, v8–v10 are kept to abide by the Minimum Versions to Keep field and v1–v7 are deleted.
        
    -   When a Minimum Number of Versions to Keep is entered, only the latest versions are kept.
        
        Example: If there are v1–v5 and 2 are selected to keep at a minimum, v4 and v5 (the current version) are kept.
        
    
6.  Check the Notifications box if you want to send notifications for updates.
    
    If the Notifications box is not checked, watchers of the page do not receive an email notification that the attachment versions have been deleted.
    
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, the Result of the script appears.

## Example

### Delete attachments older than 5 years old

Follow these steps to run a script that deletes attachments in a certain space that are older than five years while retaining the current version:

1.  Navigate to General Configuration > ScriptRunner > Built-In Scripts.
2.  Select Bulk Delete Attachment Versions.
3.  Enter a CQL Query to select attachments in a space, like type = attachment and space = DS.
4.  Enter Older than for Attachment Version Age, and then enter 5 and select Years when the Older Than fields appear.
5.  Enter 0 (or leave blank) for Minimum Versions to Keep to retain the current version.
6.  Leave Notifications unchecked.
7.  Select Run.
    

The script returns what attachments have been deleted:
