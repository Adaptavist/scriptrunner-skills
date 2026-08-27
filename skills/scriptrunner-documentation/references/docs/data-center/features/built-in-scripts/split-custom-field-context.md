# Split Custom Field Context

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4js-442888243
- Source: https://docs.adaptavist.com/sr4js/latest/features/built-in-scripts/split-custom-field-context

The _Split Custom Field_ context script allows users to separate custom field contexts between two projects, duplicating the custom field values across the projects. This means they can be configured separately.

A field can have multiple custom field configuration schemes associated with it. These configuration schemes allow you to define different field options for certain contexts (for example for different projects/issue types).

This built-in script only allows you to select a custom field configuration scheme that is used by fields with options defined by the scheme, for example, _M__ulti-select_, _Single-select,_ and _Cascade-select_ fields

This built-in script is not meant for field types that do not define options within a field configuration, such as _Text fields_ or _User pickers_.

  

![Diagram example of how this built in script works](/sr4js/files/latest/442888243/442888245/1/1758746923000/split-custom-field-context-diagram.png)

  

For example, two projects are using the same custom field configuration scheme, one project needs to delete/add/deactivate a field value from a multi-select list but the other project does not. Use the _Split Custom Field Values_ script to split the shared custom field context between two projects. This creates a new context, duplicating option values, and migrating all issue field values, allowing custom field values to be edited independently.

Although it is possible to create a new field context and move the project across, this causes values for all fields associated with the original context to be lost. Using _Split Custom Field Context_ allows field contexts to be split between projects without the need to re-enter field information.

## Using this built-in script

1.  From ScriptRunner, navigate to **Built-in Scripts > Split Custom Field Context**.
    
2.  For **Name of Custom Field Config Scheme**, select the name of the config scheme that will contain the new custom field context created.
    
3.  Under **Project Name**, select the project(s) to move to the new context.
    
    ![Image of the spit custom field contexts built in script](/sr4js/files/latest/442888243/442888248/1/1758746923000/Split_custom_field_context_1.png)
4.  Issue types associated with the selected configuration scheme and selected project show in the **Issue Types** field. Select the issue type(s) to associate with the new scheme. Leave blank to select all options.
    
5.  Under **New Context Name**, give a name to the new context.
    
6.  Click **Preview** to see a summary of changes including the number of issues to be updated.
    
    ![Image of preview results](/sr4js/files/latest/442888243/442888249/1/1758746923000/Split_custom_field_context_2.png)
7.  Click **Run** to create a new custom field context for each project selected.
