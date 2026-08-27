# Set a Default Option on a Select List

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-set-select-list-behaviour-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-select-list-behaviour-onPrem

## Overview

*Behaviours* allow you to change how fields behave on *Create Issue* or *Update Issue* screens.
Set the default option on single-select or multi-select lists and radio button custom fields using this script in a ScriptRunner Behaviour.

## Example

As a project manager, I want to make it easier for my team to fill out *Create Issue* and *Update Issue* screens. For example, I have a **Working Hours** field, and I want to specify the most commonly selected option (*Normal*) as the default value. I can use this script to set the default for this field to be *Normal*, saving time and effort for my team.

## Good to Know

* Set up this script as an initialiser.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

// a single select list custom field name
final String fieldName = "Select List"

// the value to set
final String setValue = "Some Value"

def field = getFieldByName(fieldName)

def optionsManager = ComponentAccessor.optionsManager
def customField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issueContext.projectId, issueContext.issueTypeId).find {
    it.name == fieldName
}

assert customField : "Could not find custom field with name $fieldName"

def fieldConfig = customField.getRelevantConfig(issueContext)
def options = optionsManager.getOptions(fieldConfig)
def option = options.find { it.value == setValue }

assert option : "Could not find option with value $setValue"

field.setFormValue(option.optionId)
```

