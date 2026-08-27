# Initial Synchronization Issues

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search > troubleshoot-scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-513345621
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/troubleshoot-scriptrunner-enhanced-search/initial-synchronization-issues

After [installing](https://docs.adaptavist.com/sr4jc/latest/get-started/installation) ScriptRunner Enhanced Search, you must perform an [initial JQL Keyword sync](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization#perform-an-initial-synchronisation) **only once**. The length of time this sync will take is based on the following calculation:

```
(<number of issues in instance> * 0.00029) / 50
```

Based on this calculation, we can _estimate_ a timeline for your initial sync. For example, if your instance has:

-   1,000,000 issues. We estimate it will take 5.8 days to complete the initial sync.
-   2,000,000 issues. We estimate it will take 11.6 days to complete the initial sync.

## Lengthy sync for large instances

-   Instances with **more than 500,000 issues** may experience significantly longer sync times.
-   In some cases, the sync can take **several weeks**.
-   If your instance exceeds 500,000 issues, we strongly recommend you create a [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/19) ticket so the team can monitor the initial sync with you.

## Features that require JQL keyword sync

Not all [ScriptRunner Enhanced Search functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) require a JQL keyword sync to produce accurate results.

The following do require sync:

-   `addedAfterSprintStart`
-   All JQL aliases

## Issues not syncing

Possible cause: Workflow properties preventing add-on user edits. For example, if a workflow property blocks editing when an issue is in **Resolved** status.

Recommended checks: 

-   Ensure there are no `jira.permission` workflow properties restricting issue permissions. You can refer [here](https://support.atlassian.com/jira-cloud-administration/docs/use-workflow-properties/) for more details.
-   Confirm the administrator user has permission to:
    -   View issues
    -   Edit issues
-   Note that many synchronization failures are caused by permissions issues.

## Sync status display delays

The **PARTIALLY SYNCED / FULLY SYNCED** status may not update immediately.

Cause: Project privilege data is cached.

Sync status cache duration: Up to 10 minutes.

For the most up-to-date sync status, navigate to the JQL Sync Keywords page on your instance.

For further details, you can refer to the [ScriptRunner Enhanced Search JQL Keywords Synchronization](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) section.
