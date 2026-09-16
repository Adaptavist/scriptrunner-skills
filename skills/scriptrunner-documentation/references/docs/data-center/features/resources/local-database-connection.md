# Local Database Connection

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Resources
- Doc ID: doc-sr4js-ca596631-1ff1-4677-a55d-96fb7ba0c2fa-e7874de465700be0
- Source: https://docs.adaptavist.com/sr4js/latest/features#resources--en#local-database-connection--en

Tip: Where possible, you should always use an application's API to retrieve data rather than its database.

To set up a local database connection and make the local database (the one that your Atlassian application is using) available to scripts, follow these steps:

1.  Navigate to ScriptRunner > Resources > Add New Item > Local database connection.
2.  Provide a name for the connection in Pool Name.
    
    For local connections, we recommend the name `local`.
    
3.  Optional, enter a query into the SQL field to test receiving information from the database.
    
    Note: SQL can be used to run queries that are harder to achieve using the API, such as aggregate queries.
    
4.  Select Preview to test out different queries.
    
    Tip: The SQL query is not saved when you use Preview; this function is only used to test the connection.
    
5.  If the preview is successful, select Add.
    
    Note: The local connection is always read-only (except in the case of H2, where this driver does not support it).
    

## Use your database resources inscripts

Warning: When using SQL queries in your scripts, be cautious about SQL injection vulnerabilities. Avoid using string interpolation or concatenation to insert values directly into SQL strings. Instead, use parameterized queries or prepared statements to safely include user input or variable data in your SQL queries. This practice helps prevent potential security risks associated with SQL injection attacks.

Once you have set up a local connection, you can use it in a script as follows:

```
import com.onresolve.scriptrunner.db.DatabaseUtil
 
def nProjects = DatabaseUtil.withSql('local') { sql ->
    sql.firstRow('select count(*) from project')[0]
}
```

`DatabaseUtil.withSql` takes two arguments:

1.  The name of the connection as defined by you in the Pool Name parameter when adding the connection (in this example _local_).
2.  A closure. The closure receives an initialized [groovy.lang.Sql](http://docs.groovy-lang.org/latest/html/api/groovy/sql/Sql.html) object as an argument. See [executing SQL](http://groovy-lang.org/databases.html#_executing_sql) for more information on executing queries. The benefit of using a closure is that it is returned the connection to the pool after execution.

The `withSql` method returns whatever the closure returns, as another example, you could get the number of projects using:

```
import com.onresolve.scriptrunner.db.DatabaseUtil
 
def nProjects = DatabaseUtil.withSql('local') { sql ->
    sql.firstRow('select count(*) from project')[0]
}
```
