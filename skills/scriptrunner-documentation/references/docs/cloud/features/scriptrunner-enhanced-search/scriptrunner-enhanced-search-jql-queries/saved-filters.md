# Saved Filters

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > scriptrunner-enhanced-search-jql-queries
- Doc ID: doc-sr4jc-298091458
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries/saved-filters

You can access your ScriptRunner Enhanced Search JQL queries that have been saved as filters from the top left tab section of the Enhanced Search page, namely **Created By You** and **Shared With You**. Any of your saved filters can be shared with other users. However, only the owner of a filter can make edits to it.

Recently, we've made some performance and reliability improvements, which means we do not update the search results for Enhanced Search saved filters that have **not been used in Jira for 2 months or more**. Specifically, the term '_using'_ the saved filter refers to viewing it in a Jira search, a dashboard or an agile board powered by the filter, or other such instances, such as being part of a Confluence macro that uses the filter. Note that viewing the search results for those saved filters **within the Enhanced Search app** does not count as actually using them.

Modify or transfer filters

**Modify shared filters**  
If you share a filter with another user, they can only view the JQL. In order to modify the filter, they will need to contact the owner of that filter or create a new filter using the JQL.

**Transfer ownership of a filter**  
When transferring ownership of an Enhanced Search filter, ensure the original owner continues to have view permission for the filter before completing the transfer. If the original owner loses access after ownership is changed, the filter **may be deleted**. This is because the system cannot verify the new owner’s Atlassian account ID during the transfer unless the previous owner still has permission to view the filter.

![](/sr4jc/files/latest/298091458/298091462/2/1731327189000/new+saved+filter+for+in+app+help.png)

From here, you can understand and work with saved filters in several ways:

  

Function

Description

1

Created By You/Shared With You

Indicates filters that are private or shared with you. Any of your saved filters can be shared with other users, however, only the owner of a filter can make edits to it.

2

Sort By

Use the drop down list to sort filters alphabetically, by filters that are not synced automatically, or by the most recently created filters.

3

Show details/Hide details

View or hide the owner of a shared filter and other basic information.

4

Refresh Filter

Click the refresh button to manually update a filter that you own.  

Sync interval refresh

Your search results update automatically. However, if a filter search exceeds the sync interval period of five minutes, then a manual refresh will provide the most up-to-date results.  
You can easily find filters that are not automatically update by selecting **Not automatically synced** from the _Sort by_ drop down list.

5

Shared/Private

Indicates that this is, or is not, a shared filter. You can edit either of these types of filter.

6

Delete Filter

Click **Show details** to delete a saved filter. You can only delete a filter that you own.

7

New Filter

Create a new filter [search](https://docs.adaptavist.com/es/latest/run-a-search).

8

[Edit Filter](https://docs.adaptavist.com/es/latest/save-a-search#SaveaSearch-EditaSearch)

Modify an existing saved filter's details, including how it is shared.
