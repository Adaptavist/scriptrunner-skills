# Rename Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-c5753b72-88fe-40f3-b9b8-6e17cc410697-cf6001a25d40231e
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#rename-pages--en

Use this built-in script to change the titles of pages.

Warning: Limitation

If a Draft version of a page exists, that version will not be renamed when the Rename Pages script updates a parent version of the same page.

## Run the script

Follow these steps to run the built-in script:

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Rename Pages.
3.  Enter the Space you want to work with.
4.  Determine what part of the title you want to change and fill out at least one of the following fields:
    
    -   Enter text you want at the beginning of the title in Title Prefix.
    -   Enter text you want at the end of the title in Title Suffix.
    -   Use Title Replace to find and replace words in a title when renaming pages. Both of the following fields are required:
        1.  Enter the word from the original page that you want to replace in Find in Title.
        2.  Enter the new word you would like to replace the old word with in Replace With.
    
5.  Check Notifications if you want to send notifications for updates.
    
    If Notifications is not checked, watchers of the page do not receive an email notification that the page has been renamed.
    
6.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the Result of the script appears.
    

## Example

### Rename all pages to include information about their space

If you want to rename all pages in a space to include information about the space, you can use this script. For example, you could rename pages in a Demonstration Space to include the word "Demo" at the beginning of the page and replace the word "edit" with "update," follow these steps:

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Rename Pages.
3.  Enter Demonstration Space for Space.
4.  Select the entire space for Pages.
5.  Enter Demo - for Title Prefix.
6.  For Title Replace, enter edit and update for Replace With.
7.  Leave Notifications unchecked to not send notifications to watchers.
8.  Select Run.
    

You will get a notification about how many pages have been renamed.
