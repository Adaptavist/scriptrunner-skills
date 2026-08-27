# Updates all the Projects provided with a single Permission Scheme.

- Platform: data-center
- Feature: script-console
- Tags: automate, administer, project, dynamic-forms
- Language: groovy
- Doc ID: example-dataCenter-bulk-change-projects-permission-scheme-onPrem
- Source: https://examples.scriptrunner.io/scripts/bulk-change-projects-permission-scheme-onPrem

## Overview

It would be a good idea to put your Jira instance in "read-only" mode before migrating to Jira Cloud to ensure there 
is no loss of data during the migration process. However, Jira does not provide this functionality.

One way around this is to change the Permission Scheme for each project to "read-only". This can be tedious, 
as you have to go through each project individually and change its Permission Scheme.

This script automates that process and sets the Permission Scheme of each project to "read-only".

## Example

As a Jira administrator, I want to be able to bulk set the Permission Scheme to "read-only" for each project in my 
Jira instance.

## Good to Know

When the script finishes, it also shows what the Permission Scheme of each project was before it was changed to "read-only". 
You should save this list so that you can return each project to its original Permission Scheme setting after the migration is complete.

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.permission.PermissionSchemeManager
import com.atlassian.jira.project.Project
import com.atlassian.jira.scheme.Scheme
import com.onresolve.scriptrunner.parameters.annotation.ProjectPicker
import com.onresolve.scriptrunner.parameters.annotation.ShortTextInput
import groovy.transform.Field

@ProjectPicker(label = "Project picker", description = "Projects to change their Permission Scheme", multiple = true)
List<Project> projectList
@ShortTextInput(label = "Permission Scheme ID", description = "Permission Scheme ID to associate the previous selected Projects. Eg: 10000")
String permissionSchemeId

// If any of the above fields are not filled in, stop the script and returns an error informing about it.
assert projectList && permissionSchemeId : "Please, fulfill all the fields before executing the Script"

@Field PermissionSchemeManager permissionSchemeManager = ComponentAccessor.permissionSchemeManager
def permissionScheme = permissionSchemeManager.getSchemeObject(permissionSchemeId.toLong())

// If no permissions scheme is found with the provided Id, stop the script and returns an error informing about it.
assert permissionScheme : "There is no Permission Scheme with the ID ${permissionSchemeId}"

// The empty Map to store the Project keys associated with their Permission Scheme before the change.
def currentPermissions = [:] as Map<String, List>

/**
 * Stores the Project keys associated with their Permission Scheme before the change and
 * updates the selected Projects with the Permission Scheme provided.
 */
projectList.each { project ->
    saveProjectKeyAssociatedToPermissionScheme(currentPermissions, project)
    associatePermissionSchemeToProject(project, permissionScheme)
}

// Shows the Project keys associated to his previous permission scheme.
currentPermissions

/**
 * Stores the Project key that belongs to his current Permissions Scheme.
 * The format stored is as following:
 *      Permission Scheme name: List of the current Project keys that belongs to that Permission Scheme.
 * @param Map <String, List> currentPermissions - the map to store the information.
 * @param Project project - the Project to store in the List of the Map.
 */
void saveProjectKeyAssociatedToPermissionScheme(Map<String, List> currentPermissions, Project project) {
    def currentPermissionSchemeName = permissionSchemeManager.getSchemeFor(project).name
    def currentPermissionSchemeProjects = currentPermissions[currentPermissionSchemeName]

    if (currentPermissionSchemeProjects) {
        currentPermissionSchemeProjects << project.key
    } else {
        currentPermissionSchemeProjects = [project.key]
    }

    currentPermissions << [(currentPermissionSchemeName): currentPermissionSchemeProjects]
}

/**
 * Associates a Project with a new Permission Scheme.
 * @param Project project - the Project to update.
 * @param Scheme permissionScheme - the Permission Scheme to associate with the project.
 */
void associatePermissionSchemeToProject(Project project, Scheme permissionScheme) {
    permissionSchemeManager.removeSchemesFromProject(project)
    permissionSchemeManager.addSchemeToProject(project, permissionScheme)
}
```

