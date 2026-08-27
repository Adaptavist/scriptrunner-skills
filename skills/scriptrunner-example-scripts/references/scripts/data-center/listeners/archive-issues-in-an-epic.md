# Archive Issues in an Epic

- Platform: data-center
- Feature: listeners
- Tags: issue, project
- Language: groovy
- Doc ID: example-dataCenter-archive-issues-in-epic-onPrem
- Source: https://examples.scriptrunner.io/scripts/archive-issues-in-epic-onPrem

## Overview

This sample code enables a user to archive the issues that are currently in an Epic if the Epic itself has been archived.

## Example

As a Jira user, I want to automatically archive issues in Epic if the Epic itself has been archived.

## Description

#### Overview
This sample code enables a user to archive the issues that are currently in an Epic if the Epic itself has been archived.

#### Example
As a Jira user, I want to automatically archive issues in Epic if the Epic itself has been archived.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.archiving.ArchivedIssueService
import com.atlassian.greenhopper.manager.issuelink.EpicLinkManager

import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.customisers.JiraAgileBean

@WithPlugin("com.pyxis.greenhopper.jira")

@JiraAgileBean
EpicLinkManager epicLinkManager

def archivedIssueService = ComponentAccessor.getComponent(ArchivedIssueService)
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser

def epicIssue = event.issue // the epic issue
def epicType = epicIssue.issueType.name.toString()

if (epicType != 'Epic') {
    return
}

def issuesInEpic = epicLinkManager.getIssuesInEpic(epicIssue)

issuesInEpic.each {
    def validationArchive = archivedIssueService.validateArchiveIssue(user, it.key, false)

    if (validationArchive.valid) {
        archivedIssueService.archiveIssue(validationArchive)
    }
}
```

