# Round Robin Assign Issue to Users in a Certain Project Role

- Platform: data-center
- Feature: post-functions
- Tags: customise, workflow, user, issue
- Language: groovy
- Doc ID: example-dataCenter-round-robin-assign-onPrem
- Source: https://examples.scriptrunner.io/scripts/round-robin-assign-onPrem

## Overview

Assign issues to the members of a project role in 'round robin' manner. This script automatically assigns the next user
in the list to each newly created issue.

## Example

I want to equally distribute the work of a customer service project between the agents in charge, so each new issue
is assigned to the agent who is next in the queue.

## Good to Know

* Use this script a post function associated with the *Create* step.
* The new issues are assigned to the agents depending on the creation order of the issues.
* You can configure the "reassignedIssues" value to reassigned the assigned issues or not.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

// The role you want assignees to set from
final roleName = 'Project Role'

// If it is true, the assigned issues will be reassigned
final reassignedIssues = true

def issueManager = ComponentAccessor.issueManager
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)

// Get all of the users associated with the specified project role
def projectRole = projectRoleManager.getProjectRole(roleName)

// Sort the users of the project role using the user key
def users = projectRoleManager.getProjectRoleActors(projectRole, issue.projectObject)
    .applicationUsers
    .toSorted { it.key }

// There are no users in the specific project role
if (!users) {
    log.info ("No users for project role $roleName")
    return
}

if (!reassignedIssues && issue.assignee) {
    log.info ('The issue is already assigned')
    return
}

// Find the latest created issue id that has an assignee
def lastIssueIdWithAssignee = issueManager.getIssueIdsForProject(issue.projectObject.id)
    .sort()
    .reverse()
    .find { issueManager.getIssueObject(it).assignee }

if (!lastIssueIdWithAssignee) {
    issue.setAssignee(users.first())
    return
}

def lastAssignee = issueManager.getIssueObject(lastIssueIdWithAssignee).assignee
def lastAssigneeIndex = users.indexOf(lastAssignee)
def nextAssignee = users[(lastAssigneeIndex + 1) % users.size()]

issue.setAssignee(nextAssignee)
```

