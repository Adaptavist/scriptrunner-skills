# Transition an Issue when a Zephyr Scale Test Execution is Updated

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-transition-issue-testexecution-change-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-issue-testexecution-change-onPrem

## Overview

Transition any issues linked to a test execution when the status is updated.

## Example

I work on the QA team and, when a test execution status changes from ‘Fail’ to ‘Pass’, I want to update
the linked defects so that the development team can review existing defects before release.

## Good to Know

* Associate this script with the `TestExecutionChangedEvent` event listener.

## Script

```groovy
@WithPlugin("com.kanoah.test-manager")
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.atlassian.jira.component.ComponentAccessor
import com.adaptavist.tm4j.api.event.testexecution.TestExecutionChangedEvent
import com.adaptavist.tm4j.api.service.testexecution.TestExecutionService
import com.adaptavist.tm4j.api.service.status.StatusService
import com.adaptavist.tm4j.api.service.tracelink.TraceLinkService
import com.atlassian.jira.user.ApplicationUser
import com.opensymphony.workflow.loader.ActionDescriptor
import com.atlassian.jira.issue.Issue

def testExecutionService = ComponentAccessor.getOSGiComponentInstanceOfType(TestExecutionService)
def statusService = ComponentAccessor.getOSGiComponentInstanceOfType(StatusService)
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def event = event as TestExecutionChangedEvent
def testExecutionId = event.id
def testExecutionModel = testExecutionService.getTestExecutionModelById(currentUser.key, testExecutionId).result
def testExecutionStatusId = testExecutionModel.statusId
def testExecutionStatusResult = statusService.getTestExecutionStatusModelById(currentUser.key, testExecutionStatusId)
def testExecutionStatusModel = testExecutionStatusResult.result

def doneAction = "Done"
def inProgressAction = "In Progress"
def toDoAction = "To Do"

if (testExecutionStatusModel.pass) {
    issueTransition(doneAction, currentUser, testExecutionId)
} else if (testExecutionStatusModel.inProgress) {
    issueTransition(inProgressAction, currentUser, testExecutionId)
} else {
    issueTransition(toDoAction, currentUser, testExecutionId)
}

def issueTransition(String actionName, ApplicationUser currentUser, Long testExecutionId) {
    def issueManager = ComponentAccessor.issueManager
    def issueService = ComponentAccessor.issueService
    def traceLinkService = ComponentAccessor.getOSGiComponentInstanceOfType(TraceLinkService)
    def traceLinks = traceLinkService.getTraceLinkModelsByTestExecutionId(currentUser.key, testExecutionId).result
    def traceLinksWithIssues = traceLinks.findAll { tl -> tl.issueId != null }
    def issueIds =  traceLinksWithIssues*.issueId
    issueIds.each { issueId ->
        def issue = issueManager.getIssueObject(issueId)
        def issueInputParameters = issueService.newIssueInputParameters()
        def action = getAction(actionName, issue)
        if (action == null) {
            throw new RuntimeException("Action '" + actionName +  "' Not Found")
        }
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

