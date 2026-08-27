# Update the Priority of an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-priority-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-priority-onPrem

## Overview

Automatically update the priority of issues in Jira. This can be used for bulk updating priorities, or as part of a larger script.

## Example

When issues have been open for more than one week without them being transitioned into 'In Progress', I want the issue priority to increase one level above their current priority.
For example, I want the 'Low' priority issues to change to 'Medium', 'Medium' priority issues to change to 'High'.

## Description

#### Overview
Automatically update the priority of issues in Jira. This can be used for bulk updating priorities, or as part of a larger script.

#### Example
When issues have been open for more than one week without them being transitioned into 'In Progress', I want the issue priority to increase one level above their current priority.
For example, I want the 'Low' priority issues to change to 'Medium', 'Medium' priority issues to change to 'High'.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.type.EventDispatchOption

// the key of the issue we will update
final String issueKey = "JRA-1"

// the name of the priority to set
final String priorityName = "High"

// set to true in order to send an email
final boolean sendMail = false

def issueService = ComponentAccessor.issueService
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issue = ComponentAccessor.issueManager.getIssueByCurrentKey(issueKey)

def availablePriorities = ComponentAccessor.constantsManager.priorities
def highPriority = availablePriorities.find { it.name == priorityName }

assert highPriority : "Could not find priority with name $priorityName. Available priorities are ${availablePriorities*.name.join(", ")}"

def issueInputParams = issueService.newIssueInputParameters()
issueInputParams.with {
    priorityId = highPriority.id
}

def updateValidationResult = issueService.validateUpdate(loggedInUser, issue?.id, issueInputParams)
assert updateValidationResult.valid : updateValidationResult.errorCollection

def updateResult = issueService.update(loggedInUser, updateValidationResult, EventDispatchOption.ISSUE_UPDATED, sendMail)
assert updateResult.valid : updateResult.errorCollection
```

