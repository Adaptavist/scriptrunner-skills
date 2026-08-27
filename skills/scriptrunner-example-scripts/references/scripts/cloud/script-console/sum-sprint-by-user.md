# Sum Sprint By User

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate, user
- Language: groovy
- Doc ID: example-cloud-sum-sprint-by-user-cloud
- Source: https://examples.scriptrunner.io/scripts/sum-sprint-by-user-cloud

## Overview

This script sums up the estimate values of work items in a sprint by assignee.

## Example

This example demonstrates how to write a script to sum the estimates of all work items in a sprint, grouped by the assignee. 
It calculates and outputs the total estimate for each team member involved in the sprint.

## Good to Know

The script assumes each work item has an estimate and is assigned to an assignee. 
Unassigned work items can be grouped separately or skipped.

## Script

```groovy
def SPRINT_ID = 1
// make search
def workItems = WorkItems.search("sprint = ${SPRINT_ID}")
assert workItems != null

// helper method for clarity
def sumOfOriginalEstimate = { fields ->
    fields*.timeoriginalestimate.inject(0) { acc, estimate ->
        acc + (estimate ?: 0) // default to 0
    }
}

def workItemsByAssignee = workItems*.fields.groupBy { it.assignee?.name }
workItemsByAssignee.collectEntries { k, v ->
    [(k): sumOfOriginalEstimate(v)]
}
```

