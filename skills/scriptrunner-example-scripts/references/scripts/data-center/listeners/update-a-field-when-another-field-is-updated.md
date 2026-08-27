# Update a field when another field is updated

- Platform: data-center
- Feature: listeners
- Tags: automate, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-update-field-when-other-field-is-updated-listener-onPrem
- Source: https://examples.scriptrunner.io/scripts/update-field-when-other-field-is-updated-listener-onPrem

## Overview

Use this listener with the 'Issue Updated' event to update a field whenever another field is updated.
This will get the date that 'Field A' has been updated as set that as 'Field B' value.

## Example

I want to easily see when a certain field was last updated.

## Description

#### Overview

Use this listener with the 'Issue Updated' event to update a field whenever another field is updated.
This will get the date that 'Field A' has been updated as set that as 'Field B' value.

#### Example

I want to easily see when a certain field was last updated.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def changeHistoryManager = ComponentAccessor.getChangeHistoryManager()

def changeHistories = changeHistoryManager.getChangeHistories(event.issue)
if (changeHistories) {
    def changeItem = changeHistories.last().getChangeItemBeans().find {
        // check if Source field value changed
        it.field == 'Source' && it.fromString != it.toString
    }

    if (changeItem) {
        event.issue.update {
            setCustomFieldValue('Target', changeItem.created)
        }
    }
}
```

