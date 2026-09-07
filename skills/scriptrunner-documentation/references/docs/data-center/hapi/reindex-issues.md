# Reindex Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: hapi
- Doc ID: doc-sr4js-442888472
- Source: https://docs.adaptavist.com/sr4js/latest/hapi/reindex-issues

When you update an issue with HAPI, the issue is reindexed automatically. In general, you shouldn't need to manually reindex an issue, however there are cases where you might want to. For example, when a modification has been made directly in the Jira database, and you want to reindex impacted issues

We've therefore made it easy to reindex issues using HAPI.

## Reindex an issue

To reindex an issue with HAPI, call the `reindex` method an instance of [Issue](https://docs.atlassian.com/software/jira/docs/api/9.9.0/com/atlassian/jira/issue/Issue.html). For example:

```
        Issues.getByKey('SR-100').reindex()
```

By default, only the issue and its change history are reindexed. This behavior is to prevent performance issues when reindexing many associated entities: [JRASERVER-72469](https://jira.atlassian.com/browse/JRASERVER-72469)

If you want to also reindex the comments or worklogs of an issue, see the examples below.

## Reindex an issue with comments/worklogs

By default, when using the method above, only the issue and its change history are reindexed.

To reindex an issue and its comments and/or worklogs, call the `withComments` and/or `withWorklogs` methods within a closure. For example:

```
        Issues.getByKey('SR-100').reindex {
            withComments()
            withWorklogs()
        }
```

  

* * *

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/index/IndexingImplementation.html)
-   [Update Issues](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
