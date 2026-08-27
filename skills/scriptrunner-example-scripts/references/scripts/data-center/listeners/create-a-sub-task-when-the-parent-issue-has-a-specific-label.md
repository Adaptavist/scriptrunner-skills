# Create a Sub-Task When the Parent Issue Has a Specific Label

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-create-subtask-if-label-present-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-subtask-if-label-present-onPrem

## Overview

Automatically create a sub-task when a specific label is added to the parent issue.

## Example

I am working on the help desk and I have been assigned to an issue to check a laptop. I have found that it is broken and needs to be replaced. Therefore, I need to create a sub-task associated with the issue to manage the purchase of the laptop. Using this script, I can label the parent issue with a 'broken' tag so the sub-task is automatically created.

## Good to Know

* Use this script on a script listener triggered for the `Issue Updated` event.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.IssueInputParametersImpl

final newLabel = 'create_subtask'

def issue = event.issue
if (!issue.subTask && newLabel in issue.labels*.label) {
    createSubtask(issue)
}

def createSubtask(Issue parentIssue) {
    def subTaskManager = ComponentAccessor.subTaskManager
    def asUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
    def constantsManager = ComponentAccessor.constantsManager
    def issueService = ComponentAccessor.issueService

    def subtaskIssueType = constantsManager.allIssueTypeObjects.findByName('Sub-task')

    assert subtaskIssueType?.subTask

    // Fill the required fields
    def issueInputParameters = new IssueInputParametersImpl()
    issueInputParameters
        .setProjectId(parentIssue.projectId)
        .setIssueTypeId(subtaskIssueType.id)
        .setSummary('A new subtask')
        .setDescription('A description')
        .setReporterId(asUser.username)

    def createValidationResult = ComponentAccessor.issueService.validateSubTaskCreate(asUser, parentIssue.id, issueInputParameters)
    if (!createValidationResult.valid) {
        log.error createValidationResult.errorCollection
        return
    }

    def newIssue = issueService.create(asUser, createValidationResult).issue
    subTaskManager.createSubTaskIssueLink(parentIssue, newIssue, asUser)
}
```

