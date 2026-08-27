# Create a Subtask

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, automate
- Language: groovy
- Doc ID: example-cloud-create-a-subtask-cloud
- Source: https://examples.scriptrunner.io/scripts/create-a-subtask-cloud

## Overview

Create a sub task for a specified parent work item inside a Company Managed space.

## Example

In this example, the script automatically creates a sub-task under an existing parent work item in a Company Managed space.

## Good to Know

The script targets a specific parent work item for sub-task creation.
Ensure that the space is Company Managed, as the script is designed to work within this type of space.

## Script

```groovy
WorkItems.getByKey("WORK_ITEM_KEY").createSubTask('Sub-task') {
    summary = 'subtask summary'
}
```

