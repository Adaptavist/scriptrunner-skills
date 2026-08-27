# Query Writing Recommendations

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-513345630
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/query-writing-recommendations

Follow our recommendations below for writing efficient JQL queries and check out our video walkthrough.

When writing queries, ensure that you have entered a space after the comma in the query you are running, or you may see the error message _"Function 'X' does not exist"._

## Filters inside functions, not outside

Context

Details

Common in:

`issuesInEpics`, `linkedIssuesOf`, `childrenOf`

Why this matters:

Enhanced Search always evaluates the function argument first, before applying any filters outside the function.

When filters are placed _outside_ the function, Enhanced Search must process a much larger set of issues than necessary. This increases execution time and can lead to search timeouts, especially due to Atlassian Cloud performance limits.

Best practice:

Always place project, status, and date filters inside the function itself, so only relevant issues are evaluated from the start.

What to do:

-   Move project, status, and date conditions into the function argument
    
-   Use external filters only when they cannot be applied inside the function
    

Example:

#### ❌ Inefficient (filters outside the function)

In this example, Enhanced Search first retrieves _all_ matching epics, then Jira applies the filters afterward.  
   
`project = SRCLOUD AND status != Done AND issueFunction in issuesInEpics("status != Done")`

This forces Enhanced Search to process more data than necessary.

#### ✅ Optimized (filters inside the function)

Here, the filtering happens _within_ the function, significantly reducing the data set processed.  
   
`issueFunction in issuesInEpics( "project = SRCLOUD AND status != Done" )`

## Use clear, scoped filters

Context

Details

Common in:

`issuesInEpics`, `linkedIssuesOf`, `childrenOf`

Why this matters:

When a function is given an empty or overly broad filter, Enhanced Search must evaluate **all possible related issues** before narrowing the results. This significantly increases processing time and can lead to **search timeouts**, particularly within Atlassian Cloud performance limits.

Best practice:

Always provide a **clear, scoped JQL filter** inside the function so Enhanced Search evaluates only the issues you actually need.

What to do:

-   Specify meaningful filters within the function arguments.
    
-   Avoid empty or generic parameters that cause instance-wide evaluation.
    
-   Narrow relationships (for example, link types) wherever possible.
    

Example:

#### ❌ Inefficient (unscoped function argument)

In this example, the second argument is empty, causing Enhanced Search to search across **all linked issues** in project `SP`.  
   
`issueFunction in linkedIssuesOf("project = SP", "")` 

This results in unnecessary processing and slower performance.

#### ✅ Optimized (scoped filter)

Here, the query explicitly limits the relationship to issues that **block** others, significantly reducing the dataset evaluated.  
   
`issueFunction in linkedIssuesOf("project = SP", "blocks")`

## Always include a project filter

Context

Details

Common in:

`childrenOf, issuesInEpics, epicsOf, parentsOf, subTasksOf`

Why this matters:

Project filtering is a strong way to prevent Enhanced Search from scanning your **entire Jira instance**, which can cause **timeouts** and slow queries.

Best practice:

Always include a project filter **inside the function** to limit the search scope.

What to do:

-   Add a project filter in the function argument.
    
-   Combine with other filters (e.g., `issuetype`, `status`) to further reduce results.
    

Example:

#### ❌ Inefficient (no project filter)

The function only receives `issueType`, so it scans children of all Epics across all projects.

`issueFunction in childrenOf("issuetype = Epic")`

#### ✅ Optimized (with project filter)

Adding the project filter limits the parent issues searched:

`issueFunction in childrenOf("project = ES AND issuetype = Epic")`

## Add a time window

Context

Details

Common in:

linkedIssuesOf, issueFieldMatch, attachment/comment keywords

Why this matters:

Time-based filtering reduces the number of issues Enhanced Search must inspect. Without a time window, functions may evaluate **every matching issue**, increasing execution time and the risk of timeouts.

Best practice:

Add a time-based condition **inside the function** to limit results to relevant, recent issues.

What to do:

-   Use fields such as `updated`, `created`, or `resolved` inside the function argument.
-   Choose a time range that reflects your actual reporting or automation needs

Example:

#### ❌ Inefficient (no time filter)

 The function processes all issues in the project, regardless of age:

`issueFunction in linkedIssesOf("project = ES", "blocks")` 

#### ✅ Optimized (with time filter)

This limits the search to issues updated on or after December 1, 2025:

`issueFunction in linkedIssuesOf("project = ES AND updated >= 2025-12-01", "blocks")`

## Narrow by issue type

Context

Details

Common in:

linkedIssuesOfRecursive, epicsOf, parentsOF

Why this matters:

Recursive and relationship-based functions expand through linked issues.  
If issue types are not restricted, Enhanced Search may follow links across **every issue type in your Jira instance**, dramatically increasing execution time and increasing the risk of timeouts.

Best practice:

Always include an **issue type filter inside the function** when using recursive or relationship-based functions.

What to do:

-   Add an `issuetype` condition inside the function argument.
    
-   Limit the query to only the issue types relevant to your use case (for example, Stories and Bugs).
    

Example:

#### ❌ Inefficient (unrestricted issue types)

In this example, the function follows **all linked issues**, then continues expanding through every connected issue type.  
   
`issueFunction in linkedIssuesOfRecursive("project = SRCLOUD")`

This causes unnecessary expansion and increases processing time.

#### ✅ Optimized (restricted issue types)

Here, the search is limited to only Stories and Bugs, keeping the recursive expansion controlled.  
   
`issueFunction in linkedIssuesOfRecursive( "project = SRCLOUD AND issuetype in (Story, Bug)" )`

## How to write efficient queries video walkthrough

&amp;amp;amp;amp;lt;p&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;br/&amp;amp;amp;amp;gt;&amp;amp;amp;amp;lt;/p&amp;amp;amp;amp;gt;
