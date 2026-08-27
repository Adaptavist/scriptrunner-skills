# Update Parent With Subtask Count

- Platform: cloud
- Feature: listeners
- Tags: automate, hapi, issue, fields
- Language: groovy
- Doc ID: example-cloud-update-parent-with-subtask-count-cloud
- Source: https://examples.scriptrunner.io/scripts/update-parent-with-subtask-count-cloud

## Overview

This script example automates the process of updating the parent work item with the count of its subtasks, 
saving from manually checking and updating it every time.

## Example

I work in engineering, and we often break down larger tasks into multiple subtasks for better tracking and delegation. 
To keep a clear overview, it's crucial to know how many subtasks a parent work item has. 
Whenever a new subtask is created, updated, or deleted, the parent work item should reflect the current count of its subtasks.

## Good to Know

The script can be triggered on most of the events related to work items (created, or deleted). From the dropdown
"On these events" in Script Listeners choose the preferred event related to work items.
When you update the parent work item, the "subtask count" field will automatically reflect the subtasks the work item contains.

If the work item you're modifying is the subtask, the script will update the count of subtasks in the parent of the current subtask.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

def workItemToUpdate = eventWorkItem.issueType.subtask ? eventWorkItem.parentObject : eventWorkItem

def subTasks = workItemToUpdate.getSubTaskObjects()
def subTaskCount = subTasks.size()

if(subTaskCount != workItemToUpdate.getCustomFieldValue("Subtasks Count")) {
    println("Total subtasks for ${workItemToUpdate.key}: ${subTaskCount}")
    workItemToUpdate.update {
        setCustomFieldValue("Subtasks Count", subTaskCount)
    }
}
```

