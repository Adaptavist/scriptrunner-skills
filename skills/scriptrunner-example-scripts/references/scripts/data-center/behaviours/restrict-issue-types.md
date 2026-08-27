# Restrict Issue Types

- Platform: data-center
- Feature: behaviours
- Tags: customise, issue
- Language: groovy
- Doc ID: example-dataCenter-restrict-issue-types-onPrem
- Source: https://examples.scriptrunner.io/scripts/restrict-issue-types-onPrem

## Overview

Behaviours allow you to change how fields behave on issue Create or Update screens.
Use this script to restrict the issue types available on the Create or Update screen.

## Example

As a project manager, I want to limit the issue types which a user can pick at the time of creating an issue.
I can use this script to restrict the issue type options available in the picker depending on the user's project role.
For instance, non-core members of the project can create "Query" issues, whereas developers can create "Bug", "Task" and "New Feature" issues.

## Good to Know

* Set up this script as an initialiser.
* In case of having translated issue type names, the original names and the translations must match. Otherwise, the script might not behave correctly.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager
import com.onresolve.jira.groovy.user.FieldBehaviours
import groovy.transform.BaseScript

import static com.atlassian.jira.issue.IssueFieldConstants.ISSUE_TYPE

@BaseScript FieldBehaviours fieldBehaviours

def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def allIssueTypes = ComponentAccessor.constantsManager.allIssueTypeObjects
def user = ComponentAccessor.jiraAuthenticationContext.loggedInUser

def issueTypeField = getFieldById(ISSUE_TYPE)
def remoteUsersRoles = projectRoleManager.getProjectRoles(user, issueContext.projectObject)*.name
def availableIssueTypes = []

if ("Users" in remoteUsersRoles) {
    availableIssueTypes.addAll(allIssueTypes.findAll { it.name in ["Query", "General Request"] })
}

if ("Developers" in remoteUsersRoles) {
    availableIssueTypes.addAll(allIssueTypes.findAll { it.name in ["Bug", "Task", "New Feature"] })
}

issueTypeField.setFieldOptions(availableIssueTypes)
```

