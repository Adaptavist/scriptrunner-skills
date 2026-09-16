# Select from Excel Sheet

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Script fields > Built-In Script Fields > Database Picker > Database Picker Examples
- Doc ID: doc-sr4js-c2f0e447-e9d6-47ec-97ef-d4d10dd082dc-1d0b0e1a55ffb434
- Source: https://docs.adaptavist.com/sr4js/latest/features#script-fields--en#built-in-script-fields--en#database-picker--en#database-picker-examples--en#select-from-excel-sheet--en

There are JDBC drivers available for all commonly-used databases and Excel and CSV files. Therefore, you can connect to a spreadsheet containing a list of items you want to be available in a custom field.

1.  First, add the spreadsheet as a connection in [setting up an external database connection](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection).
2.  Create a scripted field.
3.  Give the field an appropriate name and description then enter the following into Retrieval/Validation SQL:
    
    ```
    select id, "First Name" || ' - ' || "Experience Level" from devs
     where id = ?
    ```
    
4.  Enter the following into Search SQL:
    
    ```
    select id, "First Name" from devs
     where "First Name" like ? || '%'
    ```
    

When applied to an issue context, the results display as a drop-down:
