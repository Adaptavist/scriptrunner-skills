# Atlassian's Transition to Forge Events and Missing Event Properties

- Platform: cloud
- Space: SR4JC
- Hierarchy: Release Notes > Breaking Changes
- Doc ID: doc-sr4jc-2c461630-9ac4-4363-8637-e638643286c9-1daee999f53f6da5
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes#atlassians-transition-to-forge-events-and-missing-event-properties--en

The transition to native Forge events is required due to [Atlassian's platform changes](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps) and the deprecation of the old event model. These new Forge events have a different structure and do not include all properties previously available. Some event properties that were available in the old model are now missing and cannot be retrieved from the Atlassian API, as outlined in the table below:

Warning:

Action Required!

It's important that you review and update any [Script Listeners](../../features/script-listeners.md) that depend on the now-missing properties. There is _no workaround_ for retrieving these properties via the Atlassian REST API. Therefore, to ensure your scripts do not break after the transition, they need to be removed from any scripts that use them. Refer to our [Deprecation Notices Overview](../deprecation-notices-overview.md) for details on deadlines.

|  |  |
| --- | --- |
| Event type | Missing properties |
| Issuelink Created Issuelink Deleted | `issueLink.issueLinkType.isSubTaskLinkType`<br>`issueLink.issueLinkType.isSystemLinkType`<br>`issueLink.systemLink` |
| Worklog Updated | `worklog.comment` |
| Worklog Created Worklog Deleted | `worklog.comment`<br>`isFromIssueLimitTransformation` |
| Version Deleted | `version.userReleaseDate`<br>`version.userStartDate` |
| Project Deleted Project Soft Deleted | `project.name`<br>`project.avatarUrls`<br>`project.projectLead`<br>`project.assigneeType` |
| Issuetype Deleted | `issuetype.iconUrl`<br>`issuetype.subtask`<br>`issuetype.avatarId` |
| Issue Deleted | `issue.fields.description`<br>`issue.fields.priority`<br>`issue.fields.labels`<br>`issue.fields.timetracking`<br>`issue.fields.watches`<br>`issue.fields.worklog`<br>`issue.fields.components`<br>`issue.fields.subtasks`<br>`issue.fields.comment`<br>`issue.fields.customfield_*`<br>`issue.fields.statuscategorychangedate`<br>`issue.fields.lastViewed`<br>`issue.fields.resolutiondate`<br>`issue.fields.duedate`<br>`issue.fields.issuelinks`<br>`issue.fields.aggregateprogress`<br>`issue.fields.progress`<br>`issue.fields.aggregatetimeoriginalestimate`<br>`issue.fields.timeestimate`<br>`issue.fields.aggregatetimeestimate`<br>`issue.fields.aggregatetimespent`<br>`issue.fields.timespent`<br>`issue.fields.timeoriginalestimate`<br>`issue.fields.workratio`<br>`issue.fields.security`<br>`issue.fields.environmentissue.fields.resolution`<br>`issue.fields.versionsissue.fields.attachment` |

Note: You can use ScriptRunner for Jira Cloud's [deprecation reports](../deprecation-notices-overview/deprecation-reports.md) to identify Atlassian's deprecated endpoints, fields, and event types in your instance.

## Examples

### Issue Deleted

If you have [Script Listeners](../../features/script-listeners.md) set up for the _Issue Deleted_ event, and your code relies on the i`ssue.fields.duedate` property, it will not work once we transition to the Forge Product Events. You will need to modify your script to avoid using this property. Unfortunately, there is no way to retrieve missing properties from the Atlassian REST API.

```
def totalBalanceFiled = issue.fields.customfield_1712301 // custom fields are not provided in payload
```

For deleted events, the missing properties cannot be retrieved because the entity no longer exists. For event types other than deleted, such as created, updated, moved, and so on, Atlassian has not provided the details in the API.

### Issuetype Deleted

```
if (issuetype.subtask) { // if deleted issue type is a subtask, skip the execution
    return
}
```

When the issue type is deleted, we can no longer check if it was a subtask so you need to delete that code.

### Project Deleted

```
def projectKey = project.name // it doesn't exist
```

### Version Deleted

```
def releaseDate = version.userReleaseDate // it doesn't exist
def startDate = version.userStartDate // it doesn't exist
```
