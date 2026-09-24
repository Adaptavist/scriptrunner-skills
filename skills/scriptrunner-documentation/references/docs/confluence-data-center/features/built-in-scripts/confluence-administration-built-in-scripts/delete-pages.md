# Delete Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-22132555-f9dd-424d-b516-238484d0f36f-11d46f6e590d3368
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#delete-pages--en

Use _Delete Pages_ to move a page (or pages) and all of its children to the trash.

This built-in script works around an issue where deleting a page with child pages caused the child pages to move to the top level of the space.

CAUTION: Using this built-in script requires remove privileges to each page you are trying to remove. If you don't have permission for one of the pages, then no pages are removed.

## Run the script

Follow these steps to run the built-in script:

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Delete Pages.
3.  Enter the Space to view the contained pages.
4.  Select the Pages you want to delete when the field appears.
    
    Note: If you do not select any checkboxes, an error appears that says No space or pages provided.
    
5.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    

Once you select Run, the Result of the script appears.
