# Bindings and Parameters

- Platform: cloud
- Space: SR4JC
- Hierarchy: features > script-listeners
- Doc ID: doc-sr4jc-459571682
- Source: https://docs.adaptavist.com/sr4jc/latest/features/script-listeners/bindings-and-parameters

## Examples of additional bindings and parameters

The _Script Context_ is a set of parameters/code variables that are automatically available in your script to provide contextual data for the script listeners. You can view these by clicking the **Script context** button displayed above the code editor. The parameters and variables in the _Script Context_ are different for each Listener Event. 

Event

Binding/Context

Parameter Examples

Attachment Created

attachment

The attachment details as a Map. See [Get Attachment REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-attachment-id-get) for details.

`attachment.filename, attachment.author.displayName, attachment.content`

Attachment Deleted

Board Created

board

The board details as a Map. See [Get Board REST API reference](https://developer.atlassian.com/cloud/jira/software/rest/#agile/1.0/board-getConfiguration) for details.

`[board.id](http://board.id),   ``[board.name](http://board.name),   board.type`

Board Deleted

Board Updated

Board Configuration Changed

Comment Created

comment

The comment details as a Map. See [Get Comment REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-comment-id-get) for details.

issue

Limited issue details as a Map. It has id, self, key and fields(status, priority, assignee, project, issuetype, summary) properties.

`comment.body, comment.author.displayName,   issue.key`

Comment Updated

Comment Deleted

Issue Created

issue

The issue details as a Map. See [Get Issue REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-get) for details.

user

The user details as a Map. See [Get User REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-user-get) for details.

issue\_event\_type\_name

A String containing: issue\_created

**For Issue Updated Only**

changelog

The changelog details as a Map. See [Webhook Changelog Example](https://developer.atlassian.com/jiradev/jira-apis/webhooks#Webhooks-Executingawebhook) for details

`issue.key,   user.displayName, issue.fields.project.key`

Issue Updated

Issue Deleted

Issue Link Created

issueLink

The issue link details as a Map, available fields: id, sourceIssueId, destinationIssueId, issueLinkType. See [Get Issue Link Type REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issueLinkType-issueLinkTypeId-get) for details.

  

Issue Link Deleted

Issue Type Created

issueType

The issue type details as a Map. See [Issue Type REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/v2/api-group-issue-types/#api-rest-api-2-issuetype-post) for details.

`project.id,   project.key,   issuetype.id,`

  

Issue Type Updated

Issue Type Deleted

Option Attachments Changed

property

The Jira configuration as a Map. Available fields: self, key, value.

`property.key,   property.value`

Option Issuelinks Changed

Option Subtasks Changed

Option Timetracking Changed

Option Unassigned Issues Changed

Option Voting Changed

Option Watching Changed 

Project Created

project

The project details as a Map. See [Get Project REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-project-projectIdOrKey-get) for details.

`project.key,   project.lead.displayName`

Project Deleted

Project Updated

Sprint Created

sprint

The sprint details as a Map. See [Get Sprint REST API reference](https://developer.atlassian.com/cloud/jira/software/rest/#agile/1.0/sprint-getSprint) for details.

`sprint.name,   sprint.id`

Sprint Started

Sprint Closed

Sprint Deleted

Sprint Updated

User Created

user

The user details as a Map. See [Get User REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-user-get) for details.

`user.displayName,   user.accountId`

User Updated

User Deleted

Version Created

version

The Project Version details as a Map. See [Get Version REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-version-id-get) for details.

  

`version.name,   version.self,   version.id,   version.description,   version.archived,   version.released,   version.overdue,   version.userReleaseDate,   version.projectId`

Version Updated

Version Deleted

Version Moved

Version Released

Version Unreleased

Worklog Created

worklog

The Worklog details as a Map. See [Get Worklog REST API reference](https://developer.atlassian.com/cloud/jira/platform/rest/#api-api-2-issue-issueIdOrKey-worklog-id-get) for details.

`worklog.id,   worklog.author.displayName, worklog.updateAuthor.displayName`

Worklog Updated

Worklog Deleted

  

* * *
