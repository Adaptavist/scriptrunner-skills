# Incorrect Functions Causing Board Errors

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-550633909
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/incorrect-functions-causing-board-errors

## The problem

A regression in the Jira REST API has broken the established contract for Custom JQL functions. Before the migration to Forge, when a function returned an error, the board filters were empty and not showing the error. Now with our migration, you may experience issues accessing Jira boards and dashboards if you have improperly configured or unoptimized filters.

We have updated the app so that it reverts back to the 'empty results' state, but Atlassian has cached the error for 7 days which is why the issue is not fixed yet.

Boards and dashboards may fail to load if they rely on JQL filters that reference Enhanced Search functions incorrectly. This typically occurs in two scenarios:

1.  **Syncing issues:** A filter was migrated from Data Center to Cloud but has never successfully synced (often due to an initial sync error).
    
2.  **Migration failures:** A filter failed to migrate to Enhanced Search Cloud but is still being referenced in board or dashboard settings.
    

This occurs if an Enhanced Search function is used when searching outside of the Enhanced Search application UI.

### Why this is happening now

We recently introduced structural changes for upcoming features, which could highlight a pre-existing configuration issue on your board where a non-functional Enhanced Search query was being used. Because this filter never returned active data, removing it will restore your board immediately without data loss.

## The solution

Depending on the state of your filter, please follow the steps below to restore access:

### If the filter is a valid Enhanced Search Cloud filter

You have three options:

-   **Manual sync:** Navigate to the **Enhanced Search app** and attempt to sync the filter manually.  
    ![](/sr4jc/files/latest/550633909/550633908/1/1779907913000/Screenshot+2026-05-15+at+16.55.59.png)  
    After you select **Sync Filter**, the synchronization may not finish if there is a filter error. Read the error message and fix the broken filter to complete the sync. If you are having issues, please [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19).
    
-   **Optimise filter JQL:** If the manual sync times out (exceeds 2 minutes), the JQL query must be optimised for performance. 
    
    The most effective way to optimise these queries is to include specific project filtering within the function’s JQL. Use this documentation for help: 
    
    -   [Build Efficient Queries](https://docs.adaptavist.com/es/latest/build-efficient-queries)
    -   [Query Writing Recommendations](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/query-writing-recommendations)
    -   [Timeouts and Performance Troubleshooting](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/timeouts-and-performance)

### If the filter failed to migrate but is still referenced:

If the filter cannot be repaired or synced, you must remove the reference to the problematic filter from your **Board Settings** or dashboard gadgets entirely to restore page functionality.
