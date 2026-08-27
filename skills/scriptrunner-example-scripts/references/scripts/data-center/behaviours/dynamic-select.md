# Dynamic Select

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-dynamic-select-onPrem
- Source: https://examples.scriptrunner.io/scripts/dynamic-select-onPrem

## Overview

Create dynamic select lists. Dynamic select lists (single or multi-select) allow you to specify the options
displayed, depending on the selected single-select source option.

## Example

I am in charge of a support team and want to create a drop-down list that shows products as single-select options.
When a product is selected, the *Projects* select list only displays options relating to the product chosen in the *Product* field.
For example, if I select Jira as a product, only projects relating to the Jira product are available for selection.

## Good to Know

* This script is executed as behaviour.
* Select options can be customised with needed values.
* It can be used to customize single-select or multi-select options.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

final singleSelectName = 'Some Single Select'
final selectName = 'Other Single or Multi Select'

def cfManager = ComponentAccessor.customFieldManager
def optionsManager = ComponentAccessor.optionsManager

def singleSelectField = cfManager.getCustomFieldObjectsByName(selectName)[0]
def formSingleSelect = getFieldByName(singleSelectName)
def singleSelectValue = formSingleSelect?.value
def formSelect = getFieldByName(selectName)

// Make sure the fields we want to work with are on the form
if (!formSingleSelect && !formSelect) {
    return
}

// Must grab the relevant config given the current issue context and the custom field
def config = ComponentAccessor.fieldConfigSchemeManager.getRelevantConfig(issueContext, singleSelectField)
// Given config, grab a map of the possible options for the second select custom field
def options = optionsManager.getOptions(config)

// Define your preset options for each single select case using the format shown here.
// Just put the values, not the keys/IDs.
def optionSet1 = [
    'Option 1',
    'Option 2',
    'Option 3',
    'Option 4'
]
def optionSet2 = [
    'Option 2',
    'Option 3',
    'Option 4'
]
def optionSet3 = [
    'Option 2',
    'Option 4'
]

// Make sure the second field actually has options to set
if (!options) {
    return
}

// Set/use the appropriate optionSet, dependent on the value of the currently selected single select option
switch (singleSelectValue) {
// Notice: The optionSet that is used is changed in each case
// Change 'Single Select Option...' to match your single select's values.
    case 'Single Select Option 1':
        formSelect.setFieldOptions(options.findAll { it.value in optionSet1 }.collectEntries {
            [(it.optionId): it.value]
        })
        break
    case 'Single Select Option 2':
        formSelect.setFieldOptions(options.findAll { it.value in optionSet2 }.collectEntries {
            [(it.optionId): it.value]
        })
        break
    case 'Single Select Option 3':
        formSelect.setFieldOptions(options.findAll { it.value in optionSet3 }.collectEntries {
            [(it.optionId): it.value]
        })
        break
// Reset to default options if single select option is null or any other option that is not taken care of
    default:
        formSelect.setFieldOptions(options)
}
```

