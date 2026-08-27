# Create Sub-tasks when a Work Item is Created

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-create-subtasks-when-issue-created-cloud
- Source: https://examples.scriptrunner.io/scripts/create-subtasks-when-issue-created-cloud

## Overview

This script automatically creates sub-tasks when a new work item is created.

## Example

I require a set of sub-tasks to be added to each new work item I create. Usually, I have to create these sub-tasks manually,
which is time consuming. Using this script I can automate the process, creating sub-tasks for each new work item without
the need for manual configuration.

## Good to Know

* This script can be set as a listener for `Issue Created` event.
* This script is not executed when sub-tasks are created. You can prevent ScriptRunner from running this script on Subtasks by adding a script condition:
  ```
  issue.issueType.name != 'Sub-task'
  ```
* Sub-tasks are added to a particular work item with the same type as parent work item.
* This script works with the `Company Managed` space type in Jira Cloud.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

if (eventWorkItem.issueType.subtask) { // If the newly created work item is a subtask, skip the execution
    return
}

def listOfSummaries = ['Subtask summary 1', 'Subtask summary 2'] // The summaries to use for
def subtaskWorkItemType = 'Sub-task' // The Sub Task Work Item Type to Use

def spaceKey = eventWorkItem.getSpaceObject().key

listOfSummaries.forEach { summary ->
    eventWorkItem.createSubTask(subtaskWorkItemType) {
        setSummary(summary)
    }
}
```

