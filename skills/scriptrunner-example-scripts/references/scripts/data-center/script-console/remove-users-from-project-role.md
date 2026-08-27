# Remove Users From Project Role

- Platform: data-center
- Feature: script-console
- Tags: project
- Language: groovy
- Doc ID: example-dataCenter-remove-users-from-project-role-onPrem
- Source: https://examples.scriptrunner.io/scripts/remove-users-from-project-role-onPrem

## Overview

Removing user(s) from a project role when they are no longer required.

## Example

If you have inactive users that you want to remove, then you can use this script to remove them.

## Description

#### Overview
Removing user(s) from a project role when they are no longer required.
                                
#### Example
If you have inactive users that you want to remove, then you can use this script to remove them.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.security.roles.ProjectRoleManager
import com.atlassian.jira.bc.projectroles.ProjectRoleService

def userManager = ComponentAccessor.userManager
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def projectRoleService = ComponentAccessor.getComponent(ProjectRoleService)

//Specify project and role
final def projectKey = '<PROJECT_KEY>'
final def roleName = '<ROLE_NAME>'

//Specify usernames
final def user1name = '<USERNAME>'
final def user2name = '<USERNAME>'

//Specify user/group role actor (ex./ UserRoleActor.TYPE, GroupRoleActor.TYPE)
final def actorType = '<USER_ROLE_ACTOR>'

def project = ComponentAccessor.projectManager.getProjectByCurrentKey(projectKey)
def projectRole = projectRoleManager.getProjectRole(roleName)

def exampleUser = userManager.getUserByName(user1name)
def exampleUser2 = userManager.getUserByName(user2name)
def users = [exampleUser.key.toString(), exampleUser2.key.toString()]

projectRoleService.removeActorsFromProjectRole(users, projectRole, project, actorType, null)
```

