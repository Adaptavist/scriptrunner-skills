# Remove All Generators from a Structure

- Platform: data-center
- Feature: script-console
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-remove-generators-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-remove-generators-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
A generator is an element which you can add to a structure and acts as a rule, automatically populating or filtering
issues in a structure.
This script removes all previously added generators in a structure.

## Example

As a Jira administrator, I want to change the way my structure is filtered. To do this, I want to remove all the generators from a misconfigured structure.
Using this script, I can quickly and easily remove them all at once, allowing me to add the new generators required.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.integers.LongArray
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.forest.ForestSpec

@WithPlugin("com.almworks.jira.structure")

@PluginModule
StructureComponents structureComponents

// Get components
def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService
def rowManager = structureComponents.rowManager

// Define the params to get the structure (name of the structure and permission level of the structure)
final structureName = 'My structure'
final permissionLevel = PermissionLevel.ADMIN

def structures = structureManager.getStructuresByName(structureName, permissionLevel)
if (!structures) {
    log.warn "No existing Structure found with name '${structureName}' and permission level '${permissionLevel.name()}'"
    return
}

def structureId = structures.first().id

// Get the "forest" corresponding to the structure
def forestSpec = ForestSpec.structure(structureId)
def forestSrc = forestService.getForestSource(forestSpec)
def forest = forestSrc.latest.forest

// Iterate over all the rows of the structure to get the generators rows ids
def generatorRowIds = new LongArray()
forest.rows.each { rowId ->
    def row = rowManager.getRow(rowId.value())
    def itemId = row.itemId

    def isGenerator = (itemId.itemType == "com.almworks.jira.structure:type-generator")
    if (isGenerator) {
        generatorRowIds.add(row.rowId)
    }
}

// Remove the generators
forestSrc.apply(new ForestAction.Remove(generatorRowIds))
```

