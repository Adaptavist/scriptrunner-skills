# Get checkbox custom field option

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-get-checkbox-field-options-cloud
- Source: https://examples.scriptrunner.io/scripts/get-checkbox-field-options-cloud

## Overview

Get all of the values that have been set inside a checkbox custom field on a work item.

## Example

As a product manager I need to check if certain options have been selected in a definition of done checklist before a development ticket is marked as closed.

## Good to Know

This can be used as a script listener to check if the options required are set when a work item is created and to add a comment if they are not set.
In this case, the work item can be extracted from the *event* context variable (e.g.: *event.issue*)

## Script

```groovy
def workItemKey = "<WorkItemKeyHere>"
def customFieldName = "<CustomFieldNameHere>"

def workItem = WorkItems.getByKey(workItemKey)

def checkboxes = workItem.getCustomFieldValue(customFieldName) as List<Map>
checkboxes.value
```

