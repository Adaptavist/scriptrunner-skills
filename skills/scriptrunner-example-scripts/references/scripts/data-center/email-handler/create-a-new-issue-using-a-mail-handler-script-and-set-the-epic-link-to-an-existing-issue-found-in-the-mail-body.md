# Create a New Issue Using a Mail Handler Script and Set the Epic Link to an Existing Issue Found in the Mail Body

- Platform: data-center
- Feature: email-handler
- Tags: automate, email, issue
- Language: groovy
- Doc ID: example-dataCenter-set-new-issue-epic-link-to-existing-epic-with-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-new-issue-epic-link-to-existing-epic-with-mail-handler-onPrem

## Overview

Use this script to search an email message body and find an existing epic/initiative issue key. The script then creates a new issue within that epic/initiative as the new Stories Epic Link field value.

## Example

As a project manager, I want to automate the process of creating new stories under existing epics when a user sends an email to Jira with the epic key in the message body — saving manual effort and time.

## Good to Know

* If the subject contains an existing issue key this script exists and does not create a new issue to avoid creating duplicates

* We use the `findIssueObjectInString` method provided by Jira's ServiceUtils class to search for issue key strings like TEST-1

* This Script will only create a new issue if the message body contains an issue key pointing to an existing epic or initiative

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.exception.CreateException
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageHandlerContext
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.util.UserManager
import com.atlassian.mail.MailUtils

final targetProjectKey = 'TEST'
final defaultReporterName = 'admin'
final issueTypeForNewIssue = 'Task'
final epicLinkFieldName = 'Epic Link'

def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor) as MessageUserProcessor
def userManager = ComponentAccessor.getComponent(UserManager)
def projectManager = ComponentAccessor.projectManager
def issueFactory = ComponentAccessor.issueFactory
def customFieldManager = ComponentAccessor.customFieldManager

def subject = message.subject as String
def body = MailUtils.getBody(message) as String

def issueFromSubject = ServiceUtils.findIssueObjectInString(subject)
def issueFromBody = ServiceUtils.findIssueObjectInString(body)

if (issueFromSubject) {
    // Existing issue found in subject so will not create a new issue
    return
}

if (!(issueFromBody?.issueType?.name in ['Epic', 'Initiative'])) {
    // No existing Epic or Initiative Issue Key in email body so will not create a new issue
    return
}

def project = projectManager.getProjectObjByKey(targetProjectKey)
def user = userManager.getUserByName(defaultReporterName)
def reporterUser = messageUserProcessor.getAuthorFromSender(message) ?: user

def epicLinkField = customFieldManager.customFieldObjects.findByName(epicLinkFieldName)

def issueObject = issueFactory.issue.with {
    setProjectObject(project)
    setSummary(subject ?: 'Created via ScriptRunner mail handler') // Issues must always have a summary
    setDescription(body)
    setIssueTypeId(project.issueTypes.find { it.name == issueTypeForNewIssue }.id)
    setReporter(reporterUser)
    setCustomFieldValue(epicLinkField, issueFromBody)
    it
}

try {
    issue = (messageHandlerContext as MessageHandlerContext).createIssue(user, issueObject)
} catch (CreateException e) {
    log.error('Error creating issue: ', e)
}
```

