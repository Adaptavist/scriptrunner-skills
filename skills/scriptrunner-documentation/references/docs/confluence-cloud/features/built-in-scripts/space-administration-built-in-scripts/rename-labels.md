# Rename Labels

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Built-In Scripts > Space Administration Built-In Scripts
- Doc ID: doc-sr4cc-689a1a8f-a087-4786-9b8a-e7926fd36fa4-6df2ecbe9fb8eeb3
- Source: https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/space-administration-built-in-scripts/rename-labels

Instructions for using the Rename Labels built-in script.

Using _Rename Labels_, you can rename labels on a space or all spaces.

To run this script, follow these steps:

1.  Decide if you want to work with all spaces or specific spaces.
    
    -   If you want to work with all spaces, check the All Spaces checkbox.
    -   If you want to work with specific spaces, select them in Spaces.
    
2.  Specify the label that you want to rename for Choose Label.
3.  Specify the new replacement label name for New Name.
    
    Tip: Labels are not case-sensitive.
    
    Labels can't contain spaces or uppercase letters. If you want a label to contain more than one word, use an underscore or a hyphen, which are the only two special characters allowed. They can contain a maximum of 255 characters.
    
4.  Select Run.
    

After you select Run, your results appear:

## Replace an incorrect label

A user added the label `style guide` to several pages, not realizing that spaces aren't allowed in labels, so there were two labels added: `style` and `guide.` The space administrator can use _Rename Labels_ to change one of the labels to `styleguide`, and use _Bulk Add or Remove Labels_ to delete the other label.

For this part of the label fixing, follow these steps:

1.  Select _Product Documentation_ (or the name of the space you want to work with) for Space.
2.  Enter _style_ for Choose Label.
3.  Enter _styleguide_ for New Name.
4.  Select Run.
    

You will get your success message.

Now, navigate to [Bulk Add or Remove Labels on One or More Pages](https://docs.adaptavist.com/sr4cc/latest/features/built-in-scripts/confluence-administration-built-in-scripts/bulk-add-or-remove-labels-on-one-or-more-pages) to delete the `guide` label.
