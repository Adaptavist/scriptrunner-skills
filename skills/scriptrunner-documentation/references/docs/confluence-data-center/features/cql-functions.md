# CQL Functions

- Platform: confluence-data-center
- Space: SR4C
- Hierarchy: Features
- Doc ID: doc-sr4c-d39ecf52-8161-4542-9023-1f4c5ad39471-fcb4678e46324c1a
- Source: https://docs.adaptavist.com/sr4c/latest/features#cql-functions--en

Confluence Query Language (CQL) allow you to create custom [CQL Functions](https://developer.atlassian.com/confdev/confluence-plugin-guide/confluence-plugin-module-types/cql-function-module) that perform advanced searches for content in Confluence.

Your search results will take the same form as the Content model returned by the Content REST API. Some examples are:

-   Search all pages that contain a specific label
-   Retrieve all pages linked to a specific page
-   Search all pages that make use of the specified plugin

Tip: CQL Resources

For help with CQL, check out [CQL Guide](https://docs.adaptavist.com/sr4c/latest/get-started/cql-guide).

Read more about CQL Functions in Atlassian's [Confluence CQL Function Module documentation](https://developer.atlassian.com/confdev/confluence-server-rest-api/advanced-searching-using-cql) .

## Custom CQL Functions

Using custom CQL functions in ScriptRunner for Confluence allows you to create and share custom CQL functions (values) with your users in order to empower their search. For example, you could set a function to encompass all content with labels in your instance. For a large instance, this query could include multiple CQL statements that could get complicated very fast. Creating this custom function would allow your users to use that and perform a basic CQL query, like `pages = AllAttachments`. For help with this, visit [Custom CQL Functions](https://docs.adaptavist.com/sr4c/latest/features/cql-functions/custom-cql-functions).
