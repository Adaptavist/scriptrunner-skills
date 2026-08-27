# Archive Unused Spaces

- Platform: cloud
- Feature: script-console
- Tags: automate, project, hapi
- Language: groovy
- Doc ID: example-cloud-archive-unused-projects-cloud
- Source: https://examples.scriptrunner.io/scripts/archive-unused-projects-cloud

## Overview

A scheduled job that you can also run in the script console to archive spaces that have either no work items or work items that have not been updated within a specified number of days. 
The script evaluates all spaces and archives those that meet the criteria, thus simplifying space management and improving search efficiency within Jira.

## Example

As a Jira admin my active development environment has accumulated spaces that are no longer active. I will use this script to manage clutter in my space space by archiving spaces that are no longer active. For my context, these are spaces that either have no work items, or saw the last update to a work item over 60 days ago.

## Good to Know

Spaces with different configurations or custom fields might require adjustments to the script. Spaces with non-standard fields or those not using the default work item fields must be evaluated for compatibility with this script.

Note that running this script might timeout in instances with a large number of spaces. After a timeout, the script can be rerun, picking up where it left off. Timeouts and their resolutions will be logged in the Execution History of  a Script Job.

Ensure that your Jira instance is on a Premium or Enterprise plan, as the archiving API used in this script is only available with these subscriptions.

You can configure this script to run as a Script Job, enabling automatic archiving of unused spaces, keeping your Jira environment clean and organized.

## Script

```groovy
// Number of days since last update on any work item
int numberOfDaysWithoutWorkItemUpdateLimit = 10

// A list to store the keys of spaces to be archived
def spaceKeysToArchive = []

Spaces.getAllSpaces().each { space ->

    // If the space contains no work items then add it to the list of spaces to be archived
    if (space.getInsight().totalIssueCount == 0) {
        spaceKeysToArchive.push(space.key)
    }

    // If the space has not updated any work items in the specified timeframe then add it to the list of spaces to be archived
    def lastWorkItemUpdateTime = space.getInsight().lastIssueUpdateTime
    if (lastWorkItemUpdateTime) {
        def lastWorkItemUpdateTimestamp = Date.from(lastWorkItemUpdateTime.toInstant())
        def currentDate = new Date()
        def millisecondsDifference = Math.abs(currentDate.time - lastWorkItemUpdateTimestamp.time)
        def daysSinceLastWorkItemUpdate = millisecondsDifference / (1000 * 60 * 60 * 24) as double
        def roundedDaysSinceLastWorkItemUpdate = Math.round(daysSinceLastWorkItemUpdate)

        if (roundedDaysSinceLastWorkItemUpdate >= numberOfDaysWithoutWorkItemUpdateLimit) {
            spaceKeysToArchive.push(space.key)
        }
    }
}

// Loop over each space key in the list of spaces to be archived
spaceKeysToArchive.each { key ->
    // Archive the space
    // Note you must be on a Premium or Enterprise plan to be able to use this API
    post("/rest/api/3/project/${key}/archive")
            .header("Content-Type", "application/json")
            .asObject(Map)

    logger.info("Archived the space with the key of ${key}")
}

"Archiving completed. Check the logs tabs to see what spaces were archived and for any errors."
```

