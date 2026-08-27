# Copy Field Value from Parent Issue to Sub-task Upon Creation

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, fields, workflow
- Language: groovy
- Doc ID: example-dataCenter-copy-value-from-parent-issue-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-value-from-parent-issue-onPrem

## Overview

Copy any field value from a parent issue to a newly created sub-task.

## Example

I have a custom field which dictates which components of work are needed. This information is the same for both parent issues and sub-tasks. This script means I don't need to enter these manually each time.

## Good to Know

* Implement this as the first post function on the Create step of a workflow.
* fieldNameToCopy: Is the field name of the value to be copied.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.IssueFieldConstants
import com.atlassian.jira.issue.fields.FieldManager

// the name of the field whose value we want to copy from parent to subtask
final String fieldNameToCopy = "Component/s"

FieldManager fieldManager = ComponentAccessor.fieldManager

if (!issue.subTask) {
    return
}

def fieldToCopy = fieldManager.allAvailableNavigableFields.find { it.name == fieldNameToCopy }
if (!fieldToCopy) {
    log.info "Could not find field with name $fieldNameToCopy"
    return
}

def parentIssue = issue.parentObject
def fieldToCopyId = fieldToCopy.id

switch (fieldToCopyId) {
    case fieldManager.&isCustomFieldId:
        def customField = ComponentAccessor.customFieldManager.getCustomFieldObject(fieldToCopyId)
        def linkedIssueCustomFieldValue = parentIssue.getCustomFieldValue(customField)
        issue.setCustomFieldValue(customField, linkedIssueCustomFieldValue)
        break

    case IssueFieldConstants.COMPONENTS:
        issue.setComponent(parentIssue.components)
        break

    case IssueFieldConstants.FIX_FOR_VERSIONS:
        issue.setFixVersions(parentIssue.fixVersions)
        break

    case IssueFieldConstants.AFFECTED_VERSIONS:
        issue.setAffectedVersions(parentIssue.affectedVersions)
        break

    default:
        issue[fieldToCopyId] = parentIssue[fieldToCopyId]
}
```

