# Add a comment to an Issue using the Mail Handler

- Platform: data-center
- Feature: email-handler
- Tags: email
- Language: groovy
- Doc ID: example-dataCenter-update-an-existing-issue-using-the-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-an-existing-issue-using-the-mail-handler-onPrem

## Overview

This script enables you to add a comment to an existing issue using the mail handler. The email's subject line must match 
the existing issue's summary.

## Example

As a Project Admin, I want to automatically update the existing issues that we are currently working on per the mail we receive from our customers.
In this script, when the mail handler is triggered, it checks to see if there are any issues where the summary matches 
the email's subject. If it finds a match, the mail handler extracts the body of the email and adds it to the issue as a comment.

## Description

#### Overview
This script enables you to add a comment to an existing issue using the mail handler. The email's subject line must match 
the existing issue's summary.
                              
#### Example
As a Project Admin, I want to automatically update the existing issues that we are currently working on per the mail we receive from our customers.
In this script, when the mail handler is triggered, it checks to see if there are any issues where the summary matches 
the email's subject. If it finds a match, the mail handler extracts the body of the email and adds it to the issue as a comment.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.mail.MailUtils

final def projectKey = '<PROJECT_KEY>'

def projectManager = ComponentAccessor.projectManager
def issueManager = ComponentAccessor.issueManager
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def commentManager = ComponentAccessor.commentManager

def subject = message.subject as String
def messageBody = MailUtils.getBody(message)

def project = projectManager.getProjectByCurrentKey(projectKey)
def issues = issueManager.getIssueObjects(issueManager.getIssueIdsForProject(project.id))

//Example approach to extract the key from the email's subject.
def subjectKey = subject[1..subject.indexOf('-')]

issues.each {
    def issue = it as MutableIssue
    if (issue.summary.contains(subjectKey)) {
        //adding a new comment with message body
        commentManager.create(issue, loggedInUser, messageBody, false)
    }
}
```

