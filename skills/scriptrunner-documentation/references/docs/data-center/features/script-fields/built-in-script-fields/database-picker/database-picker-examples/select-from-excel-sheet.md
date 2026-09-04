# Select from Excel Sheet

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > script-fields > built-in-script-fields > database-picker > database-picker-examples
- Doc ID: doc-sr4js-442887980
- Source: https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/database-picker/database-picker-examples/select-from-excel-sheet

There are JDBC drivers available for all commonly-used databases and Excel and CSV files. Therefore, you can connect to a spreadsheet containing a list of items you want to be available in a custom field.

1.  First, add the spreadsheet as a connection in [setting up an external database connection](https://docs.adaptavist.com/sr4js/latest/features/resources/database-connection).
    
2.  Create a scripted field.
    
3.  Give the field an appropriate name and description then enter the following into **Retrieval/Validation SQL**:
    
    ```
select id, "First Name" || ' - ' || "Experience Level" from devs
  where id = ?
```
    
4.  Enter the following into **Search SQL**:
    
    ```
select id, "First Name" from devs
  where "First Name" like ? || '%'
```
    
    ![Example showing form fields filled in with options](/sr4js/files/latest/442887980/442887983/1/1758746895000/Select_from_excel_sheet.png)  
    
    When applied to an issue context, the results display as a drop-down:  
    ![csv pick user](/sr4js/files/latest/442887980/442887982/1/1758746895000/csv-pick-user.png)
