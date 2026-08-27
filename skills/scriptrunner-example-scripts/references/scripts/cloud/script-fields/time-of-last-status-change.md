# Time of last status change

- Platform: cloud
- Feature: script-fields
- Tags: issue, fields, customise
- Language: groovy
- Doc ID: example-cloud-time-of-last-status-change-cloud
- Source: https://examples.scriptrunner.io/scripts/time-of-last-status-change-cloud

## Overview

This scripted field is designed to capture the date and time when a work item last underwent a specific transition. 
If the work item experiences the same transition multiple times, the field will display only the date of the most recent occurrence.

## Example

This example shows how you can identify the most recent time a work item transitioned to a particular status, helping teams monitor the latest progress or updates on that work item.

## Good to Know

The field that this script will evaluate should be configured to use a 'Date Time' return type.

## Script

```groovy
def result = get('/rest/api/3/issue/' + issue.key + '/changelog')
        .header('Content-Type', 'application/json')
        .asObject(Map)
// Replace 'In Progress' with the status name
def lastTransitionDateTime = result.body.values.findAll { it['items']['field'].toString().contains('status') && it['items']['toString'].toString().contains('In Progress') }.last()
lastTransitionDateTime ? lastTransitionDateTime['created'] : "-"
```

