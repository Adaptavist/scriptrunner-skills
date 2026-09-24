# Copy Pages

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-831e5a99-3671-4b36-a020-97d5d0e891a4-22f4b4b28286f882
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#copy-pages--en

Use _Copy Pages_ to copy a page tree or pages from one location to another.

To run the built-in script, you must have permission to view all the pages you are copying and permission to edit the target root page.

## Run the script

Follow these steps to run the built-in script:

1.  Navigate to General Configuration > ScriptRunner > Built-in Scripts.
2.  Select Copy Pages.
3.  Enter a space in Source Space to select the space the page tree is copied from.
4.  Select the checkbox next to the page tree or pages you want to work with for Source Pages.
5.  Enter a space in Target Space to select the page the information is copied to.
6.  Select a checkbox next to the page that you want the information to be copied to in Target Page.
7.  Enter the text you want at the beginning of the title in Title Prefix.
8.  Enter the text you want at the end of the title in Title Suffix.
9.  Use Title Replace to find and replace words in a title when copying.
    
    Note: To copy a page within the same space, manipulate the titles with a groovy closure because titles must be unique.
    
10.  Use the checkboxes for Inline Comments and Page Comments to choose to copy that content with the pages.
11.  Use the Notifications checkbox to send notifications for the update.
12.  Use Code Transform to transform parts of the Confluence page with custom code.
13.  Select Run.
     
     You can select Preview instead of Run to view changes before implementing them.
     
     Once you select Run, the Result of the script appears.
     

## Example

### New version of product documentation

When a new version of a product is released, product documentation is released with it. You can copy the entire documentation page tree using _Copy Pages_.

In this example, we will copy the pages of the _Your Documentation Version 1_ to _Your Documentation Version 2_, using Title Replace to rename pages with the version number.

Follow these steps to run the script:

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Copy Pages.
3.  Enter Your Documentation for Source Space.
4.  Select Version 1 in the Source Pages page tree.
5.  Enter Your Documentation Version 2 in Target Space.
6.  For Title Replace, enter Version 1 in the first field and Version 2 in the second field.
7.  Select Run.
    

When you select Run, the pages are copied into _Your Documentation Version 2_.

Note: Links and image links within the copied page tree automatically update to reflect any new page titles. If you have a link where "v1.0 Product Doc/Introduction" links to "v1.0 Product Doc/Getting Started", the copied page tree "Introduction" links to "v2.0 Product Doc/Getting Started."
