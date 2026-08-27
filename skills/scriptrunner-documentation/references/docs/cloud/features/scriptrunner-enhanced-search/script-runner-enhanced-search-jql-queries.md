# ScriptRunner Enhanced Search JQL Queries

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-101629501
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries

## Run a search

You can perform searches based on applied filters to view JQL queries which can be run as one-off searches or [saved](#id-.ScriptRunnerEnhancedSearchJQLQueriesvCurrent-SavedFilters) and shared. After [installation](https://docs.adaptavist.com/sr4jc/latest/get-started/installation) and [syncing](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization):

1.  Select **Apps > ScriptRunner Enhanced Search** from the Jira menu bar located at the top of your page.  
    ![](/sr4jc/files/latest/101629501/166538352/1/1680254052000/SR+ES.jpg)Alternatively, you can select **Enhanced Search** from the left navigation when viewing a project.  
    You will see the ScriptRunner Enhanced Search screen appear:  
    ![](/sr4jc/files/latest/101629501/313196590/1/1733931805000/SR+ES+landing.png)  
    
2.  Enter your JQL query into the **JQL Search** bar and click the **Search** button.![](/sr4jc/files/latest/101629501/313196589/1/1733932086000/ES+JQL+search.png)  
    If you are unfamiliar with writing JQL queries, click the Insert Function button '**+**' to open the _Insert Functions and Users_ screen, shown below. This enables you to choose from pre-generated ScriptRunner Enhanced Search JQL queries provided in the **Functions** tab.  
    ![](/sr4jc/files/latest/101629501/151626408/1/1668178360000/Screenshot+2022-11-11+at+14.46.44.png)  
    
3.  Select the function from the **Available Functions** list within the **Functions** tab. Depending on the function chosen, you may be required to enter or select subquery details to generate valid JQL for that function. For example, a subquery `"project = EXAMPLE"` tells the `linkedIssuesOf` function that it should find issues linked to the results of that subquery.
4.  Click the **Add to query** button.  
    
5.  **(Optional)** You can also view the account IDs of users in your Jira instance within the _Insert Functions and Users_ screen. To do so, select the user from the **Users** tab, view their account ID and click the **Add to query** button.  
    ![](/sr4jc/files/latest/101629501/149693192/1/1664983352000/insert+user.jpg)
6.  Click **Search**. You are returned to the JQL Search page, which displays a list of results for the function.  
    
    Search run-time
    
    Searches can run for up to two minutes, with a progress bar indicating the status. To reduce the run time, we recommend simplifying your query as much as possible and referring to [Build Efficient Queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/build-efficient-queries).
    
7.  Check your query has returned the desired results before continuing and rerun if necessary.  
    
    Space required after comma
    
    If you see an error message informing you that **_"Function 'X' does not exist"_**, check that you have entered a space after the comma in the query you are running.
    

## Customize search results

After running your enhanced JQL query, a table of results is displayed, showing customisable information about the issues returned. ScriptRunner Enhanced Search allows you to choose what information is displayed in the **Results** table, helping you to find what you need efficiently.

To customize the **Results** table view, click **Choose Columns**, and check the columns you wish to display.

The number of columns is not capped, but depending on your screen resolution, we recommend selecting no more than 10 columns.

  
![](/sr4jc/files/latest/101629501/110335424/1/1619016804000/ES+search+results+with+column.png)

## Save a search filter

As well as running one-off searches, you can save your ScriptRunner Enhanced Search JQL queries as _filters_. Saving your query searches as filters allows you to use [ScriptRunner Enhanced Search JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) in other JQL fields.

Follow the steps below to save your filter, and refer to [Saved Filters](https://docs.adaptavist.com/es/latest/saved-filters) to understand how these can be used.

1.  Run a search as outlined above and customize the results.
2.  Click the **Save as filter** button to save the filter and reuse it later. This opens the _Save Filter_ window.  
    ![](/sr4jc/files/latest/101629501/110335423/1/1619017007000/ES+save+filter.png)
3.  Name the filter and enable the **Sync Filter** toggle to ensure your filter stays in sync with Jira data changes and reflects updates across other areas. For example, you can use it in dashboards, Jira issue navigator, and [Jira software boards](https://confluence.atlassian.com/jirasoftwarecloud/what-is-a-board-764477964.html).  
    
    Once created, new filters are not synchronized by default. All new filters are synchronized after the default interval of 5 minutes when the **Sync Filter** option is selected in the _Filter Creation Screen_. If the **Sync Filter** option is disabled, the filter does not automatically sync and must be manually synced from the _Search_ screen using the **Sync Filter** button.
    
    ![](/sr4jc/files/latest/101629501/110337052/1/1619445497000/filter+sync.png)
    
    Every 'X' minute, ScriptRunner Enhanced Search will check if the search results of the filter have changed or if someone has changed the add-on settings recently. If that check is positive, then filters are synced with the changes made to the issues in your Jira instance.
    
    Filters are always run with the same permissions set as the user who created the filter.
    
    You must make sure that the [Add-On User](https://docs.adaptavist.com/es/latest/get-started/synchronising-keywords#SynchronisingKeywords-SyncStatusandAddonUser) has the Global Permission to Browse Users for this feature to work.
    
    If you want to update or delete these Enhanced Search filters, use the Enhanced Search page instead of the Jira filters user interface.
    
4.  Choose who to share the filter with. There are three options: share with all, share with a select user group, or share with a project.
    
    -   Checking **Share With All** shares the filter with all users logged into the Jira Cloud instance.
        
    -   Entering one or more groups under **Choose Groups**, shares the filter with all members of the selected group(s).
        
    -   Selecting one or more projects under **Choose Projects**, makes the saved filter available within the selected project(s).
        
5.  Click **Save**.
    
    To see all [saved filters](https://docs.adaptavist.com/es/latest/saved-filters), click **Jira Software** and navigate to **Issues and Filters→View All Filters**.
    

### Export a saved filter to a CSV file

Once you have performed a search and saved that search as a filter, you can export that saved filter as a .csv file. To do so:

1.  Navigate to **Filters→View all filters**.
2.  Choose the filter you want to export and select **Export**.
3.  Select the export type.

## Use search results in a Jira filter

If you need to use the results of your Enhanced Search filter inside a standard Jira filter, such as a dashboard, Scrum, or Kanban board, then you can do this as follows:

1.  Create the filter on the enhanced search page.
2.  [Save](https://docs.adaptavist.com/es/latest/save-a-search) the filter and share it (This creates a copy of the filter as a standard Jira filter, where we synchronise the list of issue keys returned by the enhanced search filter.)
3.  Use the JQL below to access the results of this filter in the feature where you need to reference it.
    
    `filter=‘NameOfHisSharedESFilter’`
    

  

* * *

## Related Content

-   [Atlassian REST API](https://developer.atlassian.com/cloud/jira/platform/rest/v3/intro/#version)
-   [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions)
-   [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords)
