# Sort a Structure Using an Expression Formula

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-generators-sort-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-generators-sort-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script sorts the issues from a structure based on an expression formula. Sort issues by criteria,
such as assignee (and key when the assignee is the same).

## Example

As a project manager, I want all issues in my structure to be sorted by the assignee so I can view how workload is spread across the team.
I can configure this script in the *Script Console* to create the *Sort Generator* associated with a structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* Customise sorting by editing the formula.
* By default the generator sorts on all levels but can be configured to sort on a single level.
* A list of all sorting criteria can be found in the ALM Structure [Formula Expression Language Guide](https://wiki.almworks.com/display/structure/Expr+Language).

## Script

```groovy
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.forest.item.ItemForestBuilderImpl
import com.almworks.jira.structure.api.generator.CoreStructureGenerators
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

def structureManager = structureComponents.structureManager
def generatorManager = structureComponents.generatorManager
def forestService = structureComponents.forestService

final structureName = "YOUR_STRUCTURE_NAME"

def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)
assert !structures.empty : "No structure found with the name ${structureName}"
def structureId = structures.first().id

def forestBuilder = new ItemForestBuilderImpl()
def manualSorterItem = generatorManager.createGenerator(CoreStructureGenerators.SORTER_MANUAL, [:], null)
forestBuilder.nextRow(CoreIdentities.generator(manualSorterItem))
// Adding formula-based sorter
def formulaSorterParams = [
    attribute: [
        id: "expr",
        format: "order",
        params: [
            formula: "IF(assignee=assignee; key; assignee)",
            variables: [
                assignee: [id: "assignee", format: "text"],
                key     : [id: "key", format: "text"]
            ]
        ]
    ]
]
def formulaSorterItem = generatorManager.createGenerator(CoreStructureGenerators.SORTER_ATTRIBUTE, formulaSorterParams as Map, null)
forestBuilder.nextRow(CoreIdentities.generator(formulaSorterItem))
def forestSource = forestService.getForestSource(ForestSpec.structure(structureId))
def forestToAdd = forestBuilder.build()
forestSource.apply(new ForestAction.Add(forestToAdd, 0, 0, 0))
```

