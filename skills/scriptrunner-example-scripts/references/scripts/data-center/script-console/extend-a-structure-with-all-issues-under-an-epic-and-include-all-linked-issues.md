# Extend a Structure with All Issues Under an Epic and Include All Linked Issues

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-generators-extend-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-generators-extend-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script adds issues to an specific structure by including all issues belonging to an epic,
or all issues linked by certain link types (such as 'Blocks').

## Example

As a project manager, I want to add the issues associated with an epic, and all issues linked to an issue already in my structure.
I can use this script to create a *Extend Generator*, which automatically add all issues associated with an epic, or all issues linked to another issue in the structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.forest.item.ItemForestBuilderImpl
import com.almworks.jira.structure.api.generator.CoreStructureGenerators
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.link.IssueLinkTypeManager
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

def issueLinkTypeManager = ComponentAccessor.getComponent(IssueLinkTypeManager)
def structureManager = structureComponents.structureManager
def generatorManager = structureComponents.generatorManager

// Name of the structure you want to add this generator to
final structureName = 'YOUR_STRUCTURE_NAME'

def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)
assert !structures.empty : "No structure found with the name $structureName"
def structureId = structures.first().id

def forestBuilder = new ItemForestBuilderImpl()

// Create the generator to extend the structure with the issues associated with the epics which were added to the structure
def epicsExtenderItem = generatorManager.createGenerator(CoreStructureGenerators.EXTENDER_AGILE, [:], null)
forestBuilder.nextRow(CoreIdentities.generator(epicsExtenderItem))

// Create the generator to extend the structure with the issues linked with other issues which were added to the structure
// Change the issueLinkTypeName to what you need, in this case we are looking for the "Blocks" link type
final issueLinkTypeName = 'Blocks'
def blocksLinkTypeId = issueLinkTypeManager.getIssueLinkTypesByName(issueLinkTypeName).first().id

def params = [
    'linkTypeId'    : blocksLinkTypeId, // Id of the 'Blocks' issue link type
    'direction'     : 'outward',        // Direction of the link type, could be either 'inward' or 'outward'
    'disableActions': false,            // Enable structure actions
    'from'          : null,
    'to'            : 2                 // Number of levels to extend issue at
] as Map
def blocksExtenderItem = generatorManager.createGenerator(CoreStructureGenerators.EXTENDER_LINKS, params, structureId)
forestBuilder.nextRow(CoreIdentities.generator(blocksExtenderItem))

def forestService = structureComponents.forestService
def forestSource = forestService.getForestSource(ForestSpec.structure(structureId))
def forestToAdd = forestBuilder.build()
forestSource.apply(new ForestAction.Add(forestToAdd, 0, 0, 0))
```

