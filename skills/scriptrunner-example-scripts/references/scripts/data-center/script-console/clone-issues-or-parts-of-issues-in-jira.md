# Clone Issues or Parts of Issues in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-basics-clone-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-clone-issue-onPrem

## Overview

Use this script to clone attachments, subtasks, and custom fields when cloning an issue. To make it easier to track cloned issues, newly created issues are linked to the source issue with a 'Clones' issue link.

## Example

A bug has been fixed, and I need to file a Root Cause Analysis (RCA) ticket for this bug in another project. I want to copy over all the details and attachments from the original ticket. Using this script, I can easily clone the issue along with all its attachments, and custom fields.

## Description

#### Overview

Use this script to clone attachments, subtasks, and custom fields when cloning an issue. To make it easier to track cloned issues, newly created issues are linked to the source issue with a 'Clones' issue link.

#### Example

A bug has been fixed, and I need to file a Root Cause Analysis (RCA) ticket for this bug in another project. I want to copy over all the details and attachments from the original ticket. Using this script, I can easily clone the issue along with all its attachments, and custom fields.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.fields.CustomField

// the issue key of the issue to clone
final String originalIssueKey = "JRA-1"

// the summary of the new issue
final String newSummary = "A summary for the cloned issue"

// the empty map will clone all the custom fields from the original issue
final Map<CustomField, Optional<Boolean>> customFieldsToClone = [:]

final boolean cloneAttachments = true
final boolean cloneSubTasks = true
final boolean cloneLinks = true

def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def issueManager = ComponentAccessor.issueManager
def issueService = ComponentAccessor.issueService

def originalIssue = issueManager.getIssueByCurrentKey(originalIssueKey)

def validationResult = issueService.validateClone(loggedInUser, originalIssue, newSummary, cloneAttachments, cloneSubTasks, cloneLinks, customFieldsToClone)
assert validationResult.valid : validationResult.errorCollection

def result = issueService.clone(loggedInUser, validationResult)
assert result.valid : result.errorCollection
```

