# Add Comment To Unresolved Subtasks

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-add-comment-to-unresolved-issue-subtask-cloud
- Source: https://examples.scriptrunner.io/scripts/add-comment-to-unresolved-issue-subtask-cloud

## Overview

This example shows how you can add a comment to all unresolved subtasks.

## Description

#### Overview

This example shows how you can add a comment to all unresolved subtasks.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
def workItemSubtasks = currentWorkItem.subtasks

workItemSubtasks.forEach { subtask ->
    if (subtask.getStatus().name == "Done") {
        return
    }
    subtask.addComment("""Parent task ${issue.key} is resolved and has status: '${(currentWorkItem.status as Map).name}'.
        Please change status of this work item.""")
}
```

