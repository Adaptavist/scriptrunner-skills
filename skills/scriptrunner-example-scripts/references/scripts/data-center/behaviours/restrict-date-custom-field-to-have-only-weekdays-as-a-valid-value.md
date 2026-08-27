# Restrict Date Custom Field to Have Only Weekdays as a Valid Value

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-restrict-date-custom-field-to-weekdays-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-date-custom-field-to-weekdays-onPrem

## Overview

A Behaviour defines how fields behave for issues in a given project or issue context. This scripts allows you to do a
server-side validation of Date Custom Field data, before the issue screen is submitted.

## Example

I work as a project manager and release date need to be set for some issues. This release date only can contains
weekdays, rather than weekend days. I can use this Behaviour script to define the valid day of week for the date
custom field.

## Good to Know

* A date custom field must exist for the associated project.
* Behaviour script needs to be added to the date custom field.

## Script

```groovy
import java.time.ZoneId
import static java.time.DayOfWeek.*
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

@BaseScript FieldBehaviours fieldBehaviours

def releaseDateField = getFieldById(fieldChanged)
def releaseDate = releaseDateField.value as Date
def localDate = releaseDate.toInstant().atZone(ZoneId.systemDefault()).toLocalDate()
def dayOfWeek = localDate.dayOfWeek

if (dayOfWeek in [SATURDAY, SUNDAY]) {
    releaseDateField.setError('Release Date needs to be a valid week day, not a weekend day')
} else {
    releaseDateField.clearError()
}
```

