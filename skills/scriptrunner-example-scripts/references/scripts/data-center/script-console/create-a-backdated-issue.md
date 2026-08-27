# Create a Backdated Issue

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-a-back-dated-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-a-back-dated-issue-onPrem

## Overview

When a new issue is created, the creation date is set to the time and date of creation in Jira. This script allows you to set a creation date in the past.

## Example

I have imported some issues from one project to another. However, the creation date of these issues has now been set to the import date. I use this script to change the creation dates on these issues, so they are backdated to when they were initially created.

## Good to Know

The chosen date must be in the past. A future date can't be specified.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.MutableIssue

import java.sql.Timestamp
import java.time.LocalDateTime

def PROJECT_KEY = "TEST"
def YEAR = 2012
def MONTH = 12
def DAY = 21
def HOUR = 18 //This is server time (TimeZone)
def MINUTE = 6
def SECOND = 6

def SUMMARY = "The issue summary"
def DESCRIPTION = "The issue description"

def project = ComponentAccessor.projectManager.getProjectObjByKey(PROJECT_KEY)
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

Timestamp timestamp = Timestamp.valueOf(LocalDateTime.of(YEAR, MONTH, DAY, HOUR, MINUTE, SECOND))

if (project && timestamp) {
    MutableIssue issue = ComponentAccessor.issueFactory.issue
    issue.projectObject = project
    issue.summary = SUMMARY
    issue.created = timestamp
    issue.issueType = project.issueTypes.first()
    issue.description = DESCRIPTION
    ComponentAccessor.issueManager.createIssueObject(loggedInUser, issue)
}
```

