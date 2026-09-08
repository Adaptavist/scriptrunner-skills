# Resources

- Platform: data-center
- Space: SR4JS
- Hierarchy: features
- Doc ID: doc-sr4js-441364788
- Source: https://docs.adaptavist.com/sr4js/latest/features/resources

![](/sr4js/files/latest/441364788/441364790/1/1750863774000/sr-icon-cloud.png)

**Migrating to Jira Cloud? This feature is not available in Cloud, however alternative solutions are available. Check out our [Cloud Feature Parity documentation](https://docs.adaptavist.com/display/_PK/SR4JC/feature-parity#resources) for more details.**

The _Resources_ feature allows you to add connections to databases for use in scripts, and other places. For example:

-   Workflow Validator: Use to check that a particular item exists in your contracts database.
    
-   Post-Function: Use to update a sales database with a link to the current ticket.
    

ScriptRunner manages a [connection pool](https://en.wikipedia.org/wiki/Connection_pool), allowing database connections to be reused when future requests are required. A connection pool eliminates the need to close a connection after each use or specify connection details, such as passwords, in scripts. Instead of entering specific connection information, you can refer to the pool name entered when configuring the connection.

The _Resources_ page lists all previously configured database connections.

## Browse Resources

After selecting **Create Resources**, you can use the _Search ScriptRunner Functionality_ search bar to search the available resources.

![The Create Resources screen, with the Search ScriptRunner Functionality search bar highlighted.](/files/101638459/151628069/1/1668616521000/create_resources_page.png)

For example, if you’re looking for a resource that works with local databases, you could type "Local" and press **Enter**. Then, the list of resources is narrowed down to only those containing the word "local" in their title or description.
