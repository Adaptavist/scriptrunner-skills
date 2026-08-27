# Date of the first transition

- Platform: cloud
- Feature: script-fields
- Tags: issue, fields, customise
- Language: groovy
- Doc ID: example-cloud-date-of-the-first-transition-cloud
- Source: https://examples.scriptrunner.io/scripts/date-of-the-first-transition-cloud

## Overview

This scripted field is designed to capture the date and time when a work item first underwent a specific transition. 
If the work item experiences the same transition multiple times, the field will display only the date of the initial occurrence.

## Example

This example shows how you can track when a work item was first moved to a specific status, allowing team members to see when work officially started on that work item.

## Good to Know

The field that this script will evaluate should be configured to use a 'Date Time' return type.

## Script

```groovy
def result = get('/rest/api/3/issue/' + issue.key + '/changelog')
    .header('Content-Type', 'application/json')
    .asObject(Map)
// Replace 'In Progress' with the status name
def firstTransitionDateTime = result.body.values.find {it['items']['field'].toString().contains('status') && it['items']['toString'].toString().contains('In Progress') }
firstTransitionDateTime ? firstTransitionDateTime['created'] : "-"
```

