# ScriptRunner Enhanced Search

- Platform: cloud
- Space: SR4JC
- Hierarchy: Features
- Doc ID: doc-sr4jc-4ede025c-91e4-4ed5-bc8f-10592f052401-baa209156c99f1e4
- Source: https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search

|  |  |
| --- | --- |
|  | Migrating from ScriptRunner for Jira Server/DC to Cloud? Check out our [ScriptRunner Migration to Cloud](../uncategorized/s/script-runner-migration-to-cloud.md) section. |

## Before you start

|  |  |
| --- | --- |
|  | Learn about JQL functions and keywords.<br>[Training videos](../training/course-script-runner-for-jira-cloud-for-beginners/1-4-module-enhanced-search.md) |

Note: When ScriptRunner for Jira Cloud is [installed](../get-started/installation.md), an initial [synchronization](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) must be performed by an administrator. Synchronization is also required after [migrating](../script-runner-migration-to-cloud/migration-checklist.md) from ScriptRunner for Jira Server to Cloud.

Note: Initial Synchronisation

You must carry out an initial [JQL Keyword sync](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization) once only after [installing](../get-started/installation.md) Enhanced Search. The length of time that this sync will take is based on the following calculation:

```
(<number of issues in instance> * 0.00029) / 50
```

Based on this calculation, we can estimate a timeline for your initial sync. For example, if your instance has:

-   1,000,000 issues we estimate it will take 5.8 days to complete the initial sync.
-   2,000,000 issues we estimate it will take 11.6 days to complete the initial sync.

## What is the ScriptRunner Enhanced Search feature?

Note: Enhanced Search and ScriptRunner Enhanced Search

If you purchase ScriptRunner for Jira Cloud, you will automatically receive ScriptRunner Enhanced Search for free - this is included as part of your license. However, if you find that you're not using any of the other features offered by ScriptRunner for Jira Cloud, and you're only using Enhanced Search functionality, you can purchase Enhanced Search as a standalone product instead.

Please not that both apps are not designed to be used simultaneously as the data is stored separately. Although both products work independently, you will only see filters in the app it was created from and could duplicate work. If you currently have both products installed, or if you would like to switch from one to the other please contact our [Support](https://the-adaptavist-group-support.atlassian.net/servicedesk/customer/portal/27/user/login?destination=portal%2F27) team who can manually transfer your data on your behalf.

The ScriptRunner Enhanced Search feature provides advanced [JQL function](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) search capabilities, or _queries_, in Jira Cloud which you can modify or extend. Also available for use _within_ those JQL queries are Enhanced Search [JQL keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords).

In essence, the terms ScriptRunner Enhanced Search and JQL queries (which are advanced searches that are made up of Enhanced Search JQL functions and keywords) mean the same thing.

## What are ScriptRunner JQL functions?

The ScriptRunner Enhanced Search feature provides advanced [JQL function](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) search capabilities, or queries, in Jira Cloud. These extend Jira's built-in capabilities and enable you to conduct searches with greater granularity, including much more detailed information about what is happening in your instance and projects. For example, the [linkedIssuesOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesof--en) function will return issues of a certain type based on a subquery you give it.

ScriptRunner for Jira Cloud's out-of-the-box [JQL functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions) are available to all users but can only be used on the Enhanced Search screen under Apps > ScriptRunner Enhanced Search.

Below are just some examples of how you can use ScriptRunner JQL functions:

-   Use [epicsOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#epicsof--en) to query on epic links, such as finding all epics that have unresolved stories.
-   Use [issuesInEpics](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#issuesinepics--en) to find all stories for open epics in a project, and then look specifically at the status of issues, such as 'in progress.'
-   Use [linkedIssuesOf](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions/links-and-relationships#linkedissuesof--en) to return linked issues, such as all unresolved issues that are blocked by open issues.

## What are ScriptRunner JQL keywords?

Alongside JQL Functions are the [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords) that can be used _within_ those advanced JQL searches. ScriptRunner Enhanced Search looks at each issue in your Jira instance and adds metadata to them for easier and faster searching. We call this metadata [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords). These keywords can be used _within_ JQL queries to access this metadata and allow users to search for previously unavailable variables, such as the number of sub-tasks ( [`numberOfSubtasks`](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/numberofsubtasks.dita)).

JQL Keywords can be used in both the Enhanced Search screen under Apps > ScriptRunner Enhanced Search or within Jira's issue navigator.

Below are just some examples of how you can use ScriptRunner JQL Keywords:

-   Use [numberOfAttachments](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/numberofattachments.dita) to find issues that have a specified number of file attachments.
-   Use [numberOfSubtasks](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/numberofsubtasks.dita) to search for issues that have a specified number of subtasks.
-   Use [commentedOn](https://docs.adaptavist.com/db/organizations/adaptavist/repositories/master/content/documents/Adaptavist_Content/ScriptRunner/ScriptRunner_for_Jira_Cloud_SR4JC/topics/commentedon.dita) to find issues that have had a comment made on them on a specified date.

## Related content

-   [ScriptRunner Enhanced Search JQL Keywords Synchronization](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords-synchronization)
-   [Migration Checklist](../script-runner-migration-to-cloud/migration-checklist.md)
-   [ScriptRunner Enhanced Search JQL Functions](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-functions)
-   [ScriptRunner Enhanced Search JQL Keywords](https://docs.adaptavist.com/sr4jc/latest/features/scriptrunner-enhanced-search/scriptrunner-enhanced-search-jql-keywords)
