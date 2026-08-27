# Remove Specific Links from an Issue

- Platform: data-center
- Feature: script-console
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-remove-specific-links-from-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-specific-links-from-issue-onPrem

## Overview

The main feature of this code is to remove multiple linked issues of a specific link type.

## Example

As a Project Admin, I would like to remove the linked issues of a specific link type from the issue if they are not required anymore.
This script enables me to do so by running the script in the script console.

## Description

#### Overview
The main feature of this code is to remove multiple linked issues of a specific link type.
                                
#### Example
As a Project Admin, I would like to remove the linked issues of a specific link type from the issue if they are not required anymore.
This script enables me to do so by running the script in the script console.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

final def issueKey = '<ISSUE_KEY>'

//Specify the Link Type ID
final def linkTypeId = 10000

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issueManager = ComponentAccessor.issueManager
def issueLinkManager = ComponentAccessor.issueLinkManager

def issue = issueManager.getIssueObject(issueKey)

issueLinkManager.getOutwardLinks(issue.id).each {
    if (it.linkTypeId == linkTypeId) {
        issueLinkManager.removeIssueLink(it, loggedInUser)
    }
}
```

