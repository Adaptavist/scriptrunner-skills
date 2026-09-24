# Manage Labels

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Space Administration Built-In Scripts
- Doc ID: doc-sr4c-68a0af10-0b03-4937-98cd-68e00ee6ce38-fdb4ff9107ad5622
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#space-administration-built-in-scripts--en#manage-labels--en

Use this script to rename, add, and remove page labels in bulk.

Warning: You can only change labels within spaces that you have space administrator permissions for.

CAUTION: Labels can't contain spaces or uppercase letters. If you want a label to contain more than one word, use an underscore or a hyphen, which are the only two special characters allowed. They can contain a maximum of 255 characters.

## Run the script

There are three ways to run this script, outlined in the following tasks:

### Adding Labels

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Manage Labels.
4.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
5.  Choose the Location.
    
    -   To work with an entire space, choose Select Space(s), and then choose the Target Space(s).
    -   To work with certain pages in a space, choose Select page(s) within a specific space, and then choose the Space and Page(s).
    
    Note: This is unavailable if you're working with _All Content Types_ in Content Type.
    
6.  For Label Action, choose Add Label(s).
7.  Enter the Label Name(s) you would like to add to the selected space and pages.
    
    Note: If _All Content Types_ is selected for Content Type, the action also applies to attachments on the page.
    
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the results of the script appear.
    

The labels that were added appear on the Result list:

### Removing Labels

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Manage Labels.
4.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
5.  Select the Location where you want to run the script:
    
    -   To work with all spaces, choose All Spaces.
    -   To work with certain spaces, choose Select Space(s), and then select the Target Space(s).
    -   To work with certain spaces and pages, choose Select page(s) within a specific space, and then choose the Space and Page(s).
    
    Note: This is unavailable if you're working with _All Content Types_ in Content Type.
    
6.  Select Remove Label(s).
7.  Enter the Label Name(s) you would like to be removed from selected or all spaces.
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them. Once you select Run, the results of the script appear.
    

The removed labels appear in the Result list:

### Renaming Labels

1.  Select Space Tools from the bottom left-hand corner of the screen.
2.  Select Advanced Space Functionality.
3.  Select Manage Labels.
4.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
5.  Select the Location where you want to run the script:
    
    -   To work with all spaces, choose All Spaces.
    -   To work with certain spaces, choose Select Space(s), and then select the Target Space(s).
    -   To work with certain spaces and pages, choose _Select page(s) within a specific space_, and then choose the Space and Page(s).
    
    This is unavailable if you're working with _All Content Types_ in Content Type.
    
6.  Select Rename Label(s).
7.  Enter the Original Label Name(s) of the new label and the New Label Name you want the label to be called.
8.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the Result of the script appears.
    

The renamed labels appear in the Result list:
