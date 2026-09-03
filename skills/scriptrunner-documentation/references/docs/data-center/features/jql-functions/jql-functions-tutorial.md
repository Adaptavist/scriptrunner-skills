# JQL Functions Tutorial

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > jql-functions
- Doc ID: doc-sr4js-442886632
- Source: https://docs.adaptavist.com/sr4js/latest/features/jql-functions/jql-functions-tutorial

You can use ScriptRunner JQL functions to extend Jira's built-in capabilities, allowing you to conduct more granular searches, and obtain more detailed information about what is happening in your instance and projects. For example, if you need to find blocker issues in a project, you can use the `[hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinkType)` ScriptRunner JQL function with the `Blocker` value. To understand how our functions work you must know [how to search for issues in Jira](https://confluence.atlassian.com/jirasoftwareserver/searching-for-issues-939938681.html) and [how to construct a JQL query](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html#Advancedsearching-ConstructingJQLqueries). 

Permissions

If a user does not have permission to see a given project/issue, then the result of a JQL search does not include the restricted projects/issues. See the [Permissions](https://docs.adaptavist.com/sr4js/latest/get-started/permissions) page for full details on ScriptRunner permissions. 

In this tutorial we assume you already have knowledge of [Advanced](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-939938733.html) and [Basic](https://confluence.atlassian.com/jirasoftwareserver/basic-searching-939938708.html) search in Jira. If you're relatively new to JQL, the following table will help you understand some key terms used for constructing an _Advanced_ search JQL query: 

ScriptRunner JQL AI

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#sr-jql-ai). 

Term

Description

Clause

A clause is a simple JQL query consisting of a field, an operator, and a value or a function.

Function

A function appears as a word followed by parentheses, for example `currentUser()`. The parentheses may contain one or more explicit values. You can check out the [Atlassian JQL function documentation](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-functions-reference-939938746.html) for more details on functions. 

Operator

An operator can be a symbol, a set of symbols, or words that compare the value of a field on its left with one or more values or functions on its right. For example `!=` is the NOT EQUALS operator, `=` is the EQUALS operator, and `in` is the IN operator. 

You can check out the [Atlassian JQL operator documentation](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-operators-reference-939938745.html) for more details on operators. 

Field

A field is a word that represents a Jira field (for example `assignee`) or is a custom field that has already been defined in your Jira applications. You can check out the [Atlassian JQL field documentation](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html) for more details on fields. 

Keyword

A keyword in JQL is a word or phrase that does the following:

-   Joins clauses together (for example `[AND](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-ANDAND)`)
-   Alters the logic of clauses or operators (for example `[NOT](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-NOTNOT)`)
-   Has an explicit definition in a JQL query (for example [EMPTY](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-EMPTYEMPTY))
-   Performs a specific function that alters the results of a JQL query (for example `[ORDER BY](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html#Advancedsearchingkeywordsreference-ORDER_BYORDERBY)`)

You can check out the [Atlassian JQL keyword documentation](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-keywords-reference-939938744.html) for more details on keywords. 

Value

A value is a component of the named field in a query. For example, if the field is `project` then the value would be a project name (in the example below the value is `Great Adventure Tours`). A value can also be a number, for example if you're searching for comments with `hasComments` then you can use a number value. 

![](/sr4js/files/latest/442886632/442886639/1/1758746725000/JQL_functions_example.png)

## What ScriptRunner JQL functions are available?

You can view a complete list of ScriptRunner JQL functions on the [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) page. If you're a Jira administrator, you can view the available ScriptRunner JQL functions in your instance by going to **Administration > ScriptRunner > JQL Functions**. Administrators can also write [custom JQL functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/custom-jql-functions), but we do not cover that on this page.

If a ScriptRunner function on the Included JQL Functions page isn't visible in your instance then it may have been disabled in your instance. 

You can also find most ScriptRunner functions when typing a query and using the `issueFunction` field.

## What is `issueFunction`?

The `issueFunction` field comes built-in with ScriptRunner and allows you to run most ScriptRunner JQL functions.

In cases where `issueFunction` isn't required then a Jira field is required. For example, the `[archivedVersions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/versions#archivedVersions)` ScriptRunner JQL function (used to find issues with archived fix versions) must be preceded by the Jira `[fixVersion](https://confluence.atlassian.com/jirasoftwareserver/advanced-searching-fields-reference-939938743.html#Advancedsearchingfieldsreference-FixVersionfixVersionFixversion)` field. 

![](/sr4js/files/latest/442886632/442886643/1/1758746726000/JQL_archived_versions.png)

#### `issueFunction` in _Basic_ search

The `issueFunction` field can be found under **More** when running a basic search. After you select the `issueFunction` field, you can add a compatible ScriptRunner function. 

Your browser does not support the HTML5 video element

#### `issueFunction` in _Advanced_ search

You can use the issueFunction field in _Advanced_ search like any other field. The `issueFunction` field can only be used with the `in` and `not in` operators. After you enter the `issueFunction` field, followed by an operator, the compatible ScriptRunner JQL functions display. 

Your browser does not support the HTML5 video element

## ScriptRunner JQL tips

#### Start in basic search then switch to advanced search

If you need to become more familiar with how JQL works you can build a search query in basic search and then switch to advanced search to view the entire query. 

Your browser does not support the HTML5 video element

#### Keep it simple

To make sure your search doesn't slow down your instance, we recommend you do the following:

-   Provide a subquery in your search to help limit results.
    
    A subquery is a query within a function. If you're using the issuesInEpics() function you could add a subquery within the parentheses, for example `issueFunction in issuesInEpics ("status = 'to do' AND priority = 'high'")`. The subquery in the example provided searches for epics with the named status and priority. 
    
-   Keep your queries as simple as possible
    

#### Save your JQL queries

If you frequently run the same JQL query you can [save your search as a filter](https://confluence.atlassian.com/jirasoftwareserver/saving-your-search-as-a-filter-939938748.html).

#### Function name clashes

If you use multiple plugins to alter JQL functionality, you may encounter a case where function names are the same in each plugin. In this case, you need to disable a function because the two plugins essentially cancel each other out. For example, if two plugins use the function `hasSubtasks` you may need to disable one to be able to use the other. We recommend you check out the [Troubleshooting JQL Functions](https://docs.adaptavist.com/display/_PK/SR4JS/troubleshooting-jql-functions) page for information on how to deal with this issue.

#### Try our ScriptRunner JQL AI 

If you're not sure where to start with JQL Functions or are in need of a quick search filter, try our [ScriptRunner JQL AI](https://docs.adaptavist.com/sr4js/latest/features/jql-functions#sr-jql-ai). 

## Test yourself on key JQL terms

Have a look at the JQL query below and see if you can identify the following:

-   Fields
-   Operators
-   Keywords
-   Values
-   ScriptRunner JQL functions

Once you're happy with your decisions, hover over each part of the query to see if you are correct. 

Field Operator Value Keyword Field Function Operator Keyword Field Operator ScriptRunner JQL function Keyword Field Operator ScriptRunner JQL function Value

## Examples of search using ScriptRunner JQL functions

We recommend you set up and use a sample project for the following examples. See the [Tutorials](https://docs.adaptavist.com/sr4js/latest/training/tutorials#before-you-start) page for more information on creating a sample project. 

The following are simple examples for you to follow so you understand how ScriptRunner JQL functions work. Check out our [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions) documentation for all available ScriptRunner JQL functions and examples. 

### Find all blocker issues in a project

Before you start this tutorial make sure you have some blocker issues in your sample project. Blocker issues are issues that are given the "Blocks" [issue link](https://confluence.atlassian.com/adminjiraserver/configuring-issue-linking-938847862.html) type. 

Great Adventure wants to find all high priority blocker issues in their `Great Adventure Tours` project. By using the `[hasLinkType](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#hasLinkType)` ScriptRunner JQL, the project manager can see what issues they need to assign for completion.

Expand to view steps...

1.  Select **Issues > Search for Issues**.  
    ![](/sr4js/files/latest/442886632/442886652/1/1758746727000/JQL_search_for_issues.png)
2.  If you see the basic search with drop-down menus, select **Advanced**. (If you see a text bar, you are already in _Advanced_ search.)  
    ![](/sr4js/files/latest/442886632/442886636/1/1758746725000/JQL_tutorial_2.png)
3.  Enter the following onto the search bar, replacing the project name with your project:
    
    ```
project = GAT AND priority in (Highest, High) AND issueFunction in hasLinkType('Blocks')
```
    
4.  Select **Search**. All results that match the JQL query display.   
    ![](/sr4js/files/latest/442886632/442886648/1/1758746726000/JQL_tutorial_3.png)

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

### Find how much effort remains on a set of stories

Before you start this tutorial make sure you have a few time entries / remaining estimates in issues in your project.

Great Adventure wants to audit their current workload to find out how many weeks of effort remain on a set of stories. By using the `[aggregateExpression](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/calculations#aggregateExpression)` ScriptRunner JQL, the project manager can see at an instant the data and make an informed decision about their next steps.

Expand to view steps...

1.  Select **Issues > Search for Issues**.  
    ![](/sr4js/files/latest/442886632/442886652/1/1758746727000/JQL_search_for_issues.png)
2.  If you see the basic search with drop-down menus, select **Advanced**. (If you see a text bar, you are already in _Advanced_ search.)  
    ![](/sr4js/files/latest/442886632/442886636/1/1758746725000/JQL_tutorial_2.png)
3.  Enter the following onto the search bar, replacing the project name with your project:
    
    ```
project = GAT AND issuetype = Story AND issueFunction in aggregateExpression("Remaining work for all Issues", "remainingestimate.sum()")
```
    
4.  Select **Search**. The remaining work for all stories displays.   
    ![](/sr4js/files/latest/442886632/442886641/1/1758746726000/JQL_tutorial_aggregated_search.png)

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

### Find all epics with unresolved issues

Before you start this tutorial make sure you have some issues in an epic.

Great Adventure wants to find all epics in the `Great Adventure Tours` project with unresolved issues. Using the `[issuesInEpics](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions/issue-links#issuesInEpics)` ScriptRunner JQL, the project manager can see what epics have issues yet to be completed and make an informed decision about their next steps. 

Expand to view steps...

1.  Select **Issues > Search for Issues**.  
    ![](/sr4js/files/latest/442886632/442886652/1/1758746727000/JQL_search_for_issues.png)
2.  If you see the basic search with drop-down menus, select **Advanced**. (If you see a text bar, you are already in _Advanced_ search.)  
    ![](/sr4js/files/latest/442886632/442886636/1/1758746725000/JQL_tutorial_2.png)
3.  Enter the following onto the search bar, replacing the project name with your project:
    
    You may also have to replace the status values with values that relate to your project.
    
    ```
project = "Great Adventure Tours" AND issueFunction in issuesInEpics("status in('to do', 'in progress')")
```
    
4.  Select **Search**. All results that match the JQL query display.   
    ![](/sr4js/files/latest/442886632/442886638/1/1758746725000/JQL_tutorial_epics.png)

Once you run your search, you can save the search if you want to create a filter. You can also use this search query to power a Software board or even in a Service Management queue.

  

* * *

## Related content

-   [JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions)
-   [Included JQL Functions](https://docs.adaptavist.com/sr4js/latest/features/jql-functions/included-jql-functions)
-   [Troubleshooting JQL Functions](https://docs.adaptavist.com/display/_PK/SR4JS/troubleshooting-jql-functions)
