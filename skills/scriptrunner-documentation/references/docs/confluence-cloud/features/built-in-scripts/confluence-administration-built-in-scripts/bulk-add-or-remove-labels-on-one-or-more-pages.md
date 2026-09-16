# Bulk Add or Remove Labels on One or More Pages

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Built-In Scripts > Confluence Administration Built-In Scripts
- Doc ID: doc-sr4cc-09d15cfc-e20c-47ca-bacb-de0e8c2ac247-1c214061e7803721
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-scripts#bulk-add-or-remove-labels-on-one-or-more-pages--en

Instructions for using the Bulk Add/Remove Labels on One or More Pages built-in script.

With _Bulk Add/Remove Labels on One or More Pages_, you can add or remove labels on selected pages within a space.

Follow these steps to run the built-in script:

1.  Select the Space.
2.  In _Select a Space_, select the parent or children pages you want to update.
    
    You can select all pages within a page tree (a page and all of its children) select individual pages within a space, or a combination of both.
    
3.  For Action, specify whether to add or remove the labels.
4.  Specify the label or labels you want to work with in Labels.
    
    Tip: If you're updating multiple labels, you must separate them with a comma (example: `hr`, `internal`) .
    
    Labels can't contain spaces or uppercase letters. If you want a label to contain more than one word, use an underscore or a hyphen, which are the only two special characters allowed. They can contain a maximum of 255 characters.
    
5.  Select Run.
    

The results of the script appear after you select Run.

## Example

Add internal label to HR space

If you want to add an `internal` label to sensitive pages in a space, follow these steps:

1.  Enter HR for Space to select the _Internal HR Information_ space.
2.  For Select a Space, select which pages you want to add the label to.
    
    For this example, we'll select _Payroll_ and _Employee Locations_.
    
3.  Select _Add Labels_ for the Action.
4.  Enter _internal_ for Labels.
5.  Select Run.
    

These are the results you see after selecting Run.
