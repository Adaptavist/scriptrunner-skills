# Limit a Behaviour to a Specific Screen in Jira

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-limit-behaviour-to-screen-onPrem
- Source: https://examples.scriptrunner.io/scripts/limit-behaviour-to-screen-onPrem

## Overview

Behaviours define how fields behave for issues in a given project or issue context. Screens allow you to change
the displayed fields when creating an issue, editing an issue, or transitioning a workflow. This script allows you
to execute a specific behaviour logic inside a particular issue screen, such as a workflow transition.

## Example

Behaviours define how fields behave for issues in a given project or issue context. Screens allow you to change
the displayed fields when creating an issue, editing an issue, or transitioning a workflow. This script allows you
to execute a specific behaviour logic inside a particular issue screen, such as a workflow transition.

## Good to Know

I work in product support, and customers often report bugs. When transitioning bugs from one state to another,
such as *Open* to *In Progress*, I want to make the *Affects Version* field mandatory. I can use this behaviour script
to define this is a required field for specific transitions.

## Script

```groovy
import groovy.transform.BaseScript
import com.onresolve.jira.groovy.user.FieldBehaviours

@BaseScript FieldBehaviours fieldBehaviours

final String screenName = 'Some Screen Name'
final String fieldName = 'Some Field Name'
final String expectedValue = 'Some Value'

if (fieldScreen.name == screenName) {
    def field = getFieldByName(fieldName)
    field.value == expectedValue ? field.clearError() : field.setError('This is not a valid value')
}
```

