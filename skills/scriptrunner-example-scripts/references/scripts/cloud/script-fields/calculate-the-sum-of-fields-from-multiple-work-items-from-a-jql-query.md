# Calculate the Sum of Fields from Multiple Work Items from a JQL Query

- Platform: cloud
- Feature: script-fields
- Tags: customise, issue, fields, hapi
- Language: groovy
- Doc ID: example-cloud-calculate-sum-of-fields-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/calculate-sum-of-fields-cloud-cloud

## Overview

This script sums up the values of several customs fields across all sub-tasks, displaying the result in the parent work item.

## Example

I work in a large space with multiple colleagues working in different areas. I need to keep track of the total
time spent on a work item. Using this script, I can display the sum of all sub-task time tracking fields on the parent work item.

## Good to Know

* (Server) Use 'Number Field' as the template for the custom script field and 'Number Range' as the searcher.
* (Cloud) The custom field is created as the 'Number Field' and the script is added as a listener for 'Issue Updated'
and `Issue Created` event.

## Script

```groovy
// sum up the values of this custom field
final customFieldName = 'Amount Paid'
final parentWorkItemKey = 'Parent Work Item Key'

def parentWorkItem = WorkItems.getByKey(parentWorkItemKey)
def subtasks = parentWorkItem.subtasks

// if the work item doesn't have any sub-tasks or is a subtask itself then no need for action
if (subtasks.empty) {
    return
}
def customFieldId = parentWorkItem.getNames().find { it.value == customFieldName }.key
if (!customFieldId) {
    logger.info "Custom field with name $customFieldName is not configured for work item type ${parentWorkItem.issueType.name} and space ${parentWorkItem.getSpaceObject().name}"
    return
}

def sum = subtasks.sum { subtask ->
    subtask.getCustomFieldValue(customFieldName) ?: 0
}

parentWorkItem.update {
    setCustomFieldValue(customFieldName, sum)
}
```

