# Show all Structures Corresponding Item Counts

- Platform: data-center
- Feature: script-console
- Tags: administer, issue, reporting
- Language: groovy
- Doc ID: example-dataCenter-structure-show-all-structures-item-counts-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-show-all-structures-item-counts-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script generates an HTML report summarising all created structures and the corresponding amount of rows in each.

## Example

As a Jira administrator, I want to know how many elements are forming each structure in the Jira instance.
With this script, I can get a table with this information and view it at a glance.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.xml.MarkupBuilder
import org.apache.commons.lang.StringEscapeUtils

@WithPlugin('com.almworks.jira.structure')
@PluginModule
StructureComponents structureComponents

def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService

// Get all the structures accessible to the current user at the specified permission level
final permissionLevel = PermissionLevel.NONE
def structures = structureManager.getAllStructures(permissionLevel)
// Extract name, id and elements size for each structure, and sort them by size in descending order
def structureSizeInfoList = structures.collect { structure ->
    def forestSource = forestService.getForestSource(ForestSpec.skeleton(structure.id))
    [nameAndId: "${structure.name} (#${structure.id})", size: forestSource.latest.forest.size()]
}.sort { s1, s2 -> s2.size <=> s1.size }

// Build the HTML table
def writer = new StringWriter()
def markupBuilder = new MarkupBuilder(writer)
markupBuilder.table {
    thead {
        tr {
            th("Structure Name (ID)")
            th("Number of manually added rows")
        }
    }
    tbody {
        structureSizeInfoList.collect { structure ->
            tr {
                td(StringEscapeUtils.escapeHtml(structure.nameAndId))
                td(structure.size)
            }
        }
    }
}
writer
```

