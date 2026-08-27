# Use Mail Handler to add Email Body and Image Attachments to the Description Field

- Platform: data-center
- Feature: email-handler
- Tags: email, issue
- Language: groovy
- Doc ID: example-dataCenter-include-attachments-in-description-using-mail-handler-onPrem
- Source: https://examples.scriptrunner.io/scripts/include-attachments-in-description-using-mail-handler-onPrem

## Overview

This script is meant to be used only for issue creation. It uses the Mail Handler to extract the contents of the email 
and create a new issue. The body of the email along with any image attachments in the email are added to the description 
field. The image attachments are also included as attachments in the issue.

## Example

As a Product Support Manager, I receive a lot of emails from customers requesting support. At present, we are
only using Jira Software to handle our tickets. It is very time consuming to manually create the tickets for the customers
and include their attachments together with the steps to replicate their issues. 
To solve this problem, I would like to use ScriptRunner's mail handler to automatically extract the contents of the emails 
received, including image attachments, and add them in the description field to display the steps to replicate the issue.
This script helps me to do so.

## Description

#### Overview
This script is meant to be used only for issue creation. It uses the Mail Handler to extract the contents of the email 
and create a new issue. The body of the email along with any image attachments in the email are added to the description 
field. The image attachments are also included as attachments in the issue.
                                
#### Example
As a Product Support Manager, I receive a lot of emails from customers requesting support. At present, we are
only using Jira Software to handle our tickets. It is very time consuming to manually create the tickets for the customers
and include their attachments together with the steps to replicate their issues. 
To solve this problem, I would like to use ScriptRunner's mail handler to automatically extract the contents of the emails 
received, including image attachments, and add them in the description field to display the steps to replicate the issue.
This script helps me to do so.

## Script

```groovy

import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.util.JiraHome
import com.atlassian.jira.event.type.EventDispatchOption
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.service.services.file.FileService
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.mail.MailUtils
import org.apache.commons.io.FileUtils

//Set the user's name that you want to invoke
final def user_name = '<USER_NAME>'
//Set the key for the project you want to invoke
final def project_key = '<PROJECT_KEY>'
//Set the name of the Issue Type that you want to use
final def issueTypeName = '<ISSUE_TYPE_NAME>'

def userManager = ComponentAccessor.userManager
def projectManager = ComponentAccessor.projectManager
def issueManager = ComponentAccessor.issueManager
def issueFactory = ComponentAccessor.issueFactory
def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)
def jiraHome = ComponentAccessor.getComponent(JiraHome)

def subject = message.subject as String
def issue = ServiceUtils.findIssueObjectInString(subject) as MutableIssue

if (issue) {
    return
}

def user = userManager.getUserByName(user_name)
def reporter1 = messageUserProcessor.getAuthorFromSender(message) ?: user
def project = projectManager.getProjectObjByKey(project_key)

def issueObject = issueFactory.issue
issueObject.setProjectObject(project)
issueObject.setSummary(subject)
issueObject.setDescription(MailUtils.getBody(message))
issueObject.setIssueTypeId(project.issueTypes.find { it.name == issueTypeName }.id)
issueObject.setReporter(reporter1)
issue = messageHandlerContext.createIssue(user, issueObject)  as MutableIssue

def attachments = MailUtils.getAttachments(message)

def issueDescription = new StringBuilder(issue.description).append('\n')

attachments.eachWithIndex { item, index ->
    def file = FileUtils.getFile(item.filename) as File
    FileUtils.writeByteArrayToFile(file, item.contents)
    messageHandlerContext.createAttachment(file, item.filename, item.contentType, user, issue)
    if (item.filename.endsWith('.png') || item.filename.endsWith('.jpg') || item.filename.endsWith('.jpeg') || item.filename.endsWith('.gif') ) {
        issueDescription.append("Step ${index + 1}: \n!${item.filename}|thumbnail!\n")
    } else {
        issueDescription.append("Step ${index + 1}: \n[^${item.filename}]\n")
    }
}

def destination = new File(jiraHome.home, FileService.MAIL_DIR).canonicalFile
FileUtils.forceDelete(destination.listFiles().first())

issue.setDescription(issueDescription.toString())
issueManager.updateIssue(user, issue, EventDispatchOption.DO_NOT_DISPATCH, false)
```

