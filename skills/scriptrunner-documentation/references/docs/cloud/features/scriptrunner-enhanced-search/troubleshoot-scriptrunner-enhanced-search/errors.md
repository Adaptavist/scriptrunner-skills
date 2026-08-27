# Errors

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-513345633
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/errors

If you see an error message informing you that _"Function 'X' does not exist"_, then you should check that you have entered a space after the comma in the query you are running.

## Issues with Epic links

Summary

Cause

Resolution

If your Enhanced Search query references the **Epic Link**, you may notice that it does not return expected results on your Cloud instance.

Atlassian has deprecated the **Epic Link** field and now [recommends](https://support.atlassian.com/jira-software-cloud/docs/upcoming-changes-epic-link-replaced-with-parent/) using the **Parent** property to link to epics. 

To ensure your queries work smoothly, we recommend updating to Jira's **Parent field configuration** to ensure compatibility.

## Renamed or customized issues

Summary

Cause

Resolution

If you've renamed or customized issue types in your Jira instance, you may notice issues with epic-related queries in Enhanced Search, such as:

-   Epic-related JQL functions (e.g., `epicsOf, linkedIssuesOf`) are not returning expected results.
    

The functions `epicsOf`, `issuesInEpics` and `parentsOf` will only work with standard Jira issue types.  
  
If you would like to use Enhanced Search functions with custom issue types, you must use `parentsOf` with the 'all' parameter and the `childrenOf` function.

-   `issueFunction in parentsOf("project in (TEST)", "all") AND issuetype = "Custom Epic Name"`
-   `issueFunction in childrenOf("project in (TEST)", "hierarchyLevel = 0")`

Atlassian has documented the work item [hierarchy level](https://support.atlassian.com/jira-cloud-administration/docs/configure-the-issue-type-hierarchy/)s to use in JQL queries.

To ensure your queries work smoothly, we recommend reviewing your Enhanced Search queries and ensuring you are using the correct function for your Jira instance configuration.

## addedAfterSprintStart known issue

Summary

Cause

Resolution

It is possible that the `addedAfterSprintStart` function may return inaccurate results when sprints are reopened. 

Jira has a known limitation where, if a sprint is closed and then reopened, new changelog entries are created for all issues in the sprint using timestamps from the reopening event. Because the system relies on the latest changelog entry to determine when an issue was added to a sprint, this can affect the accuracy of tracking issue additions. While future improvements may be considered, there is currently no immediate fix due to the risk of impacting other scenarios.

It is recommended to use explicit date-based queries together with the `addedAfterSprintStart` function to help address this limitation, even though this approach may not be perfect.

## Filter search results are not automatically updated 

Summary

Resolution

This happens when the time it takes for your query to complete exceeds the sync interval (i.e., how often we update your search results) limit of five minutes.

This may also happen if a filter is unused for two+ months.

-   **Manually refresh the filter:**   
    Locate the [saved filter](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries/saved-filters) and click refresh to get the most up-to-date results, as highlighted below.  
    ![](/sr4jc/files/latest/513345633/513345635/1/1771577846000/refresh+filter.png)
    
-   **Simplify your query:**  
    Reduce the complexity or narrow down your search criteria. This helps the query to complete faster and fall within the sync interval rate. See our [Tips for Writing JQL Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries/tips-for-writing-jql-queries) for more details.

## Incorrect board ID in sprint functions

Summary

Cause

Resolution

-   Sprint functions such as `previousSprint()` do not return expected results.
    
-   The board ID believed to be correct does not align with the current sprint data.
    

This issue typically arises when teams switch to using a shared central board for sprint management but continue using an old board ID in their queries.

1.  **Verify the current board configuration:**
    
    -   Navigate to your Jira scrum board settings to confirm the board IDcurrently managing sprints. You must use the board ID of the board from which the sprint was created.
        
2.  **Update JQL functions:**
    
    -   Replace the board ID in your JQL functions with the ID of the centralized sprint board.
        
    -   Example: Change all instances of `previousSprint(boardId=234)`to `previousSprint(boardId=205)`.
        
3.  **Test the changes:**
    
    -   Run your queries to ensure they are now returning the correct issues.
        

## Slow performance with negative operators

Summary

Cause

Resolution

-   Queries using negative operators `(e.g., not in, !=)`take longer than expected to execute.
    
-   Performance issues are more pronounced in larger Jira instances.
    

Negative operators expand the search scope, requiring the system to process a larger dataset to exclude specified values.

1.  **Optimize JQL queries:**
    
    -   Combine negative operators with positive conditions to reduce the dataset being queried.
        
    -   Example: Instead of `status != "Closed"`, use `status != "Closed" AND createdDate >= -30d`.
        
2.  **Narrow the query scope:**
    
    -   Include additional limiting JQL clauses like project keys or specific fields.
        
    -   Example: assignee in `(currentUser())`AND `status not in (Closed, Resolved)`.
        
3.  **Refine your approach:**
    
    -   Evaluate if a more straightforward query could achieve the desired results without using negative operators.
        

## Unable to save JQL search

Summary

Cause

Resolution

When saving a JQL query, you receive an error message indicating that something went wrong and asking you to try again later.

-   We have a **120-second timeout limit** for searches manually triggered in the app, including the search that takes place when saving a filter. If you receive an error when the save request fails after stalling for some time, this may be the cause of the issue.
-   If you see an error stating that a '_Filter with the same name already exists_', then it's possible that a Jira filter with the same name already exists. When you create a filter, both an ES copy and a Jira copy are generated, and they essentially both reference the same filter. However, the name used **must be unique** across both. If you name a filter in ES, it will carry the same name in Jira. Therefore, the error you're seeing is likely due to a naming conflict with an existing Jira filter.

Try renaming your ES filter and saving it again.

## No results returned for 'Epic' and 'Done' query

Summary

Resolution

-   The issue type '**Epic**' with a '**Done**' status returns zero results.
-   The intention is to list all epics where at least one child issue is marked as '**Done**', or where all child issues are marked as '**Done**'.

You can use the `[epicsOf()](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships)` Enhanced Search JQL function to write queries that will find epics with some or all of the child issues resolved.

For example:

-   issueFunction in epicsOf('project= Demo and status = "Done"')
-   issueFunction in epicsOf('project= Demo and status = "Done"') and not issueFunction in epicsOf('project = Demo and status != "Done"')

## Search results cannot be saved

Summary

Cause

When you use an ES query search and the results are returned, but cannot be saved.

This can be due to too many issue results being returned. The Atlassian filter API will reject a filter if there are too many issues in the JQL (e.g., over 20,000 issue results).

## Restrictions on searches for users

Summary

Resolution

Atlassian has announced that usernames or email addresses can no longer be used in filters; instead, the `accountID` should be used.

 You can refer to their [notification](https://support.atlassian.com/jira-software-cloud/docs/how-are-usernames-changing-in-jira-cloud/) for more details.
