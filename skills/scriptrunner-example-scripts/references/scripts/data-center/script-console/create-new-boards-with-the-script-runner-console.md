# Create New Boards with the ScriptRunner Console

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-create-new-board-with-console-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-new-board-with-console-onPrem

## Overview

This script creates boards for each Jira project for which you are the project manager. You can specify whether you would like to create Scrum or Kanban boards for your projects.

## Example

As a Jira project manager, I want to create a board for each of my projects without having to switch projects each time. 
Using this script, I can choose between Scrum or Kanban boards and create them on each of my projects in one go.

## Description

#### Overview
This script creates boards for each Jira project for which you are the project manager. You can specify whether you would like to create Scrum or Kanban boards for your projects.
                                
#### Example
As a Jira project manager, I want to create a board for each of my projects without having to switch projects each time. 
Using this script, I can choose between Scrum or Kanban boards and create them on each of my projects in one go.

## Script

```groovy
import com.atlassian.greenhopper.web.rapid.view.RapidViewHelper
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.JiraAgileBean
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin('com.pyxis.greenhopper.jira')

@JiraAgileBean
RapidViewHelper rapidViewHelper

//Specify the Project Key
final def projectKey = '<PROJECT_KEY>'

//Specify the Board Name
final def boardName = '<BOARD_NAME>'

//Specify the Board Type e.g. scrum or kanban
final def boardType = '<BOARD_TYPE>'

def currentUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser
def projectManager = ComponentAccessor.projectManager

def projectIds = [projectManager.getProjectObjByKey(projectKey).id as String]
def outcome = rapidViewHelper.createRapidViewForPreset(currentUser, boardName, projectIds as Set, boardType)

log.debug outcome

if (!outcome.valid) {
    log.warn "Failed to create board: ${outcome.errors}"
}
```

