# Use Behaviours with the Sprint Field in Jira Software

- Platform: data-center
- Feature: behaviours
- Tags: customise, fields
- Language: groovy
- Doc ID: example-dataCenter-sprint-field-behaviours-onPrem
- Source: https://examples.scriptrunner.io/scripts/sprint-field-behaviours-onPrem

## Overview

This example sets *Assignee* as a required field when the *Sprint* field has a value.

## Example

As a project manager, I want someone to be assigned to all new tasks created in an active sprint.
With this script I can set the *Assignee* field as required in the creation form when the *Sprint* field has a value.

## Good to Know

* The *Sprint* field must be included in the issue creation screen.

## Script

```groovy
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

import static com.atlassian.jira.issue.IssueFieldConstants.*

@BaseScript FieldBehaviours fieldBehaviours

final sprintFieldName = 'Sprint'

def sprintField = getFieldByName(sprintFieldName)
def assigneeField = getFieldById(ASSIGNEE)

assigneeField.setRequired(sprintField.value as boolean)
```

