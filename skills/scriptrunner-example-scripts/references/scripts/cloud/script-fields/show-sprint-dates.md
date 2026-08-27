# Show sprint dates

- Platform: cloud
- Feature: script-fields
- Tags: issue, hapi, fields, automate
- Language: groovy
- Doc ID: example-cloud-show-sprint-dates-cloud
- Source: https://examples.scriptrunner.io/scripts/show-sprint-dates-cloud

## Overview

This script is designed to enhance your Jira work item tracking by automatically displaying the start and end dates of
the active sprint associated with a given work item. By integrating this script into your Jira environment, 
you can effortlessly keep track of sprint timelines directly within each work item, 
ensuring that all team members have immediate access to crucial sprint information.

## Example

The content of your scripted field will look like "Sprint starting: 2024-12-04 - Sprint ending: 2024-12-18"

## Good to Know

If the work item is not part of an active sprint, the script will display the message: 
"The [WORK-ITEM-KEY] work item is not currently in an active sprint." 
This ensures that users are aware when a work item is not currently scheduled in any ongoing sprint, 
helping to avoid confusion and enabling better sprint planning and management.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
def sprint = currentWorkItem.getCustomFieldValue("Sprint")?.find { sprint -> sprint.state == 'active' }

if (sprint) {
    String sprintStartDate = sprint.startDate.substring(0, 10)
    String sprintEndDate = sprint.endDate.substring(0, 10)

    return "Sprint starting: ${sprintStartDate} - Sprint ending: ${sprintEndDate}"

} else {
    // Return a default message if the work item is not in active sprint
    return "The ${currentWorkItem.key} work item is not currently in an active sprint"
}
```

