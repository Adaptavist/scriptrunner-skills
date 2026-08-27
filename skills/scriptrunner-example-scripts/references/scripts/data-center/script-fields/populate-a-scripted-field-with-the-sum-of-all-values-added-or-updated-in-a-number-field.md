# Populate a Scripted Field with the Sum of All Values Added or Updated in a Number Field

- Platform: data-center
- Feature: script-fields
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-scripted-field-that-sums-up-all-the-values-inserted-in-a-number-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/scripted-field-that-sums-up-all-the-values-inserted-in-a-number-field-onPrem

## Overview

By default, when an issue is created, if no value is inserted into the number field configured in this script, the scripted field result is set to zero.
When a value is added or updated in the number field, the scripted field uses the Change History, gets all the "toString" values and sums it up.

## Example

As a project manager, I want to know the total expenses on a particular issue. This script enables me to calculate that total and populate a scripted field with it.

## Description

#### Overview
By default, when an issue is created, if no value is inserted into the number field configured in this script, the scripted field result is set to zero.
When a value is added or updated in the number field, the scripted field uses the Change History, gets all the "toString" values and sums it up.
 
#### Example
As a project manager, I want to know the total expenses on a particular issue. This script enables me to calculate that total and populate a scripted field with it.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def customFieldManager = ComponentAccessor.customFieldManager
def changeHistoryManager = ComponentAccessor.changeHistoryManager

final def numberFieldName = '<FIELD_NAME>'

def sampleNumber = customFieldManager.getCustomFieldObjectsByName(numberFieldName).first()
def sampleNumberValue = sampleNumber.getValue(issue)
def changeHistories = changeHistoryManager.getChangeHistories(issue)

if (!sampleNumberValue && changeHistories.size() == 0) {
    0
} else {
    changeHistories.collect { changeHistory ->
        def result = changeHistory.changeItemBeans.find {
            it.field == numberFieldName
        }
        def value = result['toString'].toString()
        value ? Long.parseLong(value) : 0
    }.sum()
}
```

