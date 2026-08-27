# Find all projects where a certain Jira group is used in their project permissions

- Platform: data-center
- Feature: script-console
- Tags: administer, project
- Language: groovy
- Doc ID: example-dataCenter-find-projects-using-group-in-project-permissions-onPrem
- Source: https://examples.scriptrunner.io/scripts/find-projects-using-group-in-project-permissions-onPrem

## Overview

Use this script to find all projects where a specific Jira group is used by a project, through its permission scheme.
A group is being deemed as being used by a project, where it's used by its permission scheme, either directly or through a project role.

## Description

#### Overview

Use this script to find all projects where a specific Jira group is used by a project, through its permission scheme.
A group is being deemed as being used by a project, where it's used by its permission scheme, either directly or through a project role.

## Script

```groovy
import com.atlassian.crowd.embedded.api.Group
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.project.Project
import com.atlassian.jira.security.roles.ProjectRoleManager
import com.onresolve.scriptrunner.parameters.annotation.GroupPicker

import static com.atlassian.jira.permission.JiraPermissionHolderType.GROUP
import static com.atlassian.jira.permission.JiraPermissionHolderType.PROJECT_ROLE
import static com.atlassian.jira.security.roles.ProjectRoleActor.GROUP_ROLE_ACTOR_TYPE

@GroupPicker(label = 'Group', description = 'Projects using this group in their permission schemes will be returned')
Group group

def projectManager = ComponentAccessor.getProjectManager()
def projectRoleManager = ComponentAccessor.getComponent(ProjectRoleManager)
def permissionSchemeManager = ComponentAccessor.getPermissionSchemeManager()

def projectsUsingGroup = [] as Set<Project>
def projectRoles = projectRoleManager.getProjectRoles()

projectManager.getProjectObjects().each { projectObject ->

    def rolesAddingGroup = []
    projectRoles.each { role ->
        projectRoleManager.getProjectRoleActors(role, projectObject).roleActors.each { roleActor ->
            if (roleActor.type == GROUP_ROLE_ACTOR_TYPE && roleActor.parameter == group.name) {
                rolesAddingGroup.add(role.id as String)
            }
        }
    }

    projectObject.permissionScheme.permissions.each { perm ->
        def permissionsPerRole = projectObject.permissionScheme.getPermissions(perm.permission, PROJECT_ROLE)
        def isRoleAddingGroup = permissionsPerRole*.holder*.parameter*.get().any { role ->
            role in rolesAddingGroup
        }

        def groupPermissionGrants = projectObject.permissionScheme.getPermissions(perm.permission, GROUP)
        def isGroupAddedDirectly = groupPermissionGrants*.holder*.parameter*.get().any { groupName ->
            groupName == group.name
        }

        if (isRoleAddingGroup || isGroupAddedDirectly) {
            projectsUsingGroup.add(projectObject)
        }
    }
}

projectsUsingGroup*.name
```

