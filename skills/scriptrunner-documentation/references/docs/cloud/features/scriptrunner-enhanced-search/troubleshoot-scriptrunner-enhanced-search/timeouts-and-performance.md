# Timeouts and Performance

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-513345624
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/timeouts-and-performance

Sometimes, it can seem that performance on Cloud may seem a little slow. Here's why:

-   We process updates in small batches to ensure the continued reliability of our system.
    
-   When multiple users are engaged on the system at the same time, things might take a bit longer. System limits are in place to ensure fair resource sharing among all users, so results may take longer to load during peak usage times.
    
-   If you're running multiple searches, we handle them one at a time to make sure results are accurate.
    

## Timeouts

DC versus Cloud

If you have previously used ScriptRunner for Jira Data Center, you might experience timeouts more frequently in Cloud for complex searches.

Enhanced Search operations in Jira Cloud may occasionally be slow or completely fail when a query is too large or complex. This is due to platform limits designed to protect overall system performance. You should be aware of the timeout thresholds outlined below that relate to queries that are too large or slow:

### Search timeouts

Upcoming change to timeouts

To improve security and usability, ScriptRunner Enhanced Search is moving to Atlassian's native Jira platform using Forge. With the use of Forge, that means there will be changes to timeout times.

Right now, on Connect, there is a two minute timeout for searches made using the Enhanced Search page.

In Forge, there will not be an Enhanced Search search page, and you will be able to use Enhanced Search functions in the native Jira search bar where there is a 25-second limit per precomputation. In Forge, filters can contain multiple precomputations, and each one can run independently for up to 25 seconds.

Connect

Forge

2 minutes (all precomputations within a filter)

25 seconds per precomputation (multiple can be contained per filter)

Please refer to our [Breaking Changes](https://docs.adaptavist.com/es/latest/release-notes/breaking-changes) documentation to learn how to detect filters with timeout risks.

Searches that do not return results within this limit will time out. There is a progress bar indicating the status. To reduce the run time, we recommend simplifying your query as much as possible.

### Saved filter sync timeouts

Upcoming changes to timeouts

To improve security and usability, ScriptRunner Enhanced Search is moving to Atlassian's native Jira platform using Forge. With the use of Forge, that means there will be changes to timeout times.

Right now, on Connect, there is a five-minute timeout for searches. In Connect, each users filters are synced at once. If a user had 5 filters, each filter has 30 seconds to attempt to by synced. If any filter takes longer than 30 seconds to sync, the filter will return an error. There is also a 5-minute timeout limit for all filters to sync. So if 2 filters took 20 seconds , 1 filter took 10 minutes, and 1 filter took one second to sync, the 3rd and 4th filter could fail since the overall timeout was reached during the attempt to sync the 3rd filter.

When we make the upcoming change to forge, the timeout will be 25 seconds per precomputation. In Forge, filters can contain multiple precomputations, and each one can run independently for up to 25 seconds.

  

  

5 minutes (all precomputations within a filter)

25 seconds per precomputation (multiple can be contained per filter)

Please refer to our [Breaking Changes](https://docs.adaptavist.com/es/latest/release-notes/breaking-changes) documentation to learn how to learn how to detect filters with timeout risks.

**Potential risk for sync timeouts:** 

If there are too many filters to sync during the 5-minute period, an attempt cannot be made to sync them. Therefore, it cannot be determined whether the results of these unattempted filters will hit the limits of the 1000 RHS and 25 second timeout limit currently on Forge. This means we cannot display a warning for those filters in the current Connect UI, so they will not show up in the report discussed on [Breaking Changes](https://docs.adaptavist.com/spaces/ES/pages/566231140/.Breaking+Changes+vDraft). 

**Possible workaround:**

You can navigate to the Enhanced Search page and run a manual sync on all individual filters to generate the Forge errors. However, if the filter itself takes more than 2 minutes to sync, then it will still time out and not be able to produce the errors.

Filters that do not complete synchronization within this limit will time out. When you save a [JQL filter](https://docs.adaptavist.com/es/latest/save-a-search), our system syncs it in the background at regular intervals to give you the latest results. The sync interval you set is the minimum time between checks to update your filters (1 to 60 minutes). We fetch all users who own ES filters, sending a message to our filter sync system to automatically synchronise their filters.

Issue sync

In addition to filter syncs, issue syncs occur when issues are updated (added or edited in some way) in Jira, and the data stored in Enhanced Search needs to be updated so that your searches use the most up-to-date information on your issues. The issue sync includes updating metadata and occurs when we receive an event notification that something changed on your instance. 

### How to mitigate timeouts

#### Search timeouts

The following recommendations can help reduce execution time and prevent timeouts.

-   **Consider when searches run:** complex or resource-intensive searches should be run during off-peak hours to reduce the likelihood of timeouts. For frequently used searches, consider simplifying the query to improve consistency and reliability.
-   **Reduce query size:** 
    -   Break large searches into smaller queries that target a narrower set of issues.
    -   Limit scope by project and issue type wherever possible instead of searching across the entire instance.
    -   Use time-based constraints, such as creation or update dates, when full historical results are not required.
    -   Apply status or assignee filters to further reduce the number of issues evaluated.
        
-   **Optimise query structure:** 
    -   Enhanced Search supports sub-queries, which should be optimised individually before being combined into a larger query.
    -   Minimise the data set processed by each Enhanced Search function by tightening its parameters.
        
    -   Avoid stacking multiple complex functions in a single query unless necessary.
        

For example, instead of searching across all projects:

`issueFunction in linkedIssuesOfRecursive("status not in ('Done', 'Not Doing')")`

Target specific projects:

`issueFunction in linkedIssuesOfRecursive("project=PROJECTONE and status not in ('Done', 'Not Doing')")`

Want faster results?

We _**strongly recommend**_ you use the optional `[childrenOf](https://docs.adaptavist.com/es/latest/enhanced-search-jql-functions/links-and-relationships/childrenof)` (Subquery, optional descendant filter) second JQL query parameter that acts as a filter on descendant issues. Using the second JQL query parameter is an effective way to narrow down and speed up search results provided by `childrenOf`. You can refer to our [examples](https://docs.adaptavist.com/es/latest/enhanced-search-jql-functions/links-and-relationships/childrenof#examples) for more details.

#### Filter sync timeouts

To reduce sync failures and improve overall performance, apply the following optimisations.

-   **Reduce query scope:** Limit searches to specific projects wherever possible instead of running instance-wide queries. Smaller result sets sync faster. Likewise, if full historical data is not required, apply date range constraints.
-   **Simplify long-running filters:** 
    -   Reduce query complexity by removing unnecessary conditions, nested logic, or custom functions.
    -   Limit the use of functions such as `linkedIssuesOf` and `parentsOf` which significantly increases processing time and should be used sparingly, especially for filters that need to sync frequently.
    -   Review filters that combine multiple complex functions or operate over large data sets, as these are the most likely to cause timeouts.
    -   Long-running filters can delay syncing for other filters within the same account. 
-   **Distribute and reduce sync load:** share filter ownership across multiple team members to balance processing load.
-   **Delete unused filters**: If you have filters that aren't being used, consider deleting them to free up syncing resources and allow active filters to sync more efficiently.

## Performance expectations for saved filters

### Shared filters

Outlined below are typical performance characteristics of shared filters in Enhanced Search for Jira Cloud:

-   Loading shared filters may take longer in Cloud environments due to distributed processing.
    
-   Initial load times increase as the number of shared filters increases.
    
-   Performance may vary based on overall system load, including the number of concurrent users.
    

### Filter syncing 

Outlined below are typical performance characteristics of filter syncing in Enhanced Search for Jira Cloud:

-   **Sync interval**: The sync interval you set is the minimum time between checks to update your saved filters, i.e., how often we update your search results. However, actual updates may vary depending on filter complexity and whether filters are still being synced from a previous sync interval.
    
-   A **long-running filter** processes a large data set.
    
-   **Account syncing limits**: Syncing happens independently for each user account. If a sync is already in progress for your account, new syncs will wait until the current one finishes. This ensures data consistency, but it can mean your filters may not update at the regularity of your sync interval.
    

### Common reasons for sync delays

-   **Complex filters**: Filters with lots of data, complex queries, or broad JQL arguments (like `linkedIssuesOf`) take longer to sync. This can delay updates for other filters in the same account.
    
-   **Timeouts**: 
    
    Upcoming changes to timeouts
    
    Upcoming changes to timeouts
    
    To improve security and usability, ScriptRunner Enhanced Search is moving to Atlassian's native Jira platform using Forge. With the use of Forge, that means there will be changes to timeout times. Right now, on Connect, there is a 5-minute timeout for syncing one user's filters and 30 seconds for an individual filter in a set of users's filters. When we make the upcoming change to forge, it will be 25 seconds per precomputation. In Forge, filters can contain multiple precomputations, and each one can run at the same time for up to 25 seconds.
    
    For **Connect** (current): 
    
    -   Syncing all filters for a single user has a five-minute time limit. So, if a user has 10 filters that each take 10 seconds to process, they will all be successfully synced within this five-minute limit. However, if a user has 20 filters that each take 25 seconds to process, we will not be able to successfully sync every filter for that user, and they may see the error _Sync operation timed out_.  
        
    -   Syncing users' individual filters has a 30-second time limit. Filters that cannot be processed within 30 seconds will not be successfully synced within a sync operation.
    
    For upcoming **Forge**:
    
    -   Syncing any single precomputation has a 25-second time limit. A filter can contain multiple precomputations. If a filter has 10 pre computations, they can all take 25-seconds to process. However, if it takes longer than 25 seconds, it will not be able to successfully sync and you will see an error indicator. Please refer to our [Breaking Changes](https://docs.adaptavist.com/es/latest/release-notes/breaking-changes) documentation to learn how to learn how to detect filters with timeout risks.
    

### When sync improvements aren't possible

In certain situations, there may be no effective way to improve sync frequency or reliability. For example:

-   **Extremely long-running filters**: 
    
    Upcoming changes to timeouts
    
    To improve security and usability, ScriptRunner Enhanced Search is moving to Atlassian's native Jira platform using Forge. With the use of Forge, that means there will be changes to timeout times. Right now, on Connect, there is a five-minute timeout for filter syncing all of an end user's filters, and an individual filter syncing timeout of 30 seconds. When we make the upcoming change to forge, it will be 25 seconds per precomputation. In Forge, filters can contain multiple precomputations, and each one can run independently for up to 25 seconds.
    
    For **Connect** (current): 
    
    -   If a filter takes longer than 30 seconds to process, it will not complete syncing within the time limit. You can try disabling automatic syncing or optimizing the filter query.
    
    For **Forge** (upcoming): 
    
    -   If a precomputation takes longer than 25 seconds to process, it will not complete syncing within the time limit. You can try optimizing the filter query.
    
-   **Heavy data filters**: Filters that rely on extremely large datasets or involve intensive calculations may also reach technical limits. If the system cannot sync them within the available time, they will not update as frequently, no matter what changes are made.
    

In these cases, if syncing frequency or reliability is critical, consider simplifying the filter's JQL input query or using alternative filters with reduced complexity. If that's not possible, you may need to manually refresh the results or adjust expectations for real-time updates.

Need help?

If you're still experiencing persistent Cloud performance issues:

-   Look at your biggest searches - could they be made smaller?
    
-   Consider running complex queries during off-peak hours.
    
-   Contact the [Adaptavist Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19/user/login?destination=portal%2F19) if issues persist after optimization.
