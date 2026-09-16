# Bulk Fix Resolutions

- Platform: data-center
- Space: SR4JS
- Hierarchy: Features > Built-in scripts
- Doc ID: doc-sr4js-84f5572f-96f1-48d3-9280-683916da3ed7-ef866ebccf958dd4
- Source: https://docs.adaptavist.com/sr4js/latest/features#built-in-scripts--en#bulk-fix-resolutions--en

Use the _Bulk Fix Resolution_ built-in script to change the Resolution field on multiple issues that match a [saved filter](https://confluence.atlassian.com/jirasoftwareserver/saving-your-search-as-a-filter-939938748.html).

Problems with imports, workflow modifications and Jira migrations can all cause incorrect Resolution values for multiple issues. _Bulk Fix Resolution_ allows you to modify the Resolution value for all issues returned by a JQL query (filter) without entering the database or re-indexing.

## Using this built-in script

1.  From ScriptRunner, navigate to Built-in Scripts > Bulk Fix Resolutions.
2.  Under Filter ID select a filter.
    
    Issues returned by this filter are modified.
    
    Note: Only saved JQL filters show up in Filter ID. For more information on how to create and save custom filters see [Saving Your Search as a Filter](https://confluence.atlassian.com/jiracoreserver/saving-your-search-as-a-filter-939937724.html).
    
3.  In New Resolution, select the correct resolution value.
    
    Tip: For _Unresolved_ issues select None
    
4.  Check/uncheck the Send mail checkbox.
5.  Select Preview to see an overview of the changes before running the script.
6.  Select Run.
    
    All issues matching the Filter ID are changed to the specified new resolution.
    

Note: The issue resolution date is only updated on issues with no previous date set. If the Resolution Date field has a value, it is not overwritten. For issues with no resolution date, the resolution date is set to the date the script is run.

A database change history record is created, which will show the administrator running this built-in script as the user resolving the issue. If Service Desk SLAs have timers based on when the _resolution_ is set, these will be triggered.

## Information on incorrect resolution values

We recommend that incorrect resolution values are deleted after completing a bulk fix resolution. To do this, proceed as follows:

1.  Navigate to Issues > Issue Attributes > Resolutions from the Jira _Administration_ console.
2.  Select Delete next to the incorrect resolution value.
