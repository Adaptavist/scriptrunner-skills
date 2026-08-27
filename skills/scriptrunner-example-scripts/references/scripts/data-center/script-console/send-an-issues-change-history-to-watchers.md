# Send an Issue's Change History to Watchers

- Platform: data-center
- Feature: script-console
- Tags: automate, issue, email, reporting
- Language: groovy
- Doc ID: example-dataCenter-send-changehistory-to-watchers-onPrem
- Source: https://examples.scriptrunner.io/scripts/send-changehistory-to-watchers-onPrem

## Overview

Send an email to all watchers of an issue with the change history items in the last X days.
Edit the number of days to go back by changing the `lastDays` variable.
Modify the script to set the `jiraIssue` variable depending on where you add the script (for example, in a post function
use `issue.key` instead of `TEST-1`).

## Example

As a project manager, I want to keep track of all changes to my watched issues. I need to be up to date with who is
working on an issue and what has been changed. I do not want to check each watched issue manually. I can use this
script to send me an email with change history items weekly to keep informed.

## Description

#### Overview
Send an email to all watchers of an issue with the change history items in the last X days.
Edit the number of days to go back by changing the `lastDays` variable.
Modify the script to set the `jiraIssue` variable depending on where you add the script (for example, in a post function
use `issue.key` instead of `TEST-1`).

#### Example
As a project manager, I want to keep track of all changes to my watched issues. I need to be up to date with who is
working on an issue and what has been changed. I do not want to check each watched issue manually. I can use this
script to send me an email with change history items weekly to keep informed.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.mail.Email
import groovy.xml.MarkupBuilder
import java.time.LocalDate
import java.time.format.DateTimeFormatter

final jiraIssue = ComponentAccessor.issueManager.getIssueByCurrentKey("TEST-1")
final lastDays = 2

static sendEmail(String emailAddr, String subject, String body) {
    def mailServer = ComponentAccessor.mailServerManager
            .defaultSMTPMailServer
    if (mailServer) {
        def email = new Email(emailAddr)
        email.setMimeType("text/html")
        email.setSubject(subject)
        email.setBody(body)
        mailServer.send(email)
    }
}

def writer = new StringWriter()
def builder = new MarkupBuilder(writer)
builder.html {
    head {
        h1("Hi,")
    }
    body {
        p("I have some changes you might have missed.")
        def changeHistory = ComponentAccessor.changeHistoryManager.getChangeHistories(jiraIssue)
        p("Here is what changed:")
        changeHistory.each {
            def now = LocalDate.now()
            def formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss.[SSS][SS][S]")
            def dateToParse = it.timePerformed as String
            def parsedDate = LocalDate.parse(dateToParse, formatter)
            if (parsedDate < now.minusDays(lastDays)) {
                return
            }
            def change
            it.changeItems.each {
                change = "${it.field} changed from ${it.oldstring ?: 'nothing'} to ${it.newstring ?: 'nothing'}\n\t"
            }
            p("Date: ${parsedDate} | Author: ${it.authorDisplayName} | ${change}")
        }
    }
}
def watchers = ComponentAccessor.watcherManager.getWatchersUnsorted(jiraIssue)
watchers.each {
    sendEmail(it.emailAddress, "Changes", writer.toString())
}
```

