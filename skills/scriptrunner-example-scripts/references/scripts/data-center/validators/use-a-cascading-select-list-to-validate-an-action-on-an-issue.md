# Use a Cascading Select List to Validate an Action on an Issue.

- Platform: data-center
- Feature: validators
- Tags: automate, workflow, fields
- Language: groovy
- Doc ID: example-dataCenter-validate-cascading-select-onPrem
- Source: https://examples.scriptrunner.io/scripts/validate-cascading-select-onPrem

## Overview

Use this simple scripted validator to enforce specific values in a *Cascading Select* field when an issue has a particular type.

## Example

As a project manager, I only want developers working on stories for the first step of a project (Project X).
To ensure work isn't started on other stages of Project X, I have added a validator on the Category cascading list in
the Issue Creation window. With this validator, I can ensure that when a Story ticket type is created, it must have
the Category value ProjectX - Step 1.

## Good to Know

* You can choose the issue type with which the field values are checked.
* You should create the *Cascade Select Field* with the same names added in the script

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.config.IssueTypeManager

// the name of the custom field
final customFieldName = 'CascadingSelect'

// the expected parent value of the Cascading Select custom field
final parentValue = 'AAA'

// the expected child value of the Cascading Select custom field
final childValue = 'A1'

// the name of the issue type we want to check
final issueTypeName = 'Task'

def issueType = ComponentAccessor.getComponent(IssueTypeManager).issueTypes.findByName(issueTypeName)
assert issueType: "Could not find issue type with name $issueTypeName"

// if the issue type is not the one we are looking for, return true
if (issue.issueType != issueType) {
    return true
}

def customField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue).findByName(customFieldName)
assert customField: "Could not find custom field with name $customFieldName"

def selectedOptions = issue.getCustomFieldValue(customField) as Map

// in order to obtain the value you need, you will need to specify the option parent level.
// parent options do not have an ancestor, so the parent level is always 'null'.
// the selected child option has an ancestor and the parent level is always '1'.
// if there are is a third level of options, in order to obtain the selected value, it would be '2'
def parentOptionLevel = null
def childOptionLevel = '1'

def selectedParentValue = selectedOptions.get(parentOptionLevel).toString()
def selectedChildParentValue = selectedOptions.get(childOptionLevel).toString()

selectedParentValue == parentValue && selectedChildParentValue == childValue
```

