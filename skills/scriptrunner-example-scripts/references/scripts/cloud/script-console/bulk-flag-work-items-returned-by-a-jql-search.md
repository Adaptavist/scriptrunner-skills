# Bulk flag work items returned by a jql search

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-bulk-add-flag-to-issues-from-jql-search-cloud
- Source: https://examples.scriptrunner.io/scripts/bulk-add-flag-to-issues-from-jql-search-cloud

## Overview

This example shows how you can set the *impediment* flag on multiple work items returned by a jql search.

## Example

As a product owner identify all blocked work items which have not been updated in the past 14 days and add a flag to them.

## Good to Know

This script can also be run as an Escalation Service to automate it running against the work items returned by the JQL every X days.

## Script

```groovy
// Define a JQL query to search for the work items on which you want to set the impediment flag
def query = "<JQLQueryHere>"

// Iterate through the search results and set the Impediment flag for each work item returned
WorkItems.search(query).each { workItem ->
    workItem.update {
        setCustomFieldValue("Flagged", "Impediment")
    }
    logger.info("The ${workItem.key} work item was flagged as an Impediment.")
}

"Script Completed - Check the Logs tab for information on which work items were updated."
```

