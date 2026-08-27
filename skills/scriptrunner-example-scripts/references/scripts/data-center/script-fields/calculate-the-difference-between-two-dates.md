# Calculate the Difference Between Two Dates

- Platform: data-center
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-dataCenter-calculate-difference-between-dates-onPrem
- Source: https://examples.scriptrunner.io/scripts/calculate-difference-between-dates-onPrem

## Overview

Calculate the difference in a time unit between two custom date fields.
Save time manually tracking dates using this script.

## Example

As a project manager, I have an impending project deadline coming up.
I need to see how long the tasks have been running to ensure my team is on track to complete the project on time.
Using this script, I can configure a *Scripted Field*, or use the *Script Console*, to show me the time elapsed for each outstanding issue.

## Good to Know

* Change the `ChronoUnit` value to calculate the difference in the time unit of your choice.
You can check the [documentation](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/ChronoUnit.html) to see the available time units.
* The `ChronoUnit#between` method doesn't take into account fractional results,
it rounds the result to the greatest integer less than or equal to the resulting value (floor function).
* (Server) Configure a *Scripted field* to check the information at a glance.

## Script

```groovy
import java.sql.Timestamp
import java.time.temporal.ChronoUnit

def lower = issue.getCustomFieldValue('Contract Start Date') as Timestamp
def higher = issue.getCustomFieldValue('Contract End Date') as Timestamp

// Transform both values to instants
def lowerDateInstant = lower?.toInstant()
def higherDateInstant = higher?.toInstant()

// Change the chrono unit to obtain the difference in other time unit.
final chronoUnit = ChronoUnit.DAYS

if (lowerDateInstant && higherDateInstant) {
    // Calculate the difference between the lower and the higher date.
    return chronoUnit.between(lowerDateInstant, higherDateInstant)
} else {
    return null
}
```

