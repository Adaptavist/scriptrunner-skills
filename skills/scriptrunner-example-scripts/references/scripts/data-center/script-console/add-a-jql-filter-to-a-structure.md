# Add a JQL Filter to a Structure

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-generators-add-jql-filter-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-generators-add-jql-filter-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script filters issues from a specific structure by creating a JQL filter generator.

## Example

As a project manager, I want to restrict some issues from being added to the structure.
I can use this script to create a JQL filter generator, which keeps only the issues matching a JQL query in the structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* A JQL filter generator removes the issues not matching a query from the structure, whereas a JQL insert generator adds issues to the structure.
  You can check the script to create a [JQL insert generator](https://library.adaptavist.com/entity/insert-issues-into-a-structure-using-a-jql-query).

## Script

```groovy
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.generator.CoreGeneratorParameters
import com.almworks.jira.structure.api.generator.CoreStructureGenerators
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService
def generatorManager = structureComponents.generatorManager

// Name of the structure you want to add this generator to
final structureName = 'YOUR_STRUCTURE_NAME'

// Get the structure: the false flag is optional, it indicates whether we want to search archived structures or not
def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN, false)
assert !structures.empty : "No structure found with the name ${structureName}"

def structureId = structures.first().id

// JQL text query of the generator to filter the issues by
final jql = "assignee = admin"

// Build the JQL filter generator generator
def jqlParams = [(CoreGeneratorParameters.JQL): jql] as Map
def jqlFilterId = generatorManager.createGenerator(CoreStructureGenerators.FILTER_JQL, jqlParams, structureId)

// Create the item to add to the structure forest
def generatorItem = CoreIdentities.generator(jqlFilterId)
def forestSource = forestService.getForestSource(ForestSpec.structure(structureId))
forestSource.apply(new ForestAction.Add(generatorItem, 0, 0, 0))
```

