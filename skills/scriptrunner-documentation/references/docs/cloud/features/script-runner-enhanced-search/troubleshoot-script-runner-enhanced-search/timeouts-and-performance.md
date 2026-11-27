# Timeouts and Performance

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search > Troubleshoot ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-140f093a-2154-4660-8670-cfcc69a0f57b-c7884f6efbb8c27a
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#troubleshoot-scriptrunner-enhanced-search--en#timeouts-and-performance--en

Sometimes, it can seem that performance on Cloud may seem a little slow. Here's why:

-   We process updates in small batches to ensure the continued reliability of our system.
-   When multiple users are engaged on the system at the same time, things might take a bit longer. System limits are in place to ensure fair resource sharing among all users, so results may take longer to load during peak usage times.
-   If you're running multiple searches, we handle them one at a time to make sure results are accurate.

## Timeouts

Note: DC versus Cloud

If you have previously used ScriptRunner for Jira Data Center, you might experience timeouts more frequently in Cloud for complex searches.

Enhanced Search operations in Jira Cloud may occasionally be slow or completely fail when a query is too large or complex. This is due to platform limits designed to protect overall system performance. You should be aware of the timeout thresholds outlined below that relate to queries that are too large or slow:

### Search timeouts

In the native Jira search bar, there is a 55-second limit per precomputation. Filters can contain multiple precomputations, and each one can run independently for up to 55 seconds.

Visit [Detect Broken Filters Using an Analyzer](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/detect-broken-filters-using-an-analyzer) to learn how to detect filters with timeout risks.

Searches that do not return results within this limit will time out. There is a progress bar indicating the status. To reduce the run time, we recommend simplifying your query as much as possible.

### Saved filter sync timeouts

In the native Jira search bar, there is a 55-second limit per precomputation. Filters can contain multiple precomputations, and each one can run independently for up to 55 seconds.

Visit [Detect Broken Filters Using an Analyzer](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/detect-broken-filters-using-an-analyzer) to learn how to detect filters with timeout risks.

Warning:

Previously when Enhanced Search was on Connect instead of Forge, if there are too many filters to sync during the 5-minute period, an attempt cannot be made to sync them. Therefore, it cannot be determined whether the results of these unattempted filters will hit the limits of the 1000 RHS and 55-second timeout limit currently on Forge. This means we cannot display a warning for those filters in the current Connect UI, so they will not show up in the report discussed on [Detect Broken Filters Using an Analyzer](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/detect-broken-filters-using-an-analyzer).

Possible workaround: You can navigate to the Enhanced Search page and run a manual sync on all individual filters to generate the Forge errors. However, if the filter itself takes more than 2 minutes to sync, then it will still time out and not be able to produce the errors.

Filters that do not complete synchronization within this limit will time out. When you save a JQL Filter, our system syncs it in the background at regular intervals to give you the latest results. The sync interval you set is the minimum time between checks to update your filters (1 to 60 minutes). We fetch all users who own ES filters, sending a message to our filter sync system to automatically synchronise their filters.

### How to mitigate timeouts

Search timeouts

The following recommendations can help reduce execution time and prevent timeouts.

-   Consider when searches run:
    -   Complex or resource-intensive searches should be run during off-peak hours to reduce the likelihood of timeouts. For frequently used searches, consider simplifying the query to improve consistency and reliability.
-   Reduce query size:
    -   Break large searches into smaller queries that target a narrower set of issues.
    -   Limit scope by project and issue type wherever possible instead of searching across the entire instance.
    -   Use time-based constraints, such as creation or update dates, when full historical results are not required.
    -   Apply status or assignee filters to further reduce the number of issues evaluated.
-   Optimise query structure:
    -   Enhanced Search supports sub-queries, which should be optimised individually before being combined into a larger query.
    -   Minimise the data set processed by each Enhanced Search function by tightening its parameters.
    -   Avoid stacking multiple complex functions in a single query unless necessary.

For example, instead of searching across all projects:

```
issueFunction in linkedIssuesOfRecursive("status not in ('Done', 'Not Doing')")
```

Target specific projects:

```
issueFunction in linkedIssuesOfRecursive("project=PROJECTONE and status not in ('Done', 'Not Doing')")
```

Want faster results?

We strongly recommend you use the optional [`childrenOf`](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#childrenof--en) (Subquery, optional descendant filter) second JQL query parameter that acts as a filter on descendant issues. Using the second JQL query parameter is an effective way to narrow down and speed up search results provided by `childrenOf`. You can refer to our examples for more details.

Saved filter sync timeouts

To reduce sync failures and improve overall performance, apply the following optimisations.

-   Reduce query scope:
    -   Limit searches to specific projects whenever possible instead of running instance-wide queries. Smaller result sets sync faster. Likewise, if full historical data is not required, apply date range constraints.
-   Simplify long-running filters:
    -   Reduce query complexity by removing unnecessary conditions, nested logic, or custom functions.
    -   Limit the use of functions such as `linkedIssuesOf` and `parentsOf` which significantly increases processing time and should be used sparingly, especially for filters that need to sync frequently.
    -   Review filters that combine multiple complex functions or operate over large data sets, as these are the most likely to cause timeouts.
    -   Long-running filters can delay syncing for other filters within the same account.
-   Distribute and reduce sync load: Share filter ownership across multiple team members to balance processing load.
-   Delete unused filters: If you have filters that aren't being used, consider deleting them to free up syncing resources and allow active filters to sync more efficiently.

## Performance expectations for saved filters

### Shared filters

Outlined below are typical performance characteristics of shared filters in Enhanced Search for Jira Cloud:

-   Loading shared filters may take longer in Cloud environments due to distributed processing.
-   Initial load times increase as the number of shared filters increases.
-   Performance may vary based on overall system load, including the number of concurrent users.

### Filter syncing

Outlined below are typical performance characteristics of filter syncing in Enhanced Search for Jira Cloud:

-   Sync interval: The sync interval you set is the minimum time between checks to update your saved filters, i.e., how often we update your search results. However, actual updates may vary depending on filter complexity and whether filters are still being synced from a previous sync interval.
-   A long-running filter processes a large data set.
-   Account syncing limits: Syncing happens independently for each user account. If a sync is already in progress for your account, new syncs will wait until the current one finishes. This ensures data consistency, but it can mean your filters may not update at the regularity of your sync interval.

### Common reasons for sync delays

-   Complex filters: Filters with lots of data, complex queries, or broad JQL arguments (like `linkedIssuesOf`) take longer to sync. This can delay updates for other filters in the same account.
-   Timeouts: Syncing any single precomputation has a 55-second time limit. A filter can contain multiple precomputations. If a filter has 10 precomputations, they can all take 55 seconds to process. However, if it takes longer than 55 seconds, it will not be able to successfully sync and you will see an error indicator. Please refer to [Detect Broken Filters Using an Analyzer](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/detect-broken-filters-using-an-analyzer) to learn how to detect filters with timeout risks.
    

### When sync improvements aren't possible

In certain situations, there may be no effective way to improve sync frequency or reliability. For example:

-   Extremely long-running filters:
    
    If a precomputation takes longer than 55 seconds to process, it will not complete syncing within the time limit. You can try optimizing the filter query.
-   Heavy data filters: Filters that rely on extremely large datasets or involve intensive calculations may also reach technical limits. If the system cannot sync them within the available time, they will not update as frequently, no matter what changes are made.
    

In these cases, if syncing frequency or reliability is critical, consider simplifying the filter’s JQL input query or using alternative filters with reduced complexity. If that’s not possible, you may need to manually refresh the results or adjust expectations for real-time updates.

Need help?

If you’re still experiencing persistent Cloud performance issues:

-   Look at your biggest searches: Could they be made smaller?
-   Consider running complex queries during off-peak hours.
-   Contact the [Adaptavist Support Portal](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19/user/login?destination=portal%2F19) if issues persist after optimization.
