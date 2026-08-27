# Bulk Delete Custom Fields According to the Field Name

- Platform: data-center
- Feature: script-console
- Tags: administer, fields
- Language: groovy
- Doc ID: example-dataCenter-bulk-delete-custom-fields-onPrem
- Source: https://examples.scriptrunner.io/scripts/bulk-delete-custom-fields-onPrem

## Overview

This script first searches for custom fields names that match with first name specified in the variable, and adds them to a list.  
It then filters the list and removes any null value. The filtered result will be iterated once again and all the 
custom fields that match the names list will be deleted.

## Example

As a Jira Administrator, I have to manage many custom fields that are created for the projects. As time goes on, 
some of the fields become invalid due to completion or termination of a project and I would like to be able to delete 
all those custom fields in one go by only having to specify a common first name of the fields. This script helps me to do so.

## Description

#### Overview
This script first searches for custom fields names that match with first name specified in the variable, and adds them to a list.  
It then filters the list and removes any null value. The filtered result will be iterated once again and all the 
custom fields that match the names list will be deleted.

#### Example
As a Jira Administrator, I have to manage many custom fields that are created for the projects. As time goes on, 
some of the fields become invalid due to completion or termination of a project and I would like to be able to delete 
all those custom fields in one go by only having to specify a common first name of the fields. This script helps me to do so.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def customFieldManager = ComponentAccessor.customFieldManager
def customFieldObjects = customFieldManager.customFieldObjects

/*
Specify the starting characters for the names of the custom fields that you intend to remove
For example, if the value is set to Test, then all the custom fields that begin with the name Test will be included
into the list and removed
 */
final def custom_field_name_starts_with = '<STARTING_CHARACTERS_IN_CUSTOM_FIELD_NAME>'

def filteredField = customFieldObjects.collect {
    if (it.name.startsWith(custom_field_name_starts_with)) {
        it.name
    }
}.findResults { it } //This is to remove all null values from the List

filteredField.each {
    def field = customFieldManager.getCustomFieldObjectsByName(it).first()
    customFieldManager.removeCustomField(field)
}
```

