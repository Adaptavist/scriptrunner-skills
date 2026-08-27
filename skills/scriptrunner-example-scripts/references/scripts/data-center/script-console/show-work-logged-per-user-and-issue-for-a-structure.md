# Show Work Logged Per User and Issue for a Structure

- Platform: data-center
- Feature: script-console
- Tags: administer, issue, reporting, user
- Language: groovy
- Doc ID: example-dataCenter-structure-show-work-logged-for-a-structure-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-show-work-logged-for-a-structure-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script checks the work logged by each user on all issues of a single structure.

## Example

As a project manager, I use several structures to organise my software projects.
Using this script, I can see a clear overview of the work logged per user for each issue.
The table format allows me to clearly see where work has been logged so I can assess the progress of a project.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* The report shows the logged time in hours.

## Script

```groovy
import com.almworks.integers.LongIterator
import com.almworks.jira.structure.api.StructureComponents
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.item.CoreIdentities
import com.almworks.jira.structure.api.permissions.PermissionLevel
import com.atlassian.jira.component.ComponentAccessor
import com.atlassian.jira.issue.worklog.Worklog
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import groovy.xml.MarkupBuilder

import java.text.DecimalFormat

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

// The structure you want to check
final structureName = "YOUR_STRUCTURE_NAME"

// Get internal components
def worklogManager = ComponentAccessor.worklogManager
def issueManager = ComponentAccessor.issueManager
def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService
def rowManager = structureComponents.rowManager

// Get the structure
def structures = structureManager.getStructuresByName(structureName, PermissionLevel.ADMIN)
assert !structures.empty : "No structure found with the name ${structureName}"

def structure = structures.first()
def forestSrc = forestService.getForestSource(ForestSpec.structure(structure.id))
def forest = forestSrc.latest.forest
// Get all issues ids in the structure
def issueIds = forest.rows.collect { LongIterator iterator ->
    rowManager.getRow(iterator.value()).itemId
}.findAll {
    CoreIdentities.isIssue(it)
}*.longId as Collection<Long>

// Get all worklogs for every issue and group them by author
def allWorklogs = issueIds.collectMany {
    def issue = issueManager.getIssueObject(it)
    worklogManager.getByIssue(issue) as Collection<Worklog>
}
def worklogsByAuthor = allWorklogs.groupBy { it.authorKey }

// Build the HTML table
def writer = new StringWriter()
def markupBuilder = new MarkupBuilder(writer)
def decimalFormatter = new DecimalFormat('#.##')
markupBuilder.table {
    tr {
        th("Structure")
        th("User")
        th("Issue Worklogged (hours)")
    }
    worklogsByAuthor.collect { author, worklogs ->
        tr {
            td(structureName)
            td(author)
            td {
                table {
                    worklogs.collect { worklog ->
                        def timeSpentHours = worklog.timeSpent / 3600

                        tr {
                            td(worklog.issue.key)
                            td(decimalFormatter.format(timeSpentHours))
                        }
                    }
                }
            }
        }
    }
}
writer.toString()
```

