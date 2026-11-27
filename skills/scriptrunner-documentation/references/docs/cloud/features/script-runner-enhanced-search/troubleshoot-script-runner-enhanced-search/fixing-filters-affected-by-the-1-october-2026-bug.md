# Fixing Filters Affected by the 1 October 2026 Bug

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features > ScriptRunner Enhanced Search > Troubleshoot ScriptRunner Enhanced Search
- Doc ID: doc-sr4jc-0d8bdbea-d135-4948-b3a0-0526159bc439-1aa33e0706fe6108
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search#troubleshoot-scriptrunner-enhanced-search--en#fixing-filters-affected-by-the-1-october-2026-bug--en

Learn how to identify and correct Jira Enhanced Search filters affected by the 1 October 2026 bug, or remove filters that are no longer needed.

If you have been affected by this bug, you will receive an email and in-app messaging later this month with specific filter IDs that were affected. This bug affected very few (less than 0.5%) customers.

On 1 October 2026, we identified a bug that had inadvertently been introduced into Enhanced Search for Jira and ScriptRunner for Jira Cloud. This bug caused a small set of Enhanced Search filters to stop working as intended.

Most of the affected filters have now been fixed; however, there are some filters that require a manual update. These filters may be showing outdated information as they are not syncing automatically.

Please either remove the filter if it is no longer needed, or manually correct the query using this guide for instructions.

1.  Locate each Jira filter using the filter ID/Atlassian account ID we have sent you. You can do this by searching for the filter https://<insert\_instance\_name>.[atlassian.net/issues/?filter=](http://atlassian.net/issues/?filter=)<insert\_filter\_id>
    
2.  Check the Jira filter description.
    
3.  Confirm if the Jira filter description contains the correct Enhanced Search filter query, and [respond back to us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portals) with this query and the associated Jira filter ID, so we can manually fix the filter.
    
4.  If it is not the correct filter query, [respond back to us](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/user/login?destination=portals) with the desired filter query and the associated Jira filter ID, so we can manually fix the filter in our database.
    
5.  If the filter is an Enhanced Search filter but is no longer required, please navigate to the Enhanced Search page, and delete the Enhanced Search filter.
    
    If the filter was never an Enhanced Search filter, then you can ignore and skip it.
    

If you are affected and have more questions or need help, please [contact support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portals).
