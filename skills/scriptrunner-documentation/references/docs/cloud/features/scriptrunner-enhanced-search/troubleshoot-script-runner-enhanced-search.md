# Troubleshoot ScriptRunner Enhanced Search

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-313196639
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search

Enhanced Search and ScriptRunner Enhanced Search

If you purchase ScriptRunner for Jira Cloud, you will automatically receive [ScriptRunner Enhanced Search](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search) for free - this is included as part of your license. However, if you find that you're not using any of the other features offered by ScriptRunner for Jira Cloud, and you're only using Enhanced Search functionality, you can purchase [Enhanced Search](https://docs.adaptavist.com/es/latest) as a standalone product instead.

Please note that both apps are not designed to be used simultaneously, as the data is stored separately. Although both products work independently, you will only see filters in the app it was created from and could duplicate work. If you currently have both products installed, or if you would like to switch from one to the other, please contact our [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27/user/login?destination=portal%2F27) team, who can manually transfer your data on your behalf. 

## Troubleshooting overview

Symptom / Error

Likely Cause

Error Category

What to Check First

Recommended Fix

Search times out or never completes.

Query processes too many issues or is too complex.

[Timeouts and Performance](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/timeouts-and-performance)

Query size, negative operators.

Narrow scope, split queries, add date or project filters.

Search fails intermittently during heavy instance activity.

Too many searches in a short period.

[Rate Limits](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/rate-limits)

Frequency of searches, automation, or scripts.

Turn off automatic syncing for filters that don't need it, audit and delete old or unused filters.

Search returns no results, but no error.

Filters are too narrow or exclude valid issues.

[Empty or Missing Results](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/empty-or-missing-results)

AND/OR logic, empty fields, deprecated fields.

Broaden filters, include EMPTY checks, and validate fields. 

Check custom issue types as some functions work with these, and some don't. For example, `issuesInEpics`, `epicsOf`and `parentsOf` use the standard Atlassian issue types only. `parentsOf` with the _all_ parameter and `childrenOf`allow for custom issue types.

Query fails to run or save.

Invalid syntax or unsupported function.

[Errors](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/errors)

JQL syntax, function usage.

Fix syntax, use supported fields/functions.

Unable to save filter.

Filter name conflict or timeout during save.

[Errors](https://docs.adaptavist.com/es/latest/troubleshoot-enhanced-search-for-jira-cloud/errors)

Existing filter names, query complexity.

Rename filter, simplify query.

## Best practice tips

-   **Ensure JQL keywords are synced:** It can appear that JQL queries don't work when, in fact, they just haven't been [synced](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization).
-   **Use the insert function:** Build queries using the Insert Function '+' option where possible, as this helps ensure the correct syntax.
-   **Avoid timeout limits:** 
    
    Upcoming changes to timeout limits
    
    To improve security and usability, ScriptRunner Enhanced Search is moving to Atlassian's native Jira platform using Forge. With the use of Forge, that means there will be changes to timeout times. Right now, on Connect, there is a 2-minute timeout for searches when made from the UI. For filter syncing the timeout is 30 seconds for each filter. When we make the upcoming change to forge, it will be 25 seconds per precomputation. A precomputation is an individual use of an Enhanced Search function. In Forge, filters can contain multiple precomputations, and each one can run at the same time for up to 25 seconds.
    
    For **Connect** (current):
    
    As there are timeout limitations in the Cloud (2 minutes maximum), you should try to reduce the complexity of queries and make them as small as possible to avoid these. The two-minute timeout currently applies to searches made in the Enhanced Search app only, whereas any [saved filters](https://docs.adaptavist.com/es/latest/saved-filters) are subject to the 30-second search timeout limit when syncing.
    
    For **Forge** (upcoming): 
    
    As there are timeout limitations in the Cloud on the Forge platform (25-seconds per precomputation, multiple can be in a filter), you should try to reduce the complexity of queries and make them as small as possible to avoid these.
    
-   **Enable the filter sync:** Ensure filters are synced automatically when powering dashboards or Agile boards so that issues returned by a JQL query are up to date. You can toggle the filter sync filter by [editing](https://docs.adaptavist.com/es/latest/save-a-search#SaveaSearch-EditaSearch) a filter.
-   **Permissions:** Avoid tweaking permissions for the Add-On User, as this can cause many functions to not work as expected. This is particularly the case when restricting permissions.
-   **Use IDs in ES functions:** Use IDs rather than names in ES functions, where possible. For example, filter IDs, Atlassian user account IDs, board IDs, sprint IDs, and so on.

The image below summarises how you can [write efficient queries](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-queries/tips-for-writing-jql-queries) and how you can avoid writing inefficient ones:

![](/sr4jc/files/latest/313196639/513345619/1/1771579154000/tips+for+writing+queries.jpg)

## Enhanced Search Data Center to Cloud migration issues 

If you are encountering difficulties with your filters when migrating from ScriptRunner for Jira Data Center to Cloud, you can refer to our [Troubleshoot ScriptRunner Migration](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration) section for help and guidance. In particular, we have outlined some common [migration issues](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/troubleshoot-scriptrunner-migration#id-.TroubleshootScriptRunnerMigrationvCurrent-migrationissu).
