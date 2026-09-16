# Add Label

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: Features > Macros > Built-In Macros
- Doc ID: doc-sr4cc-0cf1487d-3684-43c3-adc2-5184de168c83-f621901216f07435
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/add-label

Instructions for the Add Label macro.

View [Macro Migration Tips](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips) for more information about this macro from Confluence Server or Data Center.

The _Add Label_ macro enables you to add multiple specified labels to a page if they are not already present.

When you are editing or creating a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to add a label to the page.

1.  Select Insert, and then search _Add_.
    
2.  Select the Add Label macro from the provided list.
3.  Complete the Labels field.
    
    You can add multiple labels by separating them with a comma.
    
    Tip: Labels must obey naming restrictions imposed by Atlassian. Certain characters (:, ;, ., ,, ?, &, \[, \], (, ), #, ^, \*, @, !, ', \`, spaces) are not allowed.
    
    Some restricted characters are modified when possible to allow successful application of labels.
    
4.  Click Publish and the labels you added appear on the page.
    

When the page where the macro is located is refreshed, the labels are applied. If some of the labels are already present, only the missing labels are applied. If all the labels are already present, no action is taken.
