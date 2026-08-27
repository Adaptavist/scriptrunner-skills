# Create new structure

- Platform: data-center
- Feature: script-console
- Tags: automate, issue
- Language: groovy
- Doc ID: example-dataCenter-create-new-structure-onPrem
- Source: https://examples.scriptrunner.io/scripts/create-new-structure-onPrem

## Overview

Automatically create and name an empty structure (from the *Structure for Jira* plugin).

## Example

I want to create a structure to group some of my Jira projects without having to create it manually. Using this script, I can set it up from the *Script Console*. I can bulk create several structures or use it as part of a larger script.

## Good to Know

* The plugin works with Structure for Jira 4.1+.
* The plugin does not create a structure if one with the same name already exists.

## Script

```groovy
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")

@PluginModule
StructureComponents structureComponents

// the name of the new structure
final String structureName = "YOUR_STRUCTURE_NAME"

def structureManager = structureComponents.structureManager

// if structure with the given name doesn't exist, create a new empty one
if (!structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)) {
    structureManager.createStructure().setName(structureName).saveChanges()
}
```

