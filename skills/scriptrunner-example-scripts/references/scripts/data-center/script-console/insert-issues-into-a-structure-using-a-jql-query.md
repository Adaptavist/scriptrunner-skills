# Insert Issues into a Structure Using a JQL Query

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-generators-jql-insert-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-generators-jql-insert-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script adds issues to an specific structure by creating a JQL insert generator.

## Example

As a project manager, I want to add issues (already created and to be created) to a structure automatically.
I can use this script to create a JQL insert generator,  which adds all issues matching a JQL query to the structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* Every new issue matching the JQL query of the generator will be automatically added to the structure.
* A JQL insert generator adds the issues matching a query to the structure, whereas a JQL filter generator removes issues from the structure.
  You can check the script to create a [JQL filter generator](https://library.adaptavist.com/entity/add-a-jql-filter-to-a-structure).

## Script

```groovy
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.generator.CoreGeneratorParameters
import com.almworks.jira.structure.api.generator.CoreStructureGenerators
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
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
// This is the JQL query you want the generator to execute
final jql = 'project = test and type = story'

def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)
assert !structures.empty : "No structure found with the name ${structureName}"
def structureId = structures.first().id

def params = [(CoreGeneratorParameters.JQL): jql] as Map
def jqlInserterId = generatorManager.createGenerator(CoreStructureGenerators.INSERTER_JQL, params, structureId)
def generatorItem = CoreIdentities.generator(jqlInserterId) // Item to add to forest
def forestSource = forestService.getForestSource(ForestSpec.structure(structureId)) // resolving forest source for structure
forestSource.apply(new ForestAction.Add(generatorItem, 0, 0, 0))
```

