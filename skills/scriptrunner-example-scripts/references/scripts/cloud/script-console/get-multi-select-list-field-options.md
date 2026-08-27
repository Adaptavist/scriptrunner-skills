# Get multi select list field options

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-get-multi-select-field-options-cloud
- Source: https://examples.scriptrunner.io/scripts/get-multi-select-field-options-cloud

## Overview

Get all of the values that have been set inside a multi select list custom field on a work item.

## Example

As a product manager I need to check if certain options have been selected in a multi select list custom field before a development ticket is marked as closed.

## Good to Know

This can be used as a script listener to check if the options required are set when a work item is created and to add a comment if they are not set.

## Script

```groovy
// Get the work item
def workItem = WorkItems.getByKey('<WorkItemKeyHere>')

// Get the custom field value for the work item by the custom field name i.e. "Teams To Notify Of This Change"
// We know that it is a multi select field and we cast the result to a Map so we can extract the value of each option
def values = workItem.getCustomFieldValue('<CustomFieldNameHere>') as Map

values*.value
```

