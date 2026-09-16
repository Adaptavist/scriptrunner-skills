# Search for Issues

- Platform: data-center
- Space: SR4JS
- Hierarchy: HAPI
- Doc ID: doc-sr4js-088c2c82-046a-48a3-9c5e-af374cb8c8c5-53c1518a10db1650
- Source: https://docs.adaptavist.com/sr4js/latest/hapi#search-for-issues--en

|  |  |
| --- | --- |
|  | Migrating to Jira Cloud? This feature is available in Cloud.<br>[HAPI Cloud documentation](https://docs.adaptavist.com/sr4jc/latest/hapi/work-with-work-items#search-for-work-items--en) |

With HAPI, we've made it easy for you to search for issues.

## Running JQL queries to search for issues

With HAPI, you can easily run JQL queries.

Note: In this example we're running a query that returns all Tasks of the ABC project.

Where the example says "do something with each issue" you can, for example, update all returned issues using the `[issue.update](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)` method.

Warning: `Issues.search` returns an Iterator. This is designed for you to iterate through the results instead of retaining many issues in memory. You should not call methods such as `size()` and `count()` on the iterator, as this will exhaust it and make any subsequent iterations return zero elements. If you require a count of the results of a JQL query, you can use `Issues.count` to get this first.

```
Issues.search("project = 'ABC' AND issuetype = 'Task'").each { issue ->
	// do something with `issue`
	log.warn(issue.key)
}
```

## Updating all returned issues

As mentioned above, you can update all returned issues using the `[issue.update](https://docs.adaptavist.com/sr4js/latest/hapi/update-issues)` method. This is particularly useful if you want to bulk update issues.

Note: In this example we're running a query to return all low priority tasks in project ABC. At the same time we're adding a comment to all returned issues and setting the priority to high.

```
Issues.search("project = 'ABC' AND issuetype = 'Task' AND priority = Low").each { issue ->
    issue.update {
        setComment('This task needs looking at')
        setPriority('High')
    }
    log.warn(issue.key)
}
```

## JQL queries and memory

We recommend that you do NOT execute queries using an unlimited `PagerFilter`. The returned issues are temporarily stored in memory if you execute a query without paging.

With HAPI, issues are fetched in batches from the Lucene index (transparent to the script), ensuring that memory usage is constant, and that you don't cause an `OutOfMemoryException`.

## Limiting list size for JQL queries

If you really need a `List` of issues, limit the size, as shown below.

```
Issues.search('project = ABC').take(1_000).toList()
```

One thousand issues in a list are acceptable, tens of thousands might be acceptable, but millions are not.

If you need a count of issues, use `count`. This provides better performance than executing a query and iterating through them all just to count them:

```
def issueCount = Issues.count('project = ABC')
```

## JQL queries and security

Permissions are respected, so will return the same set of issues as you would see if you executed the query in Jira.

If you want to return issues regardless of whether the current user can see them, use the methods `Jql.queryOverrideSecurity` and `Jql.countOverrideSecurity`. For example, if we take the examples from the section above, you would enter the following into the script console:

```
Issues.searchOverrideSecurity('project = ABC').take(1_000).toList()
```

or

```
def issueCount = Issues.countOverrideSecurity('project = ABC')
```

## Matching against an issue

Often it can be handy to check whether an issue matches a query because it's easier to test the issue's attributes with JQL, or with a user-supplied JQL string.

Note: This approach performs well as it generates a new query that incorporates the current issue key.

```
def issue = Issues.getByKey('ABC-1')
issue.matches('project = ABC') // true
```

The permissions of the current user are respected. If you want to test whether the issue matches the query regardless of permissions, use `matchesOverrideSecurity` instead of `matches`.

## Advanced HAPI JQL usage

You may want to filter the list of issues further because you want a condition you cannot express in JQL.

Note: In this example we're filtering issues assigned to admin only. We understand that this is easy to express in JQL, this is just for demonstration purposes.

```
Issues.search('project = ABC').findAll { issue ->
	issue.assignee?.name == 'admin'
}.each { issue ->
	// ...
}
```

## Limiting the number of issues searched

Groovy Development Kit methods such as `findAll` collect as many issues as they can, which isn't ideal. If you have a very large instance for tasks such as the one above or advanced data processing pipelines, you can use the java Streams API. The `stream()` method is available on the search result for convenience.

Note: In this example we're filtering issues assigned to admin only and limiting the results to 10.

```
import java.util.stream.Collectors
            
Issues.search('project = ABC')
	.stream()
	.filter { issue -> issue.assignee?.name == 'admin' }
	.limit(10)
	.collect(Collectors.toList())
```

The above example stops fetching issues and checking the condition, once ten issues have been found. Whereas similar code written with GDK methods processes all issues matching the JQL query, collects all matching the filter, and then takes ten.

Note: Using streams as above will always consume a bounded amount of memory.

## Related content

-   [Javadocs link](https://docs.adaptavist.com/api/javadoc/dc/scriptrunner/8.10.0/hapi/jira/groovydoc/com/adaptavist/hapi/jira/issues/Issues.html#search\(com.atlassian.query.Query\))
-   [Transition Issues](https://docs.adaptavist.com/sr4js/latest/hapi/transition-issues)
-   [Update Fields](https://docs.adaptavist.com/sr4js/latest/hapi/update-fields)
