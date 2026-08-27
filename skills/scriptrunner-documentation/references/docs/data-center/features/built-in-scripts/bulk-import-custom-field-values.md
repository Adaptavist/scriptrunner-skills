# Bulk Import Custom Field Values

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442887171
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/bulk-import-custom-field-values

Use this built-in script to bulk import a list of values into any custom field that supports options, such as select lists, radio buttons, and checkboxes. This built-in script removes the need to [manually add options](https://confluence.atlassian.com/adminjiraserver100/configuring-custom-field-contexts-1442845462.html#Configuringcustomfieldcontexts-Changefield%E2%80%99soptionsanddefaultvalue) to your custom fields when you configure a custom field's context, enabling you to quickly and easily add an entire list of options.

If your custom field already contains options, this built-in script appends the new options beneath the existing ones. Additionally, it bypasses any options that are already present, allowing you to update custom fields without fear of accidental deletion or duplication.

## Using this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts > Bulk import custom field values**.
    
2.  In **Name of custom field config scheme**, select the [custom field configuration scheme](https://confluence.atlassian.com/adminjiraserver100/associating-field-behavior-with-issue-types-1442845501.html#Associatingfieldbehaviorwithissuetypes-add) you wish to add the new field values to. These display below each available custom field.
    
    ![Image of a custom field being selected](/sr4js/files/latest/442887171/442887174/1/1758746783000/Bulk_import_custom_field_values.png)
    
    For more information on configuring custom fields see [Configuring a Custom Field](https://confluence.atlassian.com/adminjiraserver/configuring-a-custom-field-938847235.html).
    
3.  In the **Values to Import** text field, enter the field options.
    
    For single select lists, multi-select lists, radio buttons and checkboxes, enter each option on a new line. For example:
    
    ```
Option 1
Option 2
Option 3
Option 4
```
    
    For cascading-select lists, enter the sub-options indented (tab or two spaces) under their parents. For example:
    
    ```
ParentA
    ChildA1
    ChildA2
ParentB
    ChildB
```
    
    If your custom field already contains options, this built-in script appends the new options beneath the existing ones. Additionally, it bypasses any options that are already present, allowing you to update custom fields without fear of accidental deletion or duplication.
    
4.  Click **Preview** to see details of the changes.
    
5.  Click **Run** to add the new field options.
    
    Options are viewed in **Administration >** **Issues > Custom Fields** by clicking the ellipses next to custom field name and selecting **Configure contexts**.
