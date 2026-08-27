# Add or Update the link of a Work Item in Jira Cloud

- Platform: cloud
- Feature: script-console
- Tags: automate, fields, hapi
- Language: groovy
- Doc ID: example-cloud-basics-updating-issue-links-cloud-cloud
- Source: https://examples.scriptrunner.io/scripts/basics-updating-issue-links-cloud-cloud

## Overview

Linking work items means you can create an association between two existing work items. With this script, you can bulk link a set of work items.

## Example

I want to bulk link work items to keep track of my related work for one of my spaces. I can do this quickly and efficiently with this script.

## Description

#### Overview
Linking work items means you can create an association between two existing work items. With this script, you can bulk link a set of work items.

#### Example
I want to bulk link work items to keep track of my related work for one of my spaces. I can do this quickly and efficiently with this script.

## Script

```groovy
// Specify the source work item
final sourceWorkItemKey = "TEST-1"
// Specify the target work item
final targetWorkItemKey = "TEST-2"
// Specify the link direction name to use
final linkType = "blocks"

// Create the link between both work items
WorkItems.getByKey(sourceWorkItemKey).link(linkType, targetWorkItemKey)
```

