# Control Form Field Based on Selected Checkbox Value

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-control-field-selected-checkbox-onPrem
- Source: https://examples.scriptrunner.io/scripts/control-field-selected-checkbox-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Using this script, control a custom field (make it read-only, required, hidden, etc.) based on checkbox values.
selected in a checkbox.

## Example

As an help-desk manager, I want users to indicate what additional equipment do they need in their computer aquisition requests
and their reason for needing it.
I can use this script to enforce reporters to fill the *Reason* field when they select the *Additional Equipment* checkbox field.

## Good to Know

* Associate this script with a checkbox field, so it gets executed everytime the selected values change.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

// Get the logger and set the log level
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

// The name of the field to populate base on the value selected in the checkbox field associated with the script
final otherFieldName = 'Reason'

// Get the fields
def otherField = getFieldByName(otherFieldName)
def checkBoxField = getFieldById(fieldChanged)
def checkBoxFieldValue = checkBoxField.value

// Collect the selected checkbox values
log.debug("The checkbox field value: '${checkBoxFieldValue}' of type '${checkBoxFieldValue.class.simpleName}'")
def chosenValuesList = []
if (checkBoxFieldValue in String) {
    chosenValuesList.add(checkBoxFieldValue)
} else if (checkBoxFieldValue in ArrayList) {
    chosenValuesList.addAll(checkBoxFieldValue)
}

// If the user has selected "None" and nothing else, don't force to populate the other field:
if (chosenValuesList == ['None']) {
    checkBoxField.clearError()
    otherField.setRequired(false)
    otherField.setHidden(true)

// If the user has selected "None" and another value, show an error:
} else if ('None' in chosenValuesList) {
    checkBoxField.setError('You cannot select another value if "None" is selected"')
    otherField.setRequired(false)
    otherField.setHidden(true)

// If the user didn't select any value, or has selected some values, but NOT the "None" value, force to populate the other field:
} else {
    checkBoxField.clearError()
    otherField.setHidden(false)
    otherField.setRequired(true)
}
```

