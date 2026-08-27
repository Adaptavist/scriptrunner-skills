# Change Epic Status Field When Resolution Gets Set

- Platform: cloud
- Feature: listeners
- Tags: hapi, issue, fields, automate
- Language: groovy
- Doc ID: example-cloud-change-epic-status-when-resolution-set-cloud
- Source: https://examples.scriptrunner.io/scripts/change-epic-status-when-resolution-set-cloud

## Overview

Epic work items in Jira Cloud have an 'Epic Status' field associated. Only the epics with an 'Epic Status' value different from 'Done' are visible in the epic panel of scrum boards. 
Use this script to synchronise the value of the 'Epic Status' field with the resolution of the epic, so it gets set automatically once the epic resolution transitions.

## Example

I am a product manager, and I need to ensure that the Epic Status field of a work item aligns with its resolution. 
For instance, when an epic is marked as resolved, I want its Epic Status to automatically update to "Done". 
This saves me time manually updating the status.

## Good to Know

- Set the script as a listener for the Issue Updated event.
- Add a condition to the listener so the script gets executed only for epic work items.

## Script

```groovy
def eventWorkItem = WorkItems.getByKey(issue.key as String)

def resolutionChange = changelog.items.find {
    (it as Map).field == 'resolution'
} as Map
logger.info("The resolution change of work item '${eventWorkItem.key}': ${resolutionChange}.")
def newEpicStatusValue = (resolutionChange?.toString == 'Done') ? 'Done' : 'To Do'

logger.info("The epic status value is: ${newEpicStatusValue}.")

if (!resolutionChange) {
    logger.info("The resolution didn't change.")
    return
}

logger.info("Updating Epic Status field Epic Status to '${newEpicStatusValue}'.")

eventWorkItem.update{
    setCustomFieldValue('Epic Status', newEpicStatusValue)
}
```

