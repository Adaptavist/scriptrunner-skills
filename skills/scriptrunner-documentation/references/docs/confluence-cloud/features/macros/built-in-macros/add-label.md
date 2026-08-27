# Add Label

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > built-in-macros
- Doc ID: doc-sr4cc-114204664
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/add-label

View [Macro Migration Tips](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips) for more information about this macro from Confluence Server or Data Center. 

The _Add Label_ macro enables you to add multiple specified labels to a page if they are not already present. 

When you are editing or creating a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to add a label to the page.

1.  Select **Insert**, and then search _Add_.  
    ![](/sr4cc/files/latest/114204664/563708404/1/1782315572000/insert_add_labels_macro.png)
    
2.  Select the **Add Labels** macro from the provided list.
    
3.  Complete the **Labels** field.  
    ![](/sr4cc/files/latest/114204664/563708403/1/1782315572000/add_labels_to_macro.png)   
    You can add multiple labels by separating them with a comma. 
    
    Labels must comply with the naming restrictions imposed by Atlassian. Certain characters (:, ;, ., ,, ?, &, \[, \], (, ), #, ^, \*, @, !, ', \`, spaces) are not allowed.
    
    Some restricted characters are modified when possible to allow the successful application of labels.
    
4.  Click **Save**. A placeholder for the macro appears on the updated page. 
5.  Click **Publish** (or **Update**), and the labels you added appear on the page.  
    ![](/sr4cc/files/latest/114204664/563708402/1/1782315572000/add_label_macro_saved_page.png)
    

When the page where the macro is located is refreshed, the labels are applied. If some labels are already present, only the missing ones are applied. If all the labels are already present, no action is taken.
