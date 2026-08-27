# Set Behaviour Multi and Single Select Options and Value

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-basics-behaviours-set-multi-select-options-value-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-behaviours-set-multi-select-options-value-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Use this script to restrict the options available, and set the default value of single or multi-select fields on
the Create or Update screen.

## Example

As a help-desk manager, I want to limit the select field options a user can pick at the time of creating an issue
and suggest a default value. I can use this script to restrict the options available in the pickers.

## Good to Know

* Set up this script as an initialiser.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

final singleSelectListName = 'SingleSelectList'
final multiSelectListName = 'MultiSelectList'

[singleSelectListName, multiSelectListName].each { selectFieldName ->
    // Get the select field
    def selectField = getFieldByName(selectFieldName)

    // Getting select field options
    def selectCustomField = customFieldManager.customFieldObjects.findByName(selectFieldName)
    def selectConfig = selectCustomField.getRelevantConfig(issueContext)
    def selectOptions = ComponentAccessor.optionsManager.getOptions(selectConfig)

    // Filter select available options
    final selectAvailableOptions = selectOptions.findAll { it.value in ['foo', 'bar', 'spam', 'pam'] }
    selectField.setFieldOptions(selectAvailableOptions)

    // Set the default values depending on select type
    if (selectFieldName == singleSelectListName) {
        def defaultValue = selectAvailableOptions.find { it.value == 'spam' }
        selectField.setFormValue(defaultValue.optionId)
    } else if (selectFieldName == multiSelectListName) {
        def defaultValues = selectAvailableOptions.findAll { it.value in ['foo', 'spam'] }
        selectField.setFormValue(defaultValues*.optionId)
    }
}
```

