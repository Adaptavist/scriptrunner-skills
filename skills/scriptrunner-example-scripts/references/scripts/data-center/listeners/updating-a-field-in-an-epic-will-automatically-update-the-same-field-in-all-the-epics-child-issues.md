# Updating a Field in an Epic will Automatically Update the same Field in all the Epic's Child Issues

- Platform: data-center
- Feature: listeners
- Tags: administer, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-epic-updates-fields-in-child-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/epic-updates-fields-in-child-issues-onPrem

## Overview

This code provides the ability to automatically update the field value of all the child issues when the same field is 
updated in the epic.

## Example

As a Project Manager, I have many epics to manage. Whenever I make an update to a field in the epic, I would like all 
the issues associated with the epic to have the same field updated. This script enables me to do so.

## Description

#### Overview
This code provides the ability to automatically update the field value of all the child issues when the same field is 
updated in the epic. 
                              
#### Example
As a Project Manager, I have many epics to manage. Whenever I make an update to a field in the epic, I would like all 
the issues associated with the epic to have the same field updated. This script enables me to do so.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.issue.MutableIssue

def issue = event.issue as MutableIssue

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def customFieldManager = ComponentAccessor.customFieldManager
def issueManager = ComponentAccessor.issueManager
def issueLinkManager = ComponentAccessor.issueLinkManager
def projectGroup = customFieldManager.getCustomFieldObjectsByName('Project Group').first()
def epicLink = customFieldManager.getCustomFieldObjectsByName('Epic Link').first()
def projectGroupValue = issue.getCustomFieldValue(projectGroup)

def subTasks = [] as ArrayList<Issue>

if (issue.issueType.name == 'Epic' && issue) {
    def links = issueLinkManager.getOutwardLinks(issue.id)
    links.each {
        def destinationIssue = it.destinationObject as MutableIssue
        destinationIssue.setCustomFieldValue(projectGroup, projectGroupValue)
        issueManager.updateIssue(loggedInUser, destinationIssue, EventDispatchOption.DO_NOT_DISPATCH, false)
        subTasks = destinationIssue.subTaskObjects.collect { it }
    }
} else if (issue.getCustomFieldValue(epicLink)) {
    def links = issueLinkManager.getInwardLinks(issue.id)
    links.each {
        issue.setCustomFieldValue(projectGroup, it.sourceObject.getCustomFieldValue(projectGroup) )
        issueManager.updateIssue(loggedInUser, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
    }
} else if (issue.subTask) {
    subTasks.addAll(issue)
}

subTasks.each {
    def subTask = it as MutableIssue
    subTask.setCustomFieldValue(projectGroup, it.parentObject.getCustomFieldValue(projectGroup))
    issueManager.updateIssue(loggedInUser, subTask, EventDispatchOption.DO_NOT_DISPATCH, false)
}
```

