# Restrict Creation of Certain Issue Types to Members of a Project Role

- Platform: data-center
- Feature: validators
- Tags: automate, workflow, fields
- Language: groovy
- Doc ID: example-dataCenter-validate-issue-type-onPrem
- Source: https://examples.scriptrunner.io/scripts/validate-issue-type-onPrem

## Overview

Add this script to a ScriptRunner *Simple Scripted Validator* on the `Create` step of a workflow to restrict
the creation of certain types of issues to members of a specified project role.

## Example

I am a Project Manager. In my development team, I have two staff members who are in charge of Bug issue types.
I want to make sure that any bug issues created can only be assigned to one of these two developers. To do this,
I create a project role with the two developers and use this script to restrict the assignee.

## Good to Know

* The project role must exist and contain the users who we want the transition to be validated.
* The issue type must exist.
* You can configure the step in the workflow where you want the validator to be executed.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager

// the name of the project role
def roleName = 'Project Manager Role'

// the name of the issue type
def issueType = 'Epic'

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def role = projectRoleManager.getProjectRole(roleName)

issue.issueType.name == issueType && projectRoleManager.isUserInProjectRole(issue.reporter, role, issue.projectObject)
```

