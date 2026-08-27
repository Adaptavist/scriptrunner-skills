# Update Work Item Summary

- Platform: cloud
- Feature: script-console
- Tags: issue, hapi, fields, automate
- Language: groovy
- Doc ID: example-cloud-update-issue-summary-cloud
- Source: https://examples.scriptrunner.io/scripts/update-issue-summary-cloud

## Overview

Update the summary of a work item

## Good to Know

This script can be used in various contexts where you need to update the summary of a work item. 
It is useful for scripting tasks in Jira where you need to modify work item descriptions based on status changes or when automating bulk updates to work item titles for consistency across tasks.

## Description

#### Overview
Update the summary of a work item

#### Good to know
This script can be used in various contexts where you need to update the summary of a work item. 
It is useful for scripting tasks in Jira where you need to modify work item descriptions based on status changes or when automating bulk updates to work item titles for consistency across tasks.

## Script

```groovy
WorkItems.getByKey("WORK_ITEM_KEY").update {
    setSummary("Updated by a script")
}
```

