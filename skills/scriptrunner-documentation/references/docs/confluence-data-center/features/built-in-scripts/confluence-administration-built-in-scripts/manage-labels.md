# Manage Labels

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4c-4f319fb5-58aa-45de-b33c-1dd2302a4630-b752695be0a87017
- Source: https://docs.adaptavist.com/sr4c/latest/features#built-in-scripts--en#confluence-administration-built-in-scripts--en#manage-labels--en

Use this script to rename, add, and remove page labels in bulk.

CAUTION: Labels can't contain spaces or uppercase letters. If you want a label to contain more than one word, use an underscore or a hyphen, which are the only two special characters allowed. They can contain a maximum of 255 characters.

## Run the script

There are three ways to run this script, outlined in the following tasks:

### Adding Labels

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Manage Labels.
3.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
4.  Choose the Location.
    
    -   To work with an entire space, choose Select Space(s), and then choose the Target Space(s).
    -   To work with certain pages in a space, choose Select page(s) within a specific space, and then choose the Space and Page(s).
    
    Note: This is unavailable if you're working with _All Content Types_ in Content Type.
    
5.  For Label Action, choose Add Label(s).
6.  Enter the Label Name(s) you would like to add to the selected space and pages.
    
    CAUTION: If _All Content Types_ is selected for Content Type, the action also applies to attachments on pages.
    
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them.
    
    Once you select Run, the Results of the script appears.
    

The labels that were added appear on the Result list:

### Removing Labels

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Manage Labels.
3.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
4.  Select the Location where you want to run the script:
    
    -   To work with all spaces, choose All Spaces.
    -   To work with certain spaces, choose Select Space(s), and then select the Target Space(s).
    -   To work with certain spaces and pages, choose Select page(s) within a specific space, and then choose the Space and Page(s).
    
    Note: This is unavailable if you're working with _All Content Types_ in Content Type.
    
5.  Select Remove Label(s).
6.  Enter the Label Name(s) you would like to be removed from selected or all spaces.
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them. Once you select Run, the results of the script appear.
    

The removed labels appear in the Result list:

### Renaming Labels

1.  Navigate toGeneral Configuration > ScriptRunner > Built-in Scripts.
2.  Select Manage Labels.
3.  Choose the Content Type from:
    
    -   _All Content Types_
    -   _Page_
    -   _Blog_
    -   _Attachment_
    
4.  Select the Location where you want to run the script:
    
    -   To work with all spaces, choose All Spaces.
    -   To work with certain spaces, choose Select Space(s), and then select the Target Space(s).
    -   To work with certain spaces and pages, choose Select page(s) within a specific space, and then choose the Space and Page(s).
    
    Note: This is unavailable if you're working with _All Content Types_ in Content Type.
    
5.  Select Rename Label(s).
6.  Enter the Original Label Name(s) of the new label and the New Label Name you want the label to be called.
7.  Select Run.
    
    You can select Preview instead of Run to view changes before implementing them. Once you select Run, the result of the script appears.
    

The pages that have labels that were renamed appear in the Result list:
