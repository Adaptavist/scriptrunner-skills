# Create a Comment on a Jira Service Desk Ticket in Groovy

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-sd-comment-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-sd-comment-onPrem

## Overview

Create public responses on Jira Service Desk using Groovy. Using this script, create standard responses to various scenarios. You can also use this script to build an automated response, for example; comment a standardised response X hours after ticket creation.

## Example

I have a workflow action to solicit feedback from all tickets linked to a particular problem. I use this snippet as part of a larger script which checks the date the issue was reported and the date the issue was marked as resolved. Once a customer goes through this workflow, a request feedback message is sent.

## Description

#### Overview
Create public responses on Jira Service Desk using Groovy. Using this script, create standard responses to various scenarios. You can also use this script to build an automated response, for example; comment a standardised response X hours after ticket creation.

#### Example
I have a workflow action to solicit feedback from all tickets linked to a particular problem. I use this snippet as part of a larger script which checks the date the issue was reported and the date the issue was marked as resolved. Once a customer goes through this workflow, a request feedback message is sent.

## Script

```groovy
import com.atlassian.jira.bc.issue.comment.CommentService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.servicedesk.api.comment.ServiceDeskCommentService
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.atlassian.servicedesk")

final String issueKey = "TEST-1" // the key of the issue
final String comment = "This is a comment" // the comment you want to add

static void createServiceDeskComment(MutableIssue issueToComment, String text, Boolean internal) {
    def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser

    if (issueToComment.projectObject.projectTypeKey.key == "service_desk") {
        def serviceDeskCommentService = ComponentAccessor.getOSGiComponentInstanceOfType(ServiceDeskCommentService)

        def createCommentParameters = serviceDeskCommentService.newCreateBuilder()
            .author(user)
            .body(text)
            .issue(issueToComment)
            .publicComment(!internal)
            .build()

        serviceDeskCommentService.createServiceDeskComment(user, createCommentParameters)
    } else {
        def commentParameters = CommentService.CommentParameters.builder()
            .author(user)
            .body(text)
            .issue(issueToComment)
            .build()

        def commentService = ComponentAccessor.getComponent(CommentService)
        def validationResult = commentService.validateCommentCreate(user, commentParameters)
        commentService.create(user, validationResult, true)
    }
}

//Example of function in use
def issueManager = ComponentAccessor.issueManager
def issue = issueManager.getIssueByCurrentKey(issueKey)

createServiceDeskComment(issue, comment, true) //false means public, true means internal
```

