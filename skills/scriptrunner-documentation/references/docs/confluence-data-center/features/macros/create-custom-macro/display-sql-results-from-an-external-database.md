# Display SQL Results from an External Database

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Macros > Create Custom Macro
- Doc ID: doc-sr4c-20bec853-8bb5-47da-9f56-975eb17705de-28a3b34f5d3e891c
- Source: https://docs.adaptavist.com/sr4c/latest/features#macros--en#create-custom-macro--en#display-sql-results-from-an-external-database--en

If you want to display SQL results from an external database in a table, you can easily accomplish this with a custom script macro.

For this example, we are going to use data from an external pet store database. To display a table with this store data, follow these steps:

1.  Create a resource to configure an external database connection.
    
    Tip: See [External Database Connection](https://docs.adaptavist.com/sr4c/latest/features/resources/external-database-connection) for more information.
    
2.  Select the Create Macro button on the Macro page.
3.  Select Custom Script Macro.
4.  Configure your custom script macro by filling out the following fields:
    
    1.  Key: pet-store-table
    2.  Name: Pet store database table
    3.  Description: Table displaying SQL results from an external pet store database
    4.  Body Type: None
    5.  Output Type: Block
    6.  Skip the Parameter section.
    7.  Enter the following code for Macro Code:
        
        ```
        import com.onresolve.scriptrunner.db.DatabaseUtil
        import com.onresolve.scriptrunner.db.NoSuchDataSourceException
        import groovy.xml.MarkupBuilder
        
        /* You will replace 'petstore' with whatever you named your pool when
        configuring your Resource. */
        def rows
        try {
            rows = DatabaseUtil.withSql('petstore') { sql ->
                sql.rows('select NAME, SPECIES, ID From petstore')
            }
        }
        catch (NoSuchDataSourceException e) {
            return "Data source is invalid: ${e.message}"
        }
        
        def writer = new StringWriter()
        /* Notice our use of Groovy’s MarkupBuilder here. This is a helper class for creating XML or HTML markup.
        It’s very important to use the MarkupBuilder here to ensure your HTML is safe. */
        def builder = new MarkupBuilder(writer)
        
        builder.table('class': 'aui') {
            tr {
                rows.first().keySet().each { key ->
                    th {
                        mkp.yield(key)
                    }
                }
            }
            rows.each { columns ->
                tr {
                    columns.each { Map.Entry cell ->
                        td {
                            if (cell.value) {
                                mkp.yield(cell.value)
                            }
                        }
                    }
                }
            }
        }
        
        writer.toString()
        ```
        
        Tip: For more information on MarkupBuilder and safe HTML, check out [Security and Best Practices](https://docs.adaptavist.com/sr4c/latest/features/macros/create-custom-macro/security-and-best-practices).
        
    8.  Skip the Macro Javascript Code, Macro CSS Style, and Lazy Loaded fields.
    
5.  Click Add.
6.  View your new macro when the _Macro_ page loads.
    

## Result

When the macro is used on a page and the results load, it looks like the following image:
