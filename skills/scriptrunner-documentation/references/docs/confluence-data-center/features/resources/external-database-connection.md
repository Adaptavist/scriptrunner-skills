# External Database Connection

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features > Resources
- Doc ID: doc-sr4c-d20922ac-823a-4a61-bf6f-f073e1671671-9bab11c99145c901
- Source: https://docs.adaptavist.com/sr4c/latest/features#resources--en#external-database-connection--en

External database connections are used to connect to any database.

There are two types of database connections:

-   External: Used to connect to any database, such as your sales or contacts database.
-   Local: Connects to the current database your Atlassian application is using.

The _Resources_ page lists all previously configured database connections.

To set up a connection to an external database, you need to know the following information for the database:

-   The JDBC URL
-   Any required credential information (username and password)
-   The driver class

Tip: Your database administrator should be able to provide this information if you are unsure.

To set up an external database connection and make the database available to scripts:

1.  Navigate to ScriptRunner > Resources > Add New Item > Database Connection.
2.  Provide a name for the connection in Pool Name.
3.  Enter the JDBC URL of the database to which you wish to connect.
    
    For more information on sample JDBC URLs, see [JDBC Driver Connection URL Strings](https://vladmihalcea.com/jdbc-driver-connection-url-strings/).
    
4.  Provide the Driver Class Name.
    
    Click Show examples to see a list of common driver classes.
    
5.  Enter the username required to authenticate the database in User and the corresponding Password.
    
    Note: The User and Password fields are not required if the information is provided in the URL.
    
6.  Optionally, enter a query into the SQL field to test receiving information from the database. Use Preview to test out different queries.
    
    Note: This SQL query is not saved and is used only for testing the connection.
    
7.  Again, optionally, you can set advanced connection pool properties, such as the maximum pool size. This may be useful in several cases:
    
    1.  If you are using Data Center, by default, the database resource will take ten connections per node in your cluster.
        
        Tip: If this totals too many connections, you can limit the maximum size by entering, for example: `maximumPoolSize=3`.
        
    2.  If you would like to limit a database session to ten minutes, enter `maxLifetime=600000` (ten minutes in milliseconds).
        
    3.  If you see connections are growing, it could be that a prepared statement was not closed. Enter `leakDetectionThreshold=2000` to report any connection that was borrowed from the pool for more than two seconds.
        
        Tip: Look for an exception in your logs beginning: `java.lang.Exception: Apparent connection leak detected.`
        
        If your database query is expected to take more than two seconds, then this is probably not a leak, and you should raise this value.
        
    
8.  If the preview is successful, click Add.

## Other Drivers

Tip: If you need to use another database driver (like an Excel or CSV driver), copy it into the _tomcat lib_ directory of your installation and restart. For example, this could be `/opt/<application>/lib/.`

You might want to use these to create a custom field that allows users to pick from a row in a spreadsheet.

In the example shown below, we are using a [CSV driver](https://github.com/jprante/jdbc-driver-csv). This makes available all CSV in the directory provided in the JDBC URL. So in `/tmp`, we have a CSV file called `devs.csv`.
