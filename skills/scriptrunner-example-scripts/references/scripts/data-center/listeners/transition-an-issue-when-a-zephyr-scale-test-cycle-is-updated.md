# Transition an Issue when a Zephyr Scale Test Cycle is Updated

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-transition-issue-testcycle-change-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-issue-testcycle-change-onPrem

## Overview

Transition any issues linked to a test cycle when the status is updated.

## Example

I work in the QA team and, when a test cycle status changes from ‘In progress’ to ‘Done’, I want to update the linked
issues so that the team can keep track of the progress.

## Good to Know

* Associate this script with the `TestCycleChangedEvent` event listener.

## Script

```groovy
@WithPlugin("com.kanoah.test-manager")
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.adaptavist.tm4j.api.event.testcycle.TestCycleChangedEvent
import com.adaptavist.tm4j.api.service.status.StatusService
import com.adaptavist.tm4j.api.service.testcycle.TestCycleService
import com.adaptavist.tm4j.api.service.tracelink.TraceLinkService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.opensymphony.workflow.loader.ActionDescriptor
import com.atlassian.jira.issue.Issue

def testCycleService = ComponentAccessor.getOSGiComponentInstanceOfType(TestCycleService)
def statusService = ComponentAccessor.getOSGiComponentInstanceOfType(StatusService)
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def event = event as TestCycleChangedEvent
def testCycleId = event.id
def testCycleModel = testCycleService.getTestCycleModelById(currentUser.key, testCycleId).result
def testCycleStatusId = testCycleModel.statusId
def testCycleStatusModel = statusService.getTestCycleStatusModelById(currentUser.key, testCycleStatusId).result

def doneAction = "Done"
def inProgressAction = "In Progress"
def toDoAction = "To Do"

if (testCycleStatusModel.done) {
    issueTransition(doneAction, currentUser, testCycleId)
} else if (testCycleStatusModel.inProgress) {
    issueTransition(inProgressAction, currentUser, testCycleId)
} else {
    issueTransition(toDoAction, currentUser, testCycleId)
}

def issueTransition(String actionName, ApplicationUser currentUser, Long testCycleId) {
    def issueManager = ComponentAccessor.issueManager
    def issueService = ComponentAccessor.issueService
    def traceLinkService = ComponentAccessor.getOSGiComponentInstanceOfType(TraceLinkService)
    def traceLinks = traceLinkService.getTraceLinkModelsByTestCycleId(currentUser.key, testCycleId).result
    def traceLinksWithIssues = traceLinks.findAll { tl -> tl.issueId != null }
    def issueIds =  traceLinksWithIssues*.issueId
    issueIds.each { issueId ->
        def issue = issueManager.getIssueObject(issueId)
        def action = getAction(actionName, issue)
        if (!action) {
            throw new RuntimeException("Action '$actionName' Not Found")
        }
        def issueInputParameters = issueService.newIssueInputParameters()
        def validateTransition = issueService.validateTransition(currentUser, issue.id, action.id, issueInputParameters)
        if (validateTransition.valid) {
            issueService.transition(currentUser, validateTransition)
        }
    }
}

ActionDescriptor getAction(String actionName, Issue issue) {
    def workflowManager = ComponentAccessor.workflowManager.getWorkflow(issue)
    def actions = workflowManager.getActionsByName(actionName)
    actions.find { action -> action.name == actionName }
}
```

