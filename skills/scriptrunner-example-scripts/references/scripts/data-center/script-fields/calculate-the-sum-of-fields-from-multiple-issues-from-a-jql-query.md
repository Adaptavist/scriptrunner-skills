# Calculate the Sum of Fields from Multiple Issues from a JQL Query

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-calculate-sum-of-fields-onPrem
- Source: https://examples.scriptrunner.io/scripts/calculate-sum-of-fields-onPrem

## Overview

This script sums up the values of several customs fields across all sub-tasks, displaying the result in the parent issue.

## Example

I work on a large project with multiple colleagues working in different areas. I need to keep track of the total
time spent on an issue. Using this script, I can display the sum of all sub-task time tracking fields on the parent issue.

## Good to Know

* (Server) Use 'Number Field' as the template for the custom script field and 'Number Range' as the searcher.
* (Cloud) The custom field is created as the 'Number Field' and the script is added as a listener for 'Issue Updated'
and `Issue Created` event.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue

// sum up the values of this custom field
final customFieldName = 'Amount Paid'

def subtasks = issue.subTaskObjects

// if the issue doesn't have any sub-tasks or is a subtask itself then no need for action
if (!subtasks) {
    return
}

def firstSubtask = subtasks.first()
def customField_ = ComponentAccessor.customFieldManager.getCustomFieldObjects(firstSubtask).findByName(customFieldName)
if (!customField_) {
    log.info "Custom field with name $customFieldName is not configured for issue type $firstSubtask.issueType.name and project $firstSubtask.projectObject.key"
    return null
}

subtasks.sum { Issue it -> it.getCustomFieldValue(customField_) ?: 0 }
```

