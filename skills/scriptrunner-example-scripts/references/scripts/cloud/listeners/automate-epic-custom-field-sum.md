# Automate Epic Custom Field Sum

- Platform: cloud
- Feature: listeners
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-sum-custom-field-related-epic-issues-cloud
- Source: https://examples.scriptrunner.io/scripts/sum-custom-field-related-epic-issues-cloud

## Overview

Sum up the total of custom field values of all related epic work items, including sub-tasks.

## Example

There is a space that has a custom field named as "Cost". This custom field is available for all work types. When
a work item or sub-task is created or updated, you can define value of "Cost" field. If the work item or sub-task is related
with an epic, "Cost" field of the epic is automatically calculated and the result is the sum of all related work items and
sub-tasks "Cost" fields.

## Good to Know

* This script can be set as a listener for `Issue Created` and `Issue Updated`. So once a work item is created or updated
sum field value will be recalculated.
* Set up a script condition to prevent this script from running when updating Epic tasks
```
issue.issueType.name != 'Epic'
* Work items related with an epic are the ones that are children of the epic or children of those work items. 
To find all work items descendant from an Epic, we use the JQL function "linkedissue". 
But with this construct we need to remove the Epic itself from the results.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

//the name of the custom field. This code will work just as well with the custom field ID instead i.e. 10124L
def sumCustomFieldName = 'custom field name i.e. Sum of values'

//for regular work items the parent is an Epic
def epicKey = eventWorkItem.getParentObject()?.key ?: null

if(!epicKey) {
    // Checks the 'Epic Link' custom field
    epicKey = eventWorkItem.getEpic()?.key ?: null
}

if (!epicKey && eventWorkItem.issueType.subtask) {
    epicKey = eventWorkItem.parentObject?.epic?.key ?: null
}

if (!epicKey) {
    logger.info("We did not find an Epic in the hierarchy of this work item. Exiting.")
    return
}

// Find the epic work item
def epicWorkItem = WorkItems.search("key = ${epicKey}").first()
if (!epicWorkItem) {
    throw new IllegalStateException("Epic work item not found for key ${epicKey}")
}

// Sum all work items linked to the epic, taking care to exclude the epic
def sum = WorkItems.search("linkedissue = ${epicKey}").sum { workItem ->
    if (workItem.key == epicKey) return 0
    workItem.getCustomFieldValue(sumCustomFieldName) ?: 0
}

epicWorkItem.update {
    setCustomFieldValue(sumCustomFieldName, sum)
}
```

