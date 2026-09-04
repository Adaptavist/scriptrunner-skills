# Connecting to a Database (Legacy)

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > resources
- Doc ID: doc-sr4js-442889063
- Source: https://docs.adaptavist.com/sr4js/latest/features/resources/connecting-to-a-database-legacy

See [Resources](https://docs.adaptavist.com/sr4js/latest/features/resources) for a simpler and more robust way of accessing databases.

## Connecting to External Databases

You may want to connect to a database in your workflow function scripts, for instance read data from an external source in a validator.

The easiest method is to use [groovy sql](http://docs.groovy-lang.org/latest/html/api/groovy/sql/Sql.html). But, there is a gotcha or two.

JDBC drivers must be loaded by the system classloader, and furthermore the [DriverManager](http://docs.oracle.com/javase/7/docs/api/java/sql/DriverManager.html) will make checks that the driver class is accessible from the classloader of the calling class. In an OSGi environment this causes problems.

So, the following code will not work:

```
import groovy.sql.Sql

Sql.newInstance("jdbc:postgresql://localhost:5432/jira_62", "jiradb", "")
```

you will get an error: _No suitable driver found for jdbc:postgresql://localhost:5432/jira\_62_

Instead, manually load the driver class and create the connection:

```
import groovy.sql.Sql
import java.sql.Driver

def driver = Class.forName('org.postgresql.Driver').newInstance() as Driver // <1>

def props = new Properties()
props.setProperty("user", "devtools") // <2>
props.setProperty("password", "devtools")

def conn = driver.connect("jdbc:postgresql://localhost:5432/jira_6.4.6", props) // <3>
def sql = new Sql(conn)

try {
    sql.eachRow("select count(*) from jiraissue") {
        log.debug(it)
    }
} finally {
    sql.close()
    conn.close()
}
```

Driver jar files should be placed in your tomcat/lib directory, eg <jira.install>/lib, but Jira already ships with the major drivers.

### Querying the Current Jira Database

You can execute a query against the current Jira database, for instance in reports. Here’s how:

```
import com.atlassian.jira.component.ComponentAccessor
import groovy.sql.Sql
import org.ofbiz.core.entity.ConnectionFactory
import org.ofbiz.core.entity.DelegatorInterface

import java.sql.Connection

def delegator = (DelegatorInterface) ComponentAccessor.getComponent(DelegatorInterface)
String helperName = delegator.getGroupHelperName("default")

def sqlStmt = """
    SELECT     project.pname, COUNT(*) AS kount
    FROM       project
               INNER JOIN jiraissue ON project.ID = jiraissue.PROJECT
    GROUP BY project.pname
    ORDER BY kount DESC
"""

Connection conn = ConnectionFactory.getConnection(helperName)
Sql sql = new Sql(conn)

try {
    StringBuffer sb = new StringBuffer()
    sql.eachRow(sqlStmt) {
        sb << "${it.pname}\t${it.kount}\n"
    }
    log.debug sb.toString()
}
finally {
    sql.close()
}
```

Direct database update queries are not recommended in Jira. Instead, we recommend adding or modifying data using Jira’s APIs (via ScriptRunner). If you absolutely must modify data in your database via direct database queries, always [back up](https://confluence.atlassian.com/adminjiraserver071/backing-up-data-802592964.html) your data before performing any modification to the database.
