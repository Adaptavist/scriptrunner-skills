# Notify On Priority Change

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, automate, fields, email, reporting
- Language: groovy
- Doc ID: example-cloud-notify-on-priority-change-cloud
- Source: https://examples.scriptrunner.io/scripts/notify-on-priority-change-cloud

## Overview

This script demonstrates how to send notifications to users when the priority of a work item is changed in Jira. 
This ensures that all relevant stakeholders are promptly informed of critical updates to work item priority.

## Good to Know

There is a known Jira bug that can cause a 500 error if the work item lacks a reporter or assignee. 
To prevent this, the script includes checks for these fields, ensuring that notifications are only sent to valid recipients, 
avoiding disruptions in your workflow.

## Description

#### Overview
This script demonstrates how to send notifications to users when the priority of a work item is changed in Jira. 
This ensures that all relevant stakeholders are promptly informed of critical updates to work item priority.

#### Good to know
There is a known Jira bug that can cause a 500 error if the work item lacks a reporter or assignee. 
To prevent this, the script includes checks for these fields, ensuring that notifications are only sent to valid recipients, 
avoiding disruptions in your workflow.

## Script

```groovy
import groovy.xml.MarkupBuilder
import groovy.xml.XmlSlurper

def eventWorkItem = WorkItems.getByKey(issue.key as String)

Map priorityChange = changelog?.items.find { eventWorkItem.priority } as Map
if (!priorityChange) {
    logger.info("Priority was not updated")
    return
}

def fromPriority = priorityChange.fromString as String
def toPriority = priorityChange.toString as String

logger.info("Priority changed from ${fromPriority} to ${toPriority}")

if (toPriority == "Highest") {
    def writer = new StringWriter()
    // Note that markup builder will result in static type errors as it is dynamically typed.
    // These can be safely ignored
    def markupBuilder = new MarkupBuilder(writer)
    markupBuilder.div {
        p {
            // update url below:
            a(href: "http://myjira.atlassian.net/issue/${issue.key}", issue.key)
            span(" has had priority changed from ${fromPriority} to ${toPriority}")
        }
        p("You're important so we thought you should know")
    }
    def htmlMessage = writer.toString()
    def textMessage = new XmlSlurper().parseText(htmlMessage).text()

    logger.info("Sending email notification for work item {}", issue.key)

    def recipients = [:]

    if (eventWorkItem.reporter != null) {
        recipients.reporter = true
    }
    if (eventWorkItem.assignee != null) {
        recipients.assignee = true
    }
    if (eventWorkItem.watches != null && eventWorkItem.votes != null) {
        recipients.watches = true
        recipients.votes = true
    }
    // If no recipients were added, log a message
    if (recipients.isEmpty()) {
        logger.info("No valid recipients found for work item {}", issue.key)
        return
    }
    // Add users/groups to ensure at least one recipient
    recipients.users = [[name: 'admin']]
    recipients.groups = [[name: 'jira-administrators']]

    def resp = post("/rest/api/2/issue/${issue.id}/notify")
            .header("Content-Type", "application/json")
            .body([
                    subject: 'Priority Increased',
                    textBody: textMessage,
                    htmlBody: htmlMessage,
                    to: recipients
            ])
            .asString()

    assert resp.status == 204
}
```

