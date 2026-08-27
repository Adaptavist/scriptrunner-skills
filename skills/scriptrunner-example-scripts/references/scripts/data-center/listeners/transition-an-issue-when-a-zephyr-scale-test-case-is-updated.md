# Transition an Issue when a Zephyr Scale Test Case is Updated

- Platform: data-center
- Feature: listeners
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-transition-issue-testcase-change-onPrem
- Source: https://examples.scriptrunner.io/scripts/transition-issue-testcase-change-onPrem

## Overview

Transition any issues linked to a test case when the status is updated.

## Example

I work in the QA team and, when a test case status changes from ‘In draft’ to ‘Approved’, I want to update the
linked stories so that the team can see the test is ready to use.

## Good to Know

* Associate this script with the `TestCaseChangedEvent` event listener.

## Script

```groovy
@WithPlugin("com.kanoah.test-manager")
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.adaptavist.tm4j.api.event.testcase.TestCaseChangedEvent
import com.adaptavist.tm4j.api.service.status.StatusService
import com.adaptavist.tm4j.api.service.testcase.TestCaseService
import com.adaptavist.tm4j.api.service.tracelink.TraceLinkService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.opensymphony.workflow.loader.ActionDescriptor
import com.atlassian.jira.issue.Issue

def testCaseService = ComponentAccessor.getOSGiComponentInstanceOfType(TestCaseService)
def statusService = ComponentAccessor.getOSGiComponentInstanceOfType(StatusService)
def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def event = event as TestCaseChangedEvent
final testCaseId = event.id
final testCaseModel = testCaseService.getTestCaseModelById(currentUser.key, testCaseId).result
final testCaseStatusId = testCaseModel.statusId
final testCaseStatusModel = statusService.getTestCaseStatusModelById(currentUser.key, testCaseStatusId).result

final doneAction = "Done"
final inProgressAction = "In Progress"
final toDoAction = "To Do"

if (testCaseStatusModel.deprecated) {
    issueTransition(doneAction, currentUser, testCaseId)
} else if (testCaseStatusModel.draft) {
    issueTransition(toDoAction, currentUser, testCaseId)
} else {
    issueTransition(inProgressAction, currentUser, testCaseId)
}

def issueTransition(String actionName, ApplicationUser currentUser, Long testCaseId) {
    def issueManager = ComponentAccessor.issueManager
    def issueService = ComponentAccessor.issueService
    def traceLinkService = ComponentAccessor.getOSGiComponentInstanceOfType(TraceLinkService)
    def traceLinks = traceLinkService.getTraceLinkModelsByTestCaseId(currentUser.key, testCaseId).result
    def traceLinksWithIssues = traceLinks.findAll { tl -> tl.issueId != null }
    def issueIds = traceLinksWithIssues*.issueId
    issueIds.each { issueId ->
        def issue = issueManager.getIssueObject(issueId)
        def issueInputParameters = issueService.newIssueInputParameters()
        final action = getAction(actionName, issue)
        if (!action) {
            throw new RuntimeException("Action '$actionName' Not Found")
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

