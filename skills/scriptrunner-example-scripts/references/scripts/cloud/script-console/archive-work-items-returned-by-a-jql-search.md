# Archive work items returned by a JQL Search

- Platform: cloud
- Feature: script-console
- Tags: automate, organise, manage, hapi
- Language: groovy
- Doc ID: example-cloud-Archive-Issues-Retunred-By-A-Jql-Search-cloud
- Source: https://examples.scriptrunner.io/scripts/Archive-Issues-Retunred-By-A-Jql-Search-cloud

## Overview

Archive work items returned by a JQL search to help keep your instance in a clean state.

## Example

As a product manager, I want to archive any work items that have not been updated in the past 30 days, as identified by a JQL search.

## Good to Know

* The archiving APIs which this script uses are only available on the *Premium* and *Enterprise* plans of Jira Cloud. 
* The script runs for each work item returned by the JQL configured inside the *jqlQuery* variable in the script.
* This script can be run in the script console but could also be configured to run as a *Scheduled Job* to clean up work items on a periodic schedule.
* Note: The max number of work items to return from the JQL is set to *500* but this can be increased on line *7* of the script if needed.

## Script

```groovy
// Construct the JQL to return the work items to be archived
def jqlQuery = "updated >= '-30d' and project = 'RRR'"

// Loop over each work item
def archivedWorkItems = WorkItems.search(jqlQuery).take(500).collect { workItem ->
    // Archive the current work item
    def archiveWorkItem = put("/rest/api/3/issue/archive")
            .header("Content-Type", "application/json")
            .body(
                    issueIdsOrKeys: [workItem.key]
            )
            .asObject(Map)

    // Validate the work item was archived correctly
    assert archiveWorkItem.status >= 200 && archiveWorkItem.status < 300
    workItem.key
}

logger.info("The following work items were archived succesfully: ${archivedWorkItems}")
```

