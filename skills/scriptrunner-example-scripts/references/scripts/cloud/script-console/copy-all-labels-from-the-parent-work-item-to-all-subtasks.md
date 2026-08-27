# Copy all labels from the parent work item to all subtasks

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-copy-labels-from-parent-to-subtasks-cloud
- Source: https://examples.scriptrunner.io/scripts/copy-labels-from-parent-to-subtasks-cloud

## Overview

Copy all the labels from the parent work item to all subtask work items.

## Example

As a product manager whenever I add a new label to the parent work item I want it to automatically be propagated to all the subtasks.

## Good to Know

* This example can also be run as a *Script Listener* on the *Issue Created* or *Issue Updated* event to copy field values when a work item is created or updated automatically. 
* When running as a listener the *issue* object (the work item) can be extracted from the context variable *event* (*event.issue*)

## Script

```groovy
// Specify the work item key
def workItem = WorkItems.getByKey("DEMO-1");
String[] labels = issue.labels.collect { it.toString() }.toArray(new String[0]);

// Loop linked work item, outward links specifically
def successStatusByWorkItemKey = workItem.getSubTaskObjects().collect { subtask ->
    subtask.update {
        setLabels (labels)
    }
    subtask.key
}

successStatusByWorkItemKey ? "Labels successfully copied to issues: ${successStatusByWorkItemKey}. \nPlease see the 'Logs' tab for more information on what work items were updated." :
        "No subtask found. No labels copied."
```

