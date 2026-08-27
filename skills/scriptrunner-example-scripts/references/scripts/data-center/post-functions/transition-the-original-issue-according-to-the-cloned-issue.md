# Transition the Original Issue According to the Cloned Issue

- Platform: data-center
- Feature: post-functions
- Tags: workflow
- Language: groovy
- Doc ID: example-dataCenter-transition-original-issue-according-to-cloned-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-original-issue-according-to-cloned-issue-onPrem

## Overview

Creates an automation to transition an issue, based on the status of it's cloned issue.

## Example

If a cloned issue transitions to Done, the original issue will also automatically transition to the Done.

## Description

#### Overview

Creates an automation to transition an issue, based on the status of it's cloned issue.

#### Example

If a cloned issue transitions to Done, the original issue will also automatically transition to the Done.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def issueLinkManager = ComponentAccessor.issueLinkManager
def issueManager = ComponentAccessor.issueManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issueService = ComponentAccessor.issueService

def clonedIssues = issueLinkManager.getOutwardLinks(issue.id)

// The transition id of the status must have a value of type int
final int transitionId = 1

def clonedIssueObjects = clonedIssues.findAll {
    it.issueLinkType.name == 'Cloners'
}.collect {
    issueManager.getIssueObject(it.destinationId)
}

clonedIssueObjects.each {
    def outerIssue = issueManager.getIssueObject(it.toString())
    def transitionValidationResult = issueService.validateTransition(loggedInUser, outerIssue.id, transitionId, issueService.newIssueInputParameters())

    if (transitionValidationResult.valid) {
        def transitionResult = issueService.transition(loggedInUser, transitionValidationResult)
        if (transitionResult.valid) {
            log.warn "Transitioned issue ${outerIssue} through action ${transitionId}"
        } else  {
            log.warn 'Transition result is not valid'
        }
    } else {
        log.warn 'The transitionValidation is not valid'
    }
}
```

