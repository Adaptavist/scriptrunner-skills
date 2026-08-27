# Calculate the Working Days between Two Dates

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-calculate-working-days-onPrem
- Source: https://examples.scriptrunner.io/scripts/calculate-working-days-onPrem

## Overview

Easily calculate the working days between a date in a custom field and the resolution date with this script.

## Example

I need to work out the average working days it takes to resolve an issue. I can use this script to track the working days between when an issue was created, and when it was resolved.

## Good to Know

* You can calculate the overall number of days between two dates with [this script](https://library.adaptavist.com/entity/calculate-the-difference-between-two-dates).

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

import java.sql.Timestamp
import java.time.DayOfWeek

// the name of the custom field to compare with the resolution date
final String dateCustomFieldName = "First Date Custom Field"

def dateCustomField = ComponentAccessor.customFieldManager.getCustomFieldObjects(issue).findByName(dateCustomFieldName)
if (!dateCustomField) {
    log.info "Could not find custom field with name $dateCustomFieldName"
    return null
}

if (!issue.getCustomFieldValue(dateCustomField) || !issue.resolutionDate) {
    return null
}

def customFieldDate = (issue.getCustomFieldValue(dateCustomField) as Timestamp).toLocalDateTime().toLocalDate()
def resolutionDate = issue.resolutionDate.toLocalDateTime().toLocalDate()

if (!resolutionDate.isBefore(customFieldDate)) {
    return null
}

def weekend = EnumSet.of(DayOfWeek.SATURDAY, DayOfWeek.SUNDAY)
def workingDaysAfterResolution = 0

while (resolutionDate.isBefore(customFieldDate)) {
    if (!(resolutionDate.dayOfWeek in weekend)) {
        workingDaysAfterResolution += 1
    }

    resolutionDate = resolutionDate.plusDays(1)
}

workingDaysAfterResolution
```

