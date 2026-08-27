# Atlassian's Transition to Forge Events and Missing Event Properties

- Platform: cloud
- Space: SR4JC
- Hierarchy: release-notes > breaking-changes
- Doc ID: doc-sr4jc-448135193
- Source: https://docs.adaptavist.com/sr4jc/latest/release-notes/breaking-changes/atlassian-s-transition-to-forge-events-and-missing-event-properties

The transition to native Forge events is required due to [Atlassian’s platform changes](https://www.atlassian.com/blog/developer/announcing-connect-end-of-support-timeline-and-next-steps) and the deprecation of the old event model. These new Forge events have a different structure and do not include all properties previously available. Some event properties that were available in the old model are now missing and cannot be retrieved from the Atlassian API, as outlined in the table below:

Action Required!

It's important that you review and update any [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) that depend on the now-missing properties. There is _no workaround_ for retrieving these properties via the Atlassian REST API. Therefore, to ensure your scripts do not break after the transition, they need to be removed from any scripts that use them. Refer to our [Deprecation Notices Overview](https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview) for details on deadlines.

Event type

Missing properties

Issuelink Created  
Issuelink Deleted

`issueLink.issueLinkType.isSubTaskLinkType`  
`issueLink.issueLinkType.isSystemLinkType`  
`issueLink.systemLink`

Worklog Updated

`worklog.comment`

Worklog Created  
Worklog Deleted

`worklog.comment`  
`isFromIssueLimitTransformation`

Version Deleted

`version.userReleaseDate   ``version.userStartDate`

Project Deleted  
Project Soft Deleted

`project.name`  
`project.avatarUrls`  
`project.projectLead`  
`project.assigneeType`

Issuetype Deleted

`issuetype.iconUrl`  
`issuetype.subtask`  
`issuetype.avatarId`

Issue Deleted

`issue.fields.description`  
`issue.fields.priority`  
`issue.fields.labels`  
`issue.fields.timetracking`  
`issue.fields.watches`  
`issue.fields.worklog`  
`issue.fields.components`  
`issue.fields.subtasks`  
`issue.fields.comment`  
`issue.fields.customfield_*`  
`issue.fields.statuscategorychangedate`  
`issue.fields.lastViewed`  
`issue.fields.resolutiondate`  
`issue.fields.duedate`  
`issue.fields.issuelinks`  
`issue.fields.aggregateprogress`  
`issue.fields.progress`  
`issue.fields.aggregatetimeoriginalestimate`  
`issue.fields.timeestimate`  
`issue.fields.aggregatetimeestimate`  
`issue.fields.aggregatetimespent`  
`issue.fields.timespent`  
`issue.fields.timeoriginalestimate`  
`issue.fields.workratio`  
`issue.fields.security`  
`issue.fields.environment   issue.fields.resolution`  
`issue.fields.versions   issue.fields.attachment`

  

  

Deprecation reports

You can use ScriptRunner for Jira Cloud's [deprecation reports](https://docs.adaptavist.com/sr4jc/latest/release-notes/deprecation-notices-overview/deprecation-reports) to identify Atlassian's deprecated endpoints, fields, and event types in your instance.

## Examples

### Issue Deleted

If you have [Script Listeners](https://docs.adaptavist.com/sr4jc/latest/features/script-listeners) set up for the _Issue Deleted_ event, and your code relies on the i`ssue.fields.duedate` property, it will not work once we transition to the Forge Product Events. You will need to modify your script to avoid using this property. Unfortunately, there is no way to retrieve missing properties from the Atlassian REST API.

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
