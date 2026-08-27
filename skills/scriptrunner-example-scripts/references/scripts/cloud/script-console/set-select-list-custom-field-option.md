# Set Select List custom field option

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-set-select-list-custom-field-option-cloud
- Source: https://examples.scriptrunner.io/scripts/set-select-list-custom-field-option-cloud

## Overview

This example shows how to set the value of a Select List custom field on a work item.

## Example

As an administrator, I created a custom field called "Support Priority" which is a Single Select custom field with 
the options: "Low," "Medium," "High," and "Critical." The company's policy is to automatically set the "Support Priority" 
field to "High" for any ticket that comes from a premium customer.

## Good to Know

The script assumes that <OptionValueHere> option is already configurated for the custom field.

## Script

```groovy
// Specify the work item key to update
def workItemKey = 'WORK_ITEM_KEY'

// Specify the name of the select list field to set
def selectListFieldName = '<SelectListFieldNameHere>'

def workItem = WorkItems.getByKey(workItemKey)

workItem.update {
    setCustomFieldValue(selectListFieldName, '<OptionValueHere>')
}
```

