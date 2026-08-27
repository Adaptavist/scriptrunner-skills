# Transition Work Items Returned from a JQL Search

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-transition-search-issues-cloud
- Source: https://examples.scriptrunner.io/scripts/transition-search-issues-cloud

## Overview

Bulk transition all work items returned from the JQL search which meet the specified conditions.

## Example

As a Jira admin, I want to edit the status of a large number of outdated work items.
I can use this script to search for all work items with the outdated statuses using a JQL query, and transition all of these work items to the correct "Done" status.

## Good to Know

* You can use this code as part of a larger script to transition work items based on additional logic.
* You can look up the `transitionId` in the text mode page of a workflow.

## Script

```groovy
// The Name of the workflow transition to execute
final transitionName = 'Done'
// Get all work items matching the specified JQL Query
WorkItems.search("project = TEST AND issueType = Bug").each { workItem ->
    workItem.transition(transitionName)
    logger.info("Transition '${transitionName}' performed successfully for work item ${workItem}")
}
```

