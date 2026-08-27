# Count the time an issue was in a particular status

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-count-the-time-an-issue-was-in-a-particular-status-onPrem
- Source: https://examples.scriptrunner.io/scripts/count-the-time-an-issue-was-in-a-particular-status-onPrem

## Overview

As an issue is worked on, it may transition back and forth between statuses. Use this script to record the time an
issue has been in a specific status.

## Example

As a project manager, I want to be able to assess how an issue is transitioning through the development and testing
processes I have put in place. If an issue exceeds the time assigned to it, I can use this script to observe the total
duration the issue was in a specific status, so I can identify where the delay occurred.

## Good to Know

* Use *Duration* as template for the custom field.
* This script includes the time an issue is in its initial status (for example 'Created').

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.history.ChangeItemBean

// Status to be counted
final statusName = '<YOUR STATUS>'

def changeHistoryManager = ComponentAccessor.changeHistoryManager
def totalStatusTime = [0L]

// Every status change is checked
def changeItems = changeHistoryManager.getChangeItemsForField(issue, "status")
changeItems.reverse().each { ChangeItemBean item ->
    def timeDiff = System.currentTimeMillis() - item.created.time
    // Subtract time if the "from" status is equal to the status to be checked and from and to statuses are different.
    // This allows to count the time the issue is in the state for the first time
    if (item.fromString == statusName && item.fromString != item.toString) {
        totalStatusTime << -timeDiff
    }
    // Add time if the "to" status is equal to the status to be checked
    if (item.toString == statusName) {
        totalStatusTime << timeDiff
    }
}

def total = totalStatusTime.sum() as Long
// Every time (added or subtracted) is summed and divided by 1000 to get seconds
(total / 1000) as long ?: 0L
```

