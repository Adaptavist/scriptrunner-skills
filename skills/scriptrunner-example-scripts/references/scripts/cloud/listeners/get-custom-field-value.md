# Get Custom Field Value

- Platform: cloud
- Feature: listeners
- Tags: automate, fields, issue, hapi
- Language: groovy
- Doc ID: example-cloud-get-custom-field-value-cloud
- Source: https://examples.scriptrunner.io/scripts/get-custom-field-value-cloud

## Overview

This example shows how you can extract the value of a custom field for a work item using the custom field name.

Also, how to clear the value of a custom field using the custom field name.

## Good to Know

This script can be used in various contexts where you need to access custom field values of a work item or if you need to remove a value. 
It is useful for scripting tasks in Jira where you need to manipulate or report on custom field data.

## Description

#### Overview
This example shows how you can extract the value of a custom field for a work item using the custom field name.

Also, how to clear the value of a custom field using the custom field name.

#### Good to know

This script can be used in various contexts where you need to access custom field values of a work item or if you need to remove a value. 
It is useful for scripting tasks in Jira where you need to manipulate or report on custom field data.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)
def expectedValue = 'some value you expect to see in the custom field'

//get custom field value
def value = eventWorkItem.getCustomFieldValue('customFieldName')

//clear custom field value
if(value != expectedValue) {
    eventWorkItem.update {
        eventWorkItem.clearCustomFieldValue('customFieldName')
    }
}
```

