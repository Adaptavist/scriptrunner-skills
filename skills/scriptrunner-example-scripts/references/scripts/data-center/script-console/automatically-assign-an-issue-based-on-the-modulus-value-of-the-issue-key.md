# Automatically Assign an Issue based on the Modulus Value of the Issue Key

- Platform: data-center
- Feature: script-console
- Tags: issue, project, user
- Language: groovy
- Doc ID: example-dataCenter-auto-assign-issue-based-on-modulus-value-of-issue-key-onPrem
- Source: https://examples.scriptrunner.io/scripts/auto-assign-issue-based-on-modulus-value-of-issue-key-onPrem

## Overview

This console script assigns issues to the users according to the modulus value of the issue's key.

## Example

I work as a Project Manager. When I create an issue, I want to automatically assign it to a user based on the modulus value of the issue key. 
This ensures that all issues have a user assigned when the issue is created. I can adjust the modulus value calculator to balance workloads between users.

## Description

#### Overview
This console script assigns issues to the users according to the modulus value of the issue's key.  
                                
#### Example 
I work as a Project Manager. When I create an issue, I want to automatically assign it to a user based on the modulus value of the issue key. 
This ensures that all issues have a user assigned when the issue is created. I can adjust the modulus value calculator to balance workloads between users.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.MutableIssue

def issueManager = ComponentAccessor.issueManager
def projectManager = ComponentAccessor.projectManager
def userManager = ComponentAccessor.userManager

//Specify Project Key
def project = projectManager.getProjectByCurrentKey('<PROJECT_KEY>')

//Specify User's Name
def user1Id = '<USER_NAME>'
def user2Id = '<USER_NAME>'
def user3Id = '<USER_NAME>'

def issues = issueManager.getIssueObjects(issueManager.getIssueIdsForProject(project.id))

issues.sort().each {
    def issue = it as  MutableIssue

    def user1 = userManager.getUserByName(user1Id)
    def user2 = userManager.getUserByName(user2Id)
    def user3 = userManager.getUserByName(user3Id)

    def filter  = issue.key.replace("${project.key}-", '') as Integer

    if ( filter % 10 == 0 ) {
        issue.setAssignee(user1)
    } else if ( filter % 2 == 0 || filter % 3 == 0 ) {
        issue.setAssignee(user2)
    } else {
        issue.setAssignee(user3)
    }
    issueManager.updateIssue(issue.assignee, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
}
```

