# Update the Epic Link for an Issue in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, fields
- Language: groovy
- Doc ID: example-dataCenter-basics-updating-epic-link-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-updating-epic-link-onPrem

## Overview

Automatically bulk update the epic link of a set of issues.

## Example

I have been working on multiple issues; however, I now need to move these issues into an epic. I can use this script to quickly edit the epic link instead of spending time doing this manually.

## Description

#### Overview
Automatically bulk update the epic link of a set of issues.

#### Example
I have been working on multiple issues; however, I now need to move these issues into an epic. I can use this script to quickly edit the epic link instead of spending time doing this manually.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.ModifiedValue
import com.atlassian.jira.issue.util.DefaultIssueChangeHolder

// the issue key of the issue that will be added to an epic
final String issueKey = "JRA-1"

// the issue key of the epic issue
final String epicIssueKey = "JRA-2"

// the name of the custom field to update (in our case is the Epic Link)
final String epicLinkFieldName = "Epic Link"

def issueManager = ComponentAccessor.issueManager
def issue = issueManager.getIssueByCurrentKey(issueKey)
def epic = issueManager.getIssueByCurrentKey(epicIssueKey)

def targetField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue).findByName(epicLinkFieldName)
assert targetField : "Could not find custom field with name $epicLinkFieldName"

targetField.updateValue(null, issue, new ModifiedValue(issue.getCustomFieldValue(targetField), epic), new DefaultIssueChangeHolder())
```

