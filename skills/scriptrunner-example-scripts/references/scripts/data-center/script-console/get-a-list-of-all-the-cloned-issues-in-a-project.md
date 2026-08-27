# Get a list of all the cloned issues in a project

- Platform: data-center
- Feature: script-console
- Tags: issue
- Language: groovy
- Doc ID: example-dataCenter-get-cloned-issues-from-a-project-onPrem
- Source: https://examples.scriptrunner.io/scripts/get-cloned-issues-from-a-project-onPrem

## Overview

A simple console script which can be used to get all the cloned issues in a specific project.

## Example

As a user, I want to get a list of all the cloned issues in a project. To do this, I can run this sample 
script on ScriptRunner's console.

## Description

#### Overview

A simple console script which can be used to get all the cloned issues in a specific project. 
                                
#### Example

As a user, I want to get a list of all the cloned issues in a project. To do this, I can run this sample 
script on ScriptRunner's console.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor

def issueLinkManager = ComponentAccessor.issueLinkManager
def projectManager = ComponentAccessor.projectManager
def issueManager = ComponentAccessor.issueManager

//Specify the project key
final def projectKey = '<PROJECT_KEY>'

def project = projectManager.getProjectByCurrentKey(projectKey)
def issues = issueManager.getIssueObjects(issueManager.getIssueIdsForProject(project.id))

issues.collect {
    issueLinkManager.getOutwardLinks(it.id).findAll {
        it.issueLinkType.name == 'Cloners'
    }.collect {
        it.sourceObject.key
    }
}.sort().flatten()
```

