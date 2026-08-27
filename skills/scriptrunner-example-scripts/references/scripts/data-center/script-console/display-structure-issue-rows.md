# Display Structure Issue Rows

- Platform: data-center
- Feature: script-console
- Tags: issue, reporting
- Language: groovy
- Doc ID: example-dataCenter-structure-display-issue-rows-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-display-issue-rows-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
Structures can be composed of multiple elements or rows: issues, generators (automated rules to add or remove issues), folders (containers for issues), etc.
This script analyses a structure in order to find which rows of the structure are issues and which rows are not.

## Example

As a project manager, I handle a big structure composed of multiple issues and other elements (such as generators and folders).
I want to know how many rows in the structure are issues. Using this script, I can see how many rows are issues at a glance.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.integers.LongIterator

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

// Get components
def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService
def rowManager = structureComponents.rowManager

// Define the params (name of the structure and permission level)
final structureName = 'My structure'
final permission = PermissionLevel.ADMIN

// Get the structure
def structures = structureManager.getStructuresByName(structureName, permission)
if (!structures) {
    log.warn("No structures available with the name '${structureName}'")
    return
}

def structure = structures.first()
def forestSpec = ForestSpec.structure(structure.id)
def forestSrc = forestService.getForestSource(forestSpec)
def forest = forestSrc.latest.forest

// Group the rows in the "structure forest" by issues and non-issue
def itemIdsByIsIssue = forest.rows.collect { LongIterator rowIterator ->
    def row = rowManager.getRow(rowIterator.value())
    row.itemId
}.groupBy { itemId ->
    def isIssue = CoreIdentities.isIssue(itemId)
    if (isIssue) {
        log.info("Issue: ${itemId}")
    } else {
        log.info("Non issue: ${itemId}")
    }

    isIssue
}

def issueItems = itemIdsByIsIssue[true]
def nonIssueItems = itemIdsByIsIssue[false]
"Issue items (${issueItems.size()}): ${issueItems}. Non-issue items (${nonIssueItems.size()}): ${nonIssueItems}"
```

