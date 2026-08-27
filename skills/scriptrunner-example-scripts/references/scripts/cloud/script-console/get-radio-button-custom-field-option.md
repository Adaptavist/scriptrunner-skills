# Get radio button custom field option

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-get-radio-buttons-field-cloud
- Source: https://examples.scriptrunner.io/scripts/get-radio-buttons-field-cloud

## Overview

Get the value out of a radio button field

## Example

Return the value from the radio button field in order to populate other fields based on its value.

## Good to Know

* This code can also be used inside a Script Listener to update other fields automatically when an a value is set in a radio buttons field

## Script

```groovy
def workItemKey = "<WorkItemKeyHere>"
WorkItems.getByKey(workItemKey).getCustomFieldValue('<CustomFieldNameHere>').value
```

