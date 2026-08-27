# Set The Due Date Field On A Work Item

- Platform: cloud
- Feature: script-console
- Tags: issue, fields, customise, hapi
- Language: groovy
- Doc ID: example-cloud-set-due-date-field-cloud
- Source: https://examples.scriptrunner.io/scripts/set-due-date-field-cloud

## Overview

This example takes the current date, adds approximately 2 weeks, formats the date pattern and sets this as the due date on a work item that's being updated.

## Example

As a Project Manager, I would like to automatically set due dates on work items I update at the start of a sprint to be due exactly in 2 weeks time. This will save me some time on setting due dates in sprint planning.

## Good to Know

* You must specify the work item key to be updated
* You must specify the due date to be set on this work item
* You can customize this script to update multiple work items due dates

## Script

```groovy
import java.time.LocalDate

// Get a future date to set as the due date
def dueDate = LocalDate.now().plusDays(14)

WorkItems.getByKey('<WorkItemKeyHere>').update {
    setDueDate(dueDate)
    //You can also specify the date as a String parameter using this method and format:
    // setDueDate("2025-12-31")
}
```

