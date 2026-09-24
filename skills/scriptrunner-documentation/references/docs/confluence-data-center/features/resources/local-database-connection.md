# Local Database Connection

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Resources
- Doc ID: doc-sr4c-caa59634-6605-44b6-988c-c19b8943cdf9-19f9c13f6b5d8330
- Source: https://docs.adaptavist.com/sr4c/latest/features#resources--en#local-database-connection--en

Local database connections connect to the current database your Atlassian application is using.

Tip: Where possible, you should always use an application's API to retrieve data rather than its database.

To set up a local database connection and make the local database (the one that your Atlassian application is using) available to scripts, follow these steps:

1.  Navigate to General > Configuration > ScriptRunner > Resources.
2.  Select Create Resource > Local Database Connection.
3.  Provide a name for the connection in Pool Name.
    
    For local connections, we recommend the name local.
    
4.  Optionally, enter a query into the SQL field to test receiving information from the database. Use Preview to test out different queries.
    
    Note: This SQL query is not saved and is used only for testing the connection.
    
    SQL can be used to run queries that are harder to achieve using the API. For example, aggregate queries.
    
5.  If the preview is successful, click Add.
    
    Note: The local connection is always read-only (except in the case of H2, where this driver does not support it).
    

Use database resources in scripts

Having set up a local connection, you can use it in a script as follows:

```
import com.onresolve.scriptrunner.db.DatabaseUtil 
DatabaseUtil.withSql('local') { sql -> 
 sql.rows('select * from spaces') 
}
```

`DatabaseUtil.withSql` takes two arguments:

1.  The name of the connection as defined by you in the Pool Name parameter when adding the connection (in this example, local),
2.  A closure. The closure receives an initialized [`groovy.lang.Sql`](http://docs.groovy-lang.org/latest/html/api/groovy/sql/Sql.html) object as an argument. See [executing SQL](http://groovy-lang.org/databases.html#_executing_sql) for more information on executing queries. The benefit of using a closure is that it returns the connection to the pool after execution.

The `withSql` method returns whatever the closure returns, so as another example, you could get the number of spaces using:

```
import com.onresolve.scriptrunner.db.DatabaseUtil 
DatabaseUtil.withSql('local') { sql -> 
 sql.firstRow('select count(*) from spaces')[0] 
}
```
