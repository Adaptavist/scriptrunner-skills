# Select Jira Project

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > database-picker > database-picker-examples
- Doc ID: doc-sr4js-442887997
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-examples/select-jira-project

This example outlines selecting a project from the Jira _Projects_ database table.

The following serves as an example only - in practice there is an existing _Project_ picker custom field provided out of the box which you would use.

The example below assumes that one [database connection](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection) has already been set up with the name `local.`

1.  Enter a **Field Name**, **Field Description** and **Field Note**.
    
2.  In this example, select **Local** under **Connection**.
    
3.  The first SQL statement in **Retrieval/Validation SQL** is retrieving a value from the database to display.
    
    ```
select id, pname from project
  where id = cast(? as numeric)
```
    
    -   `id` is the data you wish to retrieve and store in the Jira database. In this case, the Project ID.
        
    -   `pname` is the data you wish to display in the field on the _View Issue_ screen. In this case Project Name.
        
    -   `project` is the name of the queried table (for this example, jiradb.project).
        
    -   `cast` is required in this case, as the `[project.id](http://project.id)` column (the ID column being queried) in the Jira database schema is numeric. Note that if using _mysql_ you may need to cast to `SIGNED`.
        
    -   `?` is the stored value (in this case, ID).
        
        `where id = cast(? as numeric)` ensures that the ID is cast as a numeric. If the ID column is alphanumeric, this is not required.
        
4.  The second SQL statement in **Search SQL** retrieves a value from the database to display.
    
    ```
select id, pname from project
  where lower(pname) like lower(?) || '%'
```
    
    -   `lower` changes input into lower-case for both the input value and the column being searched, allowing for a case-insensitive search.
        
    -   `?` is the parameter filled with what the user types into the custom field drop-down.
        
    -   The query concatenates the input with a `%`, which means "match anything starting with this". So as the user types, this query executes, and the project name results are displayed.
        
        The `||` operator is a SQL standard, but verify the query using the target database…​ in _mysql_ for instance you would need to use `concat(lower(?), '%')'.`
        
        Without the `%` character, the control does not show anything unless the end-user types something that is an exact match to the database record.
        
        ![Image showing filled in fields for this database picker](/sr4js/files/latest/442887997/442888000/2/1758746896000/Select_jira_project.png)
        
5.  Click **Add** to create the field.
    

Now create an issue and test the field:

1.  Add the scripted field to any screens or projects and enter a value on an issue that has this field in its context.
    
2.  Return to the _Script Fields_ screen, click the **Cog** and select **Edit** on the field just created.
    
3.  Set the **Preview Issue Key** to be the issue just created.
    
4.  Click **Preview** to see how the new field displays.
    
    ![project picker preview](/sr4js/files/latest/442887997/442887999/1/1758746896000/project-picker-preview.png)

Modify the SQL query to change what information is shown, giving you more control over the display. In this example of picking a project from the Jira database, to display both the project name and the key we could use:

```
select id, pname || ' - ' || pkey from project
  where id = cast(? as numeric)
```

If you want more control over how the field renders, please see the [Database Picker Customizations](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-customizations) section.
