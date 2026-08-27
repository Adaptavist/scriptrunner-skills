# Add Service Management Ticket Request Participants and Reporter as Watchers on Newly Linked Issues

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, user
- Language: groovy
- Doc ID: example-dataCenter-add-watchers-to-newly-linked-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-watchers-to-newly-linked-issues-onPrem

## Overview

Automate adding service management customers as watchers on newly linked non-service management issues.
Use this script as a listener with the IssueLinkCreatedEvent and configure it to listen for events in projects containing linked service management issues.
This will auto add service management issue customers as watchers on the non-service desk issues when the non-service desk issue is inward linked to a support desk issue via a specified link type.

## Example

I have a support management project and a software development project. I have created a link type named "Cause" with the outward description "caused by" and the inward description "causes".
When I link a bug to a support request using the "causes" inward link description, I want to automatically add the support issue customers to the bug as watchers so they will receive notifications when the bug has been fixed.

## Description

#### Overview
Automate adding service management customers as watchers on newly linked non-service management issues.
Use this script as a listener with the IssueLinkCreatedEvent and configure it to listen for events in projects containing linked service management issues.
This will auto add service management issue customers as watchers on the non-service desk issues when the non-service desk issue is inward linked to a support desk issue via a specified link type.

#### Example
I have a support management project and a software development project. I have created a link type named "Cause" with the outward description "caused by" and the inward description "causes".
When I link a bug to a support request using the "causes" inward link description, I want to automatically add the support issue customers to the bug as watchers so they will receive notifications when the bug has been fixed.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.event.issue.link.IssueLinkCreatedEvent
import com.atlassian.jira.issue.link.IssueLink
import com.atlassian.jira.user.ApplicationUser
import groovy.transform.Field

final requestParticipantsFieldName = 'Request participants'

@Field
final String LINK_TYPE = 'Cause'

def watcherManager = ComponentAccessor.watcherManager
def customFieldManager = ComponentAccessor.customFieldManager

if (event instanceof IssueLinkCreatedEvent) {
    def issueLink = (event as IssueLinkCreatedEvent).issueLink

    if (!isApplicable(issueLink)) {
        return
    }

    def sourceIssue = issueLink.sourceObject // service management issue
    def destinationIssue = issueLink.destinationObject // core or software issue

    def requestParticipantsCF = customFieldManager.getCustomFieldObjectsByName(requestParticipantsFieldName).first()
    def participants = sourceIssue.getCustomFieldValue(requestParticipantsCF) as List
    List<ApplicationUser> potentialWatchersToAdd = []
    potentialWatchersToAdd.add(sourceIssue.reporter)
    if (participants) {
        potentialWatchersToAdd.addAll(participants)
    }

    potentialWatchersToAdd.each { candidateWatcher ->
        watcherManager.startWatching(candidateWatcher, destinationIssue.refresh())
    }
}

Boolean isApplicable(IssueLink issueLink) {
    def service_desk_project_type_key = 'service_desk'
    def requiredLinkType = issueLink.issueLinkType.name == LINK_TYPE
    def destinationProjectNotServiceDesk = issueLink.destinationObject.projectObject.projectTypeKey.key != service_desk_project_type_key
    def sourceProjectIsServiceDesk = issueLink.sourceObject.projectObject.projectTypeKey.key == service_desk_project_type_key
    def supportIssueHasReporter = issueLink.sourceObject.reporter

    requiredLinkType && destinationProjectNotServiceDesk && sourceProjectIsServiceDesk && supportIssueHasReporter
}
```

