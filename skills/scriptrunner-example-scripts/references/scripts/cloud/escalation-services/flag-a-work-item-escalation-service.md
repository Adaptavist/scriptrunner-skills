# Flag A Work Item Escalation Service

- Platform: cloud
- Feature: escalation-services
- Tags: issue, hapi
- Language: groovy
- Doc ID: example-cloud-flag-an-issue-cloud
- Source: https://examples.scriptrunner.io/scripts/flag-an-issue-cloud

## Overview

This script helps flagging a work item, indicating that they may be impediments or require escalation. 
Flagged work items become easily identifiable and can be prioritized for review, helping to maintain space flow and address impediments swiftly.

## Example

We can flag a certain work item automatically as an impediment, notifying other team members or relevant stakeholders that attention is needed. 
This allows the team to quickly identify and address potential blockers without the need for automated rules.

## Description

#### Overview
This script helps flagging a work item, indicating that they may be impediments or require escalation. 
Flagged work items become easily identifiable and can be prioritized for review, helping to maintain space flow and address impediments swiftly.

#### Example
We can flag a certain work item automatically as an impediment, notifying other team members or relevant stakeholders that attention is needed. 
This allows the team to quickly identify and address potential blockers without the need for automated rules.

## Script

```groovy
def currentWorkItem = WorkItems.getByKey(issue.key as String)
//you can *add* a flag
currentWorkItem.update {
    setCustomFieldValue('Flagged', 'Impediment')
}

//*OR* you can *remove* a flag
currentWorkItem.update {
    clearCustomField('Flagged')
}
```

