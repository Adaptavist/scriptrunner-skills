# Get Sprint Name for Work Item

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, fields
- Language: groovy
- Doc ID: example-cloud-get-sprint-name-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/get-sprint-name-issue-cloud

## Overview

Obtain the name of the sprint that contains a specific work item.

## Example

As a project manager, I want to know the sprints in which several work items are located — allowing me to plan efficiently.
I can use this script as part of a larger script to obtain this information and view it at a glance.

## Good to Know

* You can get other attributes from the sprint, such as the id, specifying the corresponding attribute instead of `name`.
  Check all available attributes at the REST API response [documentation](https://developer.atlassian.com/cloud/jira/platform/rest/v3/api-group-issues/#api-rest-api-3-issue-issueidorkey-get-response).

## Script

```groovy
// The work item key
final workItemKey = 'TEST-1'
// Fetch the work item object from the key
def fields = get("/rest/agile/1.0/issue/${workItemKey}")
    .header('Content-Type', 'application/json')
    .asObject(Map)
    .body
    .fields as Map
// Get sprint field from the work item fields as a Map
def sprint = fields.sprint as Map
// Get the Custom field to get the option value from
def sprintName = sprint.name // Note change .name to .id to get the ID of the sprint.
"The name of the current Sprint is '${sprintName}'"
```

