# Get the Values of a Multi-Select Field

- Platform: data-center
- Feature: behaviours
- Tags: issue, fields
- Language: groovy
- Doc ID: example-dataCenter-get-values-multi-select-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-values-multi-select-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Use this script to retrieve the selected values of a multi-select field and perform actions based on them.

## Example

As a support engineer, I want users to update field descriptions based on which platforms a user has selected in a multi-select field.
For example, when multiple options are selected in the Platform select list, I want the SEN field description to update, notifying users they must provide SEN number for all chosen platforms.

## Good to Know

* Associate the script with a multi-select field.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours
def log = Logger.getLogger(getClass())

// Set log level
log.setLevel(Level.DEBUG)

def multiSelectField = getFieldByName('MultiSelectA')
// Value for a multi-select field will always be a list even if "None" is selected
def multiSelectFieldValue = multiSelectField.value as List

def description
// If value is null
if (multiSelectFieldValue == [null]) {
    description = 'Multi Select Field is set to None'

// If a given string is selected
} else if (multiSelectFieldValue == ["ABC"]) {
    description = 'Multi Select Field is set to ABC'

// If more than 1 value is selected
} else if ( multiSelectFieldValue.size() > 1 ) {
    description = 'Multi Select Field has more than 1 value selected'
}

log.debug(description)
multiSelectField.description = description
```

