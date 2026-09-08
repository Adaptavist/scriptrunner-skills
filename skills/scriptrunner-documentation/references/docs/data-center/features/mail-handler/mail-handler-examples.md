# Mail Handler Examples

- Platform: data-center
- Space: SR4JS
- Hierarchy: features > mail-handler
- Doc ID: doc-sr4js-443374195
- Source: https://docs.adaptavist.com/sr4js/latest/features/mail-handler/mail-handler-examples

## Find existing issue

This simple example reads incoming emails and tries to find an existing issue based on the email subject, and creates a new issue if it does not exist. This example illustrates the use of [`MessageUserProcessor`](https://docs.atlassian.com/software/jira/docs/api/7.13.1/com/atlassian/jira/service/util/handler/MessageUserProcessor.html) and [`MessageHandlerContext`](https://docs.atlassian.com/software/jira/docs/api/7.13.1/com/atlassian/jira/service/util/handler/MessageHandlerContext.html).  

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.atlassian.mail.MailUtils

def userManager = ComponentAccessor.getComponent(UserManager)
def projectManager = ComponentAccessor.getProjectManager()
def issueFactory = ComponentAccessor.getIssueFactory()
def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)

def subject = message.getSubject() as String
def issue = ServiceUtils.findIssueObjectInString(subject) // <1>

if (issue) {
    return // <2>
}

ApplicationUser user = userManager.getUserByName("admin")
ApplicationUser reporter = messageUserProcessor.getAuthorFromSender(message) ?: user // <3>
def project = projectManager.getProjectObjByKey("SRTESTPRJ")

def issueObject = issueFactory.getIssue()
issueObject.setProjectObject(project)
issueObject.setSummary(subject)
issueObject.setDescription(MailUtils.getBody(message))
issueObject.setIssueTypeId(project.issueTypes.find { it.name == "Bug" }.id)
issueObject.setReporter(reporter)

messageHandlerContext.createIssue(user, issueObject) // <4>
```

**Line 14:** Uses the [`ServiceUtils#findIssueObjectInString`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/ServiceUtils.html#findIssueObjectsInString-java.lang.String-) function to get the issue from the subject.

**Line 17:** If the issue mentioned in the subject exists, do nothing.

**Line 21:** Calls [`MessageUserProcessor#getAuthorFromSender`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/handler/MessageUserProcessor.html#getAuthorFromSender-javax.mail.Message-) to get the author.

**Line 31:** Uses the binding variable [`MessageHandlerContext`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/handler/MessageHandlerContext.html) to create a new issue issue.

## Create issue with attachments

The following example is similar to the previous example but it shows how to create attachments for an issue from the available attachments in a message.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.util.JiraHome
import com.atlassian.jira.service.services.file.FileService
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.service.util.handler.MessageUserProcessor
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.atlassian.mail.MailUtils
import org.apache.commons.io.FileUtils

def userManager = ComponentAccessor.getComponent(UserManager)
def projectManager = ComponentAccessor.getProjectManager()
def issueFactory = ComponentAccessor.getIssueFactory()
def messageUserProcessor = ComponentAccessor.getComponent(MessageUserProcessor)
JiraHome jiraHome = ComponentAccessor.getComponent(JiraHome)

def subject = message.getSubject() as String
def issue = ServiceUtils.findIssueObjectInString(subject)

if (issue) {
    return
}

ApplicationUser user = userManager.getUserByName("admin")
ApplicationUser reporter = messageUserProcessor.getAuthorFromSender(message) ?: user
def project = projectManager.getProjectObjByKey("SRTESTPRJ")

def issueObject = issueFactory.getIssue()
issueObject.setProjectObject(project)
issueObject.setSummary(subject)
issueObject.setDescription(MailUtils.getBody(message))
issueObject.setIssueTypeId(project.issueTypes.find { it.name == "Bug" }.id)
issueObject.setReporter(reporter)
issue = messageHandlerContext.createIssue(user, issueObject) // <1>

def attachments = MailUtils.getAttachments(message) // <2>

attachments.each { MailUtils.Attachment attachment ->
    def destination = new File(jiraHome.home, FileService.MAIL_DIR).getCanonicalFile()
    def file = FileUtils.getFile(destination, attachment.filename) as File // <3>
    FileUtils.writeByteArrayToFile(file, attachment.contents)
    messageHandlerContext.createAttachment(file, attachment.filename, attachment.contentType, user, issue) // <4>
}
```

**Line 34:** Uses the binding variable [`MessageHandlerContext`](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/handler/MessageHandlerContext.html) to create a new issue issue as the previous example.

**Line 36:** Retrieve all the attachments form the message using [`MailUtils#getAttachments`](https://docs.atlassian.com/atlassian-mail/1.9/apidocs/com/atlassian/mail/MailUtils.html#getAttachments\(javax.mail.Message\)) method.

**Line 40:** Create a temporary file in the mail import directory to write attachment content.

**Line 42:** [MessageHandlerContext#createAttachment](https://docs.atlassian.com/software/jira/docs/api/latest/com/atlassian/jira/service/util/handler/MessageHandlerContext.html#createAttachment-java.io.File-java.lang.String-java.lang.String-com.atlassian.jira.user.ApplicationUser-com.atlassian.jira.issue.Issue-) Creates and adds the attachment to the issue we have created before.

## Create users from CC and add to watchers

Let’s say the Jira does not have the user, and the user needs to be created. The following example reads addresses in the **CC** field of an email and creates users for any contacts not available:

This script is compatible with ScriptRunner version 10.x and above.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.opensymphony.util.TextUtils

import jakarta.mail.Address
import jakarta.mail.Message
import jakarta.mail.internet.InternetAddress

def userManager = ComponentAccessor.getComponent(UserManager)
def watcherManager = ComponentAccessor.getWatcherManager()

if (userManager.hasWritableDirectory()) { // <1>
    def subject = message.getSubject() as String
    def issue = ServiceUtils.findIssueObjectInString(subject)
    def addresses = message.getRecipients(Message.RecipientType.CC) as List<Address> // <2>

    if (!issue || !addresses) {
        return
    }

    addresses.each {
        InternetAddress internetAddress = it as InternetAddress // <3>
        def email = internetAddress.address
        if (TextUtils.verifyEmail(email)) {
            def fullName = internetAddress.getPersonal() ?: email // <4>
            def user = userManager.getUserByName(fullName)

            if (!user) {
                try {
                    user = messageHandlerContext.createUser(email, null, email, fullName, null) as ApplicationUser // <5>
                    log.debug "User '${user.name}' created"
                } catch (Exception ex) {
                    log.error("Cannot create user", ex)
                }
            }

            watcherManager.startWatching(user, issue) // <6>
        }
    }
}
```

This script is compatible with ScriptRunner versions 8.x to 9.x.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.service.util.ServiceUtils
import com.atlassian.jira.user.ApplicationUser
import com.atlassian.jira.user.util.UserManager
import com.opensymphony.util.TextUtils

import javax.mail.Address
import javax.mail.Message
import javax.mail.internet.InternetAddress

def userManager = ComponentAccessor.getComponent(UserManager)
def watcherManager = ComponentAccessor.getWatcherManager()

if (userManager.hasWritableDirectory()) { // <1>
    def subject = message.getSubject() as String
    def issue = ServiceUtils.findIssueObjectInString(subject)
    def addresses = message.getRecipients(Message.RecipientType.CC) as List<Address> // <2>

    if (!issue || !addresses) {
        return
    }

    addresses.each {
        InternetAddress internetAddress = it as InternetAddress // <3>
        def email = internetAddress.address
        if (TextUtils.verifyEmail(email)) {
            def fullName = internetAddress.getPersonal() ?: email // <4>
            def user = userManager.getUserByName(fullName)

            if (!user) {
                try {
                    user = messageHandlerContext.createUser(email, null, email, fullName, null) as ApplicationUser // <5>
                    log.debug "User '${user.name}' created"
                } catch (Exception ex) {
                    log.error("Cannot create user", ex)
                }
            }

            watcherManager.startWatching(user, issue) // <6>
        }
    }
}
```

**Line 14:** Checks there is at least one directory which allows creating a new user.

**Line 17:** Retrieves recipients from the message where recipient type is **CC.** 

**Line 24:** Casts the address as [InternetAddress](http://static.javadoc.io/javax.mail/javax.mail-api/1.5.6/javax/mail/internet/InternetAddress.html) which helps to get the email address, name etc.

**Line 27:** In the absence of a name in `InternetAddress` the email address is considered to be the full name of the user.

**Line 32:** Uses the `messageHandlerContext` binding variable to create the user.

**Line 39:** Uses `WatcherManager` to add the user to the issue watcher list.

## Change issue status

The following example shows how ScriptRunner _Mail Handler_ is used to change the status of an issue. This fits a scenario where an email is generated by a service or an automated system where the message body has a structured format. In this example, the email is generated by Bitbucket server to inform the reviewers that a pull request has been merged.

The email contains the name of the branch (containing the issue key) and the pull request status.

![](/sr4js/files/latest/443374195/443374193/1/1759242515000/pull-req-example.png)

The mail handler uses a regular expression to read the issue key and change the issue status to **Done**.

```
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.workflow.TransitionOptions
import com.atlassian.mail.MailUtils

def issueManager = ComponentAccessor.getIssueManager()
def workflowManager = ComponentAccessor.getWorkflowManager()
def issueService = ComponentAccessor.getIssueService()

def body = MailUtils.getBody(message) // <1>

def statusMatcher = /MERGED/ // <2>
def statusResult = body =~ /$statusMatcher/

def issueMatcher = /SRTESTPRJ-[0-9]*/ // <3>
def issueResult = body =~ /$issueMatcher/

if (statusResult.count && issueResult.count) { // <4>
    def issueKey = issueResult[0] as String

    def issue = issueManager.getIssueObject(issueKey)
    if (!issue) {
        return
    }

    def action = workflowManager.getWorkflow(issue).getActionsByName("Resolve Issue").first() // <5>
    assert action

    def adminUser = ComponentAccessor.userManager.getUserByName("admin")
    def transitionOptions = new TransitionOptions.Builder().skipConditions().skipPermissions().skipValidators().build()

    def validateTransition = issueService.validateTransition(adminUser, issue.id, action.id, issueService.newIssueInputParameters(), transitionOptions) // <6>
    def result = issueService.transition(null, validateTransition)

    if (result.errorCollection.hasAnyErrors()) {
        log.error "Error occurred while transitioning ${issue.key}"
    }
}
```

**Line 9:** Reads the mail body from the binding variable `message`. In this case, the `MailUtils` class has been used to get the mail body.

**Line 11:** Uses a regular expression to get the status of the pull request.

**Line 14:** Uses a regular expression to read the issue key from the branch name.

**Line 17:** Checks the result status for both of the matches above.

**Line 25:** Retrieves the desired workflow action, in this case, the **Done** action.

**Line 31:** Checks if the transition is valid.
