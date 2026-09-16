# Resources

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features
- Doc ID: doc-sr4js-6b382c8a-1ce9-4caf-8924-6eb503b88fd3-05ffec932b13ed9c
- Source: https://docs.adaptavist.com/sr4js/latest/features#resources--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is not available in Cloud, however alternative solutions are available.<br>[Cloud Feature Parity documentation](https://docs.adaptavist.com/sr4js/latest/scriptrunner-migration/scriptrunner-migration-to-cloud/feature-parity-and-script-alternatives#resources--en) |

The Resources feature allows you to add connections to databases for use in scripts, and other places. For example:

-   Workflow Validator: Use to check that a particular item exists in your contracts database.
-   Post-Function: Use to update a sales database with a link to the current ticket.

ScriptRunner manages a [connection pool](https://en.wikipedia.org/wiki/Connection_pool), allowing database connections to be reused when future requests are required. A connection pool eliminates the need to close a connection after each use or specify connection details, such as passwords, in scripts. Instead of entering specific connection information, you can refer to the pool name entered when configuring the connection.

The Resources page lists all previously configured database connections.

## Browse Resources

After selecting Create Resources, you can use the _Search ScriptRunner Functionality_ search bar to search the available resources.

For example, if you're looking for a resource that works with local databases, you could type "Local" and press Enter. Then, the list of resources is narrowed down to only those containing the word "local" in their title or description.
