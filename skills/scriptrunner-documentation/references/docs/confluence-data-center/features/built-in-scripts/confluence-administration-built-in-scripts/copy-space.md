# Copy Space

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-538d8578-9a8c-46e2-99cd-1b9d909915c3-b4c723f3a0085b3e
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#copy-space--en

You can make a complete copy of an existing space using _Copy Space_.

The following data is copied when using this script:

-   Space description
-   Theme, including any custom content and style sheets
-   All content, including attachments, and comments
-   Space templates
-   Space permissions

Note: Page and comment likes are not copied.

## Run the script

Follow these steps to run the built-in script:

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select Copy Space.
3.  Enter the space that you want to copy in Source Space.
4.  Enter the key of the new space in Target Space Key.
5.  Enter the name of the new space in Target Space Name.
6.  Select additional/optional content that you want to be copied:
    
    -   _Inline Comments_
    -   _Page Comments_
    
7.  For the Notifications checkbox, choose if you want to send a notification to users when copying the space.
    
    Note: Atlassian doesn't provide a way to suppress notifications for users mentioned in a comment in Confluence. Any user mentioned in a comment gets notified whether the Notifications checkbox is checked or not if comments are copied.
    
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, the Result of the script appears.

## Example

Copy a demonstration space

If your company has a _Demonstration Space_ set up with test information where you can demo new features, you can copy that into a new space to manipulate data without affecting the space for other users. Follow these steps to set up the _Demonstration Space_ for your demo:

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts .
2.  Select Copy Space.
3.  Enter Demonstration Space for Source Space.
4.  Enter the Target Space Key that you want your new space to have. For this example, we'll use NLDS for "New Listener Demonstration Space."
5.  Enter the new Target Space Name of New Listener Demonstration Space.
6.  Check Inline Comments and Page Comments to copy both types of comments to the new space.
7.  Leave Notifications unchecked because we don't want to send notifications for a demonstration space.
8.  Click Run.
    

You receive a message with the new name of your space, with a link to the space.
