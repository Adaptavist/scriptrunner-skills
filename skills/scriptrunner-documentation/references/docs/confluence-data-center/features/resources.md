# Resources

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-c4f1b337-c8ff-4195-b351-78085035c4e0-0074bea4802c7101
- Source: https://docs.adaptavist.com/sr4c/latest/features#resources--en

The _Resources_ feature allows you to add connections to databases for use in scripts and other places.

For example:

-   [CQL Escalation Service](https://docs.adaptavist.com/sr4c/latest/features/jobs/built-in-jobs/cql-escalation-services): Use to check that a particular item exists in your contracts database.
-   [Listener](https://docs.adaptavist.com/sr4c/latest/features/event-listeners): Use to update an external content management system with a link to a particular page.

ScriptRunner manages a [connection pool](https://en.wikipedia.org/wiki/Connection_pool), allowing database connections to be reused when future requests are required. A connection pool eliminates the need to close a connection after each use or specify connection details, such as passwords, in scripts. Instead of entering specific connection information, you can refer to the pool name entered when configuring the connection.

The _Resources_ page lists all previously configured database connections.

## Browse Resources

After selecting Create Resources, you can use the _Search ScriptRunner Functionality_ search bar to search the available resources.

For example, if you're looking for a resource that works with local databases, you could type Local and press Enter. Then, the list of resources is narrowed down to only those containing the word "local" in their title or description.
