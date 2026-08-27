# Store the Time When an Issue Was First Transitioned

- Platform: data-center
- Feature: script-fields
- Tags: customise, workflow
- Language: groovy
- Doc ID: example-dataCenter-date-of-first-transition-onPrem
- Source: https://examples.scriptrunner.io/scripts/date-of-first-transition-onPrem

## Overview

Show the date when an issue was transitioned to a particular status. If it undergoes the same transition multiple times, only the first date is shown.

## Example

As a manager, I want to track when the work has began on an issue. With this script I am able to view the date at first sight.

## Good to Know

* Use *Date Time Range Picker* as the search template for the custom field.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import static java.time.Instant.ofEpochMilli

final statusName = "In Progress"

final changeHistoryManager = ComponentAccessor.changeHistoryManager
def firstTransitionTime = changeHistoryManager.getChangeItemsForField(issue, "status").find {
    it.toString == statusName
}?.created?.time

firstTransitionTime ? Date.from(ofEpochMilli(firstTransitionTime)) : null
```

