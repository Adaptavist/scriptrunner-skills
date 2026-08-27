# Automate Your Project Creation in Jira

- Platform: data-center
- Feature: script-console
- Tags: automate, project
- Language: groovy
- Doc ID: example-dataCenter-basics-create-project-onPrem
- Source: https://examples.scriptrunner.io/scripts/basics-create-project-onPrem

## Overview

One of the most common tasks for Jira Administrators is project creation. This script works similarly to the ‘Create an issue in Jira’ script, allowing you to automate the creation of projects. For example, project creation can be added as a workflow post function, a REST Endpoint, or triggered by a listener.

## Example

I set up a new space in Confluence for each new project. I want to save time so Jira automatically creates a project when I set up a new confluence space. I add a listener to trigger this script, creating a project when a new space is set up in Confluence.

## Good to Know

You can edit this script to create a project with the name of the confluence space set up. You can do this by embedding this snippet in a Jira REST Endpoint and using ScriptRunner for Confluence to trigger a request after a space is created. You can then add the space name as a param.

## Script

```groovy
import com.atlassian.jira.bc.project.ProjectCreationData
import com.atlassian.jira.bc.project.ProjectService
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.project.AssigneeTypes
import com.atlassian.jira.project.type.ProjectTypeKey

// the key for the new project
final String projectKey = "AAA"

// the name of the new project
final String projectName = "A new Project"

// the description for the new project - optional
final String projectDescription = "project for testing"

def projectService = ComponentAccessor.getComponent(ProjectService)
def loggedInUser = ComponentAccessor.jiraAuthenticationContext.loggedInUser

// available project type keys: business | software | service_desk
def projectTypeKey = new ProjectTypeKey("business")

def creationData = new ProjectCreationData.Builder().with {
    withName(projectName)
    withKey(projectKey)
    withDescription(projectDescription)
    withLead(loggedInUser)
    withUrl(null)
    withAssigneeType(AssigneeTypes.PROJECT_LEAD)
    withType(projectTypeKey)
}.build()

final ProjectService.CreateProjectValidationResult projectValidationResult = projectService.validateCreateProject(loggedInUser, creationData)
assert projectValidationResult.valid : projectValidationResult.errorCollection

projectService.createProject(projectValidationResult)
```

