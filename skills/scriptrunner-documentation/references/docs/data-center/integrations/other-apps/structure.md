# Structure

- Platform: data-center
- Space: SR4JS
- Hierarchy: integrations > other-apps
- Doc ID: doc-sr4js-442889196
- Source: https://docs.adaptavist.com/sr4js/latest/integrations/other-apps/structure

Here is a minimal example for listing structures from the [Structure plugin](https://marketplace.atlassian.com/plugins/com.almworks.jira.structure). The comments in the script give more information about the important elements.

```
package examples.docs.structure

import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.almworks.jira.structure.api.StructureComponents
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

// Grab only useful for IDE help, not for runtime. Alternatively you can just add this jar to the
// "provided" scope for the module
@Grab(group = 'com.almworks.jira.structure', module = 'structure-api', version = '16.0.0')

// Specify that classes from this plugin should be available to this script
@WithPlugin("com.almworks.jira.structure")

// Inject plugin module
@PluginModule
StructureComponents structureComponents

def structureManager = structureComponents.getStructureManager()
def structures = structureManager.getAllStructures(PermissionLevel.VIEW)
structures.each { structure ->
    log.debug "Structure: ID: ${structure.id}, name: ${structure.name}"
}
```

### Add Issue to Structure on Transition

Here is another example with Structure, a post-function which adds the current current issue to a named structure. You might want this done automatically when the issue has been triaged or CCB’d…​ you may not wish to consider it in your structure before this point.

```
package examples.docs.structure

import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.forest.action.ForestAction
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.atlassian.jira.issue.Issue

import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

// Grab only necessary for IDE help, not for runtime
@Grab(group = 'com.almworks.jira.structure', module = 'structure-api', version = '16.0.0')

// Specify that classes from this plugin should be available to this script
@WithPlugin("com.almworks.jira.structure")

// Inject plugin module
@PluginModule
StructureComponents structureComponents

//noinspection GroovyVariableNotAssigned
def structureManager = structureComponents.getStructureManager()
def forestService = structureComponents.getForestService()

Issue issue = issue // provided in binding

// should only have one structure for this name - otherwise use a structure ID
def structures = structureManager.getStructuresByName("GRV", PermissionLevel.VIEW)

if (structures) {
    def structureId = structures.first().id
    // this adds the issue at the root, to the top of the structure
    forestService.getForestSource(ForestSpec.structure(structureId))
        .apply(new ForestAction.Add(CoreIdentities.issue(issue.id), 0, 0, 0))
}
```

### All Descendants Must be Resolved Condition

Another example, a condition whereby all descendant issues in all structures containing this issue must be resolved. This is just for illustrative purposes and not necessarily a good idea, or production code.

```
package examples.docs.structure

import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.StructureComponents
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.Issue
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin

@WithPlugin("com.almworks.jira.structure")

// Inject plugin module
@PluginModule
StructureComponents structureComponents

def user = ComponentAccessor.getJiraAuthenticationContext().getLoggedInUser()
def issueManager = ComponentAccessor.getIssueManager()

//noinspection GroovyVariableNotAssigned
def structureManager = structureComponents.getStructureManager()
def forestService = structureComponents.getForestService()

Issue myIssue
if (!binding.hasVariable("issue")) {
    log.warn "No issue in context, presume running in console"
    myIssue = issueManager.getIssueObject("GRV-90")
} else {
    myIssue = issue
}

def query = structureComponents.getStructureQueryParser().parse("descendants of ${myIssue.key} and [resolution is empty]")
def structures = structureManager.getViewableStructuresWithIssue(myIssue.id)

passesCondition = structures.every { structure ->
    def forest = forestService.getForestSource(ForestSpec.skeleton(structure.id))
    def childrenClosedForStructure = query.execute(forest.getLatest().getForest()).isEmpty()
    log.debug("All children closed for structure: ${structure.name}: $childrenClosedForStructure")
    childrenClosedForStructure
}

log.debug "passesCondition: $passesCondition"
passesCondition
```
