# Flag an individual work item from script console

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-flag-an-individual-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/flag-an-individual-issue-cloud

## Overview

Add a flag to an individual work item from the *Script Console*.

## Example

As a project manager an impediment is found on one work item during the daily standup and you need to add a flag to this work item.

## Good to Know

* This script can be run as an *Escalation Service* to automatically flag work items returned by JQL on a periodic schedule.

## Script

```groovy
// Specify the work item by its key and perform the update
WorkItems.getByKey('<WorkItemKeyHere>').update {
    setCustomFieldValue("Flagged", "Impediment")
}
```

