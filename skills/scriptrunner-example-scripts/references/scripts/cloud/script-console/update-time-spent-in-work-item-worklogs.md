# Update Time Spent in Work Item Worklogs

- Platform: cloud
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-cloud-update-time-spent-worklogs-cloud
- Source: https://examples.scriptrunner.io/scripts/update-time-spent-worklogs-cloud

## Overview

Update the time spent in all the worklogs of a work item.

## Example

As an admin, I want to fix the worklogs of a work item to display the correct time spent.
Using this script, I can bulk update all of the worklogs of a work item at once, saving time and reducing the risk of error.

## Good to Know

* You must execute the script as "ScriptRunner Add-On User" to override screen security.
* You can fine-tune the worklogs to update applying extra query parameters, or extra conditions based on attributes, to the [worklog search request](https://developer.atlassian.com/cloud/jira/platform/rest/v2/#api-rest-api-2-issue-issueIdOrKey-worklog-get).

## Script

```groovy
// Specify the work item to set the worklog on
final workItemKey = "TEST-1"

// Specify the time to be set on each worklog (format: 24m for 24 minutes or 2h for 2 hours)
final timeSpentValue = "1h"

// Execute the rest call to get all worklogs of a work item
def workItemWorklogs = get("/rest/api/2/issue/${workItemKey}/worklog")
    .header('Content-Type', 'application/json')
    .asObject(Map).body.worklogs as List<Map>
logger.info("The worklogs of issue ${workItemKey}: ${workItemWorklogs}")

// Iterate over each worklog
def statusByWorklogId = workItemWorklogs.collectEntries { worklog ->
    // Execute the rest call to update the worklog on the work item
    def result = put("/rest/api/2/issue/${workItemKey}/worklog/${worklog.id}")
        .header('Content-Type', 'application/json')
        // Override screen security if the field is not on screen (this means the script must be run as the "ScriptRunner Add-On User")
        .queryString("overrideScreenSecurity", true)
        .body([
            // Specify the time to be set updated on the worklog
            "timeSpent": timeSpentValue
        ])
        .asObject(Map)

    // Log out the work items transitioned or which failed to be transitioned
    if (result.status == 200) {
        logger.info("Update of worklog ${worklog.id} performed successfully")
    } else {
        logger.warn("Failed to update the worklog ${worklog.id}")
    }

    // Collect the success status by worklog key to show them as part of the script return value
    [(worklog.id): (result.status == 200)]
}

"Status by worklog id (updated?): ${statusByWorklogId}"
```

