# Copy field value from linked issue

- Platform: data-center
- Feature: post-functions
- Tags: automate, issue, fields, workflow
- Language: groovy
- Doc ID: example-dataCenter-copy-linked-issue-value-onPrem
- Source: https://examples.scriptrunner.io/scripts/copy-linked-issue-value-onPrem

## Overview

Use a post function to copy any field value from a linked issue to the issue in transition.

## Example

When an issue is updated, I want to assign a specific field of all linked issues to the same value which the updated issue now has.

## Good to Know

`fieldNameToCopy`: The field name of which the value will get copied. `issueLinkNameToSync`: The issue linked with that link type will be used as the source issue.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.IssueFieldConstants

// the name of the field to copy
final String fieldNameToCopy = "Priority"

// leave blank to copy from the last linked issue (regardless the link type)
final String issueLinkTypeName = "Blocks"

def fieldManager = ComponentAccessor.fieldManager

def fieldToCopy = fieldManager.allAvailableNavigableFields.find { it.name == fieldNameToCopy }
if (!fieldToCopy) {
    log.info "Could not find field with name $fieldNameToCopy"
    return
}

def linkedIssues = ComponentAccessor.issueLinkManager.getOutwardLinks(issue.id)
if (!linkedIssues) {
    log.info "There are no linked issues"
    return
}

if (issueLinkTypeName && !(issueLinkTypeName in linkedIssues*.issueLinkType*.name)) {
    log.info "Could not find any issue, linked with the $issueLinkTypeName issue type"
    return
}

def linkedIssue = issueLinkTypeName ?
    linkedIssues.findAll { it.issueLinkType.name == issueLinkTypeName }.last().destinationObject :
    linkedIssues.last().destinationObject

def fieldToCopyId = fieldToCopy.id

switch (fieldToCopyId) {
    case fieldManager.&isCustomFieldId:
        def customField = ComponentAccessor.customFieldManager.getCustomFieldObject(fieldToCopyId)
        def linkedIssueCustomFieldValue = linkedIssue.getCustomFieldValue(customField)
        issue.setCustomFieldValue(customField, linkedIssueCustomFieldValue)
        break

    case IssueFieldConstants.COMPONENTS:
        def commonComponents = linkedIssue.components.findAll { it.name in issue.components*.name }
        issue.setComponent(commonComponents)
        break

    case IssueFieldConstants.FIX_FOR_VERSIONS:
        def commonFixedVersions = linkedIssue.fixVersions.findAll { it.name in issue.fixVersions*.name }
        issue.setFixVersions(commonFixedVersions)
        break

    case IssueFieldConstants.AFFECTED_VERSIONS:
        def commonVersions = linkedIssue.affectedVersions.findAll { it.name in issue.affectedVersions*.name }
        issue.setFixVersions(commonVersions)
        break

    default:
        issue[fieldToCopyId] = linkedIssue[fieldToCopyId]
}
```

