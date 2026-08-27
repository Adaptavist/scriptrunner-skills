# Create Multiple Assignees in an Issue

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-multiple-assignees-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/multiple-assignees-issue-onPrem

## Overview

Associate multiple assignees with an issue via custom fields, so each user corresponds to a specific issue status.

## Example

Several users are responsible for an specific status of an issue. Using this script I can specify which user corresponds to each stage.

## Good to Know

* Create custom fields to store the assignable users.
* Associate this script with the `All Issue Events` event listener.
* You can use this script in a post-function using the implicit `issue` variable instead of `event.issue`.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.user.ApplicationUser

def issue = event.issue as MutableIssue

final customFieldManager = ComponentAccessor.customFieldManager
final statusName = 'Testing'

def roleName = (issue.status.name == statusName) ? 'Tester' : 'Engineer'
def assignee = issue.getCustomFieldValue(customFieldManager.getCustomFieldObjects(issue).find { it.name == roleName }) as ApplicationUser

if (!assignee) {
    return
}

if (issue.assignee && issue.assignee.username == assignee.username) {
    return
}

def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
issue.setAssignee(assignee)
ComponentAccessor.issueManager.updateIssue(currentUser, issue, EventDispatchOption.ISSUE_UPDATED, false)
```

