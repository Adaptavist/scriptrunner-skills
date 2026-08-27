# Create an attachment of email converted to an issue and include the email in the issue

- Platform: data-center
- Feature: email-handler
- Tags: email, issue
- Language: groovy
- Doc ID: example-dataCenter-create-attachment-of-email-converted-issue-and-include-in-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-attachment-of-email-converted-issue-and-include-in-issue-onPrem

## Overview

Converts the received email into a Jira ticket and also adds the email received as an attachment to the newly created ticket

## Example

When an email is received from the email address configured in the Mail Handler, that email will be
converted to an issue using the parameters set. The email is also added as an .eml file attached
to the newly created ticket. Once the ticket has been created, the eml file attached can be reopened as an email.
The eml file can then be downloaded and opened using a mail reader, e.g. Mozilla's Thunderbird.

## Description

#### Overview

Converts the received email into a Jira ticket and also adds the email received as an attachment to the newly created ticket
                              
#### Example

When an email is received from the email address configured in the Mail Handler, that email will be
converted to an issue using the parameters set. The email is also added as an .eml file attached
to the newly created ticket. Once the ticket has been created, the eml file attached can be reopened as an email.
The eml file can then be downloaded and opened using a mail reader, e.g. Mozilla's Thunderbird.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.util.JiraHome
import com.atlassian.jira.issue.MutableIssue
import com.atlassian.jira.issue.attachment.CreateAttachmentParamsBean
import com.atlassian.jira.service.services.file.FileService
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.mail.MailUtils
import javax.mail.Message
import javax.mail.Session
import javax.mail.internet.InternetAddress
import javax.mail.internet.MimeBodyPart
import javax.mail.internet.MimeMessage
import javax.mail.internet.MimeMultipart

//This requires the name of the user that will trigger the Mail Handler
final def username = '<USERNAME>'

//This requires the Project's Key that will be used for the Mail Handler
final def projectKey = '<PROJECT_KEY>'

//This requires the name of the Issue Type that will be used
final def issueTypeName = '<ISSUE_TYPE_NAME>'

//This requires the temporary file name. The file name should end with the .eml extension
final def temporaryAttachmentFileName = '<TEMPORARY_ATTACHMENT_FILE_NAME>'

//This requires the actual file name. The file name should end with the .eml extension
final def actualAttachmentFileName = '<ACTUAL_ATTACHMENT_FILE_NAME>'

//This requires the hostname for IMAP / POP server that is being used
final def mailHost = '<IMAP_OR_POP_HOSTNAME>'

//This requires the Email Port that is being used
final def mailPort = '<EMAIL_PORT>'

def userManager = ComponentAccessor.userManager
def projectManager = ComponentAccessor.projectManager
def attachmentManager = ComponentAccessor.attachmentManager
def issueFactory = ComponentAccessor.issueFactory
def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)
def jiraHome = ComponentAccessor.getComponent(JiraHome)

def user = userManager.getUserByName(username)
def reporter = messageUserProcessor.getAuthorFromSender(message) ?: user
def project = projectManager.getProjectObjByKey(projectKey)

def subject = message.subject
def from = message.from.join(',')
def to = message.allRecipients.join(',')
def messageBody = MailUtils.getBody(message)

static Message createMessage(String from, String to, String subject, String content, String mailHost, String mailPort) {
    def properties = System.properties
    properties.setProperty('mail.smtp.host', mailHost)
    properties.setProperty('mail.smtp.port', mailPort)
    def session = Session.getDefaultInstance(properties)
    def msg = new MimeMessage(session)
    msg.setFrom(new InternetAddress(from))
    msg.setRecipient(Message.RecipientType.TO, new InternetAddress(to))
    msg.setSubject(subject)
    def body = new MimeBodyPart()
    body.setText(content)
    msg.setContent(new MimeMultipart(body))
    msg
}

def issue = ServiceUtils.findIssueObjectInString(subject) as MutableIssue

if (issue) {
    return
}

def issueObject = issueFactory.issue
issueObject.setProjectObject(project)
issueObject.setSummary(subject)
issueObject.setDescription(messageBody)
issueObject.setIssueTypeId(project.issueTypes.find { it.name == issueTypeName }.id)
issueObject.setReporter(reporter)

issue = messageHandlerContext.createIssue(user, issueObject)  as MutableIssue

def destination = new File(jiraHome.home, FileService.MAIL_DIR).absoluteFile
def file = new File("${destination}/${temporaryAttachmentFileName}")
file.createNewFile()

def out = new FileOutputStream(file)

def emailContent = createMessage(from, to, subject, messageBody, mailHost, mailPort)
emailContent.writeTo(out)

def attachmentParams = new CreateAttachmentParamsBean.Builder("${destination}/${file.absoluteFile.name}" as File, actualAttachmentFileName, '', user, issue).build()
attachmentManager.createAttachment(attachmentParams)

file.delete()
```

