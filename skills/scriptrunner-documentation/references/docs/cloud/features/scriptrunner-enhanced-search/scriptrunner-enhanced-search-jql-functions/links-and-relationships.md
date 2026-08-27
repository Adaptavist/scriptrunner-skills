# Links and Relationships

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-functions
- Doc ID: doc-sr4jc-313196614
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships

These ScriptRunner Enhanced Search JQL functions help to identify blockers, dependencies, and linked tasks.

The Issue Link functions use issue link attributes to sort through issues. The Epic functions filter via epic links and the Sub-task functions return sub-tasks of issues, or parents of sub-tasks.

Using the NOT keyword

When using a negative search, you can use the `not` keyword before or after `issueFunction` as shown in the following examples:

`project = "KEY" and not issueFunction in linkedIssuesOfRecursive("component='componentName'", "depends on")`

`project = "KEY" and issueFunction not in linkedIssuesOfRecursive("component='componentName'", "depends on")`

## linkedIssuesOf

This function helps you find all issues linked to those identified by a specific query. It is particularly useful for:

-   Identifying dependencies between tasks
    
-   Highlighting blockers
    
-   Enhancing visibility across linked issues
    

For more information on how to configure JQL queries, see the Atlassian [Advanced Searching documentation](https://support.atlassian.com/jira-software-cloud/docs/what-is-advanced-search-in-jira-cloud/).

### Syntax and parameters

```
linkedIssuesOf(Subquery, [link type] [the name of the link description (inward or outward)])
```

-   **Subquery:** A JQL query to find the issues of interest. This query should be enclosed in double quotes.
    
-   **Link name:** The type of link between issues (e.g., "blocks", "is blocked by"). If omitted, the function searches across all link types, which we only recommend if you are not looking for a specific link type.
    

The issues returned when using link names such as 'blocks' and 'is Blocked by', or 'clones' and 'is Cloned by', in the `linkedIssuesOf` function may provide different results when using the same link names for the `issueLinkType` alias.

### **Examples**

1.  **Finding unresolved issues blocked by open issues:**
    
    To identify unresolved issues that are blocked by issues in the Open state, you can use the following query:
    
    ```
issueFunction in linkedIssuesOf("status = Open", "blocks") AND resolution IS EMPTY
```
    
    This query helps teams to focus on resolving blocking issues first, ensuring a smoother workflow.
    
2.  **Searching for linked issues without specifying a link type:**
    
    If you need to find all linked issues regardless of the link type, you can use a query like:
    
    ```
issueFunction in linkedIssuesOf("resolution = unresolved")
```
    
    This broader query is useful for gaining a comprehensive view of all dependencies.
    
    -   **Define clear link types:** Specify the link type in your query to narrow down results and focus on the most relevant dependencies.
        
    -   **Use with other functions:** Combine `linkedIssuesOf` with other JQL functions for more complex queries. For example, integrate it with `epicsOf` to see how linked issues relate to larger epics.
        
    

## linkedIssuesOfRecursive

The `linkedIssuesOfRecursive` function allows you to delve into the web of dependencies within your projects to uncover not just direct links but also the intricate network of indirect relationships between issues.

This function is essential for:

-   Mapping out complex dependency chains to foresee potential project roadblocks
    
-   Revealing the full scope of project interdependencies
    
-   Identifying and addressing indirect dependencies early
    

Consider a real-world scenario: You're using the function to trace all issues related to a critical epic, `EPIC-123`. By executing `issueFunction in linkedIssuesOfRecursive("epic = EPIC-123")`, you uncover not just the tasks directly linked to `EPIC-123`, but also tasks linked to those tasks, and so on. This might reveal that a seemingly unrelated task in another team’s backlog is actually a crucial piece of the puzzle.

### Syntax and parameters

```
linkedIssuesOfRecursive(Subquery, [Link name])
```

-   **Subquery:** A JQL query to identify the initial set of issues. This is enclosed in double quotes.
    
-   **Link name:** Specifies the type of issue link to traverse. If this parameter is not used, all link types are considered, which we don’t recommend.
    

### Find any issues linked to a subquery demo video

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### **Examples**

1.  **Mapping out all dependencies of an issue:**
    
    To visualise all direct and indirect dependencies of a particular issue, you might use:
    
    ```
issueFunction in linkedIssuesOfRecursive("issue = DEMO-1")
```
    
    This query helps in understanding the full extent of dependencies for `DEMO-1`, aiding in thorough planning and risk assessment.
    
2.  **Focusing on specific link types:**
    
    To concentrate on a specific type of dependency, such as "blocks", the query can be refined:
    
    ```
issueFunction in linkedIssuesOfRecursive("issue = DEMO-1", "blocks")
```
    
    By focusing on blocking issues, teams can prioritise work to clear these critical paths.
    

-   **Understand the impact of recursive searches:** Recursive searches can be resource-intensive. Be mindful of the number of issues your query will search through, as this can impact system performance.
    
-   **Use specific link types for efficiency:** Narrowing your search to specific link types can make your queries more efficient and the results more relevant.
    
-   **Beware of circular dependencies:** Our built-in protection mechanisms prevent infinite loops in search queries, enhancing reliability and stability.
    

We have protection mechanisms built in to deal with circular dependencies in your issue links. For example, if `DEMO-1` links to `DEMO-2`, `DEMO-2` links to `DEMO-3` and `DEMO-3` links to `DEMO-1,` then we will notice that we have already seen `DEMO-1` and stop processing. 

Time limited search

If you have thousands of indirectly linked issues, traversal of all of the links will take a long time or may time out. A two-minute time limit is imposed on queries that run in the search bar to avoid a) overwhelming Jira with search requests and b) search results taking a long time to keep up to date. However, a lower timeout limit of 30 seconds exists for automatic syncing.

Using the NOT keyword

When using a negative search, you can use the `not` keyword before or after `issueFunction` as shown in the following examples:

`project = "KEY" and not issueFunction in linkedIssuesOfRecursive("component='componentName'", "depends on")`

`project = "KEY" and issueFunction not in linkedIssuesOfRecursive("component='componentName'", "depends on")`

## linkedIssuesOfRecursiveLimited

The `linkedIssuesOfRecursiveLimited` function extends the capabilities of `linkedIssuesOfRecursive` by adding a critical feature: the ability to limit the depth of the issue link traversal. This applies when understanding dependencies beyond a certain depth becomes less relevant or could clutter the analysis with excessive information.

It is particularly beneficial for:

-   Focusing on immediate or near-term dependencies that are most relevant
    
-   Providing clearer, more manageable insights into dependencies
    

### Syntax and parameters

```
linkedIssuesOfRecursiveLimited(Subquery, Traversal depth, [Link name])
```

-   **Subquery:** A JQL query string that identifies the initial set of issues. This query is enclosed in double quotes.
    
-   **Traversal depth:** An integer specifying how many levels deep the function should traverse issue links.
    
-   **Link name:** Specifies the type of issue link to consider in the traversal.
    

### **Examples**

1.  **Limiting dependency analysis to immediate links:**
    
    To explore all links from issues in the `DEMO` project, limited to two links deep:
    
    ```
issueFunction in linkedIssuesOfRecursiveLimited("project = DEMO", 2)
```
    
    This query helps project managers focus on the most immediate dependencies that could impact the project's short-term goals.
    
2.  **Specifying link types for targeted analysis:**
    
    For a targeted approach, specifying a link type narrows down the analysis:
    
    ```
issueFunction in linkedIssuesOfRecursiveLimited("issue = TEST-2", 3, "is blocked by")
```
    
    This would return issues like `TEST-3`, `TEST-6`, and `TEST-5`, providing insight into the specific obstacles facing `TEST-2`.
    

-   **Choose an appropriate depth:** Selecting the right depth for traversal can significantly impact the usefulness of the results. Consider the complexity of your project and the level of detail needed when deciding.
    
-   **Combine with specific link types:** Utilising the optional link type parameter can yield more focused insights, especially when dealing with large projects or when certain dependencies are of particular interest.
    

The following query will follow all links, recursively, from all issues in the `DEMO` project until it has traversed a maximum of 2 links deep along any link path.

`issueFunction in linkedIssuesOfRecursiveLimited("project = DEMO", 2)`

Using the following setup:

![A graphic example of a linkedIssuesOfRecursiveLimited setup.](/sr4jc/files/latest/313196614/313196616/1/1734103087000/jql-recursive-limited.png)

Our query with the depth parameter would return: DEMO-1, DEMO-2, TEST-1, TEST-2, TEST-4 and TEST-5.

We could specify the link name as well, to get different results:

`issueFunction in linkedIssuesOfRecursiveLimited("issue = TEST-2", 3, "is blocked by")`

which would return: TEST-3, TEST-6 and TEST-5

## issuesInEpics

The `issuesInEpics` function allows you to identify all issues that are part of epics matching a specific query.

It's helpful for:

-   Enhancing visibility into the scope and progress of epics
    
-   Simplifying the tracking of stories, tasks, and other issue types that contribute to the completion of epics
    
-   Assisting in workload assessment and resource allocation
    

The `issuesinEpics` function does not support team-managed projects.

### Syntax and parameters

```
issueInEpics(Subquery)
```

-   **Subquery:** A JQL query that identifies the epics of interest.

### How to use the issuesInEpics JQL function demo video

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### **Example**

-   **Finding all stories for open epics in a project:  
    **To aggregate all stories associated with epics that are currently in the "To Do" status within a specific project, you might use:  
    
    ```
issueFunction in issuesInEpics("project = DEMO AND status = 'To Do'")
```
    

## epicsOf

The `epicsOf` function helps you find the epics associated with a specified set of issues.

It’s helpful for:

-   Providing a linkage between individual stories and the larger epics they contribute to
    
-   Identifying epics that are impacted by specific issues
    

### Syntax and parameters

```
epicsOf(Subquery)
```

-   **Subquery:** A JQL query designed to select the issues for which associated epics are to be identified. This could be based on status, project, assignee, or any other relevant criteria.
    

### **Examples**

1.  **Finding epics related to overdue tasks:**
    
    To understand which strategic initiatives are potentially at risk due to delays, you might use a query like:
    
    ```
issueFunction in epicsOf("due <= now() AND resolution = Unresolved")
```
    
    This approach helps to highlight epics that contain overdue tasks, prompting a review of timelines or resources.
    
2.  **Finding empty epics:**
    
    To identify epics within a specific project with no child issues, you can use the `epicsOf` function in conjunction with other JQL criteria.
    
    You may try something like the example below, which may work depending on your use case.
    
    ```
issueFunction not in epicsOf("project = <project name>") AND project = "<project name>" AND issueType = Epic
```
    

Jira Epic Link Field

Due to Atlassian’s recent deprecation of the **Epic Link** default Jira field, Enhanced Search has updated its functionality to align with new standards. This change means that **renamed or customized Epic fields are no longer dynamically supported** in Enhanced Search queries.

To keep your epic-related JQL functions (such as `epicsOf` and `linkedIssuesOf`) working smoothly, you need to ensure you’re using the **Parent** default Jira field. If you have renamed your **Epic** field, we recommend reverting to the default setup to ensure compatibility.

## subtasksOf

The `subtasksOf` function is a targeted tool within Jira for drilling down into the specifics of task management, enabling users to isolate and manage sub-tasks associated with issues identified by a subquery.

It’s helpful for:

-   Identifying all subtasks under specific issues
    
-   Reviewing the progress of subtasks
    

### Identifying board issues with blocked subtasks video demo

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### Syntax and parameters

```
subtasksOf(Subquery)
```

-   **Subquery:** A JQL query string to identify the parent issues whose sub-tasks you want to retrieve. This can be based on various criteria such as project, status, or any specific identifiers.

### **Examples**

1.  **Identifying sub-tasks of high-priority issues:**
    
    To ensure that high-priority issues are progressing well, you might want to isolate and examine their sub-tasks with:
    
    ```
issueFunction in subtasksOf("priority = Highest AND project = CURRENT")
```
    
2.  **Identifying sub-tasks of high-priority issues:  
    **To find sub-tasks that are _Open_, but their parent issue has a resolution of _Fixed_, you could use:  
    
    ```
issueFunction in subtasksOf("resolution = Fixed") AND status = Open
```
    
    To find unresolved sub-tasks of resolved issues you can use:
    
    ```
issueFunction in subtasksOf("resolution IS NOT EMPTY") AND resolution IS EMPTY
```
    

## childrenOf

The `childrenOf` function allows you to identify all descendant issues from a specified subquery. This function is vital for:

-   Visualising the structure and breakdown of large tasks, initiatives, or epics, helping teams understand the scope and scale of work involved.
    
-   Providing a comprehensive view of all related lower-level tasks, from children to grandchildren.
    
-   Facilitating the tracking of progress across multiple levels of a project's hierarchy.
    

### How to find child issues in Jira: The childrenOf JQL function video demo

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### Syntax and parameters

```
childrenOf(Subquery)
```

-   **Subquery:** A JQL query string that identifies the parent issues for which descendant issues are to be retrieved. This could be targeted to specific projects or issues.
-   **Second parameter (optional):** You can use a second JQL query to the childrenOf(Subquery) that acts as a filter on descendant issues. We _**strongly recommend**_ using this option to avoid filters that require significantly longer processing times because of their recursive nature.

### **Examples**

1.  **Identifying all descendant issues of a specific initiative:**
    
    To examine the full extent of issues that stem from a particular initiative, you can use:
    
    ```
issueFunction in childrenOf("issue = EXAMPLE-1")
```
    
    This query helps you see how many tasks, sub-tasks, and further breakdowns have been planned or are underway related to a specific initiative.
    
2.  **Finding children issues in a project, excluding subtasks:**
    
    If you want to focus on significant tasks (excluding subtasks) within a project, the query might look like:
    
    ```
issueFunction in childrenOf("project = DEMO", "issueType != Subtask")
```
    
    Using a second JQL query in this example narrows the results further.
    
3.  **Narrow down search results using a second JQL query:**  
    You can use a second, optional, JQL query to narrow down search results retrieved using `childrenOf`. The second query acts as a filter on the descendant issue results. For example:  
    
    ```
issueFunction in childrenOf("project = ABC and issuetype = initiative", "issuetype = Bug and created >= -30d")
```
    

## parentsOf

The `parentsOf` function allows you to trace up the hierarchy to find ancestor issues of a specified subquery. This function is invaluable for:

-   Understanding the upper levels of the project hierarchy
    
-   Facilitating a comprehensive review of project health and progress by tracking how individual tasks contribute to overarching goals.
    
-   Ensuring that all tasks align with and support higher-level initiatives and milestones.
    

### How to find parent issues in Jira: The parentsOf JQL function video demo

&amp;amp;amp;lt;p&amp;amp;amp;gt;&amp;amp;amp;lt;br/&amp;amp;amp;gt;&amp;amp;amp;lt;/p&amp;amp;amp;gt;

### Syntax and parameters

```
parentsOf(Subquery, [Depth])
```

-   **Subquery:** A JQL query that identifies the child issues whose parent issues are to be retrieved.
-   **Depth:** Can specify "all" to include all ancestors up to the highest level (e.g., initiatives), or omit this to get the parents of subtasks only.

### Examples

1.  **Finding Parent Issues of Subtasks in a Project:**
    
    For teams looking to track the progress of specific subtasks back to their main tasks:
    
    ```
issueFunction in parentsOf("project = DEMO")
```
    
    This query helps in understanding how subtasks are nested within larger tasks, aiding in detailed project tracking and management.
    
2.  **Tracing All Ancestors of Issues in a Project:**
    
    When needing a comprehensive view of all the hierarchical relationships within a project, including epics and initiatives:
    
    ```
issueFunction in parentsOf("project = DEMO", "all")
```
    
    This provides a clear picture of how stories, epics, and other issues stack up under higher-level initiatives, crucial for strategic planning.
    
3.  **Identifying Initiatives Directly Affecting Active Tasks:**
    
    To focus specifically on initiatives affecting active projects without including intermediate levels like epics:
    
    ```
issueFunction in parentsOf("project = DEMO", "all") and issueType != "Epic"
```
    
    This query filters out the epics, allowing project managers to focus on the initiatives directly driving project efforts.
