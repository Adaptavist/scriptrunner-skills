# Create a linked development Bug when a Bug raised in a service management space.

- Platform: cloud
- Feature: post-functions
- Tags: workflow, automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-create-linked-development-bug-cloud
- Source: https://examples.scriptrunner.io/scripts/create-linked-development-bug-cloud

## Overview

Each time a customer raises a Bug inside a service management space automatically create a linked Bug work item ticket in the development project.

## Example

As a product manager I want a linked bug to be created in my development backlog every time a customer raises one through the support portal so that I can triage and prioritise these to be fixed.

## Good to Know

* This script needs to be configured on the *Create* transition in the workflow used by the *Bug* work item type, in *Jira Service Management* project. 
  *Note:* The perform actions rule must be ordered as the last perform actions rule in the list of perform action rules to ensure the work item is created before it can be linked to. 

* On line *2* of the script specify the space key for the development space that the linked bug will be created in. 
* On line *5* of the script specify the name of the Bug work item type for your instance. 

* The script will Automatically copy the *Summary* and *Description* values from the service desk work item and add them to the linked Bug work item. 
  *Note:* If you wish to add other fields then you should modify the *WorkItems.create* method on line *12* to set the other fields you require. 

*  The work item is linked with the *Relates* link type and if you need to use a different link type then you should change this on line *18* of the script.

## Script

```groovy
// Specify the key of the space to create the work item in.
def spaceKey = "Demo"

// Specify the name of the Bug work type
def bugWorkType = "Bug"

def workItemHapi = WorkItems.getByKey(issue.key as String)
// Get the value entered on the Service Desk ticket for Summary and Description
def serviceDeskWorkItemSummary = workItemHapi.getSummary()
def serviceDeskWorkItemDescription =  workItemHapi.getDescription()

def createdWorkItem =  WorkItems.create(spaceKey, bugWorkType) {
    setSummary(serviceDeskWorkItemSummary)
    setDescription(serviceDeskWorkItemDescription)
}

// Create the work item link between both work items
workItemHapi.link("relates to", createdWorkItem)
```

