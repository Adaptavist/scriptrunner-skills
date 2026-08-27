# Bulk Update Multiple Work Item Resolutions

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-bulk-update-resolutions-cloud
- Source: https://examples.scriptrunner.io/scripts/bulk-update-resolutions-cloud

## Overview

Bulk update the resolution of all work items returned from the JQL search which meet the specified conditions.

## Example

As a Jira admin, I want to change the resolution of a large number of work items which were mislabeled.
I can use this script to update the resolution of all these work items to their corresponding one (like "Duplicate").

## Good to Know

* You can use this code as part of a larger script to update the work items resolution based on additional logic.
* You can look up the available resolution names in "Jira Settings" > "WORK ITEM ATTRIBUTES" > "Resolutions".

## Script

```groovy
// The Name of the resolution to be set
def resolutionName = 'Cannot Reproduce'

// Get all work items matching the specified JQL Query
WorkItems.search("project = TEST AND issueType = Bug").each { workItem ->
    workItem.transition('Done') {
        setResolution(resolutionName)
    }
    logger.info("Resolution set to ${resolutionName} for the ${workItem.key} work item")
}
```

