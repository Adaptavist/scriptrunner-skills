# Calculate Total Value of Selected Checkboxes

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-calculate-numbers-from-selected-checkbox-onPrem
- Source: https://examples.scriptrunner.io/scripts/calculate-numbers-from-selected-checkbox-onPrem

## Overview

Calculate the total value of selected checkboxes when the user has selected at least one option from a checkbox field. A new field is auto-populated after the user has selected at least one option from the checkbox.

## Example

As a Finance manager, I want to know the total cost of the employee's expenses. When they select expenses options from the checkbox menu, I want those values added together and displayed in a Total Cost field.

## Good to Know

The example below is using two types of fields. One checkbox field is the list of expenses, and the other one is a single line custom field called Total Cost which will be auto-populated.

## Script

```groovy
import org.apache.log4j.Level

log.setLevel(Level.DEBUG)

def textField = getFieldByName('Total Expenses')
def checkBoxField = getFieldById(fieldChanged)
def checkBoxFieldValue = checkBoxField.value

def isCollection = checkBoxFieldValue instanceof Collection
log.debug "Instance of Collection: ${isCollection}"

def total = 0

// If selected more than 1 field
if (isCollection) {
    def checkBoxFieldValueList = checkBoxFieldValue as List
    log.debug "checkBoxFieldValue: ${checkBoxFieldValueList}"

    if (checkBoxFieldValueList.contains('House')) {
        total += 100
    }

    if (checkBoxFieldValueList.contains('Car')) {
        total += 200
    }

    if (checkBoxFieldValueList.contains('Insurance')) {
        total += 300
    }

// If selected 1 field only
} else {
    def checkBoxFieldValueString = checkBoxFieldValue.toString()
    log.debug "checkBoxFieldValue: ${checkBoxFieldValueString}"

    if (checkBoxFieldValue == 'House') {
        total += 100
    }

    if (checkBoxFieldValueString == 'Car') {
        total += 200
    }

    if (checkBoxFieldValueString == 'Insurance') {
        total += 300
    }
}

log.debug "Current total: ${textField.value}"
log.debug "total: ${total}"

textField.setFormValue(total)
```

