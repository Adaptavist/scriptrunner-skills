# Add a Comment to the Service Management Issue Mentioned in the Mail Subject

- Platform: data-center
- Feature: email-handler
- Tags: automate, email, issue
- Language: groovy
- Doc ID: example-dataCenter-add-comment-to-existing-service-management-issue-with-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-comment-to-existing-service-management-issue-with-mail-handler-onPrem

## Overview

Automate adding a comment to an existing Service Management issue when the subject line of an email sent to Jira contains a valid issue key.
If you want to allow comments from unregistered Jira users, you can choose a registered user who will add those comments on behalf of the email sender.

## Example

As a Service Desk Manager, I want the body of emails sent to Jira to automatically be added as a comment on existing issues when the user includes that issue key in the email subject.
Comments should be added as the sender user, or as a delegated/impersonating user commenting on behalf of the sender.

## Good to Know

* `addCommentAsPublic` set to true to create the comment as public or false to create it as internal. Note: Not all users can comment internally.

* Use the `allowCommentsFromUnregisteredUsers` boolean and the `commentAsUser` user Name string to allow a designated user to add comments for unregistered Jira users.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.atlassian.jira.permission.ProjectPermissions
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.mail.MailUtils
import com.atlassian.servicedesk.api.comment.ServiceDeskCommentService
import com.atlassian.servicedesk.api.customer.CustomerContextService
import com.atlassian.servicedesk.api.permission.ServiceDeskPermissionService
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.transform.Field
import javax.mail.Message

@WithPlugin('com.atlassian.servicedesk')

// add service desk comment as public
final addCommentAsPublic = true

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

createComment(commentUser as ApplicationUser, commentBody as String, issue as Issue, addCommentAsPublic as Boolean)

void createComment(ApplicationUser commentUser, String commentBody, Issue issue, Boolean publicComment) {
    @PluginModule ServiceDeskCommentService serviceDeskCommentService
    @PluginModule CustomerContextService customerContextService
    customerContextService.runInCustomerContext {
        def createCommentParameters = serviceDeskCommentService.newCreateBuilder()
            .author(commentUser)
            .body(commentBody)
            .issue(issue)
            .publicComment(publicComment)
            .build()

        serviceDeskCommentService.createServiceDeskComment(commentUser, createCommentParameters)
    }
}

// this method will return a user who can comment or null if a valid user cannot be found
def getCommentUser(Message message, Issue issue, Boolean allowCommentsFromNonJiraUsers) {
    @PluginModule ServiceDeskPermissionService serviceDeskPermissionService

    def userManager = ComponentAccessor.userManager
    def permissionManager = ComponentAccessor.permissionManager
    def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)

    def sender = (messageUserProcessor as MessageUserProcessor).getAuthorFromSender(message)
    def delegatedUser = allowCommentsFromNonJiraUsers ? userManager.getUserByName(commentAsUser as String) : null

    // check if sender is customer user or they have the project permission to add comments
    def senderCanComment = null
    if (sender) {
        senderCanComment = serviceDeskPermissionService.isCustomer(sender, issue) ||
            permissionManager.hasPermission(ProjectPermissions.ADD_COMMENTS, issue, sender)
    }

    // if sender can add comments return sender, else return the commentAsUser
    senderCanComment ? sender : delegatedUser
}
```

