# Add Column to a New Structure View

- Platform: data-center
- Feature: script-console
- Tags: customise, ui
- Language: groovy
- Doc ID: example-dataCenter-structure-add-column-view-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-add-column-view-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script adds a new view with a custom column, allowing you to visualise specific data of the issues in the structure.

## Example

As a project manager, I want to view the original estimate multiplied by an exceed factor for every issue in a strcture.
Using this script, I can create an alternative view for my structures which contains the custom column showing this data.

I can use this script as part of a larger script, to quickly create the view and columns I require for an instance, simplifying the migration process.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).

## Script

```groovy
import com.almworks.jira.structure.api.view.ViewSpecification
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.util.JsonMapUtil
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")

@PluginModule
StructureComponents structureComponents

def viewManager = structureComponents.viewManager

// The view id to create the column in it
final viewId = 118
// Formula params can be extracted from the POST request payload captured while you save a new formula column using browser developer tools.
// Look for a POST request to <BASEURL>/rest/structure/1.0/view and find your column spec in the "Request Payload" section under the "Headers" tab.
final formula = [
    formula: "original_estimate * 2",
    normalizedFormula: "mul(original_estimate,2)",
    variables: [
        original_estimate: [id: "timeoriginalestimate", format: "duration"]
    ]
]

def existingView = viewManager.getView(viewId, PermissionLevel.NONE)
if (!existingView) {
    log.warn("View #'${viewId}' was not found")
    return
}

final sumOverSubItems = false

def columnParams = JsonMapUtil.copyParameters(formula, true, false, false)
if (sumOverSubItems) {
    columnParams.aggregate = 'sum'
    columnParams.forestSpec = 'unfiltered'
} else {
    columnParams.remove("aggregate")
    columnParams.remove("forestSpec")
}
// If you want Distinct flag support add a new function parameter and logic to set/remove it from columnParams
columnParams.remove("distinct")

try {
    def viewSpecBuilder = new ViewSpecification.Builder(existingView.specification)

    def columnBuilder = viewSpecBuilder.addColumn('formula')
    columnBuilder.name = 'My New Column'
    columnBuilder.parameters = columnParams

    def newView = viewManager.createView()
    newView.specification = viewSpecBuilder.build()
    // Set proper view name and description
    newView.name = "${existingView.name} v2.0"
    newView.description = "${existingView.description} with ${columnBuilder.name}"
    newView.owner = existingView.owner

    newView.makePublic().saveChanges()

    "New view with id ${newView.id} created."
} catch (Exception e) {
    log.warn("Unexpected error happened while processing view #${existingView.id} '${existingView.name}' Error: ${e}")
}
```

