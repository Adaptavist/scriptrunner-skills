# ScriptRunner Enhanced Search JQL Queries

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-39b49378-d96a-4e60-9608-d248d72df7cc-3d53f24fe42ffd4f
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#scriptrunner-enhanced-search-jql-queries--en

## Run a search

You can perform searches based on applied filters to view JQL queries which can be run as one-off searches or [saved](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries#saved-filters--en) and shared. After [installation](../../get-started/installation.md) and [syncing](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization):

1.  Select Apps > ScriptRunner Enhanced Search from the _Jira_ menu bar located at the top of your page.
    
    Alternatively, you can select Enhanced Search from the left navigation when viewing a project.
    
    You will see the _ScriptRunner Enhanced Search_ screen appear:
    
2.  Enter your JQL query into the JQL Search bar and click the Search button.
    
    If you are unfamiliar with writing JQL queries, click the Insert Function button ' +' to open the _Insert Functions and Users_ screen, shown below. This enables you to choose from pre-generated ScriptRunner Enhanced Search JQL queries provided in the _Functions_ tab.
    
3.  Select the function from the Available Functions list within the Functions tab.
    
    Depending on the function chosen, you may be required to enter or select subquery details to generate valid JQL for that function. For example, a subquery `"project = EXAMPLE"` tells the `linkedIssuesOf` function that it should find issues linked to the results of that subquery.
    
4.  Click the Add to query button.
5.  Optional: You can also view the account IDs of users in your Jira instance within the _Insert Functions and Users_ screen. To do so, select the user from the Users tab, view their account ID and click the Add to query button.
    
6.  Click Search.
    
    You are returned to the JQL Search page, which displays a list of results for the function.
    
    Note: Search run-time
    
    Searches can run for up to two minutes, with a progress bar indicating the status. To reduce the run time, we recommend simplifying your query as much as possible and referring to [Build Efficient Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/build-efficient-queries).
    
7.  Check your query has returned the desired results before continuing and rerun if necessary.
    
    Tip: Space required after comma
    
    If you see an error message informing you that _"Function 'X' does not exist"_, check that you have entered a space after the comma in the query you are running.
    

## Customize search results

After running your enhanced JQL query, a table of results is displayed, showing customisable information about the issues returned. ScriptRunner Enhanced Search allows you to choose what information is displayed in the Results table, helping you to find what you need efficiently.

To customize the Results table view, click Choose Columns, and check the columns you wish to display.

The number of columns is not capped, but depending on your screen resolution, we recommend selecting no more than 10 columns.

## Save a search filter

As well as running one-off searches, you can save your ScriptRunner Enhanced Search JQL queries as _filters_. Saving your query searches as filters allows you to use [ScriptRunner Enhanced Search JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) in other JQL fields.

Follow the steps below to save your filter, and refer to [Saved Filters](https://docs.adaptavist.com/enhanced-search-for-jira-cloud/latest/saved-filters) to understand how these can be used.

1.  Run a search as outlined above and customize the results.
2.  Click the Save as filter button to save the filter and reuse it later.
    
    This opens the _Save Filter_ window.
    
3.  Name the filter and enable the Sync Filter toggle to ensure your filter stays in sync with Jira data changes and reflects updates across other areas.
    
    For example, you can use it in dashboards, Jira issue navigator, and [Jira software boards](https://confluence.atlassian.com/jirasoftwarecloud/what-is-a-board-764477964.html).
    
    Note: Once created, new filters are not synchronized by default. All new filters are synchronized after the default interval of 5 minutes when the Sync Filter option is selected in the _Filter Creation Screen_. If the Sync Filter option is disabled, the filter does not automatically sync and must be manually synced from the _Search_ screen using the Sync Filter button.
    
    Every 'X' minute, ScriptRunner Enhanced Search will check if the search results of the filter have changed or if someone has changed the add-on settings recently. If that check is positive, then filters are synced with the changes made to the issues in your Jira instance.
    
    Filters are always run with the same permissions set as the user who created the filter.
    
    Note: You must make sure that the [Add-On User](https://docs.adaptavist.com/enhanced-search-for-jira-cloud/latest/get-started/synchronising-keywords) has the Global Permission to Browse Users for this feature to work.
    
    If you want to update or delete these Enhanced Search filters, use the Enhanced Search page instead of the Jira filters user interface.
    
4.  Choose who to share the filter with.
    
    There are three options: share with all, share with a select user group, or share with a project.
    
    -   Checking Share With All shares the filter with all users logged into the Jira Cloud instance.
    -   Entering one or more groups under Choose Groups, shares the filter with all members of the selected group(s).
    -   Selecting one or more projects under Choose Projects, makes the saved filter available within the selected project(s).
    
5.  Click Save.

To see all [saved filters](https://docs.adaptavist.com/enhanced-search-for-jira-cloud/latest/saved-filters), click Jira Software and navigate to Issues and Filters > View All Filters.

### Export a saved filter to a CSV file

Once you have performed a search and saved that search as a filter, you can export that saved filter as a .csv file. To do so, follow these steps:

1.  Navigate to Filters > View all filters.
2.  Choose the filter you want to export and select Export.
3.  Select the export type.

## Use search results in a Jira filter

If you need to use the results of your Enhanced Search filter inside a standard Jira filter, such as a dashboard, Scrum, or Kanban board, then you can do this as follows:

1.  Create the filter on the Enhanced Search page.
2.  [Save](https://docs.adaptavist.com/enhanced-search-for-jira-cloud/latest/save-a-search) the filter and share it (This creates a copy of the filter as a standard Jira filter, where we synchronise the list of issue keys returned by the enhanced search filter.)
3.  Use the JQL below to access the results of this filter in the feature where you need to reference it.
    
    ```
    filter='NameOfHisSharedESFilter'
    ```
    

## Saved Filters

You can access your ScriptRunner Enhanced Search JQL queries that have been saved as filters from the top left tab section of the Enhanced Search page, namely Created By You and Shared With You. Any of your saved filters can be shared with other users. However, only the owner of a filter can make edits to it.

Recently, we've made some performance and reliability improvements, which means we do not update the search results for Enhanced Search saved filters that have not been used in Jira for 2 months or more. Specifically, the term ' _using_' the saved filter refers to viewing it in a Jira search, a dashboard or an agile board powered by the filter, or other such instances, such as being part of a Confluence macro that uses the filter. Note that viewing the search results for those saved filters within the Enhanced Search app does not count as actually using them.

Note: Modify or transfer filters

Modify shared filters

If you share a filter with another user, they can only view the JQL. In order to modify the filter, they will need to contact the owner of that filter or create a new filter using the JQL.

Transfer ownership of a filter

When transferring ownership of an Enhanced Search filter, ensure the original owner continues to have view permission for the filter before completing the transfer. If the original owner loses access after ownership is changed, the filter may be deleted. This is because the system cannot verify the new owner's Atlassian account ID during the transfer unless the previous owner still has permission to view the filter.

From here, you can understand and work with saved filters in several ways:

|  | Function | Description |
| --- | --- | --- |
| 1 | Created By You/Shared With You | Indicates filters that are private or shared with you. Any of your saved filters can be shared with other users, however, only the owner of a filter can make edits to it. |
| 2 | Sort By | Use the drop down list to sort filters alphabetically, by filters that are not synced automatically, or by the most recently created filters. |
| 3 | Show details/Hide details | View or hide the owner of a shared filter and other basic information. |
| 4 | Refresh Filter | Note: Sync interval refresh Click the refresh button to manually update a filter that you own. Your search results update automatically. However, if a filter search exceeds the sync interval period of five minutes, then a manual refresh will provide the most up-to-date results. You can easily find filters that are not automatically update by selecting Not automatically synced from the _Sort by_ drop down list. |
| 5 | Shared/Private | Indicates that this is, or is not, a shared filter. You can edit either of these types of filter. |
| 6 | Delete Filter | Click Show details to delete a saved filter. You can only delete a filter that you own. |
| 7 | New Filter | Create a new filter [search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries#run-a-search--en). |
| 8 | [Edit Filter](https://docs.adaptavist.com/enhanced-search-for-jira-cloud/latest/save-a-search) | Modify an existing saved filter's details, including how it is shared. |

## Edit a Search

You can edit any previously saved searches as follows:

1.  Locate the tab section of your page that highlights Created By You and Shared With You.
2.  Scroll to find saved filters, or use the Sort by dropdown box to refine your search.
3.  Select your preferred search from the saved filters and click the Edit Filter button.
    
    Note: Edit Permissions
    
    The option to edit a filter is only available if you own the filter or have permission to edit a shared filter.
    
    You can open any of the links within the _Results_ columns to see more details related to issues, assignees, reporters, and so on.
    
4.  Modify the details of the saved filter.
    
5.  Click Save to confirm the changes or Cancel.

Note: Modify or transfer filters

Modify shared filters If you share a filter with another user, they can only view the JQL. In order to modify the filter, they will need to contact the owner of that filter or create a new filter using the JQL.

Transfer ownership of a filter When transferring ownership of an Enhanced Search filter, ensure the original owner continues to have view permission for the filter before completing the transfer. If the original owner loses access after ownership is changed, the filter may be deleted. This is because the system cannot verify the new owner's Atlassian account ID during the transfer unless the previous owner still has permission to view the filter.

## Related Content

-   [Atlassian REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#version)
-   [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions)
-   [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords)
