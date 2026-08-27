# Create Work Items Script

- Platform: cloud
- Feature: listeners
- Tags: issue, hapi, automate, project
- Language: groovy
- Doc ID: example-cloud-create-issues-script-cloud
- Source: https://examples.scriptrunner.io/scripts/create-issues-script-cloud

## Overview

This script demonstrates how to create work items of the type "Task" in Jira. 
It automates the process of work item creation, ensuring that tasks are generated based on specific triggers.

## Good to Know

The script listener events must be associated with space-related actions in Jira, such as Project Created, Project Updated, or Project Deleted. 
This allows for seamless integration with space management workflows, ensuring that tasks are created in response to relevant space changes.

## Description

#### Overview
This script demonstrates how to create work items of the type "Task" in Jira. 
It automates the process of work item creation, ensuring that tasks are generated based on specific triggers.

#### Good to know
The script listener events must be associated with space-related actions in Jira, such as Project Created, Project Updated, or Project Deleted. 
This allows for seamless integration with space management workflows, ensuring that tasks are created in response to relevant space changes.

## Script

```groovy
def spaceKey = project.key as String

// create two work items
WorkItems.create(spaceKey, 'Task') {
    summary = "Create Confluence space associated to the space"
    description = "Don't forget to do this!."
}
WorkItems.create(spaceKey, 'Task') {
    summary = "Bootstrap connect add-on"
    description = "Some other task"
}
```

