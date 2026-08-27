# Create a New Issue Using a Mail Handler script and Set the Assignee to the First Valid CC User

- Platform: data-center
- Feature: email-handler
- Tags: automate, email, issue
- Language: groovy
- Doc ID: example-dataCenter-set-new-issue-assignee-to-first-cc-user-with-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-new-issue-assignee-to-first-cc-user-with-mail-handler-onPrem

## Overview

Use this script to capture the CC users from an email sent to Jira with the ScriptRunner Mail Handler, then create a new issue with the assignee field set to the first valid CC user.
To be considered a valid user, the CC email address must be linked to a Jira user.
If the first CC user is not valid, the script searches all CC email addresses until it finds a valid user. If no user is found, the issue is created without an assignee.

## Example

As a project manager, I want to automate the process of creating tickets when an email request is received. As part of this process, I want to ensure each ticket is assigned to the relevant team member. This script allows me to automatically assign a user based on the email CC list.

## Description

#### Overview

Use this script to capture the CC users from an email sent to Jira with the ScriptRunner Mail Handler, then create a new issue with the assignee field set to the first valid CC user.
To be considered a valid user, the CC email address must be linked to a Jira user.
If the first CC user is not valid, the script searches all CC email addresses until it finds a valid user. If no user is found, the issue is created without an assignee.

#### Example

As a project manager, I want to automate the process of creating tickets when an email request is received. As part of this process, I want to ensure each ticket is assigned to the relevant team member. This script allows me to automatically assign a user based on the email CC list.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.exception.CreateException
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageHandlerContext
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.atlassian.mail.MailUtils
import javax.mail.Message
import javax.mail.internet.InternetAddress

final targetProjectKey = 'TEST'
final defaultReporterName = 'admin'
final defaultIssueType = 'Task'

def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor) as MessageUserProcessor
def userManager = ComponentAccessor.getComponent(UserManager)
def projectManager = ComponentAccessor.projectManager
def issueFactory = ComponentAccessor.issueFactory

def subject = message.subject as String
def issue = ServiceUtils.findIssueObjectInString(subject)

if (issue) {
    // issue already exists so do nothing
    return
}

def project = projectManager.getProjectObjByKey(targetProjectKey)

def user = userManager.getUserByName(defaultReporterName)
def reporterUser = messageUserProcessor.getAuthorFromSender(message) ?: user

def allCcRecipients = message.getRecipients(Message.RecipientType.CC) as List<InternetAddress>
def firstValidUser = allCcRecipients.findResult {
    messageUserProcessor.findUserByEmail(it.address)
}

def issueObject = issueFactory.issue
issueObject.setProjectObject(project)
issueObject.setSummary(subject)
issueObject.setDescription(MailUtils.getBody(message))
issueObject.setIssueTypeId(project.issueTypes.find { it.name == defaultIssueType }.id)
issueObject.setReporter(reporterUser)
firstValidUser ?
    issueObject.setAssignee(firstValidUser as ApplicationUser) :
    log.error('Unable to retrieve valid user from message CC list, issue will be created without assignee')

try {
    (messageHandlerContext as MessageHandlerContext).createIssue(user, issueObject)
} catch (CreateException e) {
    log.error('Error creating issue: ', e)
}
```

