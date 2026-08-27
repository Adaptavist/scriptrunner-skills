# ScriptRunner Enhanced Search JQL Keywords Synchronization

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > scriptrunner-enhanced-search
- Doc ID: doc-sr4jc-103678131
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization

When ScriptRunner for Jira Cloud is [installed](https://docs.adaptavist.com/sr4jc/latest/get-started/installation), an administrator must perform an initial synchronisation. Although the administrator initiates the synchronisation process, the issues are accessed as the ScriptRunner user. Synchronisation is also required after [migrating](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud) from ScriptRunner for Jira Server to Cloud.

Lengthy Sync Alert

Currently, instances that contain more than 500,000 issues may take a _significant_ amount of time to sync. **In some cases, this can take several weeks.** If your instance falls into this category, we strongly advise you to create a [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27) ticket so we can keep track of the initial sync with you. 

ScriptRunner Enhanced Search augments each issue in your Jira instance with some additional metadata and provides a number of [ScriptRunner Enhanced Search JQL keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) that you can use within your JQL queries to access this metadata. These keywords allow users to search for previously unavailable variables, such as the number of sub-tasks (`[numberOfSubtasks](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords#id-.JQLKeywordsvCurrent-Subtasks)`). The metadata is stored within your Jira instance. The _Issue Updated_ field on your issues is NOT affected by the metadata we store against each issue.

The metadata we store against each issue is automatically updated asynchronously whenever an issue is updated. This means that your search results **may be out of date** for a short while after you edit an issue.

  

Initial Synchronisation

After [installing](https://docs.adaptavist.com/sr4jc/latest/get-started/installation) Enhanced Search you must perform an initial JQL Keyword sync **once only**. The length of time this sync takes is based on the following calculation:

```
(<number of issues in instance> * 0.00029) / 50
```

Based on this calculation, we can **estimate** a timeline for your initial sync. For example, if your instance has:

-   1,000,000 issues. We estimate it will take 5.8 days to complete the initial sync.
-   2,000,000 issues. We estimate it will take 11.6 days to complete the initial sync.

The sync should only be started after reindexing is complete, which usually takes **one day** after a migration is completed. If you have any questions about if a re-indexing is complete, raise a [support ticket](https://support.atlassian.com/contact#/) with Atlassian.

## Perform an initial synchronisation

1.  Navigate to the _JQL Keywords Sync_ page from the Jira _Administration_ menu by selecting **Apps > ScriptRunner > JQL Keywords Sync.**
2.  Click **Sync All Issues**, as shown below:

![](/sr4jc/files/latest/103678131/166538355/1/1680518440000/JQL+keyword+sync.jpg)

Once the sync is in progress, you can safely close the page or shut down your computer.

A list containing metadata that is stored for each issue is displayed, including:

-   a list of the link types (e.g. Blocks) for linked issues
    
-   the number of issue links
    
-   a list of link names (e.g. "is cloned by") for linked issues
    
-   number of attachments on the issue
    
-   a list of file extensions from attachments
    
-   the date on which the first attachment was added to the issue
    
-   date on which the last (most recent) attachment was added to the issue
    
-   a list of usernames that added attachments to the issue
    
-   number of subtasks of the issue
    
-   a list of project roles that worklogs were restricted to
    
-   a list of user groups that worklogs were restricted to
    
-   number of comments on the issue
    
-   date of the first comment on the issue
    
-   date of the last (most recent) comment on the issue
    
-   a list of all dates on which comments were added to the issue
    
-   a list of usernames that have added comments to the issue
    
-   list of project roles that comments have been restricted to
    
-   a list of user groups that comments have been restricted to
    
-   the username of the person who last (most recent) made a comment on the issue
    
-   the project role that the last (most recent) comment was restricted to
    
-   the user group that the last (most recent) comment was restricted to
    

You may encounter issues that do not sync on instances with a workflow property setup that does not allow an add-on user to edit an issue if it was in the **Resolved** status.

It is good practice to check that you do not have any workflow properties setup to adjust permissions on an issue (jira.permission property). You can refer to [Use workflow properties](https://support.atlassian.com/jira-cloud-administration/docs/use-workflow-properties/) for more details.

## Enhanced search syncing

### JQL keyword synchronisation

As outlined in the introduction above, a JQL keyword sync is required **only once after installing or migrating to** ScriptRunner for Jira Cloud. As this sync needs to update every issue in your instance, it can take a significant amount of time if your instance contains a large number of issues.

The metadata saved to your issues allows for faster recall when searching because many searches will find the metadata instead of calculating it on the fly each time you search. You may search directly for these keywords, or you may search using [ScriptRunner Enhanced Search JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) that use this metadata. Many Enhanced Search functions will use the metadata saved to your issues to run searches.

#### JQL functions not dependent on keyword synchronisation

There are some JQL functions that will return accurate results even when the keyword sync is still in progress or has yet to be completed. Listed below are the JQL functions that are not dependent on the JQL keyword sync:

-   linkedIssuesOf
    
-   linkedIssuesOfRecursive
    
-   linkedIssuesOfRecursiveLimited
    
-   subTasksOf
    
-   childrenOf
    
-   parentsOf
    
-   epicsOf
    
-   issuesInEpics
    
-   versionMatch
    
-   projectMatch
    
-   componentMatch
    
-   issueFieldMatch
    
-   issueFieldExactMatch
    
-   dateCompare
    
-   inSprint
    
-   nextSprint
    
-   previousSprint
    

JQL Keyword Sync for Enhanced Search Functions

Although not all Enhanced Search functions require a JQL keyword sync, `addedAfterSprintStart` is an exception. You should also be aware that all JQL aliases also require a JQL keyword sync.

### Issue synchronisation

When issues are updated (added or edited in some way) in Jira, the data stored in Enhanced Search needs to be updated so that your searches use the most updated information on your issues. The issue sync includes updating metadata and occurs when we receive an event notification that something has changed on your instance. 

### Filter synchronisation

The results of a filter need to be accurate, so ensuring that the Jira filter (results of ES search) has the latest information from the original Enhanced Search filter is necessary. The filter sync occurs at the interval you’ve set (1 to 60 minutes) and fetches all users who own ES filters, sending a message to our filter sync system to automatically synchronise their filters.

## Permissions

The ScriptRunner user can only see comments and worklogs from the following groups:

-   jira-core-users
    
-   jira-servicedesk-users
    
-   jira-software-users
    
-   jira-servicemanagement-users-<sitename>
    
-   jira-workmgmt-users-<sitename>
    
-   jira-software-users-<sitename>
    

Search results will be incorrect if the ScriptRunner user does not have permission to view:

-   Edit all issues (edit permission is required to store the additional metadata).
    
-   All comments, including those restricted to a particular group/role.
    
-   All worklogs, including those restricted to a particular group/role.
    

If worklogs and comments are restricted to a role, ensure the role is assigned to the group the ScriptRunner user belongs to under _Project Settings_.

* * *

## Related Content

-   [JQL Sync Status and Add-on User Permissions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/jql-sync-status-and-add-on-user-permissions)
-   [Use workflow properties](https://support.atlassian.com/jira-cloud-administration/docs/use-workflow-properties/?_ga=2.264543047.95936120.1725871880-750409009.1722420616)
-   [Migration Checklist](https://docs.adaptavist.com/sr4jc/latest/scriptrunner-migration-to-cloud/migration-checklist)
