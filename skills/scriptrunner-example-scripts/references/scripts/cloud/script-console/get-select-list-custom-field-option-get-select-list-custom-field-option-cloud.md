# Get select list custom field option

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-cloud-get-select-list-custom-field-option-cloud
- Source: https://examples.scriptrunner.io/scripts/get-select-list-custom-field-option-cloud

## Overview

This example shows how to retrieve the value of a single select list custom field.

## Description

#### Overview

This example shows how to retrieve the value of a single select list custom field.

## Script

```groovy
def workItem = WorkItems.getByKey('<WorkItemKeyHere>')

// Get the custom field value for the work item by the custom field name i.e. "Change Reason"
def value = workItem.getCustomFieldValue('<CustomFieldNameHere>').value

// Return the option value
return "The value of the select list from the <CustomFieldNameHere> custom field is: ${value}"
```

