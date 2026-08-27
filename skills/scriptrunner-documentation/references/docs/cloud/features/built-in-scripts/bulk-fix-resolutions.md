# Bulk Fix Resolutions

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > built-in-scripts
- Doc ID: doc-sr4jc-101628964
- Source: https://docs.adaptavist.com/sr4jc/latest/features/built-in-scripts/bulk-fix-resolutions

The _Resolution_ field within Jira informs you of the various workflow stages of a work item, for example, _Closed_ or _Resolved_. However, _Resolutions_ can often reflect an incorrect status after a workflow has been modified, or due to an import, and need to be updated.

ScriptRunner for Jira Cloud allows you to search for all work items with the same resolution status and modify or fix the resolution on all the work items returned in bulk by a query you specify so they match. It's worth noting that the search request result is limited to return a maximum of 100 work items. 

To use the Bulk Fix Resolution feature:

1.  Navigate to the _Bulk fix resolutions_ page from the Jira _Administration_ menu by selecting **Apps > ScriptRunner > Built-in Scripts**.
2.  Select a filter that relates to the work item you wish to fix in the _Filter_ drop-down list.
3.  Select the filter in the _New resolution_ field to reflect the change you want to make.
4.  Click the **Run** button, or click the **Choose another script** button to repeat the process and bulk fix more work items.

![](/sr4jc/files/latest/101628964/110333914/2/1774006013000/bulk+fix+resolutions.png)
