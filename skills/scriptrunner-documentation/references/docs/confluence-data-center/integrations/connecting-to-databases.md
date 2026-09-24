# Connecting to Databases

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Integrations
- Doc ID: doc-sr4c-8603370a-ff07-4bd5-bc39-fd490686bef2-8b7382a1501d2fef
- Source: https://docs.adaptavist.com/sr4c/latest/integrations#connecting-to-databases--en

Find instructions for connecting the app to databases of your choice.

Tip: See [Resources](https://docs.adaptavist.com/sr4c/latest/features/resources) for a simpler and more robust way of accessing databases.

## Querying the current Confluence database using JNDI

You can execute a query against the current Confluence database. Here's how:

```
import javax.naming.InitialContext
import javax.naming.NamingException
import javax.sql.DataSource
import java.sql.Connection
import java.sql.ResultSet
import java.sql.Statement

Logger log = Logger.getLogger("--Accessing Confluence Database--")
ClassLoader threadClassLoader = Thread.currentThread().getContextClassLoader()
Connection confluenceConnection = null

try {
    Thread.currentThread().setContextClassLoader(ContainerManager.getClassLoader())
    InitialContext ctx = new InitialContext()
    DataSource confluenceDs = (DataSource) ctx.lookup("java:comp/env/jdbc/ConfluenceDS")

    confluenceConnection = confluenceDs.getConnection()

    Statement stmnt = confluenceConnection.createStatement()
    ResultSet result = stmnt.executeQuery("SELECT count(*) FROM spaces")

    // Process result

} catch (NamingException e) {
    log.error("Connecting to Confluence database error: " + e.explanation)
} finally {
    Thread.currentThread().setContextClassLoader(threadClassLoader)

    if (confluenceConnection != null) {
        confluenceConnection.close()
    }
}
```

## Querying the current Confluence database without JNDI

The next example shows how to connect to the default Confluence H2 database:

```
import java.sql.Connection
import java.sql.DriverManager
import java.sql.ResultSet
import java.sql.SQLException
import java.sql.Statement

String USER_NAME = "sa"
String PASSWORD = ""
String DB_CONN_STRING = "jdbc:hsqldb:/confluence/home/database/confluencedb;hsqldb.tx=MVCC;readonly=true"
String DRIVER_CLASS_NAME = "org.hsqldb.jdbcDriver"

Logger log = Logger.getLogger("--Accessing Confluence DB--")
Connection connection = null
try {
    Class.forName(DRIVER_CLASS_NAME)
} catch (Exception ex) {
    log.error("Check classpath. Cannot load db driver: " + DRIVER_CLASS_NAME)
}

try {
    connection = DriverManager.getConnection(DB_CONN_STRING, USER_NAME, PASSWORD)
    Statement stmnt = connection.createStatement()
    ResultSet result = stmnt.executeQuery("SELECT * FROM spaces")

    // Process result

} catch (SQLException e) {
    log.error("Driver loaded, but cannot connect to db: " + DB_CONN_STRING)
} finally {
    try {
        if (connection != null) {
            connection.close()
        }
    } catch (SQLException e) {
        e.printStackTrace()
    }
}
```

Your database connection configuration is stored in the server.xml or <confluence\_home>/confluence.cfg.xml file. For more info have a look at the [Atlassian documentation](https://confluence.atlassian.com/confkb/how-to-find-confluence-s-database-connection-parameters-779172320.html) .

Warning: Direct database update queries are not recommended in Confluence. Instead, we recommend adding or modifying data using Confluence's APIs (via ScriptRunner). If you absolutely must modify data in your database via direct database queries, always [back up](https://confluence.atlassian.com/doc/site-backup-and-restore-163578.html) your data before performing any modification to the database.
