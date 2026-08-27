# Set a Default Option on a Cascading Select List

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-set-cascading-select-behaviour-onPrem
- Source: https://examples.scriptrunner.io/scripts/set-cascading-select-behaviour-onPrem

## Overview

Behaviours allow you to change how fields behave on *Create Issue* or *Update Issue* screens.
Set the default option on a cascading-select custom field using this script in a ScriptRunner Behaviour.

## Example

As a project manager, I want to make it easier for my team to fill out *Create Issue* and *Update Issue* screens.
For example, I have a **Product Project** field, and I want to specify the most commonly selected option (SR4JS, Support)
as the default value. I can use this script to set the default for this field to be *SR4JS* (Product), *Support* (Project),
saving time and effort for my team.

## Good to Know

* Set up this script as an initialiser.
* A cascade-select custom field and options must exist for the associated project.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

// the cascading select field that you want to set
final  fieldName = 'Cascading Select'

// parent value that you want to select
final  parentValue = 'AAA'

// child value that you want to select
final  childValue = 'A1'

def field = getFieldByName(fieldName)
def optionsManager = ComponentAccessor.optionsManager
def customField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issueContext.projectId, issueContext.issueTypeId).findByName(fieldName)

assert customField : "Could not find custom field with name $fieldName"

def fieldConfig = customField.getRelevantConfig(issueContext)
def options = optionsManager.getOptions(fieldConfig)

// find the Cascading Select options with those values
def parentOption = options.find { it.value == parentValue }
def childOption = parentOption?.childOptions?.find { it.value == childValue }

assert parentOption && childOption : 'One ore more of the given option values are not available'

field.setFormValue([parentOption.optionId, childOption.optionId])
```

