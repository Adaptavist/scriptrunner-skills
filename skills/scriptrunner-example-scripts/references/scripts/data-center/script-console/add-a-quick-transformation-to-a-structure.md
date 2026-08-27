# Add a Quick Transformation to a Structure

- Platform: data-center
- Feature: script-console
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-add-quick-transformation-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-add-quick-transformation-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script adds a *Quick Transformation* to a structure, allowing you to enable a filtered view of the structure with the click of a button.

## Example

As a project manager, I want to be able to view only the open issues of a structure at a glance.
With this script, I can specify a JQL query searching for all open issues, and filter the structure by this query.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import groovy.json.JsonOutput
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.generator.CoreStructureGenerators
import com.almworks.jira.structure.api.generator.CoreGeneratorParameters

@WithPlugin("com.almworks.jira.structure")

@PluginModule
StructureComponents structureComponents

def structureManager = structureComponents.structureManager
def propertyService = structureComponents.structurePropertyService

final structureName = 'My structure'
final permission = PermissionLevel.ADMIN

def structures = structureManager.getStructuresByName(structureName, permission)
if (!structures) {
    log.warn "No existing Structure found"
    return
}

def structureId = structures.first().id

def quickFilter = [
    "module": CoreStructureGenerators.FILTER_JQL,
    "params": [
        (CoreGeneratorParameters.JQL): "status != Closed",
    ],
    "key": 'filter',
    "quick": [
        "id": "-${structureId}-1",
        "name": "Show non-Closed issues"
    ]
]

// Warning! The existing quick transformations in the structure will be overwritten!
propertyService.setValue(structureId, "quick-transforms", JsonOutput.toJson([quickFilter]))
```

