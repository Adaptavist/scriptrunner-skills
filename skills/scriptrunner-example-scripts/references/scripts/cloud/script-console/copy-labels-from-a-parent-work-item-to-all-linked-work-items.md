# Copy Labels from a Parent Work Item to all linked work items

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-copy-labels-from-a-parent-issue-to-all-linked-issues-cloud
- Source: https://examples.scriptrunner.io/scripts/copy-labels-from-a-parent-issue-to-all-linked-issues-cloud

## Overview

Automate the copy of every labels from a work item to all of its linked work items.

## Example

I work as a product manager and I need to relate some bugs with the original feature. I classify these bugs with
labels, and I want to copy all labels from bugs to the original linked work item.

## Good to Know

* This script only works for outward links.

## Script

```groovy
// Specify the work item by key
def workItem = WorkItems.getByKey("TEST-9");
String[] labels = workItem.labels.collect{it.toString()}.toArray(new String[0]);

// Loop linked work items, outward links specifically
def successStatusByWorkItemKey = workItem.getOutwardLinks().collect { linkedWorkItem ->
    WorkItems.getByKey(linkedWorkItem.outwardIssue.key).update {
        setLabels (labels)
    }
    linkedWorkItem.outwardIssue.key
}

successStatusByWorkItemKey ? "Labels successfully copied to work items: ${successStatusByWorkItemKey}. \nPlease see the 'Logs' tab for more information on what work items were updated." :
        "No outward links found. No labels copied."
```

