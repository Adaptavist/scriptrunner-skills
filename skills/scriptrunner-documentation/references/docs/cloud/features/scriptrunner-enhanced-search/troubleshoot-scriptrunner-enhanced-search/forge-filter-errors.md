# Forge Filter Errors

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-566298276
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/forge-filter-errors

As we move to Forge and native Jira search, you could see different errors. Jira has specific limits to keep performance fast. If your filter hits one of these limits, you’ll see an error. Here is how to understand and fix them: 

**Error**

**Why?**

**How to fix**

**Notes**

1000 RHS values error

In native Jira search, a single custom JQL function is restricted to returning a maximum of **1,000 Right Hand Side (RHS) values**.

RHS values are the specific items returned by a function to complete the JQL statement. While these are typically **Issue IDs**, some functions return other types such as **Projects**, **Components**, or **Versions**. Jira processes the conversion from these entities into the final issue result list in the background.

For example:

-   A function like `linkedIssuesOf` that returns issue results is limited to 1,000 issues.
    
-   A function like `projectMatch` that returns projects is limited to 1,000 projects. In this case, the final issue count may exceed 1,000, but the function itself cannot reference more than 1,000 project entities.
    

You can narrow the scope of the function results by refining your JQL argument.  
  
For example:

`issueFunction in linkedIssuesOf("project in (A,B,C)")`  
  
could become:  
  
`issueFunction in linkedIssuesOf("project in (A) AND statusCategory != Done)") AND issueFunction in linkedIssuesOf("project in (B) AND statusCategory != Done)") AND issueFunction in linkedIssuesOf("project in (C) AND statusCategory != Done)")`

This limitation applies strictly to the **individual****Enhanced Search function** return limit, not the total results of the final filter.

Function processing took longer than 25 seconds

In the new native Jira search feature, functions may only run issue searches for up to 25 seconds, before Atlassian will cut off the function processing. Therefore, it is important that the ES function must be able to retrieve the issue results within 25 seconds, or it will fail and return an error.

You can narrow the scope of the function results by refining your JQL argument.

For example:

`issueFunction in parentsOf("statusCategoy != Done")`

could become:

`issueFunction in parentsOf("project in (A) AND statusCategory in ('In Progress')")`

or

i`ssueFunction in parentsOf("project in (A) AND statusCategoy != Done AND created < 30d")`

  

Any other error

The native Jira search feature requires all filters to be evaluated as valid JQL before they can be saved as a Jira filter.  
  
Filters containing syntax errors cannot be updated or saved using the new Enhanced Search function syntax. It is critical to resolve these errors immediately; filters that remain invalid will become inaccessible once the Connect functionality is officially deprecated.

Consult the specific error message provided by the Enhanced Search application to identify the syntax issue. Update the query to comply with standard JQL requirements to ensure the filter can be saved and migrated successfully.

You could be having other errors based on incorrect functions. We recently introduced structural changes for upcoming features, which could highlight a pre-existing configuration issue on your board where a non-functional Enhanced Search query was being used. Because this filter never returned active data, removing it will restore your board immediately without data loss. For more information, please visit [Incorrect Functions Causing Board Errors](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/incorrect-functions-causing-board-errors). 

  

For more information about limits, please visit [Timeouts and Performance](https://docs.adaptavist.com/spaces/ES/pages/490144903/.Timeouts+vDraft).
