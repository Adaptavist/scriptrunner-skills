# Copy Page Tree

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4cc-217a631f-d6b2-42d6-9378-179c0ba17526-816d924796aab3e9
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-scripts#copy-page-tree--en

Instructions for using the Copy Page Tree built-in script.

Using _Copy Page Tree_, you can copy all pages within a page tree; this means copying a page and all of its children to another space or within the same space. When copying, you can rename pages or add a prefix to copied pages.

Note: To use this feature, you must have _View_ permissions on all pages you're copying and _Edit_ permission in the space that you're copying the page tree into.

To use this script, follow these steps:

1.  Select the space where the page tree is currently located for Source Space.
2.  Specify the page tree that you wish to copy in Select a Space.
3.  Select the space you want to copy the page tree to Target Space.
4.  Add a Prefix to be added to the copied pages.
5.  Specify the part or whole page name you wish to transform in the Search and Replace boxes.
    
    CAUTION: If your Target Space is the space where the page tree originated, you must add a prefix or rename the pages since Confluence does not allow pages to have the same name in the same space.
    
6.  Select Run.

Note: Links and image links within the tree of pages you are copying will automatically be updated to reflect any new page titles.

After selecting Run, the results appear and let you know how long the copy took.

## Copy page tree to have a larger demonstration space

If you have a client demonstration space and want to copy a page tree to have more content in your space, follow these steps:

1.  For Source Space, enter the name of the space you want pages copied from.
    
    For this example, _Client Demonstration for CQL (CQLDS\_)_.
    
2.  For Select a Space, select the page trees you want to copy.
    
    For this example, the two demo sections.
    
3.  For Target Space, select the space you want to copy the page trees to.
    
    For this example, we are copying to the same space.
    
4.  Select a Parent Page to Copy To.
    
    For this example, we chose the main page tree.
    
5.  Enter _Copy_ in Prefix to indicate that the copied pages are copies.
6.  Select Run.
    
7.    
    
    Tip: To use Search and Replace, enter the words into the field.
    
    Search is the field for the word you want to remove, and Replace is for the new word you want to use. For example, you could replace Demo with Demonstration by filling out the fields like this:
    

Once your script runs, the pages should be copied. Here is what the copied pages will look like in the Confluence space:
