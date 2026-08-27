# Perform a JQL Search in ScriptRunner for Jira Cloud

- Platform: cloud
- Feature: script-console
- Tags: automate, reporting, issue, hapi
- Language: groovy
- Doc ID: example-cloud-jql-search-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/jql-search-cloud-cloud

## Overview

Use this snippet to look for work items based on a JQL search.
This code can be used as part of a larger bulk-administration or workflow automation task, in the *Script Console* and other features.

## Example

The available work item resolutions in a space have been updated, leaving several work items with incorrect resolution values.
I want to locate all work items with the incorrect value, so I can perform a bulk action to update them all.
To save me time manually searching, I can use this script to run a JQL search, locating all affected work items.

## Description

#### Overview
Use this snippet to look for work items based on a JQL search.
This code can be used as part of a larger bulk-administration or workflow automation task, in the *Script Console* and other features.

#### Example
The available work item resolutions in a space have been updated, leaving several work items with incorrect resolution values.
I want to locate all work items with the incorrect value, so I can perform a bulk action to update them all.
To save me time manually searching, I can use this script to run a JQL search, locating all affected work items.

## Script

```groovy
def jqlSearch = "project = \"TEST\" and issueType = Task"

WorkItems.search(jqlSearch).each { workItem ->
    // Here you can do something with each work item
    logger.info "Work item key: ${workItem.key}"
    logger.info "Work item summary: ${workItem.summary}"
}
```

