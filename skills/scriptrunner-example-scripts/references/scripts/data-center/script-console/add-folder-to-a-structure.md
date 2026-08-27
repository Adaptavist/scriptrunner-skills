# Add Folder to a Structure

- Platform: data-center
- Feature: script-console
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-add-folder-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-add-folder-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script adds a folder to a structure, allowing you to separate and organise issues.

## Example

As a project manager, I want to separate issues in groups inside my structure.
Using this script, I can easily create multiple folders to organise my issues within a structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.folder.Folder
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.item.ItemForestBuilderImpl
import com.almworks.jira.structure.api.item.CoreIdentities

@WithPlugin("com.almworks.jira.structure")

@PluginModule
StructureComponents structureComponents

// Get components
def structureManager = structureComponents.structureManager
def folderManager = structureComponents.folderManager
def forestService = structureComponents.forestService

// Define the params (name of the structure, permission level of the structure and folder name)
final structureName = 'My structure'
final permissionLevel = PermissionLevel.ADMIN
final newFolderName = 'My folder'

def structures = structureManager.getStructuresByName(structureName, permissionLevel)
if (!structures) {
    log.warn "No existing Structure found with name '${structureName}' and permission level '${permissionLevel.name()}'"
    return
}

def structureId = structures.first().id

// Create the folder associated with the structure
def newFolder = Folder.named(newFolderName).setOwningStructure(structureId).build()
def folderItem = folderManager.createFolder(newFolder)
def forestBuilder = new ItemForestBuilderImpl()
forestBuilder.nextRow(CoreIdentities.folder(folderItem))

// Add the folder to the structure
def forestSource = forestService.getForestSource(ForestSpec.structure(structureId))
def forestToAdd = forestBuilder.build()
forestSource.apply(new ForestAction.Add(forestToAdd, 0, 0, 0))
```

