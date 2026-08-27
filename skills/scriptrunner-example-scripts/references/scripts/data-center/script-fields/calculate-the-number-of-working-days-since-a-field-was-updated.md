# Calculate the Number of Working Days Since a Field Was Updated

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-calculate-working-days-custom-field-onPrem
- Source: https://examples.scriptrunner.io/scripts/calculate-working-days-custom-field-onPrem

## Overview

Track and calculate the number of days since a custom field was updated in a scripted field.

## Example

I want to make sure my SLA's are on target and have not gone overdue. Using this script to calculate the days since a custom scripted field was updated, I can easily keep track of my teams to ensure we are delivering in accordance with our SLA's.

## Good to Know

* The custom field should be updated at least once in the lifetime of the issue for the script to work correctly.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

final String customFieldName = "Custom Field Name"

def startDate = Calendar.instance
def endDate = Calendar.instance

def changeHistoryManager = ComponentAccessor.changeHistoryManager
def transition = changeHistoryManager.getChangeItemsForField(issue, customFieldName)

startDate.setTime(transition*.created.max())

int weekDays = 0
while (startDate.timeInMillis < endDate.timeInMillis) {
    startDate.add(Calendar.DAY_OF_MONTH, 1)
    startDate.get(Calendar.DAY_OF_WEEK) in [Calendar.SATURDAY, Calendar.SUNDAY] ? null : ++weekDays
}

weekDays
```

