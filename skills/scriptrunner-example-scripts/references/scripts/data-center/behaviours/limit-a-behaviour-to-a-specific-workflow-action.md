# Limit a Behaviour to a Specific Workflow Action

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, workflow
- Language: groovy
- Doc ID: example-dataCenter-limit-behaviour-to-action-onPrem
- Source: https://examples.scriptrunner.io/scripts/limit-behaviour-to-action-onPrem

## Overview

Behaviours give you more control over fields in Jira. Use this script to customise how fields behave on a specific
workflow action.

## Example

As a project manager, I want to ensure that a specific custom field has been changed when a developer starts progress
on an issue.
I can use this to ensure that the behaviour specifying a field change is assigned to the *Start Progress* action.

## Good to Know

* This script makes the behaviour work only on the action(s) you specify.
* You can configure simple conditions through the UI by default, but are able to configure more complex operations
and conditions programatically.

## Script

```groovy
import groovy.transform.BaseScript
import com.onresolve.jira.groovy.user.FieldBehaviours

@BaseScript FieldBehaviours fieldBehaviours

final expectedActionName = 'Start Progress'
final expectedDestinationName = 'Done'
final fieldName = 'Some Field'

def field = getFieldByName(fieldName)

actionName == expectedActionName || destinationStepName == expectedDestinationName ?
    field.setRequired(true) :
    field.setRequired(false)
```

