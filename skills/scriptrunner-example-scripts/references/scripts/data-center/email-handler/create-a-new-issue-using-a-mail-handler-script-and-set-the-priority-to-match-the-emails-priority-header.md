# Create a New Issue Using a Mail Handler Script and Set the Priority to Match the Emails Priority Header

- Platform: data-center
- Feature: email-handler
- Tags: automate, email, issue
- Language: groovy
- Doc ID: example-dataCenter-set-new-issue-priority-to-match-the-email-priority-level-with-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-new-issue-priority-to-match-the-email-priority-level-with-mail-handler-onPrem

## Overview

Use this script with the ScriptRunner Mail Handler to create a new issue from emails sent to Jira, and to set the priority to the same level as the emails X-Priority header.

## Example

As a Jira Admin, I want users to be able to send emails to Jira that automatically create an issue with the same priority value as the priority set in the header of the email to ensure issues are prioritised correctly.

## Good to Know

This script will look at the mail caught by the mail handler and find the "X-Priority" header value, and then it translates this value to an applicable Jira issue priority.
If the script cannot translate the mail priority to a matching Jira priority, it will set the issue to the default level defined in the script.

You should set the `defaultFallbackPriority` variable to the default priority name you want issues to have when the email does not contain a matching priority in its header.
The `priorityHeaderValueToJiraPriorityName` Map should be set based on how your business defines the X-Priority header values.

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
final defaultIssueType = 'Task'
final defaultFallbackPriority = 'Medium'
// X-Priority is usually a number string and is defined by your mail server admin. This map defines an example relationship between X-Priority and a Jira Priority Name.
final priorityHeaderValueToJiraPriorityName = [
    '5': 'Lowest',
    '4': 'Low',
    '3': 'Medium',
    '2': 'High',
    '1': 'Highest',
]

def constantsManager = ComponentAccessor.constantsManager
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

def defaultPriority = constantsManager.priorities.findByName(defaultFallbackPriority)
def mailPriority = message.getHeader('X-Priority')?.first()
def translatedPriority = priorityHeaderValueToJiraPriorityName[mailPriority]
def derivedPriority = constantsManager.priorities.findByName(translatedPriority) ?: defaultPriority

if (!derivedPriority) {
    log.error('A valid Priority could not be found so no issue will be created')
    return
}

def issueObject = issueFactory.issue.with {
    setProjectObject(project)
    setSummary(subject ?: 'Created via ScriptRunner mail handler') // Issues must always have a summary
    setDescription(MailUtils.getBody(message))
    setIssueTypeId(project.issueTypes.find { it.name == defaultIssueType }.id)
    setReporter(reporterUser)
    setPriority(derivedPriority)
    it
}

try {
    (messageHandlerContext as MessageHandlerContext).createIssue(user, issueObject)
} catch (CreateException e) {
    log.error('Error creating issue: ', e)
}
```

