# Convert Absolute Links to Confluence Links

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-ffa53655-1512-4fd8-8096-0d4a1364f77c-0ba4631f3fdae7c2
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#convert-absolute-links-to-confluence-links--en

Prior to upgrading to recent versions of Confluence, you could have created links to pages in Confluence by copying and pasting the URL from the browser address bar.

Even though the link works, there are some problems with that method, including:

-   Loss of some features (incoming links, for example)
-   Broken links if you change the title of a page
-   Loss of functionality (changing the base URL, exporting the space to another instance without breaking links)

To avoid these problems, use _Convert Absolute Links to Confluence Links_ to convert links to the correct internal storage format. If any page has links that are required to be updated, a new page version is created, allowing you to roll back if necessary.

_Convert Absolute Links to Confluence Links_ handles links with anchors, but anchors are still difficult to use in Confluence because they contain the page name. If a link with an anchor does not work correctly before running this built-in script, the script will not fix it.

Tip: Your base URL must be set correctly for this to work, and the base URL must match the full URLs in the pages. If it does not, the links do not appear as candidates for rewriting.

Confluence includes JavaScript that automatically creates links with the correct internal storage format when you copy the address, but this functionality does not work on existing content. If you have recently upgraded your Confluence instance, you should only need to run _Convert Absolute Links to Confluence Links_ once.

Warning: Versions

If an absolute link points to any version of the page other than the current version, it won't be converted to a Confluence link.

## Run this script

Follow these steps to run the built-in script:

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts .
2.  Select Convert Absolute Links to Confluence Links.
3.  Choose one of the following:
    
    -   Select the All Spaces checkbox if you want to run the script on all global spaces.
    -   Enter the specific space you want to work with for Space.
    
4.  Select Run.
    
    You can select Preview instead of Run to view results before running the script.
    

Once you select Run, the Result of the script appears.
