# Propagate field changes across all the Linked Issues

- Platform: data-center
- Feature: listeners
- Tags: automate, workflow, hapi
- Language: groovy
- Doc ID: example-dataCenter-propagate-changes-linked-issues-onPrem
- Source: https://examples.scriptrunner.io/scripts/propagate-changes-linked-issues-onPrem

## Overview

Place this script in a Custom Listener, to automatically update the value of a custom field across desired linked issues.

## Example

As a project manager working on a project with a large number of issues, I must ensure all issues are up to date.
Therefore, once a given field is updated, I want to automatically propagate this change across all the linked issues.

## Good to Know

* Add a custom listener, and choose the `Issue Updated` event.

## Script

```groovy
// Field that will be synchronised
final customFieldName = 'TextFieldA'

def issue = event.issue
def change = event.changeLog.getRelated('ChildChangeItem').find { it.field == customFieldName }

if (!change) {
    return
}

// Find linked issues of type 'Bug' with the 'Blocks' link type
def linkedIssues = issue.outwardLinks.findAll {
    it.issueLinkType.name == 'Blocks' && it.destinationObject.issueType.name == 'Bug'
}*.destinationObject

if (!linkedIssues) {
    return
}

linkedIssues.each { linkedIssue ->
    linkedIssue.update {
        setCustomFieldValue(customFieldName, issue.getCustomFieldValue(customFieldName))
    }
}
```

