# Inherit Multi-user Picker Values from Parent in Sub-Task Create Form

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-behaviour-multi-user-parent-to-subtask-onPrem
- Source: https://examples.scriptrunner.io/scripts/behaviour-multi-user-parent-to-subtask-onPrem

## Overview

*Behaviours* allow you to change how fields behave on issue Create or Update screens.
Scripts can be associated with a field (executed when the field changes) or as an initialiser (executed once the form is opened).

Using this script, you can inherit the value of a multi-user picker field from a parent issue in the sub-task create form,
meaning the default value set in the sub-task creation form is taken from the parent issue.

## Example

As an admin, I want to suggest users to create sub-tasks with some of the same field values as their parent issue, for example,
a multi-user picker field for tracking stakeholders of an issue.
Using this script, I can set the *Stakeholders* field of the sub-task to replicate the parent issue field by default the default value of a sub-task in the form.

## Good to Know

* Associate the script with a field which doesn't have an initial default value in the form, such as the summary field,
  as it's not possible to read the current value of fields such as the parent issue id from an initialiser script.
* The script will do nothing once the value of the associated field is set, this way the script will execute only once when the form gets opened.
* The script body might get executed again if the value of the associated field is cleared.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.user.ApplicationUser
import com.onresolve.jira.groovy.user.FieldBehaviours
import org.apache.log4j.Logger
import org.apache.log4j.Level
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours
// Set log level
def log = Logger.getLogger(getClass())
log.setLevel(Level.DEBUG)

// Define the user picker field param
final multiUserPickerFieldName = 'Stakeholders'

// Get components
def issueManager = ComponentAccessor.issueManager
def customFieldManager = ComponentAccessor.customFieldManager

def changedFormField = getFieldById(fieldChanged)
def parentIssueFormField = getFieldById('parentIssueId')
def parentIssueId = parentIssueFormField.formValue as Long

log.debug("The parent issue id: ${parentIssueId}")
log.debug("The changed field form value: ${changedFormField.formValue}")
// Do nothing if the issue is not a subtask or the field associated with the script already has data
if (!parentIssueId || changedFormField.formValue) {
    return
}

// Get the parent issue
def parentIssue = issueManager.getIssueObject(parentIssueId)
// Get the value of the user picker in the parent issue
def parentIssueUserPickerCustomField = customFieldManager.getCustomFieldObjects(parentIssue)?.find { it.name == multiUserPickerFieldName }
def parentIssueUserPickerCustomFieldValue = (parentIssueUserPickerCustomField ? parentIssue.getCustomFieldValue(parentIssueUserPickerCustomField) : null) as List<ApplicationUser>

// Do nothing if the field doesn't have a value in the parent issue or it's not really an issue picker
if (!parentIssueUserPickerCustomFieldValue) {
    return
}

log.debug("The parent user picker values: ${parentIssueUserPickerCustomFieldValue*.username}")
def userPickerFormField = getFieldByName(multiUserPickerFieldName)
userPickerFormField.setFormValue(parentIssueUserPickerCustomFieldValue*.username)
```

