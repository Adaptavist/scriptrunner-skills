# Update Parent With Estimate Sum

- Platform: cloud
- Feature: listeners
- Tags: automate, hapi, issue, fields
- Language: groovy
- Doc ID: example-cloud-update-parent-with-estimate-sum-cloud
- Source: https://examples.scriptrunner.io/scripts/update-parent-with-estimate-sum-cloud

## Overview

This script updates the parent work item by summing the time estimates from all associated subtasks. 
It is designed to optimise performance by fetching only the necessary estimate fields during the work item search.
The script is lightweight and efficient, focusing on retrieving only the estimate fields, which reduces the time needed for the search operation.

## Example

I work in engineering, and we often have complex parent work items with multiple subtasks. 
Keeping the parent work item's time estimate up to date manually can be time-consuming. With this script, the parent work item 
is automatically updated whenever subtasks are modified, ensuring that we have an accurate sum of all the time estimates in real-time.

## Good to Know

If you want to restrict the script to work only within a specific space, you can use a condition like:
if (!(issue.subTask && issue.getProjectObject().key == '<SpaceKeyHere>')) {
  return;
}
This helps to limit the scope of the script, ensuring it only affects the intended space.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

def parent = eventWorkItem.parentObject
def subtasks = parent.subtasks
logger.info("Total subtasks for ${parent.key}: ${subtasks.size()}")

// Sum the estimates
def estimate = subtasks.sum { subtask ->
    subtask.getCustomFieldValue('Time Estimate') ?: 0
}
logger.info("Summed estimate: ${estimate}")

parent.update {
    setCustomFieldValue('Summed Subtask Estimate', estimate)
}
```

