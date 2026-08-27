# Remove Issues from a Structure Based on a JQL Query

- Platform: data-center
- Feature: script-console
- Tags: administer, issue
- Language: groovy
- Doc ID: example-dataCenter-structure-remove-issue-based-on-jql-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-remove-issue-based-on-jql-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script removes specific issues from a structure based on a given JQL query.

## Example

As a project manager, I want to remove some issues that no longer apply to a structure.
With this script, I can identify these issues using a JQL query, and remove them from the specified structure.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.jql.parser.JqlQueryParser
import com.atlassian.query.Query
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.row.StructureRow
import com.almworks.jira.structure.api.row.RowManager
import com.almworks.jira.structure.api.item.ItemIdentity
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.util.JiraComponents
import com.almworks.integers.LongArray
import com.almworks.integers.LongIterator
import com.almworks.integers.LongOpenHashSet
import com.almworks.jira.structure.StructurePluginHelperInternal

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

def plugin = ComponentAccessor.pluginAccessor.getPlugin('com.almworks.jira.structure')

def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService

final structureName = "YOUR_STRUCTURE_NAME"

def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)
assert !structures.empty : "No structure found with the name ${structureName}"

def struct = structures.first()
def forestSpec = ForestSpec.structure(struct.id)
def forestSrc = forestService.getForestSource(forestSpec)
RowManager rowManager = structureComponents.rowManager
def forest = forestSrc.latest.forest

// This will allow us access to useful helper functions, in this case the application of our JQL query to our rows.
def helper = plugin.getModuleDescriptor('helper').module as StructurePluginHelperInternal

// This variable will hold all our issues that match our JQL query.
def matchingIssues = new LongOpenHashSet()
// This variable will store all the elements in our structure that are issues (vs folders or generators).
LongArray onlyIssues = new LongArray()
// This variable will hold the rows that that are eventually removed from the Structure.
LongArray matchingRows = new LongArray()

// This will turn our JQL string into a Jira query.
final jqlQuery = "assignee = admin"
Query query = JiraComponents.getComponent(JqlQueryParser).parseQuery(jqlQuery)

// Here we are iterating over all the rows of our structure to get the issues.
for (LongIterator ri : forest.rows) {
    StructureRow row = rowManager.getRow(ri.value())
    ItemIdentity itemId = row.itemId
    if (CoreIdentities.isIssue(itemId)) {
        onlyIssues.add(itemId.longId)
    }
}

// Here we are evaluating which items match the query. If we change the boolean value to false, we get the opposite.
helper.matchIssues(onlyIssues, query, true, matchingIssues)

// Now we are iterating over our structure again, row by row, to translate the issues that we want to remove to their respective rows.
for (LongIterator ri : forest.rows) {
    StructureRow row = rowManager.getRow(ri.value())
    ItemIdentity itemId = row.itemId
    if (CoreIdentities.isIssue(itemId) && matchingIssues.contains(itemId.longId)) {
        matchingRows.add(ri.value())
    }
}

// Here we pass the rows we identified as unwanted to our remove function.
forestSrc.apply(new ForestAction.Remove(matchingRows.subList(0, matchingRows.size())))
```

