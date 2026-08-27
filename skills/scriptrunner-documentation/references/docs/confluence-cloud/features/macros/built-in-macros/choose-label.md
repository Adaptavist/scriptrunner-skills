# Choose Label

- Platform: confluence-cloud
- Space: SR4CC
- Hierarchy: features > macros > built-in-macros
- Doc ID: doc-sr4cc-114204692
- Source: https://docs.adaptavist.com/sr4cc/latest/features/macros/built-in-macros/choose-label

View [Macro Migration Tips](https://docs.adaptavist.com/sr4cc/latest/migration/feature-parity/macro-migration-tips) for more information about this macro from Confluence Server or Data Center. 

Using the _Choose Label_ macro, you can add labels and generate suggested labels to a page if they are not present.

When you edit or create a page in Confluence Cloud, you can use ScriptRunner for Confluence Cloud to choose labels for a page:

1.  Select **Insert**, and then search _Choose_.  
    ![](/sr4cc/files/latest/114204692/563708411/1/1782315977000/insert_choose_labels.png)
    
2.  Select the **Choose Label** macro from the provided list.
    
3.  Complete the following fields as needed:  
    ![](/sr4cc/files/latest/114204692/563708410/1/1782315977000/fields_for_choose_labels_macro.png)  
    
    Field
    
    Description
    
    Type
    
    Default
    
    Required
    
    Tip
    
    **Title**
    
    Specify a title for the macro that is displayed above it.
    
    string
    
    none
    
    no
    
    N/A
    
    **Labels**
    
    Specify the labels using a comma-separated list.
    
    string
    
    none
    
    yes
    
    -   Labels must obey naming restrictions imposed by Atlassian. Certain characters (:, ;, ., ,, ?, &, \[, \], (, ), #, ^, \*, @, !, ', \`, spaces) are not allowed.
        
    -   Some restricted characters are modified when possible to allow successful application of labels.
        
    
    **Descriptions**
    
    Specify label descriptions using a comma-separated list. If this field is left empty, the description of each label is the same as the label. If populated, the length of the description and label field must match.
    
    string
    
    none
    
    no
    
    None
    
    **Button Text**
    
    Specify custom text for the **Add Label** button.
    
    string
    
    _Add Label_
    
    no
    
    N/A
    
    Mixing languages on a Confluence page results in undefined label suggestion behavior.
    
    4\. Click **Publish** (or **Update**), and the macro appears on the page.  
    ![](/sr4cc/files/latest/114204692/563708409/1/1782315977000/choose_labels_placeholder_macro.png)  
    

When the page where the macro is located is opened, the _Choose Label_ macro is shown and only the applicable labels are shown. If all the provided labels are already present on the page, the macro is not shown.

You will see the page labels appear once the page is refreshed.
