# Clone an Epic with its Issues and Subtasks when it Transitions

- Platform: data-center
- Feature: post-functions
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-clone-an-epic-along-with-its-issues-and-subtasks-onPrem
- Source: https://examples.scriptrunner.io/scripts/clone-an-epic-along-with-its-issues-and-subtasks-onPrem

## Overview

This sample post-function code provides the ability to clone an epic along with its issues and sub-tasks when it transitions to a certain
status.

## Example

I would like to create a clone of my epic along with all its issues and sub-tasks when I transition it to a particular status. I can do so using this post-function script.

## Description

#### Overview
This sample post-function code provides the ability to clone an epic along with its issues and sub-tasks when it transitions to a certain
status.
                                
#### Example
I would like to create a clone of my epic along with all its issues and sub-tasks when I transition it to a particular status. I can do so using this post-function script.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.IssueFactory
import com.atlassian.jira.issue.IssueManager
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder
import com.atlassian.jira.user.ApplicationUser

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager
def issueLinkManager = ComponentAccessor.issueLinkManager
def issueFactory = ComponentAccessor.issueFactory
def subtaskManager = ComponentAccessor.subTaskManager

def changeHolder = new DefaultIssueChangeHolder()

//Create a clone of an issue
static Issue clonedIssue(Issue issue, ApplicationUser loggedInUser, IssueFactory issueFactory, IssueManager issueManager) {
    def cloneIssueFactory = issueFactory.cloneIssueWithAllFields(issue)
    def newIssueParams = ['issue': cloneIssueFactory] as Map<String, Object>
    issueManager.createIssueObject(loggedInUser, newIssueParams)
}

if (issue.issueType.name == 'Epic') {
    //Cloning of the Epic
    def epicClone = clonedIssue(issue, loggedInUser, issueFactory, issueManager)
    def epic = issueManager.getIssueByCurrentKey(epicClone.key)
    def epicName = customFieldManager.getCustomFieldObjectsByName('Epic Name').first()
    def originalEpicName = issue.getCustomFieldValue(epicName)
    epicName.updateValue(null, epic, new ModifiedValue(epic.getCustomFieldValue(epicName), "${originalEpicName} Clone".toString()), changeHolder)
    issueManager.updateIssue(loggedInUser, epic, EventDispatchOption.ISSUE_UPDATED, false)

    //Extraction of Original Issue(s) from Original Epic
    def links = issueLinkManager.getOutwardLinks(issue.id)

    def originalIssuesInEpic = links.findAll { it.issueLinkType.name == 'Epic-Story Link' }*.destinationObject

    //Cloning of Original Issue(s) from the Original Epic and Adding it to the Cloned Epic
    originalIssuesInEpic.each {
        def clonedIssue = clonedIssue(it, loggedInUser, issueFactory, issueManager)
        def subtasks = it.subTaskObjects
        if (subtasks) {
            subtasks.each { subtask ->
                def toClone = issueFactory.cloneIssueWithAllFields(subtask)
                def cloned = issueManager.createIssueObject(clonedIssue.reporter, toClone)
                subtaskManager.createSubTaskIssueLink(clonedIssue, cloned, clonedIssue.reporter)
            }
        }
        def targetField = customFieldManager.getCustomFieldObjects(clonedIssue).findByName('Epic Link')
        targetField.updateValue(null, clonedIssue, new ModifiedValue(clonedIssue.getCustomFieldValue(targetField), epic), changeHolder)
    }
}
```

