# Issue Links

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions > included-jql-functions
- Doc ID: doc-sr4js-442889353
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links

This page provides information on various functions used to find issues with links:

Spelling

It's important to note that when using these functions, especially with link names, correct spelling is crucial, as misspelled link types may result in validation errors. If you misspell a link type, the validation error will give you a list of suitable link types.

## Find issues with links (`hasLinks`)

Use `hasLinks()` to find all issues on your instance with links, for example:

```
issueFunction in hasLinks()
```

If you want to search for a specific link type, you can search for the outward or inward link description, for example, `blocks`, `is blocked by`, `duplicates`, `is duplicated by`, etc.

```
issueFunction in hasLinks("link name")
```

You can also specify the number of that link type, for example:

```
issueFunction in hasLinks("link name", "number of links")
```

### `hasLinks` examples

We want to view all the issues with `blocks` links:

```
issueFunction in hasLinks("blocks")
```

If we want to see issues with more than two `blocks` links we would use the following:

```
issueFunction in hasLinks("blocks", "+2")
```

## Find issues with specific link types (`hasLinkType`)

Use `hasLinkType()` to find issues on your instance with specific link types, for example:

  

```
issueFunction in hasLinkType("link type")
```

This function searches for issues that have the specified link type in either direction. You need to provide the name of **link type**, for example **Blocks**, **Duplicate**, **Cloners,** etc.

### `hasLinkType` examples

We want to view all the issues with the B`locks` link type:

```
issueFunction in hasLinkType("Blocks") and resolution is empty
```

These two searches are equivalent:

```
issueFunction in hasLinkType("Blocks")
issueFunction in hasLinks("blocks") OR issueFunction in hasLinks("is blocked by")
```

## Find linked issues of a subquery (`linkedIssuesOf`)

You can use `linkedIssuesOf()` to find all linked issues of a subquery: 

You can search for multiple linked issues using this function, you are not limited to one link name. 

```
issueFunction in linkedIssuesOf("subquery", "link name")
```

### `linkedIssuesOf` examples

We want to find all the unresolved issues that are blocked by issues in the **Open** state:

```
issueFunction in linkedIssuesOf("status = Open", "blocks") and resolution is empty
```

Alternatively, we want to find all issues that are linked to any unresolved issues:

```
issueFunction in linkedIssuesOf("resolution = unresolved")
```

We want to search for multiple links:

```
issueFunction in linkedIssuesOf("","is blocked by", "is cloned by")
```

## Find epics of a subquery (`epicsOf`)

You can use `epicsOf()` to find all epics of a specific subquery:

```
issueFunction in epicsOf("subquery")
```

This function only retrieves Epics that have associated issues. Any Epics without linked issues (empty Epics) will be omitted from the search results.

### epicsOf example

We want to find all **Epics** that have unresolved issues:

```
issueFunction in epicsOf("resolution = unresolved")
```

## Find issues in epics (`issuesInEpics`)

You can use `issuesInEpics()` to find all issues in epics of a subquery:

```
issueFunction in issuesInEpics("subquery")
```

### `issuesInEpics` examples

We want to find all issues in a specific project (SSPB in this example) that belong to an epic that has the **To Do** status:

```
issueFunction in issuesInEpics("project = SSP and status = 'To Do'")
```

We want to find all unresolved issues that belong to resolved epics:

```
issueFunction in issuesInEpics("resolution is not empty") and resolution is empty
```

## Find issues with issue picker fields (`issuePickerField`)

You can use `issuePickerField()` to find issues with a specified [issue picker](https://docs.adaptavist.com/sr4js/latest/features/script-fields/built-in-script-fields/issue-picker) custom field:

```
issueFunction in issuePickerField("Issue picker field name")
```

You can also use a subquery to search for specific issues that have the named issue picker custom field:

```
issueFunction in issuePickerField("Issue picker field name", "subquery")
```

### `issuePickerField` example

We want to find issues that have any bugs linked to it using the **Issue Picker** field:

```
issueFunction in issuePickerField("Issue Picker", "issuetype = Bug")
```

## Recursive: find linked issues of a subquery (`linkedIssuesOfRecursive`)

Recursive meaning

In this context, recursive means the function traverses all direct and indirect issue links, returning all issues connected to the initial subquery results, regardless of link depth.

You can use `linkedIssuesOfRecursive()` to find all recursive linked issues of a subquery: 

```
linkedIssuesOfRecursive("subquery")
```

You can refine the list of results by specifying second parameter, for example by link type:

You can search for multiple linked issues using this function, you are not limited to one link name. 

```
linkedIssuesOfRecursive("subquery", "link type")
```

### `linkedIssuesOfRecursive` example

### We have the following set up:

![](/sr4js/files/latest/442889353/441364522/1/1741621524000/Recursive_example.jpg)

To find all direct and indirectly linked issues of SSP-1 you can use:

```
issueFunction in linkedIssuesOfRecursive("issue = SSP-1")
```

The query returns all issues linked to SSP-1, and all issues linked to those that are linked to SSP-1, and so on. Using the example above our query returns SSP-1, SSP-2, SSP-3, SSP-4, and SSP-5. SSP-1 is returned as it is linked to SSP-2 and SSP-3 through the `is blocked by` link type. 

You can limit the type, and direction, of links using a second parameter. For example, if we want to search using the `blocks` link type:

```
issueFunction in linkedIssuesOfRecursive("issue = SSP-1", "blocks")
```

This query returns SSP-2, SSP-3 and SSP-4.

In addition, you can follow multiple links. For example:

```
issueFunction in linkedIssuesOfRecursive("issue = SSP-1", "blocks", "clones")
```

This query returns SSP-2, SSP-3, SSP-4 and SSP-5.

If you have a lot of indirectly linked issues, traversal of all of the links will take time.

## Recursive limited: find linked issues of a subquery (`linkedIssuesOfRecursiveLimited`)

You can use `linkedIssuesOfRecursiveLimited()` to find all recursive linked issues of a subquery, to a limited depth:

You can search for multiple linked issues using this function, you are not limited to one link name. 

```
linkedIssuesOfRecursiveLimited("subquery", "traversal depth", "link name")
```

### `linkedIssuesOfRecursiveLimited` examples

The following query will follow all links, recursively, from all issues in the SSP project until it has traversed a maximum of 2 links deep along any link path:

```
issueFunction in linkedIssuesOfRecursiveLimited("project = SSP", 2)
```

Alternatively we could specify the link name , to get different results:

```
issueFunction in linkedIssuesOfRecursiveLimited("issue = SSP-2", 3, "is blocked by")
```

## Old issue functions (`linkedIssuesOfAll`, `linkedIssuesOfAllRecursive`, and `linkedIssuesOfAllRecursiveLimited`)

These functions provide the old behaviour of the linkedIssuesOf…​ style functions, in that they include subtask and epic links when no link type is specified. Other than that, they function identically to their counterparts.

## Find issues that link to remote content (`linkedIssuesOfRemote`)

Use `linkedIssuesOfRemote()` to find issues that link to remote content, for example to find web pages, Confluence pages, or any other custom remote link type that you have set up:

  

```
issueFunction in linkedIssuesOfRemote("Remote Link property", "search term")
```

  

Two options are available:

-   Specify against which remote link property to search, **or**
-   Search against title and url

Search term supports two wildcard characters:

-   \* - matches zero or more characters. For example, he\* will match any word starting with he, such as he, her, help, hello, helicopter, hello world, and so on
    
-   ? - matches exactly one character. For example, he? will only match three-letter words starting with he, such as hem, hen, and so on.
    

A primary use case for this is to find issues linking to a particular Confluence page. This allows you to show on your wiki page all the Jira issues that reference it (see examples below). You can do this with either the [Jira issues macro](https://confluence.atlassian.com/doc/jira-issues-macro-139380.html), or the [Filter Results gadget](https://support.atlassian.com/jira-cloud-administration/docs/use-dashboard-gadgets/#:~:text=Filter%20Results%20Gadget). Note that the Jira issues macro has a cache, so if you are testing this you need to click the refresh icon on the Jira issues macro.

### `linkedIssuesOfRemote` examples

#### Searching by link properties

Supported remote link properties

-   **title**
-   **url**
-   **application name**
-   **application type**
-   **relationship**
-   **host**
-   **path**
-   **query**

Find all issues linked to a linked Confluence instance:

```
issueFunction in linkedIssuesOfRemote("application name", "Confluence")
```

Find all issues with a remote link to an Atlassian app (Confluence, Jira, Bitbucket, etc.):

```
issueFunction in linkedIssuesOfRemote("application type", "com.atlassian.*")
```

Find issues linked to a specific page id:

```
issueFunction in linkedIssuesOfRemote("query", "pageId=11469162")
```

Find issues linked to a specific web host:

```
issueFunction in linkedIssuesOfRemote("host", "www.stackoverflow.com")
```

Find issues linked to a path starting with a particular string:

```
issueFunction in linkedIssuesOfRemote("path", '/jira*')
issueFunction in linkedIssuesOfRemote("path", '/projects*')
```

By querying on the 'relationship' property, you can emulate the `hasLinks` function for links to a remote Jira instance:

```
issueFunction in linkedIssuesOfRemote("relationship", "mentioned in")
issueFunction in linkedIssuesOfRemote("relationship", "caused by")
```

#### Searching against title and URL

Find issues linked to a particular URL:

```
issueFunction in linkedIssuesOfRemote("http://www.acme.com/confluence/pages/viewpage.action?pageId=11469162")
```

Find issues linked to a particular title with some [wildcards](#id-.IssueLinksv9.x-wildcards) (this cannot be used for Confluence pages):

```
issueFunction in linkedIssuesOfRemote("title wildcard* m?tch")
```

#### Warnings and issues

When performing any of the above queries, be aware of the following important considerations:

-   For Confluence pages, use the URL containing `viewpage.action?pageId`. You can get the pageId as described in the [Atlassian documentation](https://confluence.atlassian.com/confkb/how-to-get-confluence-page-id-648380445.html). A Confluence macro would simplify this process. Alternatively, access the page by clicking the remote link directly from the Jira issue.
-   Adding a remote link doesn't automatically reindex the issue. The function won't detect it until reindexing occurs. To trigger reindexing, make an edit or perform any action on the issue.
-   To maintain query performance, avoid starting search terms with [wildcards](#id-.IssueLinksv9.x-wildcards) (`*` or `?`). This prevents the execution of potentially slow `WildcardQueries`.

The `linkedIssueOfRemote` function can only search over the properties of a [RemoteIssueLink Object](https://docs.atlassian.com/software/jira/docs/api/9.1.0/com/atlassian/jira/issue/link/RemoteIssueLink.html "Follow link") from the Jira API, so there are limits to what can be used to search for linked issues and how. Unfortunately this means that you can't search by Confluence space or multiple pages (within the same function call). When searching by pages in Confluence, the page title is always returned as wiki page, or page by the Jira API, and results in not being able to use the wildcard. This is why we specify using the pageId rather than title.

## Find issues with a remote link (`hasRemoteLinks`)

You can use `hasRemoteLinks()` to find any issue that has a remote link of any kind:

```
issueFunction in hasRemoteLinks()
```

This query could be slow in instances with a large number of projects and issues, since it is an alias for `linkedIssuesOfRemote('*')`.

## Additional example: find all issues in an epic, and their subtasks

In the following example we want to find all issues  in an epic, and all their subtasks. With these complex queries it helps to break them down into steps:

1.  Find the stories of the epics in a particular project:  
    
    ```
issuefunction in issuesInEpics("project = SSP")
```
    
2.  [Save the search as a filter](https://confluence.atlassian.com/jirasoftwareserver/saving-your-search-as-a-filter-939938748.html) and call it `Issues in Epic`.
3.  Use this filter in a `subtasksOf()` query, as described below.

### Find subtasks of issues (`subtasksOf`)

You can use subtasksOf() to search for subtasks of issues. For example, we can use the filter created above to find all subtasks of the `Issues in Epic` filter:

```
issuefunction in subtasksOf("filter = 'Issues in Epic'")
```

Don’t edit the `Stories In Epic` filter as you will cause a cyclical reference. Instead create a new filter.

The above only returns the subtasks. If you want to return issues and their subtasks whereas you can do the following:

```
filter = 'Issues in Epic' or issuefunction in subtasksOf("filter = 'Issues in Epic'")
```

If you also want issues linked to the issues, you can use:

```
filter = 'Issues in Epic' or issuefunction in subtasksOf("filter = 'Issues in Epic'") or issueFunction in linkedIssuesOf("filter = 'Issues in Epic'")
```

The `[linkedIssuesOf](#id-.IssueLinksv9.x-linkedIssuesOf)` function takes an optional second parameter which is the link name, eg "blocks" or "is blocked by", so you can constrain the issues returned by that clause.

  

When working on complex queries bear in mind the following:

-   Clauses in a multiple clause query should be tested on their own to check they are returning what you want
    
-   If a sub-filter gets complicated, save it as a filter and use `filter = 'Filter Name'`
    
-   You can use double and single quotes if necessary, so long as they are balanced. You cannot escape quotes, if you need to you will need to save as a filter.
    

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [JQL Functions Tutorial](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
