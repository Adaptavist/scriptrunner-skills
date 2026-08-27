# Automatically Add Epic Link into Issue of Certain Type

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-add-epic-link-to-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/add-epic-link-to-issue-onPrem

## Overview

This script adds an epic link issue into other issues with the type specified by user. This epic link is set in the
custom field called 'Epic Link' of the issue created with a certain type.

## Example

As a support engineer, I want all support issues to be associated with certain epic issues. With this script, I can
create an epic issue and link it to all issues with the issue type I specify.

## Description

#### Overview

This script adds an epic link issue into other issues with the type specified by user. This epic link is set in the
custom field called 'Epic Link' of the issue created with a certain type.

#### Example

As a support engineer, I want all support issues to be associated with certain epic issues. With this script, I can
create an epic issue and link it to all issues with the issue type I specify.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

// When you create an issue of issue type Story that will be under an Epic
final issueTypeName = "Story"

// The issue key of the Epic
final epicIssueKey = "EPIC-1"

if (issue.issueType.name != issueTypeName) {
    return
}

def epicLinkCustomField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue).findByName("Epic Link")
def newEpic = ComponentAccessor.issueManager.getIssueByCurrentKey(epicIssueKey)

issue.setCustomFieldValue(epicLinkCustomField, newEpic)
```

