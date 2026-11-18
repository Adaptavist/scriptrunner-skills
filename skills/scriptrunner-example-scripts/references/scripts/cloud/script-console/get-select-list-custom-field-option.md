# Get select list custom field option

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, fields
- Language: groovy
- Doc ID: example-cloud-get-custom-field-option-cloud
- Source: https://examples.scriptrunner.io/scripts/get-custom-field-option-cloud

## Overview

This example shows how to retrieve the value of a select list custom field.

## Description

#### Overview
This example shows how to retrieve the value of a select list custom field.

## Script

```groovy
def workItemKey = 'KAN-1'
def customFieldName = 'myCustomField'

def customField = WorkItems.getByKey(workItemKey).getCustomFieldValue(customFieldName)

if (customField != null) {
    "The value of the select list from the ${customFieldName} custom field is: ${customField}"
} else {
    return "${customFieldName} field is null"
}
```

