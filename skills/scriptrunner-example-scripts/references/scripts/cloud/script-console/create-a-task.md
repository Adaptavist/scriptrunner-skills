# Create a Task

- Platform: cloud
- Feature: script-console
- Tags: automate, issue, hapi
- Language: groovy
- Doc ID: example-cloud-create-a-task-cloud
- Source: https://examples.scriptrunner.io/scripts/create-a-task-cloud

## Overview

Automatically create a task for a particular space.

## Example

I am working in IT Management and I would like to automatically create an onboarding task for the IT Services department to action when a new employee joins the company. I set the space key to 'ITS'. I then populate the Task Summary and Description with the appropriate actions to be taken by the IT admin.

## Good to Know

* You must specify the space key where the task should be created.
* You can use this script in conjunction with a Script Listener to automatically create a task when related work items are updated.
* You can customize this script to call your own REST API's as conditional input for creating a task or for adding in extra detail to the task body.

## Script

```groovy
def spaceKey = "TP"

WorkItems.create(spaceKey, "Task") {
    setSummary("Task Summary")
    setDescription("Don't forget to do this!")
}
```

