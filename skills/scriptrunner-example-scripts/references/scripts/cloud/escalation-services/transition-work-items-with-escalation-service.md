# Transition work items with Escalation Service

- Platform: cloud
- Feature: escalation-services
- Tags: issue, hapi
- Language: groovy
- Doc ID: example-cloud-transition-issues-escalation-service-cloud
- Source: https://examples.scriptrunner.io/scripts/transition-issues-escalation-service-cloud

## Overview

With this script you can transition all work items matching the escalation service JQL query.

## Example

I want to transition every work item matching my JQL query in Escalation Service.

## Description

#### Overview
With this script you can transition all work items matching the escalation service JQL query.

#### Example
I want to transition every work item matching my JQL query in Escalation Service.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
def transitionName = 'Start progress'

try {
    currentWorkItem.transition(transitionName)
    return "Work item ${currentWorkItem.key} was transitioned by the escalation service."
} catch (Exception e) {
    return "The escalation service failed to transition work item ${currentWorkItem.key}."
}
```

