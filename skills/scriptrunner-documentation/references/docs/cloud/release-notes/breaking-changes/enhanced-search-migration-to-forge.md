# Enhanced Search Migration to Forge

- Platform: cloud
- Space: SR4JC
- Hierarchy: Release Notes > Breaking Changes
- Doc ID: doc-sr4jc-abc2298f-b7af-4e60-b6c6-969062871c73-7e70ae938d644504
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#enhanced-search-migration-to-forge--en

## Advance notice: ScriptRunner Enhanced Search for Jira Cloud migration to Forge

ScriptRunner Enhanced Search for Jira Cloud is moving to Atlassian's native Forge platform this year. As part of this transition:

-   Searches will be integrated into the native Jira search bar.
-   Forge custom JQL functions will be used.

Watch this space for further announcements on dates and deadlines.

### What you need to do before migration

We will initiate the transfer of your filters according to a planned migration schedule. Any filters that fail to migrate automatically will remain on Connect for you to fix before you can manually attempt to migrate it again.

To avoid disruption during the rollout of the new app version, you must identify any existing saved filters that require attention to ensure a successful migration from the current Connect platform to Forge.

1.  Detect broken filters.
    
    If a filter requires attention, an error symbol indicator appears alongside it. This indicator:
    
    -   Highlights filters that are at high risk of failing during migration.
    -   Includes a link to additional information about the issue.
    
    For example, you can see all error symbol indicators contained within the image below:
    
    Warning: A note about new result and time limits
    
    There are two new limits associated with the Forge migration:
    
    -   Result limit of 1,000 issues
    -   Timeout limit of 25 seconds
    
    Both of these limits are per precomputation. A precomputation is an individual use of an Enhanced Search function. Filters can contain multiple precomputations, and each one can return up to 1,000 issues and run for 25 seconds.
    
    Example: `issueFunction` in `linkedIssuesOf("project = test")` and `issueFunction` in `addedAfterSprintStart(1)`. Each use of a function, or precomputation, can return 1000 issues, so the entire filter could return 2,000 issues since there are two. For timeout limits, each function, or precomputation, can take 25-seconds to process. They will run at the same time.
    
    Each symbol relates to a different error type that include:
    
    -   Results exceeding 1,000 issues.
    -   Taking 25 seconds or longer to load.
    -   Returning errors.
    
    Once the issue is resolved, the indicator will disappear.
    

How to fix broken filters

2.  Review and update your saved filters that have been flagged with an error symbol.
    
    You must review and update your saved filters that have been flagged with an error symbol. Refer to the [Troubleshoot](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search) section for guidance on resolving filter errors or other issues.
    

## Make your Enhanced Search filters ready for Jira Cloud
