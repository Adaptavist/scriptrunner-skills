# Calculate the Difference Between Two Dates

- Platform: cloud
- Feature: script-fields
- Tags: customise, issue, fields
- Language: groovy
- Doc ID: example-cloud-calculate-difference-between-dates-cloud
- Source: https://examples.scriptrunner.io/scripts/calculate-difference-between-dates-cloud

## Overview

Calculate the difference in a time unit between two custom date fields.
Save time manually tracking dates using this script.

## Example

As a project manager, I have an impending project deadline coming up.
I need to see how long the tasks have been running to ensure my team is on track to complete the project on time.
Using this script, I can configure a *Scripted Field*, or use the *Script Console*, to show me the time elapsed for each outstanding work item.

## Good to Know

* Change the `ChronoUnit` value to calculate the difference in the time unit of your choice.
You can check the [documentation](https://docs.oracle.com/javase/8/docs/api/java/time/temporal/ChronoUnit.html) to see the available time units.
* The `ChronoUnit#between` method doesn't take into account fractional results,
it rounds the result to the greatest integer less than or equal to the resulting value (floor function).
* Execute the script in the *Script Console*.

## Script

```groovy
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import java.time.temporal.ChronoUnit

// The work item key
final workItemKey = 'TEST-1'
final dateFieldName = 'Created'
final chronoUnit = ChronoUnit.DAYS

// Jira datetime field format
def formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss.SSSZ")

// Pick a date that you would like to calculate from
def workItemFieldId = getFieldIdFromName(dateFieldName)
// Pick a date from another date field, in this case the built-in 'Updated' field
def updatedFieldId = 'updated'

def createdDate = ZonedDateTime.parse(getWorkItemField(workItemKey, workItemFieldId), formatter)
def updatedDate = ZonedDateTime.parse(getWorkItemField(workItemKey, updatedFieldId), formatter)

def dateDifference = chronoUnit.between(createdDate, updatedDate)

/**
 * Get the work item field data on a given work item
 * @param workItemKey The key of the work item to get the data from
 * @param fieldId The field to get the data of
 * @return The value of the field
 */
String getWorkItemField(workItemKey, fieldId) {
    def workItemFieldValue = null
    def result = get('/rest/api/2/issue/' + workItemKey)
        .header('Content-Type', 'application/json')
        .asObject(Map)
    if (result.status == 200) {
        result.body.fields.each { key, value ->
            if (key == fieldId) {
                workItemFieldValue = value.toString()
            }
        }
        logger.warn "${workItemFieldValue}"
        return workItemFieldValue
    }

    logger.warn "Failed to find work item: Status: ${result.status} ${result.body}"
    null
}

/**
 * Get the id of a field
 * @param fieldName The name of the field
 * @return The field id
 */
String getFieldIdFromName(String fieldName) {
    def fields = get("/rest/api/2/field").asObject(List).body
    def customFieldObject = (fields as List<Map>).find { Map field ->
        field.name == fieldName
    }
    (customFieldObject as Map).id
}

// Return the value
"${dateDifference} ${chronoUnit.toString().toLowerCase()}"
```

