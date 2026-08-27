# Add a Comment to the Issue Mentioned in the Mail Subject

- Platform: data-center
- Feature: email-handler
- Tags: automate, email, issue
- Language: groovy
- Doc ID: example-dataCenter-add-comment-to-existing-issue-with-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-comment-to-existing-issue-with-mail-handler-onPrem

## Overview

Automate adding a comment to an existing issue when the subject line of an email sent to Jira contains a valid issue key.
If you want to allow comments from unregistered Jira users, you can choose a registered user who will add those comments on behalf of the email sender.

## Example

As a project manager, I want the body of emails sent to Jira to automatically be added as a comment on existing issues when the user includes that issue key in the email subject.
Comments should be added as the sender user, or as a delegated/impersonating user commenting on behalf of the sender.

## Good to Know

* Use the `dispatchCommentedEvent` boolean to tell Jira to send an Issue Commented event or not.

* Use the `allowCommentsFromUnregisteredUsers` boolean and the `commentAsUser` user Name string to allow a designated user to add comments for unregistered Jira users.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.permission.ProjectPermissions
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageHandlerContext
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.mail.MailUtils
import groovy.transform.Field
import javax.mail.Message

// should dispatch Issue Commented event
final dispatchCommentedEvent = true

// allow comments from non-jira users
final allowCommentsFromUnregisteredUsers = true

// to allow comments from any email sender you must specify an existing user who will add the comments on their behalf
@Field final commentAsUser = 'impersonatingUser'

def subject = message.subject as String
def issue = ServiceUtils.findIssueObjectInString(subject)
if (!issue) {
    // existing issue not found within subject, so no issue will be updated
    return
}

def body = MailUtils.getBody(message)
if (!body) {
    // mail has no body content so comment will not be added
    return
}

def commentUser = getCommentUser(message, issue, allowCommentsFromUnregisteredUsers)
if (!commentUser) {
    log.error("Could not add comment to ${issue.key} from email with subject $subject, as no user with permission to comment was found")
    return
}

// get senders email addresses and prepend to mail body so comment has source email address on the first line
def senders = MailUtils.getSenders(message).join(',')
def commentBody = "$senders\n$body"

(messageHandlerContext as MessageHandlerContext).createComment(issue as Issue, commentUser as ApplicationUser, commentBody as String, dispatchCommentedEvent as Boolean)

def getCommentUser(Message message, Issue issue, Boolean allowCommentsFromNonJiraUsers) {
    def userManager = ComponentAccessor.userManager
    def permissionManager = ComponentAccessor.permissionManager
    def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)

    def sender = (messageUserProcessor as MessageUserProcessor).getAuthorFromSender(message)
    def delegatedUser = allowCommentsFromNonJiraUsers ? userManager.getUserByName(commentAsUser as String) : null

    // if sender can add comments return sender user, else return the commentAsUser
    permissionManager.hasPermission(ProjectPermissions.ADD_COMMENTS, issue, sender) ? sender : delegatedUser
}
```

