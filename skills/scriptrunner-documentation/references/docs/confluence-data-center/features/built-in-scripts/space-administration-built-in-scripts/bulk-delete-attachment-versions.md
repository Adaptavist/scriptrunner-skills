# Bulk Delete Attachment Versions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Space Administration Built-In Scripts
- Doc ID: doc-sr4c-8bdc2794-71b3-4c29-a275-262481c0ecc0-c6db87ddd5f5e00c
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#space-administration-built-in-scripts--en#bulk-delete-attachment-versions--en

Use this script to delete old attachment versions throughout your instance.

Warning: You can only use this script to work with spaces that you have admin permissions to.

Since old versions are kept each time a new version is saved, this can free up a lot of space in your instance.

## Run this script

To use this script, follow these steps:

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Bulk Delete Attachment Versions.
4.  In CQL Query, enter a query to select attachments.
    
    Tip: CQL tips
    
    -   This field has CQL autocomplete. Start typing to see suggestions.
    -   You can select Show Examples to see and use example queries.
    -   For help with CQL, visit [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).
    
5.  Specify the minimum age of attachment versions you want to delete in Attachment Version Age.
6.  Specify the minimum number to keep regardless of the age selected in Minimum Versions to Keep. Leave the field blank if you only want to retain the latest version.
    
    CAUTION: Important information about Attachment Age Version and Minimum Versions to Keep fields
    
    -   Keeping the Minimum Versions to Keep field blank retains only the current version.
    -   The Minimum Versions to Keep field takes precedence over the Attachment Age Version field if there is an overlap between the values. Example: There are 10 attachment versions, all older than 1 year. If the script is configured to delete attachments older than 6 months and keep 3 at a minimum, v8-v10 are kept to abide by the Minimum Versions to Keep field and v1-v7 are deleted.
    -   When a Minimum Number of Versions to Keep is entered, only the latest versions are kept. Example: If there are v1-v5 and 2 are selected to keep at a minimum, v4 and v5 (the current version) are kept.
    
7.  Check the Notifications box if you want to send notifications for updates.
    
    If the Notifications box is not checked, watchers of the page do not receive an email notification that the attachment versions have been deleted.
    
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, the Result of the script appears.

## Example

### Delete attachments older than 5 years old

Follow these steps to run a script that deletes attachments in a certain space that are older than 5 years old while retaining the current version:

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Bulk Delete Attachment Versions.
4.  Enter a CQL Query to select attachments in a space, like `type = attachment and space = DS`.
5.  Enter Older than for Attachment Version Age, and then enter 5 and select Years when the Older Than fields appear.
6.  Enter 0 (or leave blank) for Minimum Versions to Keep to retain the current version.
7.  Leave Notifications unchecked.
8.  Select Run.
    

The script returns what attachments have been deleted:
