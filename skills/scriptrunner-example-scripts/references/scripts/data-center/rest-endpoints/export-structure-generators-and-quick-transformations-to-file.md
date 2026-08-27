# Export Structure Generators and Quick Transformations to File

- Platform: data-center
- Feature: rest-endpoints
- Tags: administer, reporting
- Language: groovy
- Doc ID: example-dataCenter-structure-export-generators-quick-transformations-onPrem
- Source: https://examples.scriptrunner.io/scripts/structure-export-generators-quick-transformations-onPrem

## Overview

*Structure for Jira* allows you to create structures to organise issues and projects.
This script downloads a file containing a summary of the generators and quick transformations of each structure in the instance.

## Example

As a Jira administrator, I want to backup the information about the generators and quick transformations applied to each structure.
Using this script, I can generate a file summarasing all this info, to check the global status at a glance
or replicate the information in another instance.

## Good to Know

* This script requires the [Structure for Jira plugin](https://marketplace.atlassian.com/apps/34717/structure-project-management-at-scale).
* Apart from being downloaded, the backup file is saved in the Jira export directory as well.

## Script

```groovy
import com.almworks.integers.LongIterator
import com.almworks.jira.structure.api.forest.ForestSpec
import com.almworks.jira.structure.api.item.CoreIdentities
import com.atlassian.jira.component.ComponentAccessor
import com.onresolve.scriptrunner.runner.customisers.PluginModule
import com.onresolve.scriptrunner.runner.customisers.WithPlugin
import com.onresolve.scriptrunner.runner.rest.common.CustomEndpointDelegate
import com.atlassian.jira.config.util.JiraHome
import groovy.transform.BaseScript
import org.apache.log4j.Level
import com.almworks.jira.structure.api.StructureComponents
import org.apache.log4j.Logger

import javax.ws.rs.core.MediaType
import javax.ws.rs.core.MultivaluedMap
import javax.ws.rs.core.Response

@BaseScript CustomEndpointDelegate delegate

@WithPlugin("com.almworks.jira.structure")
@PluginModule
StructureComponents structureComponents

// Set log level to INFO (default for REST endpoints is WARN)
def log = Logger.getLogger(getClass())
log.setLevel(Level.INFO)

def structureManager = structureComponents.structureManager
def forestService = structureComponents.forestService
def rowManager = structureComponents.rowManager
def generatorManager = structureComponents.generatorManager
def propertyService = structureComponents.structurePropertyService
def jiraHome = ComponentAccessor.getComponent(JiraHome)

// The requesting user must be in one of these groups
final allowedGroups = ['jira-administrators']
getStructureGeneratorsAndTransformsBackup(httpMethod: "GET", groups: allowedGroups) { MultivaluedMap queryParams, String body ->
    def allStructures = structureManager.getAllStructures(null)

    // Create the file in the Jira export directory
    def exportFile = new File(jiraHome.exportDirectory, 'structure_generators_transformations_export.txt')
    def printWriter = exportFile.newPrintWriter()

    // Iterate over all structures to get the elements of each one
    allStructures.each { structure ->
        // Print structure name and id
        printWriter.println("------- Structure (#${structure.id}): '${structure.name}'")

        // Collect the generators ids in the structure
        def forest = forestService.getForestSource(ForestSpec.structure(structure.id)).latest.forest
        def generatorsIds = forest.rows.collect { LongIterator li ->
            def row = rowManager.getRow(li.value())
            row.itemId
        }.findAll {
            CoreIdentities.isGenerator(it)
        }*.longId

        // Print the info of each generator
        printWriter.println('----- Generators')
        generatorsIds.each { id ->
            def generator = generatorManager.getGenerator(id)
            printWriter.println("--- Row id: ${id}")
            printWriter.println("--- Module key: ${generator.moduleKey}")
            printWriter.println("--- Owning structure: ${generator.owningStructure}")
            printWriter.println("--- Parameters: ${generator.parameters}")
            printWriter.println()
        }

        // Print the info about the quick transforms
        def quickTransforms = propertyService.getString(structure.id, 'quick-transforms', '')
        printWriter.println('----- Quick transforms')
        printWriter.println("--- JSON: ${quickTransforms}")
        printWriter.println()
    }
    printWriter.close()

    log.info("Export file generated at export directory, path: '${exportFile.absolutePath}'")
    // Send the export file
    Response.ok(exportFile, MediaType.APPLICATION_OCTET_STREAM_TYPE)
        .header('Content-Disposition', "attachment; filename=\"${exportFile.name}\"")
        .build()
}
```

