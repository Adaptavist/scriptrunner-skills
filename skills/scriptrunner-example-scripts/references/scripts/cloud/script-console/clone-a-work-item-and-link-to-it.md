# Clone a Work Item and Link To It

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, fields, hapi
- Language: groovy
- Doc ID: example-cloud-Clone-Issue-And-Link-cloud
- Source: https://examples.scriptrunner.io/scripts/Clone-Issue-And-Link-cloud

## Overview

Clone an existing work item whilst specifying which field values you would like to copy over to the new cloned work item, and create a link between the existing and cloned work item.

## Example

As a product manager you want to create the same work item to put into different sprints to capture a recurring task that needs to be completed.

## Good to Know

* This example just clones the *Summary* and *Description* fields but you can specify other fields to be cloned in the *fields* section of the *clonedIssue* rest API call. 
* The link type here is for cloned work items but you change this to any link type you want

## Script

```groovy
def workItemKey = 'WorkItemKeyHere'

def sourceWorkItem = WorkItems.getByKey(workItemKey)

def space = sourceWorkItem.getSpaceObject()

def workType = sourceWorkItem.getWorkType()

def clonedWorkItem = WorkItems.create(space.key, workType.name) {
    summary = sourceWorkItem.summary
    description = sourceWorkItem.description
}

// Change link type name below if you do not want to use the clones link type
clonedWorkItem.link("clones", sourceWorkItem)
```

