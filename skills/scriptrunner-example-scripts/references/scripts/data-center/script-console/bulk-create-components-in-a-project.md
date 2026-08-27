# Bulk Create Components in a Project

- Platform: data-center
- Feature: script-console
- Tags: manage
- Language: groovy
- Doc ID: example-dataCenter-bulk-create-components-in-a-project-onPrem
- Source: https://examples.scriptrunner.io/scripts/bulk-create-components-in-a-project-onPrem

## Overview

You can use this script to automatically insert Components inside a project.

## Example

As admin, I would like to bulk add [Components](https://confluence.atlassian.com/adminjiraserver/managing-components-938847187.html)
to a project.

## Good to Know

* You must specify your own 'components', 'username', and 'projKey'.
* You can change the 'AssigneeTypes.PROJECT_DEFAULT' to other parameters such as 'AssigneeTypes.COMPONENT_LEAD'
, 'AssigneeTypes.PROJECT_LEAD' or 'AssigneeTypes.UNASSIGNED' depending on your default assignee configuration.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.project.AssigneeTypes

def projCompManager = ComponentAccessor.projectComponentManager
def projManager = ComponentAccessor.projectManager

def components = ['User Interface (UI)', 'Database', 'API', 'Security', 'Analytics', 'Messaging', 'Infrastructure', 'Company Website / Blog', 'YouTube Videos', 'Web Advertising', 'Partner Websites', 'Networking', 'Systems', 'Software', 'Hardware']
def username = 'admin'
def projKey = 'KP'

def projectId = projManager.getProjectByCurrentKey(projKey).id
def leadUser = ComponentAccessor.userManager.getUserByName(username).key

components.each { component ->
    projCompManager.create( component, null, leadUser, AssigneeTypes.PROJECT_DEFAULT, projectId)
}
```

