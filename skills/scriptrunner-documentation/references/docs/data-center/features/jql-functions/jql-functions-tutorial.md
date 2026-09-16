# JQL Functions Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > JQL Functions
- Doc ID: doc-sr4js-7f25e794-108d-477a-9d43-be0b4a0de7db-b4f7f01c920dee63
- Source: https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#jql-functions-tutorial--en

You can use ScriptRunner JQL functions to extend Jira's built-in capabilities, allowing you to conduct more granular searches, and obtain more detailed information about what is happening in your instance and projects. For example, if you need to find blocker issues in a project, you can use the `[hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links)` ScriptRunner JQL function with the `Blocker` value. To understand how our functions work you must know [how to search for issues in Jira](https://confluence.atlassian.com/jirasoftwareserver/searching-for-issues-939938681.html) and [how to construct a JQL query](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html#Advancedsearching-ConstructingJQLqueries).

Note: Permissions

If a user does not have permission to see a given project/issue, then the result of a JQL search does not include the restricted projects/issues. See the [Permissions](../../get-started/permissions.md) page for full details on ScriptRunner permissions.

In this tutorial we assume you already have knowledge of [Advanced](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html) and [Basic](https://confluence.atlassian.com/jirasoftwareserver/basic-searching-939938708.html) search in Jira. If you're relatively new to JQL, the following table will help you understand some key terms used for constructing an _Advanced_ search JQL query:

Tip: ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#scriptrunner-jql-ai--en).

<table class="table" id="jql-functions-tutorial--en__generated-table-id-1"><caption></caption><thead class="thead"><tr class="row"><th class="entry" id="jql-functions-tutorial--en__generated-table-id-1__entry__1">Term</th><th class="entry" id="jql-functions-tutorial--en__generated-table-id-1__entry__2">Description</th></tr></thead><tbody class="tbody"><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Clause</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">A clause is a simple JQL query consisting of a field, an operator, and a value or a function.</td></tr><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Function</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">A function appears as a word followed by parentheses, for example <code class="ph codeph">currentUser()</code>. The parentheses may contain one or more explicit values. You can check out the <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-functions-reference-939938746.html" target="_blank">Atlassian JQL function documentation</a> for more details on functions. </td></tr><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Operator</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">An operator can be a symbol, a set of symbols, or words that compare the value of a field on its left with one or more values or functions on its right. For example <code class="ph codeph">!=</code> is the NOT EQUALS operator, <code class="ph codeph">=</code> is the EQUALS operator, and <code class="ph codeph">in</code> is the IN operator. You can check out the <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-operators-reference-939938745.html" target="_blank">Atlassian JQL operator documentation</a> for more details on operators. </td></tr><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Field</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">A field is a word that represents a Jira field (for example <code class="ph codeph">assignee</code>) or is a custom field that has already been defined in your Jira applications. You can check out the <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html" target="_blank">Atlassian JQL field documentation</a> for more details on fields. </td></tr><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Keyword</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">&#10;                            <p class="p">A keyword in JQL is a word or phrase that does the following:</p>&#10;                            <ul class="ul"><li class="li">Joins clauses together (for example <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-ANDAND" target="_blank">AND</a>)</li><li class="li">Alters the logic of clauses or operators (for example <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-NOTNOT" target="_blank">NOT</a>)</li><li class="li">Has an explicit definition in a JQL query (for example <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-EMPTYEMPTY" target="_blank">EMPTY</a>)</li><li class="li">Performs a specific function that alters the results of a JQL query (for example <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-ORDER_BYORDERBY" target="_blank">ORDER BY</a>)</li></ul>&#10;                            <p class="p">You can check out the <a class="xref j-external-link" href="https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html" target="_blank">Atlassian JQL keyword documentation</a> for more details on keywords. </p>&#10;                        </td></tr><tr class="row"><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">Value</td><td class="entry" headers="jql-functions-tutorial--en__generated-table-id-1__entry__1 jql-functions-tutorial--en__generated-table-id-1__entry__2 ">A value is a component of the named field in a query. For example, if the field is <code class="ph codeph">project</code> then the value would be a project name (in the example below the value is <code class="ph codeph">Great Adventure Tours</code>). A value can also be a number, for example if you're searching for comments with <code class="ph codeph">hasComments</code> then you can use a number value. </td></tr></tbody></table>

## What ScriptRunner JQL functions are available?

You can view a complete list of ScriptRunner JQL functions on the [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) page. If you're a Jira administrator, you can view the available ScriptRunner JQL functions in your instance by going to Administration > ScriptRunner > JQL Functions. Administrators can also write [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions), but we do not cover that on this page.

Note: If a ScriptRunner function on the Included JQL Functions page isn't visible in your instance then it may have been disabled in your instance.

You can also find most ScriptRunner functions when typing a query and using the `issueFunction` field.

## What is issueFunction?

The `issueFunction` field comes built-in with ScriptRunner and allows you to run most ScriptRunner JQL functions.

In cases where `issueFunction` isn't required then a Jira field is required. For example, the [`archivedVersions`](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#archivedversions--en) ScriptRunner JQL function (used to find issues with archived fix versions) must be preceded by the Jira [`fixVersion`](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion) field.

### issueFunction in Basic search

The `issueFunction` field can be found under More when running a basic search. After you select the `issueFunction` field, you can add a compatible ScriptRunner function.

[Media](https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#jql-functions-tutorial--en)

### issueFunction in Advanced search

You can use the issueFunction field in _Advanced_ search like any other field. The `issueFunction` field can only be used with the `in` and `not in` operators. After you enter the `issueFunction` field, followed by an operator, the compatible ScriptRunner JQL functions display.[Media](https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#jql-functions-tutorial--en)

## ScriptRunner JQL tips

### Start in basic search then switch to advanced search

If you need to become more familiar with how JQL works you can build a search query in basic search and then switch to advanced search to view the entire query.

[Media](https://docs.adaptavist.com/sr4js/latest/features#jql-functions--en#jql-functions-tutorial--en)

### Keep it simple

To make sure your search doesn't slow down your instance, we recommend you do the following:

-   Provide a subquery in your search to help limit results.
    
    Note: A subquery is a query within a function. If you're using the issuesInEpics() function you could add a subquery within the parentheses, for example `issueFunction in issuesInEpics ("status = 'to do' AND priority = 'high'")`. The subquery in the example provided searches for epics with the named status and priority.
    
-   Keep your queries as simple as possible

### Save your JQL queries

If you frequently run the same JQL query you can [save your search as a filter](https://confluence.atlassian.com/jirasoftwareserver/saving-your-search-as-a-filter-939938748.html).

### Function name clashes

If you use multiple plugins to alter JQL functionality, you may encounter a case where function names are the same in each plugin. In this case, you need to disable a function because the two plugins essentially cancel each other out. For example, if two plugins use the function `hasSubtasks` you may need to disable one to be able to use the other. We recommend you check out the [Troubleshooting JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/troubleshooting-jql-functions) page for information on how to deal with this issue.

### Try our ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#scriptrunner-jql-ai--en).

## Examples of search using ScriptRunner JQL functions

Note: We recommend you set up and use a sample project for the following examples. See the [Tutorials](../../training/tutorials.md) page for more information on creating a sample project.

The following are simple examples for you to follow so you understand how ScriptRunner JQL functions work. Check out our [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) documentation for all available ScriptRunner JQL functions and examples.

### Find all blocker issues in a project

Note: Before you start this tutorial make sure you have some blocker issues in your sample project. Blocker issues are issues that are given the "Blocks" [issue link](https://confluence.atlassian.com/adminjiraserver/configuring-issue-linking-938847862.html) type.

Great Adventure wants to find all high priority blocker issues in their `Great Adventure Tours` project. By using the [`hasLinkType`](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-issues-with-specific-link-types-haslinktype--en) ScriptRunner JQL, the project manager can see what issues they need to assign for completion.

1.  Select Issues > Search for Issues.
    
2.  If you see the basic search with drop-down menus, select Advanced.
    
    (If you see a text bar, you are already in _Advanced_ search.)
    
3.  Enter the following onto the search bar, replacing the project name with your project:
    
    ```
    project = GAT AND priority in (Highest, High) AND issueFunction in hasLinkType('Blocks')
    ```
    
4.  Select Search.
    
    All results that match the JQL query display.
    

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

### Find how much effort remains on a set of stories

Note: Before you start this tutorial make sure you have a few time entries / remaining estimates in issues in your project.

Great Adventure wants to audit their current workload to find out how many weeks of effort remain on a set of stories. By using the `[aggregateExpression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#summarise-data-in-fields-aggregateexpression--en)` ScriptRunner JQL, the project manager can see at an instant the data and make an informed decision about their next steps.

1.  Select Issues > Search for Issues.
    
2.  If you see the basic search with drop-down menus, select Advanced. (If you see a text bar, you are already in _Advanced_ search.)
    
3.  Enter the following onto the search bar, replacing the project name with your project:
    
    ```
    project = GAT AND issuetype = Story AND issueFunction in aggregateExpression("Remaining work for all Issues", "remainingestimate.sum()")
    ```
    
4.  Select Search.
    
    The remaining work for all stories displays.
    

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

### Find all epics with unresolved issues

Note: Before you start this tutorial make sure you have some issues in an epic.

Great Adventure wants to find all epics in the `Great Adventure Tours` project with unresolved issues. Using the [`issuesInEpics`](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#find-issues-in-epics-issuesinepics--en) ScriptRunner JQL, the project manager can see what epics have issues yet to be completed and make an informed decision about their next steps.

1.  Select Issues > Search for Issues.
    
2.  If you see the basic search with drop-down menus, select Advanced. (If you see a text bar, you are already in _Advanced_ search.)
    
3.  Enter the following onto the search bar, replacing the project name with your project.
    
    You may also have to replace the status values with values that relate to your project.
    
    ```
    project = "Great Adventure Tours" AND issueFunction in issuesInEpics("status in('to do', 'in progress')")
    ```
    
4.  Select Search. All results that match the JQL query display.
    

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [Troubleshooting JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/troubleshooting-jql-functions)
