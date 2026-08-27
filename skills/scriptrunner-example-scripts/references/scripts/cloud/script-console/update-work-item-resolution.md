# Update Work Item Resolution

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, fields, automate
- Language: groovy
- Doc ID: example-cloud-update-issue-resolution-cloud
- Source: https://examples.scriptrunner.io/scripts/update-issue-resolution-cloud

## Overview

Update the resolution of a work item when it transitions between workflows.

## Good to Know

This script can be used in various contexts where you need to update the resolution of a work item.
It is useful for scripting tasks in Jira where you need to dynamically update the resolution when moving tickets through different workflow stages, such as when closing tasks, handling work item duplication, or marking them as completed.

## Description

#### Overview
Update the resolution of a work item when it transitions between workflows. 

#### Good to know
This script can be used in various contexts where you need to update the resolution of a work item.
It is useful for scripting tasks in Jira where you need to dynamically update the resolution when moving tickets through different workflow stages, such as when closing tasks, handling work item duplication, or marking them as completed.

## Script

```groovy
WorkItems.getByKey("WORK_ITEM_KEY").transition('Done') {
    // Can set any resolutions used in your version of Jira
    setResolution('Duplicate')
}
```

